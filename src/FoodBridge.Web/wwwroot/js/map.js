// FoodBridge Egypt Nationwide Coverage Map Module
let egyptMapInstance = null;
let currentTileLayer = null;
let egyptMapMarkers = [];
let currentTileType = 'google'; // 'google', 'satellite', 'osm', 'embed'

const EGYPT_HUBS = [
    {
        id: 'cairo',
        region: 'cairo',
        nameAr: 'مركز القاهرة الكبرى اللوجستي',
        nameEn: 'Greater Cairo Central Hub',
        govAr: 'القاهرة والجيزة والقليوبية',
        govEn: 'Cairo, Giza & Qalyubia',
        coords: [30.0444, 31.2357],
        partnersCount: 48,
        charitiesCount: 35,
        mealsCount: '14,250+',
        topPartners: ['Bella Italia Ristorante', 'Artisan Bread & Pastry Co.', 'Nile Grand Palace', 'Zamalek Bakery Studio'],
        topCharities: ['بنك الطعام المصري', 'جمعية رسالة للأعمال الخيرية', 'مؤسسة مصر الخير'],
        addressAr: 'مجمع واحة الابتكار، القرية الذكية & حي الزمالك، القاهرة',
        addressEn: 'Innovation Way, Smart Village & Zamalek, Cairo',
        featured: true
    },
    {
        id: 'alex',
        region: 'alex',
        nameAr: 'مركز الإسكندرية والساحل الشمالي',
        nameEn: 'Alexandria & North Coast Hub',
        govAr: 'الإسكندرية ومطروح',
        govEn: 'Alexandria & Matrouh',
        coords: [31.2001, 29.9187],
        partnersCount: 32,
        charitiesCount: 22,
        mealsCount: '8,400+',
        topPartners: ['Mediterranean Sea Breeze Hotel', 'Alex Patisserie & Pastry', 'Corniche Gourmet Buffets'],
        topCharities: ['جمعية صناع الحياة الإسكندرية', 'مبرة العصافرة الخيرية'],
        addressAr: 'طريق الكورنيش، محطة الرمل وسموحة، الإسكندرية',
        addressEn: 'Corniche Road, Raml Station & Smouha, Alex',
        featured: false
    },
    {
        id: 'delta',
        region: 'delta',
        nameAr: 'مركز الدلتا والإنتاج الزراعي',
        nameEn: 'Delta Agriculture & Food Hub',
        govAr: 'الدقهلية والغربية والشرقية',
        govEn: 'Dakahlia, Gharbia & Sharqia',
        coords: [31.0409, 31.3785],
        partnersCount: 24,
        charitiesCount: 18,
        mealsCount: '6,100+',
        topPartners: ['Delta Fresh Greenhouses', 'Al-Mansoura Sweet Bakery', 'Tanta Golden Grains'],
        topCharities: ['جمعية سنابل الخير', 'مؤسسة أهل الدلتا التنموية'],
        addressAr: 'شارع الجمهورية، المنصورة & طنطا',
        addressEn: 'Gomhoria Street, Mansoura & Tanta',
        featured: false
    },
    {
        id: 'canal',
        region: 'canal',
        nameAr: 'مركز مدن القناة والخدمات اللوجستية',
        nameEn: 'Suez Canal Cities Hub',
        govAr: 'بورسعيد والإسماعيلية والسويس',
        govEn: 'Port Said, Ismailia & Suez',
        coords: [30.5965, 32.2715],
        partnersCount: 16,
        charitiesCount: 12,
        mealsCount: '4,200+',
        topPartners: ['Canal Marine Catering', 'Port Said Bakery Workshop', 'Suez Bay Hospitality'],
        topCharities: ['جمعية شباب القناة للتكافل الاجتماعي'],
        addressAr: 'شارع محمد علي، الإسماعيلية & حي المناخ، بورسعيد',
        addressEn: 'Mohamed Ali St, Ismailia & Port Said',
        featured: false
    },
    {
        id: 'upper',
        region: 'upper',
        nameAr: 'مركز صعيد مصر للإغاثة والتكافل',
        nameEn: 'Upper Egypt Relief & Food Hub',
        govAr: 'أسيوط وسوهاج والمنيا وقنا',
        govEn: 'Assiut, Sohag, Minya & Qena',
        coords: [27.1801, 31.1837],
        partnersCount: 22,
        charitiesCount: 19,
        mealsCount: '6,800+',
        topPartners: ['Assiut University Banquets', 'Nile Mill & Bakery Co.', 'Upper Egypt Hospitality'],
        topCharities: ['جمعية تنمية المجتمع بأسيوط', 'مؤسسة مصر الخير - صعيد مصر'],
        addressAr: 'ميدان المحطة، أسيوط & شارع الجمهورية، سوهاج',
        addressEn: 'Station Square, Assiut & Gomhoria St, Sohag',
        featured: false
    },
    {
        id: 'redsea',
        region: 'coastal',
        nameAr: 'مركز البحر الأحمر وجنوب سيناء السياحي',
        nameEn: 'Red Sea & Resorts Hospitality Hub',
        govAr: 'البحر الأحمر وجنوب سيناء',
        govEn: 'Red Sea & South Sinai',
        coords: [27.2579, 33.8116],
        partnersCount: 20,
        charitiesCount: 10,
        mealsCount: '5,350+',
        topPartners: ['Red Sea Luxury Resorts', 'Sharm El Sheikh Palace Buffets', 'Sinai Hospitality Network'],
        topCharities: ['جمعية حماية البيئة والتكافل الاجتماعي بالبحر الأحمر'],
        addressAr: 'الممشى السياحي، الغردقة & خليج نعمة، شرم الشيخ',
        addressEn: 'Touristic Promenade, Hurghada & Naama Bay, Sharm',
        featured: false
    },
    {
        id: 'luxor',
        region: 'upper',
        nameAr: 'مركز الأقصر وأسوان الحضاري',
        nameEn: 'Luxor & Aswan Heritage Hub',
        govAr: 'الأقصر وأسوان',
        govEn: 'Luxor & Aswan',
        coords: [25.6872, 32.6396],
        partnersCount: 14,
        charitiesCount: 11,
        mealsCount: '3,600+',
        topPartners: ['Nile Cruise Floating Restaurants', 'Luxor Palace Catering Services'],
        topCharities: ['مؤسسة أبناء النيل الخيرية بالأقصر'],
        addressAr: 'كورنيش النيل، الأقصر & كورنيش أسوان',
        addressEn: 'Nile Corniche, Luxor & Aswan',
        featured: false
    }
];

