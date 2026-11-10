document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    initLanguage();
    updateAuthUI();
    initSignalR();

    const savedView = sessionStorage.getItem('foodbridge_view');
    if (currentUser && currentUser.role === 'Admin') {
        navigateTo(savedView === 'admin' || !savedView ? 'admin' : savedView);
    } else if (currentUser && currentUser.role === 'Provider') {
        navigateTo(savedView === 'provider' ? 'provider' : 'landing');
    } else if (currentUser && currentUser.role === 'Charity') {
        navigateTo(savedView === 'charity' ? 'charity' : 'landing');
    } else {
        navigateTo(savedView && savedView !== 'admin' && savedView !== 'provider' && savedView !== 'charity' ? savedView : 'landing');
    }

    initScrollReveal();
    init3DTilt();
    if (typeof initEgyptMap === 'function') {
        setTimeout(initEgyptMap, 200);
    }
    checkMaintenanceStatus();
});