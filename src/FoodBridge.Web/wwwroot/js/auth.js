function openAdminSignInModal() {
    const modal = document.getElementById('authModal');
    if (modal) modal.classList.remove('hidden');

    const tabsContainer = document.getElementById('authModalTabsContainer');
    if (tabsContainer) tabsContainer.classList.add('hidden');

    setAuthTab('login', true);
}

function openAuthModal(tab = 'login', adminOnly = false) {
    const modal = document.getElementById('authModal');
    if (modal) modal.classList.remove('hidden');

    const isMaintenance = typeof maintenanceStatus !== 'undefined' && maintenanceStatus.isMaintenanceActive;
    const tabsContainer = document.getElementById('authModalTabsContainer');

    if (adminOnly || isMaintenance) {
        if (tabsContainer) tabsContainer.classList.add('hidden');
        setAuthTab('login', true);
    } else {
        if (tabsContainer) tabsContainer.classList.remove('hidden');
        setAuthTab(tab, false);
    }
}

function closeAuthModal() {
    const modal = document.getElementById('authModal');
    if (modal) modal.classList.add('hidden');
    const tabsContainer = document.getElementById('authModalTabsContainer');
    if (tabsContainer) tabsContainer.classList.remove('hidden');
}

function setAuthTab(tab, isExplicitAdmin = false) {
    document.getElementById('loginForm').classList.add('hidden');
    document.getElementById('regProviderForm').classList.add('hidden');
    document.getElementById('regCharityForm').classList.add('hidden');

    ['login', 'reg-provider', 'reg-charity'].forEach(t => {
        const btn = document.getElementById(`atab-${t}`);
        if (btn) btn.className = 'py-1.5 rounded-lg text-slate-600 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white transition';
    });

    const isMaintenance = typeof maintenanceStatus !== 'undefined' && maintenanceStatus.isMaintenanceActive;
    const isSpecialAdmin = isExplicitAdmin || isMaintenance;

    if (tab === 'login') {
        document.getElementById('loginForm').classList.remove('hidden');
        const loginTabBtn = document.getElementById('atab-login');
        if (loginTabBtn) loginTabBtn.className = 'py-1.5 rounded-lg bg-white dark:bg-slate-700 text-slate-800 dark:text-white shadow-sm transition';
        document.getElementById('authModalTitle').textContent = isSpecialAdmin
            ? (currentLang === 'ar' ? 'تسجيل دخول مسؤول النظام' : 'Platform Administrator Sign In')
            : (currentLang === 'ar' ? 'تسجيل الدخول إلى FoodBridge' : 'Sign In to FoodBridge');
    } else if (tab === 'reg-provider') {
        document.getElementById('regProviderForm').classList.remove('hidden');
        const regPBtn = document.getElementById('atab-reg-provider');
        if (regPBtn) regPBtn.className = 'py-1.5 rounded-lg bg-white dark:bg-slate-700 text-slate-800 dark:text-white shadow-sm transition';
        document.getElementById('authModalTitle').textContent = currentLang === 'ar' ? 'تسجيل مزود طعام جديد' : 'Register Food Provider';
    } else if (tab === 'reg-charity') {
        document.getElementById('regCharityForm').classList.remove('hidden');
        const regCBtn = document.getElementById('atab-reg-charity');
        if (regCBtn) regCBtn.className = 'py-1.5 rounded-lg bg-white dark:bg-slate-700 text-slate-800 dark:text-white shadow-sm transition';
        document.getElementById('authModalTitle').textContent = currentLang === 'ar' ? 'تسجيل جمعية خيرية جديدة' : 'Register Charitable Organization';
    }
}

function showSignInModal() { openAuthModal('login'); }
async function handleLoginSubmit(e) {
    e.preventDefault();
    const btn = e.target.querySelector('button[type=submit]');
    const email = document.getElementById('loginEmail').value.trim();
    const password = document.getElementById('loginPassword').value;

    if (!email || !password) {
        showToast('Missing Fields', 'Please enter your email and password.', 'warning');
        return;
    }

    if (btn) { btn.disabled = true; btn.textContent = 'Signing in...'; }
    const success = await performLogin(email, password);
    if (btn) { btn.disabled = false; btn.textContent = 'Sign In'; }
    if (success) closeAuthModal();
}

