async function loadCharityPortal() {
    if (!currentUser || (currentUser.role !== 'Charity' && currentUser.role !== 'Admin')) {
        const isAr = currentLang === 'ar';
        showToast(isAr ? 'تسجيل الدخول مطلوب' : 'Charity Access Only', isAr ? 'يرجى تسجيل الدخول بحساب جمعية خيرية.' : 'Please sign in or switch to a Charity profile.', 'info');
        navigateTo('landing');
        return;
    }

    await loadCharityStats();
    await loadCharityReservations();
}

async function loadCharityStats() {
    if (!currentUser) return;
    try {
        const res = await fetch(`${API_BASE}/reports/charity`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        if (res.ok) {
            const stats = await res.json();
            document.getElementById('statCharityTotalReceived').textContent = stats.totalReceived;
            document.getElementById('statCharityActive').textContent = stats.activeReservations;
            document.getElementById('statCharityQuantity').textContent = stats.totalQuantityReceived;
            document.getElementById('statCharityReviewsGiven').textContent = stats.totalReviewsGiven;
        }
    } catch (err) {
        console.error('Error fetching charity stats:', err);
    }
}

async function loadCharityReservations() {
    if (!currentUser) return;
    const status = document.getElementById('charityReservationsStatusFilter')?.value || '';
    const container = document.getElementById('charityReservationsContainer');
    const dict = i18nDict[currentLang] || i18nDict.en;
    const isAr = currentLang === 'ar';

    try {
        const res = await fetch(`${API_BASE}/reservations/charity/my-reservations?status=${status}`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        const list = await res.json();

        if (!list || list.length === 0) {
            container.innerHTML = `<div class="p-8 text-center text-slate-400 text-xs">${isAr ? 'لم يتم العثور على حجوزات بهذه الحالة.' : 'No food reservations found for this status.'}</div>`;
            return;
        }

        container.innerHTML = list.map(r => {
            const statusBadge = r.status === 'Completed' ? 'bg-emerald-100 text-emerald-800' :
                                r.status === 'ReadyForPickup' ? 'bg-indigo-100 text-indigo-800' :
                                r.status === 'Accepted' ? 'bg-blue-100 text-blue-800' :
                                r.status === 'ProblemReported' ? 'bg-rose-100 text-rose-800' : 'bg-amber-100 text-amber-800';

            let actions = '';
            if (r.status === 'Accepted' || r.status === 'ReadyForPickup') {
                actions = `
                    <div class="flex flex-wrap items-center gap-2">
                        <button onclick="markReservationCompleted(${r.id})" class="px-3.5 py-1.5 rounded-xl text-xs font-semibold bg-emerald-600 hover:bg-emerald-700 text-white shadow-xs">
                            <i class="fa-solid fa-check ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.confirmCollected}
                        </button>
                        <button onclick="openReportProblemModal(${r.id})" class="px-2.5 py-1.5 rounded-xl text-xs font-semibold text-rose-600 hover:bg-rose-50 border border-rose-200">
                            ${dict.reportIssue}
                        </button>
                        <button onclick="cancelReservation(${r.id})" class="px-2.5 py-1.5 rounded-xl text-xs font-semibold text-slate-500 hover:bg-slate-100 border border-slate-200">
                            ${dict.cancel}
                        </button>
                    </div>
                `;
            } else if (r.status === 'Pending') {
                actions = `
                    <button onclick="cancelReservation(${r.id})" class="px-3 py-1.5 rounded-xl text-xs font-semibold text-rose-600 hover:bg-rose-50 border border-rose-200">
                        ${dict.withdrawRequest}
                    </button>
                `;
            } else if (r.status === 'Completed') {
                if (!r.hasCharityReviewed) {
                    actions = `
                        <button onclick="openReviewModal(${r.id}, '${escapeHtml(r.providerOrganization)}')" class="px-3.5 py-1.5 rounded-xl text-xs font-semibold bg-amber-500 hover:bg-amber-600 text-white shadow-xs">
                            <i class="fa-solid fa-star ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.leaveReview}
                        </button>
                    `;
                } else {
                    actions = `<span class="text-xs text-emerald-600 font-semibold"><i class="fa-solid fa-circle-check ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.reviewed}</span>`;
                }
            }

            return `
                <div class="p-5 rounded-2xl border border-slate-200/90 hover:border-slate-300 transition flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <div class="flex items-center space-x-2 mb-1">
                            <span class="px-2.5 py-0.5 rounded-full text-xs font-bold ${statusBadge}">${formatStatus(r.status)}</span>
                            <span class="text-xs font-bold text-slate-500">${escapeHtml(r.quantity)} ${escapeHtml(r.unitOfMeasurement)}</span>
                        </div>
                        <h4 class="font-heading font-bold text-base text-slate-900">${escapeHtml(r.foodName)}</h4>
                        <div class="text-xs text-slate-600 mt-1 flex flex-wrap gap-x-4 gap-y-1">
                            <span><i class="fa-solid fa-store mr-1 text-amber-500"></i> ${escapeHtml(r.providerOrganization)}</span>
                            <span><i class="fa-solid fa-envelope mr-1 text-slate-400"></i> ${escapeHtml(r.providerEmail)}</span>
                        </div>
                        ${r.confirmedLocation ? `
                            <div class="mt-2 text-xs bg-indigo-50/70 p-2.5 rounded-xl border border-indigo-100 text-indigo-900">
                                <div class="font-bold flex items-center"><i class="fa-solid fa-location-dot text-indigo-600 mr-1.5"></i> ${escapeHtml(r.confirmedLocation)}</div>
                                <div class="text-[11px] text-indigo-700 mt-0.5">Scheduled Pickup: <strong>${new Date(r.pickupDateTime).toLocaleString()}</strong></div>
                            </div>
                        ` : ''}
                        ${r.problemDescription ? `<div class="mt-2 text-xs bg-rose-50 p-2 rounded-xl border border-rose-100 text-rose-800"><strong>Problem Reported:</strong> ${escapeHtml(r.problemDescription)}</div>` : ''}
                    </div>
                    <div class="shrink-0 flex items-center justify-end">
                        ${actions}
                    </div>
                </div>
            `;
        }).join('');

    } catch (err) {
        console.error('Error fetching charity reservations:', err);
    }
}

async function markReservationCompleted(id) {
    if (!confirm('Confirm that your team has collected and verified this food donation?')) return;
    try {
        const res = await fetch(`${API_BASE}/reservations/${id}/complete`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        const data = await res.json();
        if (!res.ok) {
            showToast('Action Failed', data.message || 'Error completing reservation.', 'error');
            return;
        }

        showToast('Donation Collected!', 'Thank you! The redistribution record is marked as completed.', 'success');
        loadCharityReservations();
        loadCharityStats();

        openReviewModal(id, data.providerOrganization || 'Food Provider');

    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

async function cancelReservation(id) {
    const reason = prompt('Please specify a cancellation reason:');
    if (!reason) return;

    try {
        const res = await fetch(`${API_BASE}/reservations/${id}/cancel`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({ reason })
        });
        const data = await res.json();
        if (!res.ok) {
            showToast('Cancellation Failed', data.message || 'Cannot cancel reservation.', 'error');
            return;
        }

        showToast('Cancelled', 'Reservation cancelled. The food listing has been restored to Available status.', 'info');
        loadCharityReservations();
        loadCharityStats();
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

function openReportProblemModal(id) {
    document.getElementById('reportProblemReservationId').value = id;
    document.getElementById('reportProblemText').value = '';
    document.getElementById('reportProblemModal').classList.remove('hidden');
}

function closeReportProblemModal() {
    document.getElementById('reportProblemModal').classList.add('hidden');
}

async function handleReportProblemSubmit(e) {
    e.preventDefault();
    const id = document.getElementById('reportProblemReservationId').value;
    const problemDescription = document.getElementById('reportProblemText').value;

    try {
        const res = await fetch(`${API_BASE}/reservations/${id}/report-problem`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({ problemDescription })
        });
        if (!res.ok) {
            const data = await res.json();
            showToast('Failed', data.message, 'error');
            return;
        }

        closeReportProblemModal();
        showToast('Problem Reported', 'Notification dispatched to provider and flagged for administrator review.', 'warning');
        loadCharityReservations();
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

function openReviewModal(reservationId, partnerName) {
    document.getElementById('reviewReservationId').value = reservationId;
    document.getElementById('reviewModalSubtitle').textContent = `Rate your experience collaborating with ${partnerName}`;
    setReviewRating(5);
    document.getElementById('reviewComment').value = '';
    document.getElementById('reviewModal').classList.remove('hidden');
}

function closeReviewModal() {
    document.getElementById('reviewModal').classList.add('hidden');
}

function setReviewRating(rating) {
    document.getElementById('reviewRatingValue').value = rating;
    document.querySelectorAll('.star-btn').forEach(star => {
        const val = parseInt(star.dataset.value);
        if (val <= rating) {
            star.className = 'fa-solid fa-star star-btn text-amber-400';
        } else {
            star.className = 'fa-solid fa-star star-btn text-slate-200';
        }
    });
}

async function handleReviewSubmit(e) {
    e.preventDefault();
    const reservationId = parseInt(document.getElementById('reviewReservationId').value);
    const rating = parseInt(document.getElementById('reviewRatingValue').value);
    const comment = document.getElementById('reviewComment').value;

    try {
        const res = await fetch(`${API_BASE}/reviews`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({ reservationId, rating, comment })
        });
        const data = await res.json();
        if (!res.ok) {
            showToast('Review Failed', data.message || 'Cannot submit review.', 'error');
            return;
        }

        closeReviewModal();
        showToast('Review Posted!', 'Your evaluation has been published to the partner profile.', 'success');
        if (currentView === 'charity') loadCharityReservations();
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