function initEgyptMap() {
    const mapElement = document.getElementById('egyptMap');
    const iframeElement = document.getElementById('googleMapIframe');
    if (!mapElement) return;

    if (typeof L === 'undefined') {
        // Fallback to official Google Maps embed directly
        if (mapElement) mapElement.classList.add('hidden');
        if (iframeElement) iframeElement.classList.remove('hidden');
        renderEgyptHubCards('all');
        return;
    }

    if (egyptMapInstance) {
        setTimeout(() => egyptMapInstance.invalidateSize(), 150);
        return;
    }

    const isDark = document.documentElement.classList.contains('dark');

    try {
        // Centered on Egypt
        egyptMapInstance = L.map('egyptMap', {
            center: [27.8, 31.0],
            zoom: 6,
            minZoom: 5,
            maxZoom: 18,
            scrollWheelZoom: false,
            attributionControl: false
        });

        applyMapTileLayer(isDark);
        renderEgyptHubsOnMap();
        renderEgyptHubCards('all');

        setTimeout(() => {
            if (egyptMapInstance) egyptMapInstance.invalidateSize();
        }, 250);
    } catch (err) {
        console.warn('Leaflet initialization fallback to Google Maps Embed:', err);
        if (mapElement) mapElement.classList.add('hidden');
        if (iframeElement) iframeElement.classList.remove('hidden');
        renderEgyptHubCards('all');
    }
}

