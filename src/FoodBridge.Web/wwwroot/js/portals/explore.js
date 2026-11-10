async function loadLandingStats() {
    try {
        const res = await fetch(`${API_BASE}/reports/platform-stats`);
        if (res.ok) {
            const stats = await res.json();
            animateCounter('landingStatRedistributed', stats.totalFoodRedistributedQuantity || 115);
            animateCounter('landingStatDonations',    stats.totalCompletedDonations || 2);
            animateCounter('landingStatProviders',    stats.totalProviders || 5);
            animateCounter('landingStatCharities',    stats.totalCharities || 3);
        } else {
            animateCounter('landingStatRedistributed', 115);
            animateCounter('landingStatDonations', 2);
            animateCounter('landingStatProviders', 5);
            animateCounter('landingStatCharities', 3);
        }
    } catch (_) {
        animateCounter('landingStatRedistributed', 115);
        animateCounter('landingStatDonations', 2);
        animateCounter('landingStatProviders', 5);
        animateCounter('landingStatCharities', 3);
    }
    setTimeout(() => {
        initScrollReveal();
        init3DTilt();
    }, 60);
}

function setCategoryFilter(category) {
    currentCategoryFilter = category;
    document.querySelectorAll('.category-pill').forEach(pill => {
        if ((!category && pill.dataset.category === 'all') || (pill.dataset.category === category)) {
            pill.className = 'category-pill px-3.5 py-1.5 rounded-full text-xs font-semibold bg-emerald-600 text-white shadow-sm transition shrink-0';
        } else {
            pill.className = 'category-pill px-3.5 py-1.5 rounded-full text-xs font-semibold bg-slate-100 text-slate-700 hover:bg-slate-200 transition shrink-0';
        }
    });
    loadExploreListings();
}

function resetExploreFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('providerTypeFilter').value = '';
    document.getElementById('dateFilter').value = '';
    document.getElementById('sortByFilter').value = 'newest';
    setCategoryFilter(null);
}

