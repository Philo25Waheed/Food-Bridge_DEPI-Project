async function loadProviderPortal() {
    if (!currentUser || (currentUser.role !== 'Provider' && currentUser.role !== 'Admin')) {
        const isAr = currentLang === 'ar';
        showToast(isAr ? 'تسجيل الدخول مطلوب' : 'Provider Access Only', isAr ? 'يرجى تسجيل الدخول بحساب مزود طعام.' : 'Please sign in or switch to a Provider profile.', 'info');
        navigateTo('landing');
        return;
    }

    await loadProviderStats();
    await loadProviderListings();
    await loadProviderRequests();
}

async function loadProviderStats() {
    if (!currentUser) return;
    try {
        const res = await fetch(`${API_BASE}/reports/provider`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        if (res.ok) {
            const stats = await res.json();
            document.getElementById('statProviderTotalListed').textContent = stats.totalListed;
            document.getElementById('statProviderTotalCompleted').textContent = stats.totalCompleted;
            document.getElementById('statProviderActiveListings').textContent = stats.activeListings;
            document.getElementById('statProviderRedistributed').textContent = `${stats.totalRedistributedQuantity}`;
            document.getElementById('statProviderRating').textContent = stats.averageRating > 0 ? stats.averageRating.toFixed(1) : '5.0';
            document.getElementById('statProviderReviewsCount').textContent = `Based on ${stats.totalReviews} reviews`;
        }
    } catch (err) {
        console.error('Error fetching provider stats:', err);
    }
}

async function loadProviderListings() {
    if (!currentUser) return;
    const status = document.getElementById('providerListingsStatusFilter')?.value || '';
    const tbody = document.getElementById('providerListingsTableBody');

    try {
        const res = await fetch(`${API_BASE}/foodlistings/provider/my-listings?status=${status}`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        const listings = await res.json();

        const dict = i18nDict[currentLang] || i18nDict.en;
        const isAr = currentLang === 'ar';

        if (!listings || listings.length === 0) {
            tbody.innerHTML = `<tr><td colspan="6" class="px-5 py-8 text-center text-slate-400 text-xs">${isAr ? 'لم يتم العثور على تبرعات طعام بهذه الحالة.' : 'No food donation listings found for this status.'}</td></tr>`;
            return;
        }

        tbody.innerHTML = listings.map(l => {
            const statusClass = l.status === 'Available' ? 'bg-emerald-100 text-emerald-800' :
                                l.status === 'Reserved' ? 'bg-amber-100 text-amber-800' :
                                l.status === 'Completed' ? 'bg-blue-100 text-blue-800' : 'bg-slate-100 text-slate-600';

            const deadline = new Date(l.pickupDeadline).toLocaleString(isAr ? 'ar-EG' : [], { dateStyle: 'short', timeStyle: 'short' });

            const actions = l.status === 'Available' 
                ? `<button onclick="markListingUnavailable(${l.id})" class="px-2.5 py-1 text-xs rounded-lg text-rose-600 hover:bg-rose-50 border border-rose-200">${dict.markUnavailable}</button>`
                : `<span class="text-xs text-slate-400">—</span>`;

            return `
                <tr class="hover:bg-slate-50 dark:hover:bg-slate-800 transition">
                    <td class="px-5 py-4 font-semibold text-slate-800 dark:text-slate-100">${escapeHtml(l.foodName)}</td>
                    <td class="px-5 py-4">${formatCategory(l.foodCategory)}</td>
                    <td class="px-5 py-4 font-bold text-slate-700 dark:text-slate-200">${escapeHtml(l.quantity)} ${escapeHtml(l.unitOfMeasurement)}</td>
                    <td class="px-5 py-4 text-xs">${deadline}</td>
                    <td class="px-5 py-4"><span class="px-2 py-0.5 rounded-full text-xs font-bold ${statusClass}">${formatStatus(l.status)}</span></td>
                    <td class="px-5 py-4 ${isAr ? 'text-left' : 'text-right'}">${actions}</td>
                </tr>
            `;
        }).join('');

    } catch (err) {
        console.error('Error fetching provider listings:', err);
    }
}

async function loadProviderRequests() {
    if (!currentUser) return;
    const container = document.getElementById('providerRequestsList');
    const badge = document.getElementById('providerIncomingCount');
    const dict = i18nDict[currentLang] || i18nDict.en;
    const isAr = currentLang === 'ar';

    try {
        const res = await fetch(`${API_BASE}/reservations/provider/incoming`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        const requests = await res.json();

        const pending = requests.filter(r => r.status === 'Pending');
        if (badge) badge.textContent = pending.length;

        if (!requests || requests.length === 0) {
            container.innerHTML = `<div class="p-8 text-center text-slate-400 text-xs bg-white rounded-2xl border border-slate-200">${isAr ? 'لا توجد طلبات حجز واردة حالياً.' : 'No incoming reservation requests.'}</div>`;
            return;
        }

        container.innerHTML = requests.map(r => {
            const isPending = r.status === 'Pending';
            const isAccepted = r.status === 'Accepted';

            let buttons = '';
            if (isPending) {
                buttons = `
                    <div class="flex items-center space-x-2">
                        <button onclick="openAcceptReservationModal(${r.id}, '${escapeHtml(r.foodName)}')" class="px-4 py-2 rounded-xl text-xs font-semibold bg-emerald-600 hover:bg-emerald-700 text-white shadow-sm">
                            <i class="fa-solid fa-check ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.acceptPickup}
                        </button>
                        <button onclick="rejectReservation(${r.id})" class="px-3 py-2 rounded-xl text-xs font-semibold text-rose-600 hover:bg-rose-50 border border-rose-200">
                            ${dict.decline}
                        </button>
                    </div>
                `;
            } else if (isAccepted) {
                buttons = `
                    <button onclick="markReadyForPickup(${r.id})" class="px-4 py-2 rounded-xl text-xs font-semibold bg-indigo-600 hover:bg-indigo-700 text-white shadow-sm">
                        <i class="fa-solid fa-box ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.markReady}
                    </button>
                `;
            } else if (r.status === 'ReadyForPickup') {
                buttons = `<span class="inline-flex items-center text-xs font-semibold text-indigo-700 bg-indigo-50 px-3 py-1.5 rounded-xl border border-indigo-200"><i class="fa-solid fa-hourglass-half ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.awaitingPickup}</span>`;
            } else if (r.status === 'Completed') {
                buttons = `<span class="inline-flex items-center text-xs font-semibold text-emerald-700 bg-emerald-50 px-3 py-1.5 rounded-xl border border-emerald-200"><i class="fa-solid fa-check-double ${isAr ? 'ml-1' : 'mr-1'}"></i> ${dict.completedDouble}</span>`;
            } else {
                buttons = `<span class="text-xs text-slate-400 font-semibold">${formatStatus(r.status)}</span>`;
            }

            return `
                <div class="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <div class="flex items-center space-x-2 mb-1">
                            <span class="px-2 py-0.5 rounded text-[10px] font-bold bg-slate-100 text-slate-700 uppercase">${r.foodCategory}</span>
                            <span class="text-xs font-semibold text-emerald-600">${escapeHtml(r.quantity)} ${escapeHtml(r.unitOfMeasurement)}</span>
                        </div>
                        <h4 class="font-heading font-bold text-base text-slate-900">${escapeHtml(r.foodName)}</h4>
                        <div class="text-xs text-slate-600 mt-1 flex flex-wrap gap-x-4 gap-y-1">
                            <span><i class="fa-solid fa-hand-holding-heart mr-1 text-emerald-600"></i> ${escapeHtml(r.charityOrganization)}</span>
                            <span><i class="fa-solid fa-user mr-1 text-slate-400"></i> ${escapeHtml(r.charityName)}</span>
                            <span><i class="fa-solid fa-envelope mr-1 text-slate-400"></i> ${escapeHtml(r.charityEmail)}</span>
                        </div>
                        ${r.charityTargetCommunity ? `<div class="text-[11px] text-slate-500 mt-1.5 bg-slate-50 p-2 rounded-lg border border-slate-100"><strong>Mission:</strong> ${escapeHtml(r.charityTargetCommunity)}</div>` : ''}
                        ${r.confirmedLocation ? `<div class="text-[11px] text-indigo-700 mt-1"><strong>Agreed Location:</strong> ${escapeHtml(r.confirmedLocation)} • <strong>Pickup:</strong> ${new Date(r.pickupDateTime).toLocaleString()}</div>` : ''}
                    </div>
                    <div class="shrink-0 flex items-center justify-end">
                        ${buttons}
                    </div>
                </div>
            `;
        }).join('');

    } catch (err) {
        console.error('Error fetching provider requests:', err);
    }
}

function switchProviderTab(tab) {
    if (tab === 'listings') {
        document.getElementById('providerTabListings').classList.remove('hidden');
        document.getElementById('providerTabRequests').classList.add('hidden');
        document.getElementById('ptab-listings').className = 'pb-3 text-sm font-semibold text-emerald-600 border-b-2 border-emerald-600';
        document.getElementById('ptab-requests').className = 'pb-3 text-sm font-semibold text-slate-500 hover:text-slate-800 border-b-2 border-transparent';
    } else {
        document.getElementById('providerTabListings').classList.add('hidden');
        document.getElementById('providerTabRequests').classList.remove('hidden');
        document.getElementById('ptab-listings').className = 'pb-3 text-sm font-semibold text-slate-500 hover:text-slate-800 border-b-2 border-transparent';
        document.getElementById('ptab-requests').className = 'pb-3 text-sm font-semibold text-emerald-600 border-b-2 border-emerald-600';
    }
}

function openCreateListingModal() {
    if (!currentUser || currentUser.role !== 'Provider') {
        showToast('Provider Login Required', 'Please switch to a Provider profile to create donation listings.', 'warning');
        return;
    }

    const now = new Date();
    const nowStr = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toISOString().slice(0, 16);
    const deadline = new Date(now.getTime() + 12 * 60 * 60 * 1000);
    const deadlineStr = new Date(deadline.getTime() - deadline.getTimezoneOffset() * 60000).toISOString().slice(0, 16);

    document.getElementById('createPrepDate').value = nowStr;
    document.getElementById('createPickupDeadline').value = deadlineStr;
    document.getElementById('createAddress').value = currentUser.organizationAddress || '42 Nile Corniche, Cairo';

    document.getElementById('createListingModal').classList.remove('hidden');
}

function closeCreateListingModal() {
    document.getElementById('createListingModal').classList.add('hidden');
}

async function handleCreateListing(e) {
    e.preventDefault();
    if (!currentUser) return;

    const foodName = document.getElementById('createFoodName').value;
    const foodCategory = document.getElementById('createFoodCategory').value;
    const quantity = parseFloat(document.getElementById('createQuantity').value);
    const unitOfMeasurement = document.getElementById('createUnit').value;
    const description = document.getElementById('createDescription').value;
    const prepDate = document.getElementById('createPrepDate').value;
    const pickupDeadline = document.getElementById('createPickupDeadline').value;
    const storageConditions = document.getElementById('createStorage').value;
    const allergens = document.getElementById('createAllergens').value;
    const pickupAddress = document.getElementById('createAddress').value;
    const imageFile = document.getElementById('createImageFile').files[0];
    const imageUrl = document.getElementById('createImageUrl').value;

    const submitBtn = document.getElementById('createListingSubmitBtn');
    submitBtn.disabled = true;
    submitBtn.textContent = 'Publishing...';

    try {
        let res;
        if (imageFile) {
            const formData = new FormData();
            formData.append('FoodName', foodName);
            formData.append('FoodCategory', foodCategory);
            formData.append('Quantity', quantity);
            formData.append('UnitOfMeasurement', unitOfMeasurement);
            formData.append('Description', description);
            formData.append('PreparationDate', prepDate);
            formData.append('PickupDeadline', pickupDeadline);
            formData.append('StorageConditions', storageConditions);
            formData.append('Allergens', allergens);
            formData.append('PickupAddress', pickupAddress);
            formData.append('image', imageFile);

            res = await fetch(`${API_BASE}/foodlistings`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${currentUser.token}` },
                body: formData
            });
        } else {
            const payload = {
                foodName,
                foodCategory,
                quantity,
                unitOfMeasurement,
                description,
                preparationDate: prepDate,
                pickupDeadline,
                storageConditions,
                allergens,
                pickupAddress
            };

            res = await fetch(`${API_BASE}/foodlistings/json`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${currentUser.token}`
                },
                body: JSON.stringify(payload)
            });
        }

        const data = await res.json();
        if (!res.ok) {
            showToast('Submission Failed', data.message || 'Error occurred.', 'error');
            return;
        }

        closeCreateListingModal();
        showToast('Donation Published!', 'Your surplus food donation is now discoverable by charities.', 'success');
        loadProviderListings();
        loadProviderStats();

    } catch (err) {
        showToast('Error', err.message, 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = 'Publish Donation';
    }
}

async function markListingUnavailable(listingId) {
    if (!confirm('Mark this listing as unavailable? Charities will no longer be able to reserve it.')) return;
    try {
        const res = await fetch(`${API_BASE}/foodlistings/${listingId}/unavailable`, {
            method: 'PATCH',
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        if (res.ok) {
            showToast('Updated', 'Listing marked as unavailable.', 'info');
            loadProviderListings();
            loadProviderStats();
        }
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

function openAcceptReservationModal(reservationId, foodName) {
    document.getElementById('acceptReservationId').value = reservationId;

    const now = new Date();
    const scheduled = new Date(now.getTime() + 2 * 60 * 60 * 1000);
    const scheduledStr = new Date(scheduled.getTime() - scheduled.getTimezoneOffset() * 60000).toISOString().slice(0, 16);

    document.getElementById('acceptPickupDateTime').value = scheduledStr;
    document.getElementById('acceptLocation').value = currentUser.organizationAddress || '42 Nile Corniche, Kitchen Loading Dock';

    document.getElementById('acceptReservationModal').classList.remove('hidden');
}

function closeAcceptReservationModal() {
    document.getElementById('acceptReservationModal').classList.add('hidden');
}

async function handleAcceptReservationSubmit(e) {
    e.preventDefault();
    const id = document.getElementById('acceptReservationId').value;
    const pickupDateTime = document.getElementById('acceptPickupDateTime').value;
    const confirmedLocation = document.getElementById('acceptLocation').value;

    try {
        const res = await fetch(`${API_BASE}/reservations/${id}/accept`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({ pickupDateTime, confirmedLocation })
        });
        const data = await res.json();
        if (!res.ok) {
            showToast('Action Failed', data.message || 'Error accepting reservation.', 'error');
            return;
        }

        closeAcceptReservationModal();
        showToast('Reservation Accepted', 'Confirmed pickup details transmitted to charity via SignalR.', 'success');
        loadProviderRequests();
        loadProviderStats();
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

async function rejectReservation(id) {
    const reason = prompt('Please enter the reason for rejecting this reservation:');
    if (!reason) return;

    try {
        const res = await fetch(`${API_BASE}/reservations/${id}/reject`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({ reason })
        });
        if (res.ok) {
            showToast('Declined', 'Reservation request declined.', 'info');
            loadProviderRequests();
        }
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

async function markReadyForPickup(id) {
    try {
        const res = await fetch(`${API_BASE}/reservations/${id}/ready-for-pickup`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        if (res.ok) {
            showToast('Ready for Pickup!', 'Charity notified food is packaged and waiting for collection.', 'success');
            loadProviderRequests();
        }
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

