async function checkMaintenanceStatus(manualCheck = false) {
    try {
        const res = await fetch(`${API_BASE}/admin/maintenance/status`);
        if (res.ok) {
            const data = await res.json();
            handleMaintenanceModeChanged(data);
            if (manualCheck) {
                const isAr = currentLang === 'ar';
                if (data.isMaintenanceActive) {
                    showToast(
                        isAr ? 'الصيانة لا تزال جارية' : 'Maintenance Ongoing',
                        isAr ? 'يجري العمل حالياً على التحديثات وسنعود في أقرب وقت.' : 'System updates are still in progress. Please check again soon.',
                        'info'
                    );
                } else {
                    showToast(
                        isAr ? 'النظام متاح الآن!' : 'System Online!',
                        isAr ? 'عادت المنصة للعمل بصورة طبيعية.' : 'Platform services have been fully restored.',
                        'success'
                    );
                }
            }
        }
    } catch (err) {
        console.error('Error checking maintenance status:', err);
    }
}

function handleMaintenanceModeChanged(status) {
    if (!status) return;
    maintenanceStatus = status;

    const isAr = currentLang === 'ar';
    const dict = i18nDict[currentLang] || i18nDict.en;

    const dot = document.getElementById('adminMaintenanceStatusDot');
    const title = document.getElementById('adminMaintenanceStatusTitle');
    const subtitle = document.getElementById('adminMaintenanceStatusSubtitle');
    const toggleBtn = document.getElementById('btnAdminMaintenanceToggle');
    const toggleText = document.getElementById('btnAdminMaintenanceToggleText');

    if (dot && title && subtitle && toggleBtn && toggleText) {
        if (status.isMaintenanceActive) {
            dot.className = 'w-3 h-3 rounded-full bg-rose-500 animate-ping';
            title.textContent = dict.systemMaintenanceStatus;
            subtitle.textContent = dict.systemMaintenanceDesc;
            toggleBtn.className = 'px-3.5 py-1.5 rounded-xl text-xs font-bold transition flex items-center shadow-xs bg-emerald-600 text-white hover:bg-emerald-700';
            toggleText.textContent = dict.btnUnlockMaintenance;
        } else {
            dot.className = 'w-3 h-3 rounded-full bg-emerald-500 animate-pulse';
            title.textContent = dict.systemOnlineStatus;
            subtitle.textContent = dict.systemOnlineDesc;
            toggleBtn.className = 'px-3.5 py-1.5 rounded-xl text-xs font-bold transition flex items-center shadow-xs bg-rose-50 text-rose-700 hover:bg-rose-100 dark:bg-rose-950/40 dark:text-rose-300';
            toggleText.textContent = dict.btnLockMaintenance;
        }
    }

    const adminBanner = document.getElementById('adminMaintenanceBanner');
    if (adminBanner) {
        if (status.isMaintenanceActive && currentUser && currentUser.role === 'Admin') {
            adminBanner.classList.remove('hidden');
        } else {
            adminBanner.classList.add('hidden');
        }
    }

    const overlay = document.getElementById('maintenanceOverlay');
    if (overlay) {
        if (status.isMaintenanceActive) {
            if (currentUser && currentUser.role === 'Admin') {
                overlay.classList.add('hidden');
            } else {
                // If a non-admin user was logged in, log them out immediately to preserve data
                if (currentUser && currentUser.role !== 'Admin') {
                    currentUser = null;
                    localStorage.removeItem('foodbridge_user');
                    try { sessionStorage.removeItem('foodbridge_view'); } catch (e) {}
                    updateAuthUI();
                    showToast(
                        isAr ? 'النظام قيد التطوير والتحديثات' : 'System Under Development & Upgrades',
                        isAr
                            ? 'المنصة متوقفة مؤقتاً لأعمال الصيانة والتطوير. تم تسجيل الخروج تلقائياً لحفظ البيانات.'
                            : 'Maintenance mode activated. You have been signed out to protect data integrity.',
                        'warning'
                    );
                }

                overlay.classList.remove('hidden');
                renderMaintenanceScreen();

                // Close other modals, but NEVER close authModal so admin sign-in is uninterrupted!
                document.querySelectorAll('.fixed.inset-0:not(#maintenanceOverlay):not(#authModal)').forEach(m => {
                    m.classList.add('hidden');
                });
            }
        } else {
            overlay.classList.add('hidden');
        }
    }
}