async function performLogin(email, password) {
    const isAr = currentLang === 'ar';
    try {
        const res = await fetch(`${API_BASE}/auth/login`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });
        const data = await res.json();

        if (!res.ok) {
            const isSuspended = data.isSuspended || 
                                res.status === 403 || 
                                (data.message && (data.message.includes('تعليق') || data.message.includes('suspended') || data.message.includes('Suspended')));
            if (isSuspended) {
                closeAuthModal();
                showSuspendedScreen(data);
                return false;
            }

            if (res.status === 503) {
                const title = isAr ? 'النظام قيد التطوير والتحديثات' : 'System Under Development & Upgrades';
                const msg = isAr
                    ? (data.message || 'النظام قيد التطوير والتحديثات حالياً. تسجيل الدخول متاح لمسؤولي النظام فقط.')
                    : (data.messageEn || data.message || 'The platform is currently under development and scheduled upgrades. Access is restricted to Administrators only.');
                showToast(title, msg, 'warning');
                return false;
            }

            const errorMsg = isAr ? (data.message || 'البريد الإلكتروني أو كلمة المرور غير صحيحة.') : (data.messageEn || data.message || 'Invalid email or password.');
            showToast(isAr ? 'فشل تسجيل الدخول' : 'Login Failed', errorMsg, 'error');
            return false;
        }

        if (maintenanceStatus && maintenanceStatus.isMaintenanceActive && data.role !== 'Admin') {
            showToast(
                isAr ? 'النظام قيد التطوير والتحديثات' : 'System Under Development & Upgrades',
                isAr
                    ? 'النظام قيد التطوير والتحديثات حالياً. تسجيل الدخول متاح لمسؤولي النظام فقط.'
                    : 'The platform is currently under development and scheduled upgrades. Access is restricted to Administrators only.',
                'warning'
            );
            return false;
        }

        currentUser = data;
        localStorage.setItem('foodbridge_user', JSON.stringify(currentUser));
        closeAuthModal();
        updateAuthUI();
        showToast(
            isAr ? 'أهلاً بك مجدداً!' : 'Welcome back!',
            isAr ? `تم تسجيل الدخول بنجاح بصفتك ${currentUser.fullName}` : `Signed in as ${currentUser.fullName}`,
            'success'
        );

        if (typeof handleMaintenanceModeChanged === 'function') {
            handleMaintenanceModeChanged(maintenanceStatus);
        }

        if (signalrConnection) await signalrConnection.stop();
        await initSignalR();

        if (currentUser.role === 'Admin') navigateTo('admin');
        else if (currentUser.role === 'Provider') navigateTo('provider');
        else if (currentUser.role === 'Charity') navigateTo('charity');
        else navigateTo('explore');

        return true;
    } catch (err) {
        showToast(isAr ? 'خطأ' : 'Error', isAr ? 'تعذر الاتصال بالخادم. يرجى المحاولة لاحقاً.' : 'Unable to connect. Please try again.', 'error');
        return false;
    }
}

