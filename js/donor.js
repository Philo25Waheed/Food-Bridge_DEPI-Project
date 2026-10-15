/**
 * Food Bridge — Donor Workflows & Dashboard Handlers
 */

document.addEventListener('DOMContentLoaded', () => {
  initDonorDashboard();
  initManageDonations();
});

// ==========================================================================
// Donor Dashboard
// ==========================================================================
function initDonorDashboard() {
  const chartCanvas = document.getElementById('donorActivityChart');
  if (!chartCanvas) return;

  const currentRole = EcoStore.getCurrentRole();
  const currentUser = EcoStore.getCurrentUser();
  const donations = EcoStore.getDonations().filter(d => d.donorId === currentUser.id || currentRole === 'donor');
  const requests = EcoStore.getRequests().filter(r => r.donorId === currentUser.id || currentRole === 'donor');

  // Update Summary Metrics
  const totalKg = donations.reduce((sum, d) => sum + (d.unit === 'kg' ? d.quantity : 10), 0);
  const activeCount = donations.filter(d => d.status === 'available').length;
  const pendingRequests = requests.filter(r => r.status === 'pending');
  const completedCount = donations.filter(d => d.status === 'completed').length;

  const metricTotal = document.getElementById('donorMetricTotalKg');
  const metricActive = document.getElementById('donorMetricActive');
  const metricPending = document.getElementById('donorMetricPending');
  const metricCompleted = document.getElementById('donorMetricCompleted');

  if (metricTotal) metricTotal.textContent = `${totalKg + 650} kg`;
  if (metricActive) metricActive.textContent = activeCount;
  if (metricPending) metricPending.textContent = pendingRequests.length;
  if (metricCompleted) metricCompleted.textContent = completedCount + 12;

  // Render Chart.js
  if (typeof Chart !== 'undefined') {
    const isDark = EcoTheme.get() === 'dark';
    const gridColor = isDark ? '#22382B' : '#E2E8F0';
    const textColor = isDark ? '#94A3B8' : '#64748B';

    if (window.donorChartInstance) {
      window.donorChartInstance.destroy();
    }

    const ctx = chartCanvas.getContext('2d');
    window.donorChartInstance = new Chart(ctx, {
      type: 'line',
      data: {
        labels: (typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar') ? ['مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر'] : ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'],
        datasets: [
          {
            label: (typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar') ? 'الغذاء المنقذ (كجم)' : 'Rescued Food (kg)',
            data: [280, 420, 390, 560, 680, 890],
            borderColor: '#228B55',
            backgroundColor: 'rgba(34, 139, 85, 0.15)',
            fill: true,
            tension: 0.35,
            borderWidth: 3,
            pointBackgroundColor: '#228B55',
            pointRadius: 5
          },
          {
            label: (typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar') ? 'انبعاثات كربون تم تفاديها (كجم)' : 'CO2 Offset (kg)',
            data: [140, 210, 195, 280, 340, 445],
            borderColor: '#2A9D8F',
            backgroundColor: 'rgba(42, 157, 143, 0.08)',
            fill: true,
            tension: 0.35,
            borderWidth: 2,
            pointBackgroundColor: '#2A9D8F',
            pointRadius: 4
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

    window.removeEventListener('themeChanged', window._donorChartThemeHandler);
    window._donorChartThemeHandler = () => initDonorDashboard();
    window.addEventListener('themeChanged', window._donorChartThemeHandler);
  }

  // Render Incoming Requests List
  const requestsList = document.getElementById('donorIncomingRequestsContainer');
  if (requestsList) {
    if (pendingRequests.length === 0) {
      requestsList.innerHTML = `
        <div class="p-4 text-center text-muted">
          <i class="bi bi-inbox fs-2 text-secondary d-block mb-2"></i>
          No pending charity requests at this moment.
        </div>
      `;
    } else {
      requestsList.innerHTML = pendingRequests.map(req => `
        <div class="p-3 border-bottom d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3">
          <div>
            <div class="d-flex align-items-center gap-2">
              <strong class="text-dark">${req.charityName}</strong>
              <span class="badge bg-warning text-dark" style="font-size:0.75rem">Pending Review</span>
            </div>
            <div class="text-secondary small mt-1">
              Requested <strong>${req.requestedQuantity} ${req.unit}</strong> of "${req.donationTitle}"
            </div>
            ${req.notes ? `<div class="text-muted small mt-1 fst-italic">"${req.notes}"</div>` : ''}
          </div>
          <div class="d-flex gap-2">
            <button class="btn btn-sm btn-primary-eco py-1 px-3 btn-approve-request" data-req-id="${req.id}">
              <i class="bi bi-check-lg"></i> Approve
            </button>
            <button class="btn btn-sm btn-ghost py-1 px-3 text-danger border-danger btn-reject-request" data-req-id="${req.id}">
              <i class="bi bi-x-lg"></i> Reject
            </button>
          </div>
        </div>
      `).join('');

      // Wire up approve / reject actions
      requestsList.querySelectorAll('.btn-approve-request').forEach(btn => {
        btn.addEventListener('click', () => {
          const reqId = btn.dataset.reqId;
          EcoStore.updateRequestStatus(reqId, 'approved');
          EcoToast.show('Request approved! Pickup coordination unlocked.', 'success');
          initDonorDashboard();
        });
      });

      requestsList.querySelectorAll('.btn-reject-request').forEach(btn => {
        btn.addEventListener('click', () => {
          const reqId = btn.dataset.reqId;
          if (confirm('Are you sure you want to decline this request?')) {
            EcoStore.updateRequestStatus(reqId, 'rejected', 'Listing reserved for emergency shelter priority.');
            EcoToast.show('Request rejected.', 'info');
            initDonorDashboard();
          }
        });
      });
    }
  }

  // Render Recent Donations Table in Dashboard
  const tableBody = document.getElementById('donorRecentDonationsTableBody');
  if (tableBody) {
    tableBody.innerHTML = donations.slice(0, 5).map(d => `
      <tr>
        <td>
          <div class="d-flex align-items-center gap-3">
            <img src="${d.images[0]}" alt="${d.title}" class="rounded" style="width: 48px; height: 48px; object-fit: cover;">
            <div>
              <a href="donation-details.html?id=${d.id}" class="fw-bold text-dark text-decoration-none">${d.title}</a>
              <div class="text-muted small">${d.category}</div>
            </div>
          </div>
        </td>
        <td><strong>${d.quantity}</strong> ${d.unit}</td>
        <td>${new Date(d.expiresAt).toLocaleDateString()}</td>
        <td><span class="badge-eco badge-${d.status}">${d.status.toUpperCase()}</span></td>
        <td>
          <a href="donation-details.html?id=${d.id}" class="btn btn-sm btn-ghost p-1 px-2" title="View Details">
            <i class="bi bi-eye"></i>
          </a>
        </td>
      </tr>
    `).join('');
  }
}

// ==========================================================================
// Manage Donations Page
// ==========================================================================
function initManageDonations() {
  const container = document.getElementById('manageDonationsContainer');
  if (!container) return;

  const searchInput = document.getElementById('manageDonationSearch');
  const categoryFilter = document.getElementById('manageCategoryFilter');
  const statusTabs = document.querySelectorAll('#manageStatusTabs .nav-link');

  let currentStatus = 'all';
  let currentCategory = 'all';
  let searchTerm = '';

  function renderList() {
    let list = EcoStore.getDonations();

    if (currentStatus !== 'all') {
      list = list.filter(d => d.status === currentStatus);
    }
    if (currentCategory !== 'all') {
      list = list.filter(d => d.category.toLowerCase() === currentCategory.toLowerCase());
    }
    if (searchTerm) {
      list = list.filter(d =>
        d.title.toLowerCase().includes(searchTerm) ||
        d.description.toLowerCase().includes(searchTerm) ||
        d.pickupAddress.toLowerCase().includes(searchTerm)
      );
    }

    if (list.length === 0) {
      container.innerHTML = `
        <div class="empty-state w-100">
          <div class="empty-state-icon"><i class="bi bi-folder2-open"></i></div>
          <h4>No donations found</h4>
          <p class="text-secondary">Try adjusting your filters, search term, or publish a new donation listing.</p>
          <a href="create-donation.html" class="btn btn-primary-eco">Create New Donation</a>
        </div>
      `;
      return;
    }

    container.innerHTML = list.map(d => `
      <div class="col-lg-6 col-xl-4 mb-4" id="card-${d.id}">
        <div class="eco-card h-100 d-flex flex-column p-0">
          <div class="position-relative" style="height: 180px; overflow: hidden;">
            <img src="${d.images[0]}" alt="${d.title}" style="width: 100%; height: 100%; object-fit: cover;">
            <span class="donation-category-pill">${d.category}</span>
            <span class="position-absolute bottom-0 end-0 m-2 badge-eco badge-${d.status}">${d.status.toUpperCase()}</span>
          </div>
          <div class="p-3 d-flex flex-column flex-grow-1">
            <h5 class="fw-bold mb-1">${d.title}</h5>
            <div class="text-secondary small mb-2"><i class="bi bi-geo-alt text-success"></i> ${d.pickupAddress}</div>
            <div class="d-flex justify-content-between text-muted small py-2 border-top border-bottom mb-3">
              <span>Quantity: <strong>${d.quantity} ${d.unit}</strong></span>
              <span>Exp: <strong>${new Date(d.expiresAt).toLocaleDateString()}</strong></span>
            </div>
            <div class="mt-auto d-flex gap-2">
              <a href="donation-details.html?id=${d.id}" class="btn btn-sm btn-ghost flex-grow-1">
                <i class="bi bi-eye"></i> Details
              </a>
              <button class="btn btn-sm btn-ghost text-primary btn-edit-donation" data-id="${d.id}" title="Edit Listing">
                <i class="bi bi-pencil-square"></i>
              </button>
              ${d.status !== 'cancelled' ? `
                <button class="btn btn-sm btn-ghost text-danger btn-cancel-donation" data-id="${d.id}" title="Cancel Listing">
                  <i class="bi bi-trash3"></i>
                </button>
              ` : ''}
            </div>
          </div>
        </div>
      </div>
    `).join('');

    // Wire up edit modal trigger
    container.querySelectorAll('.btn-edit-donation').forEach(btn => {
      btn.addEventListener('click', () => {
        const dId = btn.dataset.id;
        const donation = EcoStore.getDonationById(dId);
        if (!donation) return;

        const editTitle = document.getElementById('editDonationTitle');
        const editQty = document.getElementById('editDonationQuantity');
        const editId = document.getElementById('editDonationId');

        if (editTitle && editQty && editId) {
          editTitle.value = donation.title;
          editQty.value = donation.quantity;
          editId.value = donation.id;
          const editModal = new bootstrap.Modal(document.getElementById('editDonationModal'));
          editModal.show();
        }
      });
    });

    // Wire up cancel listing
    container.querySelectorAll('.btn-cancel-donation').forEach(btn => {
      btn.addEventListener('click', () => {
        const dId = btn.dataset.id;
        if (confirm('Are you sure you want to cancel this donation listing? It will no longer be visible to charities.')) {
          EcoStore.cancelDonation(dId);
          EcoToast.show('Donation listing cancelled.', 'warning');
          renderList();
        }
      });
    });
  }

  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchTerm = e.target.value.toLowerCase().trim();
      renderList();
    });
  }

  if (categoryFilter) {
    categoryFilter.addEventListener('change', (e) => {
      currentCategory = e.target.value;
      renderList();
    });
  }

  statusTabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      e.preventDefault();
      statusTabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      currentStatus = tab.dataset.status || 'all';
      renderList();
    });
  });

  // Handle Edit form submission inside modal
  const editForm = document.getElementById('editDonationForm');
  if (editForm) {
    editForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const id = document.getElementById('editDonationId').value;
      const title = document.getElementById('editDonationTitle').value;
      const qty = parseFloat(document.getElementById('editDonationQuantity').value);

      EcoStore.updateDonation(id, { title, quantity: qty });
      EcoToast.show('Listing updated successfully!', 'success');

      const modalEl = document.getElementById('editDonationModal');
      const modal = bootstrap.Modal.getInstance(modalEl);
      if (modal) modal.hide();

      renderList();
    });
  }

  window.addEventListener('langChanged', () => {
    renderList();
  });

  renderList();
}


window.addEventListener('langChanged', () => {
  initDonorDashboard();
  initManageDonations();
});
