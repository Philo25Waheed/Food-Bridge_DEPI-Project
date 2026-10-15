/**
 * Food Bridge — Platform Administration Handlers
 */

document.addEventListener('DOMContentLoaded', () => {
  initAdminDashboard();
  initManageUsers();
  initManageOrganizations();
  initManageReports();
});

// ==========================================================================
// Admin Dashboard
// ==========================================================================
function initAdminDashboard() {
  const chartCanvas = document.getElementById('adminDonationTrendsChart');
  if (!chartCanvas) return;

  const users = EcoStore.getUsers();
  const donations = EcoStore.getDonations();
  const reports = EcoStore.getReports();

  const totalUsersCount = users.length;
  const verifiedOrgsCount = users.filter(u => u.role === 'charity' && u.verified).length;
  const pendingOrgsCount = users.filter(u => u.role === 'charity' && !u.verified).length;
  const activeListingsCount = donations.filter(d => d.status === 'available').length;
  const pendingReportsCount = reports.filter(r => r.status === 'pending').length;

  const mUsers = document.getElementById('adminMetricTotalUsers');
  const mOrgs = document.getElementById('adminMetricVerifiedOrgs');
  const mPendingOrgs = document.getElementById('adminMetricPendingOrgs');
  const mActive = document.getElementById('adminMetricActiveListings');
  const mReports = document.getElementById('adminMetricReports');

  if (mUsers) mUsers.textContent = totalUsersCount + 280;
  if (mOrgs) mOrgs.textContent = verifiedOrgsCount + 42;
  if (mPendingOrgs) mPendingOrgs.textContent = pendingOrgsCount;
  if (mActive) mActive.textContent = activeListingsCount;
  if (mReports) mReports.textContent = pendingReportsCount;

  // Chart 1: Platform Monthly Volume Trends
  if (typeof Chart !== 'undefined') {
    const isDark = EcoTheme.get() === 'dark';
    const gridColor = isDark ? '#22382B' : '#E2E8F0';
    const textColor = isDark ? '#94A3B8' : '#64748B';
    const borderColor = isDark ? '#131E17' : '#FFFFFF';

    if (window.adminTrendChartInstance) {
      window.adminTrendChartInstance.destroy();
    }
    if (window.adminCatChartInstance) {
      window.adminCatChartInstance.destroy();
    }

    const ctx1 = chartCanvas.getContext('2d');
    window.adminTrendChartInstance = new Chart(ctx1, {
      type: 'bar',
      data: {
        labels: (typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar') ? ['مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر'] : ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
        datasets: [
          {
            label: (typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar') ? 'حجم الغذاء المنقذ (كجم)' : 'Rescued Food Volume (kg)',
            data: [3200, 4800, 4100, 6200, 7400, 9150],
            backgroundColor: '#228B55',
            borderRadius: 6
          },
          {
            label: 'Meals Served Equivalent',
            data: [2600, 3900, 3400, 5100, 6100, 7600],
            backgroundColor: '#2A9D8F',
            borderRadius: 6
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: { position: 'top', labels: { color: textColor, font: { family: 'Inter', weight: '600' } } }
        },
        scales: {
          y: { grid: { color: gridColor }, ticks: { color: textColor, font: { family: 'Inter' } } },
          x: { grid: { display: false }, ticks: { color: textColor, font: { family: 'Inter' } } }
        }
      }
    });

    // Chart 2: Category Breakdown
    const catCanvas = document.getElementById('adminCategoryDistributionChart');
    if (catCanvas) {
      const ctx2 = catCanvas.getContext('2d');
      window.adminCatChartInstance = new Chart(ctx2, {
        type: 'doughnut',
        data: {
          labels: ['Produce', 'Bakery', 'Prepared Meals', 'Dairy', 'Canned Goods', 'Frozen'],
          datasets: [{
            data: [32, 22, 18, 14, 8, 6],
            backgroundColor: [
              '#228B55',
              '#F4A261',
              '#E76F51',
              '#2A9D8F',
              '#2563EB',
              '#94A3B8'
            ],
            borderWidth: 2,
            borderColor: borderColor
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { position: 'bottom', labels: { color: textColor, font: { family: 'Inter', size: 11 } } }
          }
        }
      });
    }

    window.removeEventListener('themeChanged', window._adminChartThemeHandler);
    window._adminChartThemeHandler = () => initAdminDashboard();
    window.addEventListener('themeChanged', window._adminChartThemeHandler);
  }

  // Pending Charity Verification Queue in Admin Dashboard
  const queueContainer = document.getElementById('adminPendingQueueBody');
  if (queueContainer) {
    const pendingCharities = users.filter(u => u.role === 'charity' && !u.verified);
    if (pendingCharities.length === 0) {
      queueContainer.innerHTML = `
        <tr>
          <td colspan="5" class="text-center py-4 text-muted">
            <i class="bi bi-shield-check fs-3 text-success d-block mb-1"></i>
            All charity organizations have been verified. No pending reviews!
          </td>
        </tr>
      `;
    } else {
      queueContainer.innerHTML = pendingCharities.map(org => `
        <tr>
          <td>
            <div class="fw-bold text-dark">${org.name}</div>
            <div class="text-muted small">${org.orgType || 'Charitable Non-Profit'}</div>
          </td>
          <td>${org.contactPerson || 'Logistics Coordinator'}</td>
          <td><code>${org.taxId || '501(c)(3) #Pending'}</code></td>
          <td><span class="badge bg-warning text-dark">Pending Review</span></td>
          <td>
            <a href="manage-organizations.html" class="btn btn-sm btn-primary-eco py-1 px-3">
              <i class="bi bi-file-earmark-check"></i> Review
            </a>
          </td>
        </tr>
      `).join('');
    }
  }
}

// ==========================================================================
// Manage Users Page
// ==========================================================================
function initManageUsers() {
  const tableBody = document.getElementById('manageUsersTableBody');
  if (!tableBody) return;

  const searchInput = document.getElementById('usersSearchInput');
  const roleFilter = document.getElementById('usersRoleFilter');
  const statusFilter = document.getElementById('usersStatusFilter');

  function renderUsers() {
    let users = EcoStore.getUsers();

    const searchVal = searchInput ? searchInput.value.toLowerCase().trim() : '';
    const roleVal = roleFilter ? roleFilter.value : 'all';
    const statusVal = statusFilter ? statusFilter.value : 'all';

    if (searchVal) {
      users = users.filter(u =>
        u.name.toLowerCase().includes(searchVal) ||
        u.email.toLowerCase().includes(searchVal) ||
        u.address.toLowerCase().includes(searchVal)
      );
    }

    if (roleVal !== 'all') {
      users = users.filter(u => u.role === roleVal);
    }

    if (statusVal !== 'all') {
      users = users.filter(u => u.status === statusVal);
    }

    if (users.length === 0) {
      tableBody.innerHTML = `
        <tr>
          <td colspan="6" class="text-center py-5 text-muted">
            <i class="bi bi-people fs-2 d-block mb-2"></i>
            No users found matching your criteria.
          </td>
        </tr>
      `;
      return;
    }

    tableBody.innerHTML = users.map(u => `
      <tr>
        <td>
          <div class="d-flex align-items-center gap-3">
            <img src="${u.avatar}" alt="${u.name}" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">
            <div>
              <div class="fw-bold text-dark">${u.name}</div>
              <div class="text-muted small">${u.email}</div>
            </div>
          </div>
        </td>
        <td>
          <span class="badge ${u.role === 'admin' ? 'bg-dark' : (u.role === 'charity' ? 'bg-info text-dark' : 'bg-success')} text-uppercase">
            ${u.role}
          </span>
        </td>
        <td>${u.joinedDate || '2025-01-10'}</td>
        <td>
          <span class="badge ${u.status === 'active' ? 'bg-success' : 'bg-danger'}">
            ${u.status.toUpperCase()}
          </span>
        </td>
        <td>
          <div class="d-flex gap-2">
            <button class="btn btn-sm btn-ghost p-1 px-2 btn-view-user" data-id="${u.id}" title="User Profile">
              <i class="bi bi-eye"></i>
            </button>
            ${u.role !== 'admin' ? `
              <button class="btn btn-sm btn-ghost p-1 px-2 ${u.status === 'active' ? 'text-danger' : 'text-success'} btn-toggle-status" data-id="${u.id}" title="${u.status === 'active' ? 'Suspend User' : 'Reactivate User'}">
                <i class="bi ${u.status === 'active' ? 'bi-slash-circle' : 'bi-check-circle'}"></i>
              </button>
            ` : ''}
          </div>
        </td>
      </tr>
    `).join('');

    // Wire up toggle status (suspend/reactivate)
    tableBody.querySelectorAll('.btn-toggle-status').forEach(btn => {
      btn.addEventListener('click', () => {
        const uId = btn.dataset.id;
        const updated = EcoStore.toggleUserStatus(uId);
        if (updated) {
          EcoToast.show(`User ${updated.name} account is now ${updated.status.toUpperCase()}.`, updated.status === 'active' ? 'success' : 'warning');
          renderUsers();
        }
      });
    });

    // Wire up view details modal
    tableBody.querySelectorAll('.btn-view-user').forEach(btn => {
      btn.addEventListener('click', () => {
        const uId = btn.dataset.id;
        const user = EcoStore.getUsers().find(u => u.id === uId);
        if (!user) return;

        const modalEl = document.getElementById('userDetailsModal');
        if (modalEl) {
          document.getElementById('modalUserName').textContent = user.name;
          document.getElementById('modalUserEmail').textContent = user.email;
          document.getElementById('modalUserPhone').textContent = user.phone;
          document.getElementById('modalUserAddress').textContent = user.address;
          document.getElementById('modalUserRole').textContent = user.role.toUpperCase();
          document.getElementById('modalUserAvatar').src = user.avatar;
          const modal = new bootstrap.Modal(modalEl);
          modal.show();
        }
      });
    });
  }

  if (searchInput) searchInput.addEventListener('input', renderUsers);
  if (roleFilter) roleFilter.addEventListener('change', renderUsers);
  if (statusFilter) statusFilter.addEventListener('change', renderUsers);

  renderUsers();
}

// ==========================================================================
// Manage Organizations Page
// ==========================================================================
function initManageOrganizations() {
  const container = document.getElementById('manageOrgsTableBody');
  if (!container) return;

  function renderOrgs() {
    const orgs = EcoStore.getUsers().filter(u => u.role === 'charity');

    container.innerHTML = orgs.map(org => `
      <tr>
        <td>
          <div class="d-flex align-items-center gap-3">
            <img src="${org.avatar}" class="rounded-circle" style="width: 44px; height: 44px; object-fit: cover;">
            <div>
              <div class="fw-bold text-dark">${org.name}</div>
              <div class="text-muted small">${org.address}</div>
            </div>
          </div>
        </td>
        <td>${org.orgType || 'Food Bank & Pantry'}</td>
        <td><code>${org.taxId || '501(c)(3)'}</code></td>
        <td>
          <span class="badge ${org.verified ? 'bg-success' : 'bg-warning text-dark'}">
            ${org.verified ? 'VERIFIED' : 'PENDING'}
          </span>
        </td>
        <td>
          <div class="d-flex gap-2">
            <button class="btn btn-sm btn-outline-primary py-1 px-2 btn-inspect-org" data-id="${org.id}">
              <i class="bi bi-file-earmark-text"></i> Inspect Docs
            </button>
            ${!org.verified ? `
              <button class="btn btn-sm btn-success py-1 px-2 btn-approve-org" data-id="${org.id}">
                <i class="bi bi-check-circle"></i> Approve
              </button>
              <button class="btn btn-sm btn-danger py-1 px-2 btn-reject-org" data-id="${org.id}">
                <i class="bi bi-x-circle"></i> Reject
              </button>
            ` : `
              <span class="text-success small fw-bold d-flex align-items-center"><i class="bi bi-shield-fill-check me-1"></i> Approved</span>
            `}
          </div>
        </td>
      </tr>
    `).join('');

    // Inspect Docs Modal
    container.querySelectorAll('.btn-inspect-org').forEach(btn => {
      btn.addEventListener('click', () => {
        const orgId = btn.dataset.id;
        const org = EcoStore.getUsers().find(u => u.id === orgId);
        if (!org) return;

        const modalEl = document.getElementById('orgInspectModal');
        if (modalEl) {
          document.getElementById('inspectOrgName').textContent = org.name;
          document.getElementById('inspectTaxId').textContent = org.taxId || '501(c)(3) #84-9201934';
          document.getElementById('inspectServiceArea').textContent = org.serviceArea || 'Metro City Wide';
          const modal = new bootstrap.Modal(modalEl);
          modal.show();
        }
      });
    });

    // Approve Org
    container.querySelectorAll('.btn-approve-org').forEach(btn => {
      btn.addEventListener('click', () => {
        const orgId = btn.dataset.id;
        EcoStore.updateOrgStatus(orgId, 'verified');
        EcoToast.show('Organization verified! Full collection privileges granted.', 'success');
        renderOrgs();
      });
    });

    // Reject Org
    container.querySelectorAll('.btn-reject-org').forEach(btn => {
      btn.addEventListener('click', () => {
        const orgId = btn.dataset.id;
        const reason = prompt('Please enter reason for rejecting this verification request:', 'Tax documentation incomplete or outdated.');
        if (reason) {
          EcoStore.updateOrgStatus(orgId, 'rejected', reason);
          EcoToast.show('Verification request rejected.', 'warning');
          renderOrgs();
        }
      });
    });
  }

  renderOrgs();
}

// ==========================================================================
// Manage Reports Page
// ==========================================================================
function initManageReports() {
  const container = document.getElementById('manageReportsTableBody');
  if (!container) return;

  function renderReports() {
    const reports = EcoStore.getReports();

    if (reports.length === 0) {
      container.innerHTML = `
        <tr>
          <td colspan="6" class="text-center py-5 text-muted">
            <i class="bi bi-check2-all fs-2 text-success d-block mb-2"></i>
            No active moderation reports!
          </td>
        </tr>
      `;
      return;
    }

    container.innerHTML = reports.map(r => `
      <tr>
        <td>
          <span class="badge ${r.targetType === 'listing' ? 'bg-primary' : 'bg-secondary'} text-uppercase">
            ${r.targetType}
          </span>
        </td>
        <td>
          <div class="fw-bold text-dark">${r.targetTitle}</div>
          <div class="text-secondary small">Reported by: ${r.reportedBy}</div>
        </td>
        <td class="text-secondary small">${r.reason}</td>
        <td>${r.date}</td>
        <td>
          <span class="badge ${r.status === 'pending' ? 'bg-warning text-dark' : (r.status === 'resolved' ? 'bg-success' : 'bg-secondary')}">
            ${r.status.toUpperCase()}
          </span>
        </td>
        <td>
          ${r.status === 'pending' ? `
            <div class="d-flex gap-2">
              <button class="btn btn-sm btn-success py-1 px-2 btn-resolve-report" data-id="${r.id}">
                <i class="bi bi-check-lg"></i> Resolve
              </button>
              <button class="btn btn-sm btn-ghost py-1 px-2 text-danger border-danger btn-dismiss-report" data-id="${r.id}">
                Dismiss
              </button>
            </div>
          ` : `
            <span class="text-muted small">Closed</span>
          `}
        </td>
      </tr>
    `).join('');

    container.querySelectorAll('.btn-resolve-report').forEach(btn => {
      btn.addEventListener('click', () => {
        const id = btn.dataset.id;
        EcoStore.resolveReport(id, 'resolved');
        EcoToast.show('Report resolved and actions applied.', 'success');
        renderReports();
      });
    });

    container.querySelectorAll('.btn-dismiss-report').forEach(btn => {
      btn.addEventListener('click', () => {
        const id = btn.dataset.id;
        EcoStore.resolveReport(id, 'dismissed');
        EcoToast.show('Report dismissed as unfounded.', 'info');
        renderReports();
      });
    });
  }

  renderReports();
}


window.addEventListener('langChanged', () => {
  initAdminDashboard();
  initManageUsers();
  initManageOrganizations();
  initManageReports();
});
