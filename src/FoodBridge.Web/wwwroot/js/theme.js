function updateThemeUI(isDark) {
    const icon1 = document.getElementById('themeToggleIcon');
    const icon2 = document.getElementById('maintenanceThemeToggleIcon');
    const icon3 = document.getElementById('suspendedThemeToggleIcon');
    const iconClass = isDark ? 'fa-solid fa-sun text-base text-amber-400' : 'fa-solid fa-moon text-base text-amber-500';
    if (icon1) icon1.className = iconClass;
    if (icon2) icon2.className = iconClass;
    if (icon3) icon3.className = iconClass;
    if (typeof window.updateEgyptMapTheme === 'function') {
        window.updateEgyptMapTheme(isDark);
    }
}

function initTheme() {
    const savedTheme = localStorage.getItem('foodbridge_theme') || 'light';
    const isDark = savedTheme === 'dark';
    if (isDark) {
        document.documentElement.classList.add('dark');
    } else {
        document.documentElement.classList.remove('dark');
    }
    updateThemeUI(isDark);
}

function toggleTheme() {
    const isDark = document.documentElement.classList.toggle('dark');
    localStorage.setItem('foodbridge_theme', isDark ? 'dark' : 'light');
    updateThemeUI(isDark);
    const isAr = currentLang === 'ar';
    const title = isAr ? (isDark ? 'الوضع الليلي' : 'الوضع النهاري') : (isDark ? 'Dark Mode' : 'Light Mode');
    const msg = isAr ? (isDark ? 'تم تفعيل الوضع الليلي بنجاح.' : 'تم تفعيل الوضع النهاري بنجاح.') : (isDark ? 'Dark mode enabled successfully.' : 'Light mode enabled successfully.');
    showToast(title, msg, 'info');
}