function applyMapTileLayer(isDark, overrideType) {
    if (!egyptMapInstance) return;
    if (currentTileLayer) {
        try { egyptMapInstance.removeLayer(currentTileLayer); } catch (_) {}
    }

    const type = overrideType || (isDark ? 'dark' : (currentTileType || 'google'));
    let tileUrl = '';
    let options = {};

    if (type === 'satellite') {
        tileUrl = 'https://{s}.google.com/vt/lyrs=y&x={x}&y={y}&z={z}';
        options = { subdomains: ['mt0', 'mt1', 'mt2', 'mt3'], maxZoom: 20 };
    } else if (type === 'osm') {
        tileUrl = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
        options = { subdomains: 'abc', maxZoom: 19 };
    } else if (type === 'dark' || (isDark && type !== 'satellite')) {
        tileUrl = 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png';
        options = { subdomains: 'abcd', maxZoom: 19 };
    } else { // default 'google' streets
        tileUrl = 'https://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}';
        options = { subdomains: ['mt0', 'mt1', 'mt2', 'mt3'], maxZoom: 20 };
    }

    currentTileLayer = L.tileLayer(tileUrl, options).addTo(egyptMapInstance);
}

function setMapLayer(layerType) {
    currentTileType = layerType;
    const isDark = document.documentElement.classList.contains('dark');
    
    const mapEl = document.getElementById('egyptMap');
    const iframeEl = document.getElementById('googleMapIframe');

    // Update active button styles
    const btnGoogle = document.getElementById('btnLayerGoogle');
    const btnSatellite = document.getElementById('btnLayerSatellite');
    const btnEmbed = document.getElementById('btnLayerEmbed');

    [btnGoogle, btnSatellite, btnEmbed].forEach(btn => {
        if (btn) btn.className = 'px-2.5 py-1 rounded-lg text-[11px] font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition flex items-center';
    });

    if (layerType === 'embed') {
        if (btnEmbed) btnEmbed.className = 'px-2.5 py-1 rounded-lg text-[11px] font-bold bg-emerald-600 text-white transition flex items-center shadow-xs';
        if (mapEl) mapEl.classList.add('hidden');
        if (iframeEl) iframeEl.classList.remove('hidden');
        return;
    }

    if (iframeEl) iframeEl.classList.add('hidden');
    if (mapEl) mapEl.classList.remove('hidden');

    if (layerType === 'satellite') {
        if (btnSatellite) btnSatellite.className = 'px-2.5 py-1 rounded-lg text-[11px] font-bold bg-emerald-600 text-white transition flex items-center shadow-xs';
    } else {
        if (btnGoogle) btnGoogle.className = 'px-2.5 py-1 rounded-lg text-[11px] font-bold bg-emerald-600 text-white transition flex items-center shadow-xs';
    }

    if (!egyptMapInstance) {
        initEgyptMap();
    } else {
        applyMapTileLayer(isDark, layerType);
        setTimeout(() => egyptMapInstance.invalidateSize(), 100);
    }
}