async function loadExploreListings() {
    if (!currentUser) {
        const grid = document.getElementById('listingsGrid');
        const emptyState = document.getElementById('emptyListingsState');
        const countDisplay = document.getElementById('listingCountDisplay');
        if (countDisplay) countDisplay.textContent = '0 active food donations';
        if (grid) grid.innerHTML = '';
        if (emptyState) emptyState.classList.remove('hidden');
        return;
    }

    const search = document.getElementById('searchInput')?.value || '';
    const providerType = document.getElementById('providerTypeFilter')?.value || '';
    const date = document.getElementById('dateFilter')?.value || '';
    const sortBy = document.getElementById('sortByFilter')?.value || 'newest';

    const params = new URLSearchParams({
        onlyAvailable: 'true',
        sortBy: sortBy,
        pageSize: '30'
    });
    if (currentCategoryFilter) params.append('category', currentCategoryFilter);
    if (search) params.append('searchTerm', search);
    if (providerType) params.append('providerType', providerType);
    if (date) params.append('availabilityDate', date);

    const grid = document.getElementById('listingsGrid');
    const emptyState = document.getElementById('emptyListingsState');
    const countDisplay = document.getElementById('listingCountDisplay');

    try {
        const res = await fetch(`${API_BASE}/foodlistings?${params.toString()}`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        if (res.status === 401) {
            currentUser = null;
            localStorage.removeItem('foodbridge_user');
            updateAuthUI();
            openAuthModal('login');
            return;
        }
        const data = await res.json();

        if (countDisplay) {
            countDisplay.textContent = `${data.totalCount || 0} active food donations`;
        }

        if (!data.items || data.items.length === 0) {
            grid.innerHTML = '';
            emptyState.classList.remove('hidden');
            return;
        }

        emptyState.classList.add('hidden');
        grid.innerHTML = data.items.map(item => renderListingCard(item)).join('');

    } catch (err) {
        console.error('Error loading explore listings:', err);
    }
}

function renderListingCard(item) {
    const dict = i18nDict[currentLang] || i18nDict.en;
    const isAr = currentLang === 'ar';
    const imgUrl = item.imageUrl || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop&q=80';
    const ratingDisplay = item.providerAverageRating > 0 
        ? `<span class="inline-flex items-center text-amber-500 font-bold text-xs"><i class="fa-solid fa-star text-[10px] ${isAr ? 'ml-1' : 'mr-1'}"></i>${item.providerAverageRating.toFixed(1)}</span>`
        : `<span class="text-slate-400 text-[10px]">${isAr ? 'مزود جديد' : 'New provider'}</span>`;

    const deadline = new Date(item.pickupDeadline);
    const deadlineStr = deadline.toLocaleTimeString(isAr ? 'ar-EG' : [], { hour: '2-digit', minute: '2-digit', month: 'short', day: 'numeric' });

    return `
        <div class="interactive-card bg-white dark:bg-slate-800 rounded-3xl border border-slate-200/90 dark:border-slate-700 overflow-hidden shadow-sm hover:shadow-2xl hover:border-emerald-400 dark:hover:border-emerald-500/50 transition-all duration-300 flex flex-col group">
            <div class="relative h-48 bg-slate-100 dark:bg-slate-900 overflow-hidden">
                <img src="${escapeHtml(imgUrl)}" alt="${escapeHtml(item.foodName)}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500 ease-out">
                <div class="absolute top-3 ${isAr ? 'right-3' : 'left-3'} px-2.5 py-1 rounded-full text-[11px] font-bold bg-white/95 dark:bg-slate-900/90 text-slate-800 dark:text-slate-100 shadow-md backdrop-blur-md group-hover:scale-105 group-hover:shadow-emerald-500/20 transition-all duration-300">
                    ${formatCategory(item.foodCategory)}
                </div>
                <div class="absolute top-3 ${isAr ? 'left-3' : 'right-3'} px-2.5 py-1 rounded-full text-[11px] font-bold bg-emerald-600 text-white shadow-md group-hover:scale-105 group-hover:bg-emerald-500 transition-all duration-300">
                    ${escapeHtml(item.quantity)} ${escapeHtml(item.unitOfMeasurement)}
                </div>
            </div>

            <div class="p-5 flex-1 flex flex-col justify-between">
                <div>
                    <div class="flex items-center justify-between text-xs text-slate-500 mb-1.5">
                        <span class="font-semibold text-slate-700 dark:text-slate-200 truncate max-w-[180px]">${escapeHtml(item.providerOrganization)}</span>
                        ${ratingDisplay}
                    </div>

                    <h3 class="font-heading font-bold text-lg text-slate-900 dark:text-white mb-2 leading-snug line-clamp-2 group-hover:text-emerald-600 dark:group-hover:text-emerald-400 group-hover:translate-x-0.5 transition-all duration-200">
                        ${escapeHtml(item.foodName)}
                    </h3>

                    <p class="text-xs text-slate-500 dark:text-slate-400 line-clamp-2 mb-4 leading-relaxed">
                        ${escapeHtml(item.description)}
                    </p>

                    <!-- Key disclosures (FR2.3, FR3.2) -->
                    <div class="flex flex-wrap gap-1.5 mb-4 text-[11px]">
                        <span class="px-2 py-0.5 rounded-md bg-blue-50 dark:bg-blue-950/40 text-blue-700 dark:text-blue-300 border border-blue-100 dark:border-blue-900/50 flex items-center">
                            <i class="fa-solid fa-snowflake text-[10px] ${isAr ? 'ml-1' : 'mr-1'} text-blue-500"></i> ${escapeHtml(item.storageConditions)}
                        </span>
                        <span class="px-2 py-0.5 rounded-md bg-amber-50 dark:bg-amber-950/40 text-amber-700 dark:text-amber-300 border border-amber-100 dark:border-amber-900/50 flex items-center">
                            <i class="fa-solid fa-triangle-exclamation text-[10px] ${isAr ? 'ml-1' : 'mr-1'} text-amber-500"></i> ${dict.allergens}: ${escapeHtml(item.allergens)}
                        </span>
                    </div>
                </div>

                <div class="pt-3 border-t border-slate-100 dark:border-slate-700 flex items-center justify-between">
                    <div>
                        <div class="text-[10px] font-semibold text-slate-400 uppercase tracking-wider">${dict.pickupBefore}</div>
                        <div class="text-xs font-bold text-rose-600 flex items-center">
                            <i class="fa-regular fa-clock ${isAr ? 'ml-1' : 'mr-1'} text-[11px] animate-pulse"></i> ${deadlineStr}
                        </div>
                    </div>
                    <button onclick="openListingDetailModal(${item.id})" class="btn-glow px-4 py-2 rounded-xl text-xs font-bold bg-emerald-50 dark:bg-emerald-950/40 text-emerald-700 dark:text-emerald-300 group-hover:bg-emerald-600 group-hover:text-white transition-all duration-300 shadow-xs group-hover:shadow-lg group-hover:scale-105 active:scale-95">
                        ${dict.viewAndReserve}
                    </button>
                </div>
            </div>
        </div>
    `;
}

async function openListingDetailModal(listingId) {
    if (!currentUser) {
        const isAr = currentLang === 'ar';
        showToast(
            isAr ? 'تسجيل الدخول مطلوب' : 'Sign In Required',
            isAr ? 'يرجى تسجيل الدخول أو إنشاء حساب لعرض تفاصيل التبرع والحجز.' : 'Please sign in to view details and reserve food.',
            'warning'
        );
        openAuthModal('login');
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/foodlistings/${listingId}`, {
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        if (!res.ok) {
            if (res.status === 401) {
                openAuthModal('login');
                return;
            }
            throw new Error('Failed to fetch listing details');
        }
        const listing = await res.json();
        currentDetailListing = listing;

        document.getElementById('detailModalFoodName').textContent = listing.foodName;
        document.getElementById('detailModalProviderInfo').textContent = `By ${listing.providerOrganization} (${listing.providerType}) • ⭐ ${listing.providerAverageRating > 0 ? listing.providerAverageRating.toFixed(1) : 'New'} (${listing.providerReviewsCount} reviews)`;
        document.getElementById('detailModalQuantity').textContent = `${listing.quantity} ${listing.unitOfMeasurement}`;
        document.getElementById('detailModalDescription').textContent = listing.description;
        document.getElementById('detailModalCategoryBadge').textContent = formatCategory(listing.foodCategory);
        document.getElementById('detailModalStorage').textContent = listing.storageConditions;
        document.getElementById('detailModalAllergens').textContent = listing.allergens;
        document.getElementById('detailModalDeadline').textContent = new Date(listing.pickupDeadline).toLocaleString();
        document.getElementById('detailModalAddress').textContent = listing.pickupAddress;
        document.getElementById('detailModalImage').src = listing.imageUrl || 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop&q=80';

        const reserveBtn = document.getElementById('detailModalReserveBtn');
        if (currentUser && currentUser.role === 'Charity') {
            reserveBtn.classList.remove('hidden');
        } else {
            reserveBtn.classList.add('hidden');
        }

        document.getElementById('listingDetailModal').classList.remove('hidden');
    } catch (err) {
        showToast('Error', 'Unable to fetch listing details.', 'error');
    }
}

function closeListingDetailModal() {
    document.getElementById('listingDetailModal').classList.add('hidden');
    currentDetailListing = null;
}

async function requestReservationFromModal() {
    if (!currentDetailListing) return;
    if (!currentUser || currentUser.role !== 'Charity') {
        showToast('Charity Required', 'Please switch to a Charity account to request food reservations.', 'warning');
        return;
    }

    try {
        const res = await fetch(`${API_BASE}/reservations/request`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({ foodListingId: currentDetailListing.Id || currentDetailListing.id })
        });

        const data = await res.json();
        if (!res.ok) {
            showToast('Reservation Request Blocked', data.message || 'Error occurred.', 'error');
            return;
        }

        closeListingDetailModal();
        showToast('Reservation Requested!', 'Your reservation request was dispatched to the food provider.', 'success');
        navigateTo('charity');
    } catch (err) {
        showToast('Error', err.message, 'error');
    }
}

