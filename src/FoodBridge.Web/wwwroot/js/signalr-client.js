async function initSignalR() {
    try {
        const token = currentUser ? currentUser.token : '';
        const userId = currentUser ? currentUser.userId : '';

        console.log('%c[SignalR Real-Time]%c Initializing connection to /hubs/notifications...', 'background: #0ea5e9; color: white; font-weight: bold; padding: 2px 6px; border-radius: 4px;', 'color: #0ea5e9; font-weight: bold;');

        signalrConnection = new signalR.HubConnectionBuilder()
            .withUrl(`/hubs/notifications?userId=${encodeURIComponent(userId)}&access_token=${encodeURIComponent(token)}`)
            .withAutomaticReconnect([0, 2000, 5000, 10000, 30000])
            .configureLogging(signalR.LogLevel.Information)
            .build();

        signalrConnection.onreconnecting((error) => {
            console.warn('%c[SignalR Warning]%c 🔄 Reconnecting to server...', 'background: #f59e0b; color: black; font-weight: bold; padding: 2px 6px; border-radius: 4px;', 'color: #f59e0b;', error);
            const ind = document.getElementById('signalrIndicator');
            if (ind) { ind.classList.remove('bg-emerald-500'); ind.classList.add('bg-amber-500'); }
        });

        signalrConnection.onreconnected((connectionId) => {
            console.log('%c[SignalR Reconnected]%c ⚡ Live connection restored! Connection ID: ' + connectionId, 'background: #10b981; color: white; font-weight: bold; padding: 2px 6px; border-radius: 4px;', 'color: #10b981;');
            const ind = document.getElementById('signalrIndicator');
            if (ind) { ind.classList.remove('bg-amber-500', 'bg-rose-500'); ind.classList.add('bg-emerald-500'); }
        });

        signalrConnection.onclose((error) => {
            console.error('%c[SignalR Closed]%c ❌ Connection terminated', 'background: #ef4444; color: white; font-weight: bold; padding: 2px 6px; border-radius: 4px;', 'color: #ef4444;', error);
            const ind = document.getElementById('signalrIndicator');
            if (ind) { ind.classList.remove('bg-emerald-500'); ind.classList.add('bg-rose-500'); }
        });

        signalrConnection.on('MaintenanceModeChanged', status => {
            console.log('%c[SignalR Push]%c ⚠️ MaintenanceModeChanged received:', 'background: #f59e0b; color: black; font-weight: bold;', 'color: #f59e0b;', status);
            handleMaintenanceModeChanged(status);
        });

        signalrConnection.on('ReceiveNotification', (notification) => {
            console.log(
                '%c[SignalR Push Notification]%c 🔔 Received: "' + (notification.title || '') + '" — ' + (notification.message || ''),
                'background: #10b981; color: white; font-weight: bold; padding: 2px 8px; border-radius: 4px;',
                'color: #059669; font-weight: bold;',
                notification
            );
            handleIncomingNotification(notification);
        });

        await signalrConnection.start();
        console.log(
            '%c[SignalR Live Hub]%c Connected & Active (Connection ID: ' + signalrConnection.connectionId + ', User: ' + (currentUser ? currentUser.email : 'Guest') + ')',
            'background: #059669; color: white; font-weight: bold; padding: 2px 8px; border-radius: 4px;',
            'color: #059669; font-weight: bold;'
        );
        const ind = document.getElementById('signalrIndicator');
        if (ind) ind.classList.remove('bg-rose-500', 'bg-amber-500');
        if (ind) ind.classList.add('bg-emerald-500');

        if (currentUser) {
            loadNotifications();
        }
    } catch (err) {
        console.warn('%c[SignalR Error]%c Connection failed (will retry):', 'background: #ef4444; color: white; font-weight: bold; padding: 2px 6px; border-radius: 4px;', 'color: #ef4444;', err);
        const ind = document.getElementById('signalrIndicator');
        if (ind) ind.classList.remove('bg-emerald-500');
        if (ind) ind.classList.add('bg-rose-500');
    }
}