function renderEgyptHubsOnMap() {
    if (!egyptMapInstance) return;

    egyptMapMarkers.forEach(m => egyptMapInstance.removeLayer(m));
    egyptMapMarkers = [];

    const isAr = typeof currentLang !== 'undefined' ? currentLang === 'ar' : true;

    EGYPT_HUBS.forEach(hub => {
        const isFeatured = hub.featured;
        const iconHtml = `
            <div class="relative group cursor-pointer">
                <div class="w-10 h-10 rounded-2xl ${isFeatured ? 'bg-gradient-to-tr from-amber-500 to-emerald-500' : 'bg-emerald-600'} text-white shadow-xl shadow-emerald-900/40 border-2 border-white flex items-center justify-center font-bold text-sm transform transition duration-300 hover:scale-125 hover:rotate-6">
                    <i class="fa-solid fa-seedling"></i>
                </div>
                <div class="absolute -top-1 -right-1 w-3.5 h-3.5 bg-amber-400 rounded-full border-2 border-white animate-ping"></div>
                <div class="absolute -top-1 -right-1 w-3.5 h-3.5 bg-amber-500 rounded-full border-2 border-white"></div>
            </div>
        `;

        const customIcon = L.divIcon({
            html: iconHtml,
            className: 'custom-map-pin',
            iconSize: [40, 40],
            iconAnchor: [20, 20],
            popupAnchor: [0, -22]
        });

        const popupContent = `
            <div class="p-3 text-slate-800 dark:text-slate-100 font-sans ${isAr ? 'rtl text-right' : 'ltr text-left'}" style="min-width: 240px;">
                <div class="flex items-center space-x-2 rtl:space-x-reverse mb-1.5">
                    <span class="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-pulse"></span>
                    <span class="text-[10px] font-bold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">${isAr ? 'مركز معتمد نشط' : 'Active Verified Hub'}</span>
                </div>
                <h4 class="font-bold text-sm text-slate-900 dark:text-white mb-1">${escapeHtml(isAr ? hub.nameAr : hub.nameEn)}</h4>
                <p class="text-xs text-slate-500 dark:text-slate-400 mb-2.5"><i class="fa-solid fa-location-dot mr-1 rtl:ml-1 text-amber-500"></i> ${escapeHtml(isAr ? hub.govAr : hub.govEn)}</p>
                <div class="grid grid-cols-2 gap-2 bg-slate-50 dark:bg-slate-800/80 p-2 rounded-xl text-center text-xs mb-2 border border-slate-200/60 dark:border-slate-700/60">
                    <div>
                        <div class="text-[10px] text-slate-400 font-semibold">${isAr ? 'المزودين' : 'Providers'}</div>
                        <div class="font-bold text-emerald-600 dark:text-emerald-400 text-sm">${hub.partnersCount}+</div>
                    </div>
                    <div>
                        <div class="text-[10px] text-slate-400 font-semibold">${isAr ? 'الجمعيات' : 'Charities'}</div>
                        <div class="font-bold text-amber-600 dark:text-amber-400 text-sm">${hub.charitiesCount}+</div>
                    </div>
                </div>
                <div class="text-[11px] text-slate-600 dark:text-slate-300">
                    <span class="font-bold text-slate-700 dark:text-slate-200">${isAr ? 'الوجبات الموزعة:' : 'Meals Diverted:'}</span>
                    <span class="font-bold text-emerald-600 dark:text-emerald-400">${hub.mealsCount}</span>
                </div>
            </div>
        `;

        const marker = L.marker(hub.coords, { icon: customIcon })
            .addTo(egyptMapInstance)
            .bindPopup(popupContent, { className: 'foodbridge-map-popup' });

        marker.hubId = hub.id;
        egyptMapMarkers.push(marker);
    });
}

function renderEgyptHubCards(region = 'all') {
    const listContainer = document.getElementById('egyptHubCardsList');
    if (!listContainer) return;

    const isAr = typeof currentLang !== 'undefined' ? currentLang === 'ar' : true;
    const filtered = region === 'all' ? EGYPT_HUBS : EGYPT_HUBS.filter(h => h.region === region);

    listContainer.innerHTML = filtered.map(h => `
        <div onclick="focusEgyptHub('${h.id}')" id="hub-card-${h.id}" class="group p-4 rounded-2xl bg-white dark:bg-slate-800/90 border border-slate-200/80 dark:border-slate-700/80 hover:border-emerald-500/60 dark:hover:border-emerald-400/60 shadow-xs hover:shadow-lg transition-all duration-300 cursor-pointer text-left rtl:text-right relative overflow-hidden">
            <div class="flex items-start justify-between gap-2 mb-2">
                <div class="flex items-center space-x-2.5 rtl:space-x-reverse">
                    <div class="w-9 h-9 rounded-xl ${h.featured ? 'bg-amber-500/15 text-amber-600 dark:text-amber-400' : 'bg-emerald-500/15 text-emerald-600 dark:text-emerald-400'} flex items-center justify-center font-bold text-sm shrink-0 group-hover:scale-110 transition">
                        <i class="fa-solid fa-building-wheat"></i>
                    </div>
                    <div>
                        <h4 class="font-heading font-bold text-xs sm:text-sm text-slate-900 dark:text-white group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition">${escapeHtml(isAr ? h.nameAr : h.nameEn)}</h4>
                        <div class="text-[11px] text-slate-500 dark:text-slate-400"><i class="fa-solid fa-map-pin mr-1 rtl:ml-1 text-emerald-500"></i> ${escapeHtml(isAr ? h.govAr : h.govEn)}</div>
                    </div>
                </div>
                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${h.featured ? 'bg-amber-100 dark:bg-amber-950/60 text-amber-700 dark:text-amber-300' : 'bg-emerald-100 dark:bg-emerald-950/60 text-emerald-700 dark:text-emerald-300'} shrink-0">
                    ${h.mealsCount} ${isAr ? 'وجبة' : 'meals'}
                </span>
            </div>
            <div class="flex items-center justify-between text-[11px] text-slate-600 dark:text-slate-300 pt-2 border-t border-slate-100 dark:border-slate-700/60">
                <span><i class="fa-solid fa-utensils text-emerald-500 mr-1 rtl:ml-1"></i> ${h.partnersCount} ${isAr ? 'مزود طعام' : 'providers'}</span>
                <span><i class="fa-solid fa-hand-holding-heart text-amber-500 mr-1 rtl:ml-1"></i> ${h.charitiesCount} ${isAr ? 'جمعية خيرية' : 'charities'}</span>
                <span class="text-emerald-600 dark:text-emerald-400 font-bold group-hover:translate-x-1 rtl:group-hover:-translate-x-1 transition flex items-center">
                    ${isAr ? 'عرض' : 'View'} <i class="fa-solid fa-chevron-left rtl:fa-chevron-left ltr:fa-chevron-right text-[10px] ml-1 rtl:mr-1"></i>
                </span>
            </div>
        </div>
    `).join('');
}

