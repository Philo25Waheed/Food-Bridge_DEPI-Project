/**
 * Food Bridge — Notifications System Handlers
 */

document.addEventListener('DOMContentLoaded', () => {
  initNotificationsPage();
});

function initNotificationsPage() {
  const container = document.getElementById('notificationsListContainer');
  if (!container) return;

  const currentRole = EcoStore.getCurrentRole();
  const filterTabs = document.querySelectorAll('#notifFilterTabs .nav-link');
  const markAllBtn = document.getElementById('markAllNotificationsReadBtn');

  let currentCategory = 'all';

  function renderNotifications() {
    let list = EcoStore.getNotifications(currentRole);

    if (currentCategory === 'unread') {
      list = list.filter(n => !n.read);
    } else if (currentCategory !== 'all') {
      list = list.filter(n => n.type === currentCategory);
    }

    const unreadCount = EcoStore.getNotifications(currentRole).filter(n => !n.read).length;
    const unreadBadge = document.getElementById('notificationsUnreadHeaderBadge');
    if (unreadBadge) {
      unreadBadge.textContent = `${unreadCount} unread`;
      unreadBadge.style.display = unreadCount > 0 ? 'inline-block' : 'none';
    }

    if (list.length === 0) {
      container.innerHTML = `
        <div class="empty-state">
          <div class="empty-state-icon"><i class="bi bi-bell-slash"></i></div>
          <h5>No notifications to display</h5>
          <p class="text-secondary">You're all caught up with your latest platform alerts.</p>
        </div>
      `;
      return;
    }

    container.innerHTML = list.map(n => {
      let icon = 'bi-bell-fill text-primary';
      if (n.type === 'request') icon = 'bi-send-fill text-success';
      if (n.type === 'pickup') icon = 'bi-calendar-check-fill text-info';
      if (n.type === 'urgent') icon = 'bi-exclamation-triangle-fill text-danger';
      if (n.type === 'verification') icon = 'bi-shield-check text-warning';
      if (n.type === 'impact') icon = 'bi-tree-fill text-success';

      return `
        <div class="eco-card p-3 mb-3 d-flex align-items-start gap-3 ${!n.read ? 'border-start border-4 border-primary bg-white' : 'bg-light text-muted'}" id="notif-item-${n.id}">
          <div class="rounded-circle p-2 bg-light d-flex align-items-center justify-content-center" style="width: 44px; height: 44px; flex-shrink: 0;">
            <i class="bi ${icon} fs-5"></i>
          </div>
          <div class="flex-grow-1">
            <div class="d-flex justify-content-between align-items-start">
              <h6 class="fw-bold mb-1 ${!n.read ? 'text-dark' : 'text-secondary'}">${typeof EcoLang !== 'undefined' ? EcoLang.t(n.title) : n.title}</h6>
              <span class="text-muted small">${typeof EcoLang !== 'undefined' ? EcoLang.t(n.time) : n.time}</span>
            </div>
            <p class="mb-2 small ${!n.read ? 'text-dark' : 'text-secondary'}">${typeof EcoLang !== 'undefined' ? EcoLang.t(n.message) : n.message}</p>
            <div class="d-flex gap-2">
              <a href="${n.link}" class="btn btn-sm btn-outline-success py-0 px-2" style="font-size: 0.8rem;">
                ${typeof EcoLang !== 'undefined' ? EcoLang.t('View Event') : 'View Event'}
              </a>
              ${!n.read ? `
                <button class="btn btn-sm btn-ghost py-0 px-2 btn-mark-read" data-id="${n.id}" style="font-size: 0.8rem;">
                  ${typeof EcoLang !== 'undefined' ? EcoLang.t('Mark as read') : 'Mark as read'}
                </button>
              ` : ''}
            </div>
          </div>
        </div>
      `;
    }).join('');

    // Mark single as read
    container.querySelectorAll('.btn-mark-read').forEach(btn => {
      btn.addEventListener('click', () => {
        const id = btn.dataset.id;
        EcoStore.markNotificationRead(id);
        EcoToast.show('Notification marked as read', 'info');
        updateNotificationBadges();
        renderNotifications();
      });
    });
  }

  // Mark all as read
  if (markAllBtn) {
    markAllBtn.addEventListener('click', () => {
      EcoStore.markAllNotificationsRead();
      EcoToast.show('All notifications marked as read', 'success');
      updateNotificationBadges();
      renderNotifications();
    });
  }

  filterTabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      e.preventDefault();
      filterTabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      currentCategory = tab.dataset.category || 'all';
      renderNotifications();
    });
  });

  renderNotifications();
}

window.addEventListener('langChanged', () => {
  initNotificationsPage();
});