function handleIncomingNotification(notification) {
    if (notification.title && notification.title.toLowerCase().includes('suspended') && currentUser && currentUser.role !== 'Admin') {
        const suspendedInfo = {
            isSuspended: true,
            fullName: currentUser.fullName,
            organizationName: currentUser.organizationName,
            email: currentUser.email,
            reason: notification.message,
            supportEmail: 'ahlawy.ahmed25@gmail.com',
            suspendedAt: new Date().toISOString()
        };
        currentUser = null;
        localStorage.removeItem('foodbridge_user');
        updateAuthUI();
        if (typeof showSuspendedScreen === 'function') {
            showSuspendedScreen(suspendedInfo);
        }
        return;
    }

    showToast(notification.title, notification.message, 'info');

    prependNotificationItem(notification);

    const badge = document.getElementById('unreadBadge');
    if (badge) {
        let count = parseInt(badge.textContent) || 0;
        count++;
        badge.textContent = count;
        badge.classList.remove('hidden');
    }

    if (currentView === 'provider') {
        loadProviderRequests();
        loadProviderListings();
    } else if (currentView === 'charity') {
        loadCharityReservations();
    } else if (currentView === 'admin') {
        loadAdminStats();
    }
}

function toggleNotificationDropdown() {
    const d = document.getElementById('notificationDropdown');
    d.classList.toggle('hidden');
    if (!d.classList.contains('hidden')) {
        loadNotifications();
    }
}

async function loadNotifications() {
    if (!currentUser) return;
    const listContainer = document.getElementById('notificationList');
    const badge = document.getElementById('unreadBadge');

    try {
        const [listRes, countRes] = await Promise.all([
            fetch(`${API_BASE}/notifications`, { headers: { 'Authorization': `Bearer ${currentUser.token}` } }),
            fetch(`${API_BASE}/notifications/unread-count`, { headers: { 'Authorization': `Bearer ${currentUser.token}` } })
        ]);

        const notifications = await listRes.json();
        const { count } = await countRes.json();

        if (count > 0) {
            badge.textContent = count;
            badge.classList.remove('hidden');
        } else {
            badge.classList.add('hidden');
        }

        if (!notifications || notifications.length === 0) {
            listContainer.innerHTML = `<div class="p-6 text-center text-slate-400 text-xs">No notifications yet.</div>`;
            return;
        }

        listContainer.innerHTML = notifications.map(n => `
            <div class="p-3.5 hover:bg-slate-50 transition flex items-start space-x-3 cursor-pointer ${!n.isRead ? 'bg-emerald-50/40' : ''}" onclick="markNotificationRead(${n.id})">
                <div class="w-2 h-2 rounded-full mt-1.5 shrink-0 ${!n.isRead ? 'bg-emerald-500' : 'bg-transparent'}"></div>
                <div class="flex-1">
                    <div class="font-bold text-xs text-slate-800">${escapeHtml(n.title)}</div>
                    <div class="text-[11px] text-slate-600 mt-0.5 leading-relaxed">${escapeHtml(n.message)}</div>
                    <div class="text-[10px] text-slate-400 mt-1">${new Date(n.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</div>
                </div>
            </div>
        `).join('');

    } catch (err) {
        console.error('Error fetching notifications:', err);
    }
}

async function markNotificationRead(id) {
    if (!currentUser) return;
    try {
        await fetch(`${API_BASE}/notifications/${id}/read`, {
            method: 'PATCH',
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        loadNotifications();
    } catch (err) {}
}

async function markAllNotificationsRead() {
    if (!currentUser) return;
    try {
        await fetch(`${API_BASE}/notifications/mark-all-read`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${currentUser.token}` }
        });
        loadNotifications();
    } catch (err) {}
}

function prependNotificationItem(n) {
    const listContainer = document.getElementById('notificationList');
    if (!listContainer) return;

    const itemHtml = `
        <div class="p-3.5 hover:bg-slate-50 transition flex items-start space-x-3 cursor-pointer bg-emerald-50/60" onclick="markNotificationRead(${n.id})">
            <div class="w-2 h-2 rounded-full mt-1.5 shrink-0 bg-emerald-500 animate-ping"></div>
            <div class="flex-1">
                <div class="font-bold text-xs text-slate-800">${escapeHtml(n.title)}</div>
                <div class="text-[11px] text-slate-600 mt-0.5 leading-relaxed">${escapeHtml(n.message)}</div>
                <div class="text-[10px] text-slate-400 mt-1">Just now</div>
            </div>
        </div>
    `;
    listContainer.insertAdjacentHTML('afterbegin', itemHtml);
}