function focusEgyptHub(hubId) {
    const hub = EGYPT_HUBS.find(h => h.id === hubId);
    if (!hub) return;

    const iframe = document.getElementById('googleMapIframe');
    if (iframe && !iframe.classList.contains('hidden')) {
        iframe.src = `https://maps.google.com/maps?q=${hub.coords[0]},${hub.coords[1]}&t=&z=13&ie=UTF8&iwloc=&output=embed`;
    }

    if (egyptMapInstance) {
        // Smooth fly to hub
        egyptMapInstance.flyTo(hub.coords, 12, {
            animate: true,
            duration: 1.2
        });

        // Open popup
        const targetMarker = egyptMapMarkers.find(m => m.hubId === hubId);
        if (targetMarker) {
            setTimeout(() => targetMarker.openPopup(), 900);
        }
    }

    // Highlight card
    document.querySelectorAll('[id^="hub-card-"]').forEach(c => {
        c.classList.remove('ring-2', 'ring-emerald-500', 'bg-emerald-50/40', 'dark:bg-emerald-950/20');
    });
    const card = document.getElementById(`hub-card-${hubId}`);
    if (card) {
        card.classList.add('ring-2', 'ring-emerald-500', 'bg-emerald-50/40', 'dark:bg-emerald-950/20');
        card.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
}

function filterEgyptMapRegion(region, btnElement) {
    renderEgyptHubCards(region);

    // Update active tab buttons
    const filterContainer = document.getElementById('egyptHubFilters');
    if (filterContainer) {
        filterContainer.querySelectorAll('button').forEach(b => {
            b.className = 'px-3 py-1 rounded-xl text-xs font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-800 transition shrink-0';
        });
    }
    if (btnElement) {
        btnElement.className = 'px-3 py-1 rounded-xl text-xs font-bold bg-emerald-600 text-white shadow-xs shrink-0 transition';
    }

    if (region === 'all') {
        resetEgyptMapView();
    } else {
        const firstHub = EGYPT_HUBS.find(h => h.region === region);
        if (firstHub && egyptMapInstance) {
            egyptMapInstance.flyTo(firstHub.coords, 9, { animate: true, duration: 1.0 });
        }
    }
}

function resetEgyptMapView() {
    const iframe = document.getElementById('googleMapIframe');
    if (iframe && !iframe.classList.contains('hidden')) {
        iframe.src = 'https://maps.google.com/maps?q=27.8,31.0&t=&z=6&ie=UTF8&iwloc=&output=embed';
    }
    if (!egyptMapInstance) return;
    egyptMapInstance.flyTo([27.8, 31.0], 6, {
        animate: true,
        duration: 1.2
    });
    egyptMapInstance.closePopup();
}

// Hook into theme toggling
window.updateEgyptMapTheme = function(isDark) {
    if (egyptMapInstance) {
        applyMapTileLayer(isDark);
    }
};

// Hook into language toggling
window.updateEgyptMapLanguage = function() {
    renderEgyptHubsOnMap();
    const activeBtn = document.querySelector('#egyptHubFilters button.bg-emerald-600');
    const activeRegion = activeBtn ? activeBtn.getAttribute('data-region') : 'all';
    renderEgyptHubCards(activeRegion || 'all');
};