async function handleRegisterProviderSubmit(e) {
    e.preventDefault();
    const btn = e.target.querySelector('button[type=submit]');
    const password = document.getElementById('regPPassword').value;
    const confirmPassword = document.getElementById('regPConfirmPassword')?.value;

    if (confirmPassword !== undefined && password !== confirmPassword) {
        showToast('Password Mismatch', 'Passwords do not match.', 'error');
        return;
    }

    const payload = {
        fullName: document.getElementById('regPFullName').value.trim(),
        organizationName: document.getElementById('regPOrgName').value.trim(),
        specificType: document.getElementById('regPSpecificType').value,
        email: document.getElementById('regPEmail').value.trim(),
        organizationAddress: document.getElementById('regPAddress').value.trim(),
        password
    };

    if (!payload.fullName || !payload.organizationName || !payload.email || !payload.password || !payload.organizationAddress) {
        showToast('Missing Fields', 'Please fill in all required fields.', 'warning');
        return;
    }

    try {
        if (btn) { btn.disabled = true; btn.textContent = 'Creating account...'; }
        const res = await fetch(`${API_BASE}/auth/register-provider`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const data = await res.json();
        if (!res.ok) {
            showToast('Registration Error', data.message || 'Registration failed. Please try again.', 'error');
            return;
        }

        currentUser = data;
        localStorage.setItem('foodbridge_user', JSON.stringify(currentUser));
        updateAuthUI();
        closeAuthModal();
        if (signalrConnection) await signalrConnection.stop();
        await initSignalR();
        showToast('Account Created! 🎉', 'Welcome to FoodBridge! Please check your email to verify your account, then await admin approval.', 'success');
        navigateTo('provider');
    } catch (err) {
        showToast('Error', 'Unable to connect. Please try again.', 'error');
    } finally {
        if (btn) { btn.disabled = false; btn.textContent = 'Create Provider Account'; }
    }
}

async function handleRegisterCharitySubmit(e) {
    e.preventDefault();
    const btn = e.target.querySelector('button[type=submit]');
    const password = document.getElementById('regCPassword').value;
    const confirmPassword = document.getElementById('regCConfirmPassword')?.value;

    if (confirmPassword !== undefined && password !== confirmPassword) {
        showToast('Password Mismatch', 'Passwords do not match.', 'error');
        return;
    }

    const payload = {
        fullName: document.getElementById('regCFullName').value.trim(),
        organizationName: document.getElementById('regCOrgName').value.trim(),
        specificType: document.getElementById('regCSpecificType').value,
        email: document.getElementById('regCEmail').value.trim(),
        targetCommunityDescription: document.getElementById('regCCommunity').value.trim(),
        organizationAddress: document.getElementById('regCAddress').value.trim(),
        password
    };

    if (!payload.fullName || !payload.organizationName || !payload.email || !payload.password || !payload.organizationAddress) {
        showToast('Missing Fields', 'Please fill in all required fields.', 'warning');
        return;
    }

    try {
        if (btn) { btn.disabled = true; btn.textContent = 'Creating account...'; }
        const res = await fetch(`${API_BASE}/auth/register-charity`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const data = await res.json();
        if (!res.ok) {
            showToast('Registration Error', data.message || 'Registration failed. Please try again.', 'error');
            return;
        }

        currentUser = data;
        localStorage.setItem('foodbridge_user', JSON.stringify(currentUser));
        updateAuthUI();
        closeAuthModal();
        if (signalrConnection) await signalrConnection.stop();
        await initSignalR();
        showToast('Account Created! 🎉', 'Welcome to FoodBridge! You can now browse and reserve surplus food donations.', 'success');
        navigateTo('charity');
    } catch (err) {
        showToast('Error', 'Unable to connect. Please try again.', 'error');
    } finally {
        if (btn) { btn.disabled = false; btn.textContent = 'Create Charity Account'; }
    }
}

function updateAuthUI() {
    const container = document.getElementById('authContainer');
    if (!container) return;

    const dict = i18nDict[currentLang] || i18nDict.en;
    const isAr = currentLang === 'ar';

    if (currentUser) {
        const roleColor = currentUser.role === 'Admin' ? 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900/60 dark:text-indigo-200' :
                          currentUser.role === 'Provider' ? 'bg-amber-100 text-amber-800 dark:bg-amber-900/60 dark:text-amber-200' : 'bg-emerald-100 text-emerald-800 dark:bg-emerald-900/60 dark:text-emerald-200';

        const roleText = isAr ? (currentUser.role === 'Admin' ? 'مشرف' : currentUser.role === 'Provider' ? 'مزود طعام' : 'جمعية خيرية') : currentUser.role;

        container.innerHTML = `
            <div class="flex items-center space-x-2.5">
                <div class="${isAr ? 'text-left' : 'text-right'} hidden sm:block">
                    <div class="text-xs font-bold text-slate-800 dark:text-slate-100">${escapeHtml(currentUser.fullName)}</div>
                    <div class="text-[10px] text-slate-500 dark:text-slate-400">${escapeHtml(currentUser.organizationName || roleText)}</div>
                </div>
                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-[11px] font-bold ${roleColor}">
                    ${roleText}
                </span>
                <button onclick="logout()" class="p-1.5 rounded-lg text-slate-400 hover:text-rose-600 hover:bg-slate-100 dark:hover:bg-slate-800 transition" title="${dict.signOut}">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i>
                </button>
            </div>
        `;

        const pBadge = document.getElementById('providerVerificationBadge');
        if (pBadge) {
            pBadge.className = currentUser.isVerified 
                ? 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-800'
                : 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-800';
            pBadge.innerHTML = currentUser.isVerified 
                ? `<i class="fa-solid fa-circle-check ${isAr ? 'ml-1' : 'mr-1'}"></i> ${isAr ? 'منظمة موثقة ومعتمدة' : 'Verified Organization'}`
                : `<i class="fa-solid fa-clock ${isAr ? 'ml-1' : 'mr-1'}"></i> ${isAr ? 'بانتظار موافقة المشرف' : 'Verification Pending Admin Approval'}`;
        }

        const cBadge = document.getElementById('charityVerificationBadge');
        if (cBadge) {
            cBadge.className = currentUser.isVerified 
                ? 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-100 text-emerald-800'
                : 'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold bg-amber-100 text-amber-800';
            cBadge.innerHTML = currentUser.isVerified 
                ? `<i class="fa-solid fa-circle-check ${isAr ? 'ml-1' : 'mr-1'}"></i> ${isAr ? 'منظمة موثقة ومعتمدة' : 'Verified Organization'}`
                : `<i class="fa-solid fa-clock ${isAr ? 'ml-1' : 'mr-1'}"></i> ${isAr ? 'بانتظار موافقة المشرف' : 'Verification Pending Admin Approval'}`;
        }

    } else {
        container.innerHTML = `
            <div class="flex items-center space-x-1.5 sm:space-x-2">
                <button onclick="openAuthModal('login')" class="px-3 py-1.5 rounded-xl text-xs font-semibold text-slate-700 dark:text-slate-200 hover:bg-slate-100 dark:hover:bg-slate-800 transition">
                    ${dict.signIn}
                </button>
                <button onclick="openAuthModal('reg-provider')" class="px-3 py-1.5 rounded-xl text-xs font-semibold bg-emerald-600 hover:bg-emerald-700 text-white shadow-sm transition">
                    ${dict.register}
                </button>
            </div>
        `;
    }
    updateNavLinks();
}

function logout() {
    currentUser = null;
    localStorage.removeItem('foodbridge_user');
    clearCachedViews();
    updateAuthUI();
    const isAr = currentLang === 'ar';
    showToast(isAr ? 'تم تسجيل الخروج' : 'Signed Out', isAr ? 'تم تسجيل الخروج بنجاح وتأمين الجلسة.' : 'You have been signed out successfully.', 'info');
    navigateTo('landing');
    if (signalrConnection) {
        signalrConnection.stop();
    }
}

let currentSuspensionData = null;

function showSuspendedScreen(data) {
    currentSuspensionData = data;

    // Force close login modal and any background open modals
    closeAuthModal();
    document.querySelectorAll('.fixed.inset-0').forEach(m => {
        m.classList.add('hidden');
    });

    const isAr = currentLang === 'ar';
    const supportEmail = data.supportEmail || 'ahlawy.ahmed25@gmail.com';
    let reasonText = data.reason || '';
    if (!reasonText && data.message) {
        reasonText = data.message;
    }
    if (!reasonText) {
        reasonText = isAr ? 'تم تعليق الحساب لمخالفة معايير واستخدام منصة FoodBridge.' : 'Account suspended due to platform policy review.';
    }

    const userName = data.fullName || 'User';
    const userOrg = data.organizationName || data.email || 'Partner Account';
    const dateObj = data.suspendedAt ? new Date(data.suspendedAt) : new Date();
    const dateStr = dateObj.toLocaleTimeString(isAr ? 'ar-EG' : 'en-US', { hour: '2-digit', minute: '2-digit' }) + ' (' + dateObj.toLocaleDateString(isAr ? 'ar-EG' : 'en-US') + ')';
    const mailtoUrl = `mailto:${supportEmail}?subject=${encodeURIComponent('FoodBridge Account Suspension Appeal - ' + (data.email || userName))}`;

    // 1. Populate Full Dedicated Page (#view-suspended)
    const pageName = document.getElementById('pageSuspendedUserName');
    if (pageName) pageName.textContent = userName;

    const pageOrg = document.getElementById('pageSuspendedUserOrg');
    if (pageOrg) pageOrg.textContent = userOrg;

    const pageReason = document.getElementById('pageSuspensionReason');
    if (pageReason) pageReason.textContent = reasonText;

    const pageEmailLink = document.getElementById('pageSupportEmailLink');
    if (pageEmailLink) {
        pageEmailLink.textContent = supportEmail;
        pageEmailLink.href = mailtoUrl;
    }

    const pageEmailBtn = document.getElementById('pageBtnEmailSupport');
    if (pageEmailBtn) pageEmailBtn.href = mailtoUrl;

    const pageDate = document.getElementById('pageSuspendedDate');
    if (pageDate) pageDate.textContent = dateStr;

    // 2. Populate Fullscreen Overlay Screen (#suspendedOverlay)
    const overlayName = document.getElementById('suspendedUserName');
    if (overlayName) overlayName.textContent = userName;

    const overlayOrg = document.getElementById('suspendedUserOrg');
    if (overlayOrg) overlayOrg.textContent = userOrg;

    const overlayReason = document.getElementById('suspendedReasonDisplay');
    if (overlayReason) overlayReason.textContent = reasonText;

    const overlayEmailLink = document.getElementById('suspendedSupportEmailLink');
    if (overlayEmailLink) {
        overlayEmailLink.textContent = supportEmail;
        overlayEmailLink.href = mailtoUrl;
    }

    const overlayContactBtn = document.getElementById('btnContactSupportEmail');
    if (overlayContactBtn) overlayContactBtn.href = mailtoUrl;

    const overlayDate = document.getElementById('suspendedDateDisplay');
    if (overlayDate) overlayDate.textContent = dateStr;

    const langBtn = document.getElementById('suspendedLangBtnText');
    if (langBtn) langBtn.textContent = isAr ? 'English' : 'عربي';

    if (typeof updateThemeUI === 'function') {
        updateThemeUI(document.documentElement.classList.contains('dark'));
    }

    // 3. Navigate directly to 'suspended' dedicated page view!
    if (typeof navigateTo === 'function') {
        navigateTo('suspended');
    }

    // 4. Also open the high-priority overlay (z-[100])
    const overlay = document.getElementById('suspendedOverlay');
    if (overlay) overlay.classList.remove('hidden');

    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function closeSuspendedScreen() {
    const overlay = document.getElementById('suspendedOverlay');
    if (overlay) overlay.classList.add('hidden');
    navigateTo('landing');
}

function copySupportEmail() {
    const email = currentSuspensionData?.supportEmail || 'ahlawy.ahmed25@gmail.com';
    navigator.clipboard.writeText(email).then(() => {
        const isAr = currentLang === 'ar';
        showToast(isAr ? 'تم النسخ!' : 'Copied!', isAr ? 'تم نسخ البريد الإلكتروني للحافظة.' : 'Support email copied to clipboard.', 'success');
    }).catch(() => {
        const isAr = currentLang === 'ar';
        showToast(isAr ? 'تنبيه' : 'Notice', email, 'info');
    });
}


