const API_BASE = '/api';

let currentUser = JSON.parse(localStorage.getItem('foodbridge_user')) || null;
let currentView = 'landing';
let currentCategoryFilter = null;
let currentDetailListing = null;
let signalrConnection = null;
let categoryChartInstance = null;
let monthlyChartInstance = null;
let reviewActiveRating = 5;

let maintenanceStatus = {
    isMaintenanceActive: false,
    reason: '',
    reasonAr: '',
    estimatedDuration: null,
    activatedAt: null,
    activatedByAdminName: null
};

let currentLang = localStorage.getItem('foodbridge_lang') || 'ar';

function getAuthHeaders(includeJson = true) {
    const headers = {};
    if (includeJson) {
        headers['Content-Type'] = 'application/json';
    }
    if (currentUser && currentUser.token) {
        headers['Authorization'] = `Bearer ${currentUser.token}`;
    }
    return headers;
}