function renderMaintenanceScreen() {
    const isAr = currentLang === 'ar';
    const reasonDisplay = document.getElementById('maintenanceReasonDisplay');
    const durationDisplay = document.getElementById('maintenanceDurationDisplay');
    const startedDisplay = document.getElementById('maintenanceStartedDisplay');

    if (reasonDisplay) {
        let text = isAr 
            ? (maintenanceStatus.reasonAr || maintenanceStatus.reason || 'تحديثات أمنية وترقية قاعدة البيانات')
            : (maintenanceStatus.reason || maintenanceStatus.reasonAr || 'Security upgrades and database optimization');
        reasonDisplay.textContent = text;
    }

    if (durationDisplay) {
        let dur = maintenanceStatus.estimatedDuration || '';
        if (dur.includes(' / ')) {
            const parts = dur.split(' / ');
            dur = isAr ? parts[0] : parts[1];
        } else if (!dur) {
            dur = isAr ? '30-45 دقيقة' : '30-45 Minutes';
        }
        durationDisplay.textContent = dur;
    }

    if (startedDisplay) {
        if (maintenanceStatus.activatedAt) {
            const date = new Date(maintenanceStatus.activatedAt);
            startedDisplay.textContent = date.toLocaleTimeString(isAr ? 'ar-EG' : 'en-US', { hour: '2-digit', minute: '2-digit' }) + ' (' + date.toLocaleDateString(isAr ? 'ar-EG' : 'en-US') + ')';
        } else {
            startedDisplay.textContent = '-';
        }
    }

    const maintLangBtn = document.getElementById('maintenanceLangBtnText');
    if (maintLangBtn) {
        maintLangBtn.textContent = isAr ? 'English' : 'عربي';
    }

    if (typeof updateThemeUI === 'function') {
        updateThemeUI(document.documentElement.classList.contains('dark'));
    }
}

function openAdminMaintenanceModal() {
    if (!currentUser || currentUser.role !== 'Admin') return;
    const isAr = currentLang === 'ar';

    const radioEnable = document.getElementById('radioEnableMaintenance');
    const radioDisable = document.getElementById('radioDisableMaintenance');
    const reasonArInput = document.getElementById('maintenanceReasonAr');
    const reasonEnInput = document.getElementById('maintenanceReasonEn');
    const durationInput = document.getElementById('maintenanceDuration');

    if (maintenanceStatus.isMaintenanceActive) {
        if (radioDisable) radioDisable.checked = true;
    } else {
        if (radioEnable) radioEnable.checked = true;
    }

    if (reasonArInput) reasonArInput.value = maintenanceStatus.reasonAr || 'تحديثات أمنية وترقية قاعدة البيانات';
    if (reasonEnInput) reasonEnInput.value = maintenanceStatus.reason || 'Database server upgrade & security enhancements';
    if (durationInput && maintenanceStatus.estimatedDuration) durationInput.value = maintenanceStatus.estimatedDuration;

    const modal = document.getElementById('adminMaintenanceModal');
    if (modal) modal.classList.remove('hidden');
}

function closeAdminMaintenanceModal() {
    const modal = document.getElementById('adminMaintenanceModal');
    if (modal) modal.classList.add('hidden');
}

async function handleAdminMaintenanceSubmit(event) {
    event.preventDefault();
    if (!currentUser || currentUser.role !== 'Admin') return;

    const isAr = currentLang === 'ar';
    const actionVal = document.querySelector('input[name="maintenanceAction"]:checked')?.value;
    const enable = actionVal === 'enable';

    const reasonAr = document.getElementById('maintenanceReasonAr')?.value.trim() || '';
    const reasonEn = document.getElementById('maintenanceReasonEn')?.value.trim() || '';
    const duration = document.getElementById('maintenanceDuration')?.value || '';

    const btn = document.getElementById('btnSubmitAdminMaintenance');
    if (btn) btn.disabled = true;

    try {
        const res = await fetch(`${API_BASE}/admin/maintenance/toggle`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${currentUser.token}`
            },
            body: JSON.stringify({
                enable,
                reason: reasonEn,
                reasonAr: reasonAr,
                estimatedDuration: duration
            })
        });

        if (res.ok) {
            const data = await res.json();
            handleMaintenanceModeChanged(data);
            closeAdminMaintenanceModal();
            showToast(
                isAr ? 'تم تحديث حالة النظام' : 'System Status Updated',
                enable
                    ? (isAr ? 'تم تفعيل وضع الصيانة بنجاح وإيقاف العمليات مؤقتاً.' : 'Maintenance mode successfully enabled.')
                    : (isAr ? 'تم فتح المنصة وعادت جميع الخدمات للعمل.' : 'Platform restored to live online status.'),
                'success'
            );
            await loadAdminAuditLogs();
        } else {
            const err = await res.json();
            showToast(isAr ? 'خطأ' : 'Error', err.message || (isAr ? 'تعذر تغيير حالة النظام' : 'Failed to update system status'), 'error');
        }
    } catch (err) {
        showToast(isAr ? 'خطأ في الاتصال' : 'Connection Error', err.message, 'error');
    } finally {
        if (btn) btn.disabled = false;
    }
}

setInterval(() => {
    checkMaintenanceStatus(false);
}, 4000);

