/**
 * Food Bridge — Charity Workflows, Discovery & Tracking Handlers
 */

document.addEventListener('DOMContentLoaded', () => {
  initCharityDashboard();
  initExploreDonations();
  initMyRequests();
  initDonationTracking();
});

// ==========================================================================
// Charity Dashboard
// ==========================================================================
function initCharityDashboard() {
  const container = document.getElementById('charityDashboardOverview');
  if (!container) return;

  const donations = EcoStore.getDonations();
  const requests = EcoStore.getRequests();

  const available = donations.filter(d => d.status === 'available');
  const urgent = available.filter(d => d.urgent);
  const myPending = requests.filter(r => r.status === 'pending');
  const myScheduled = requests.filter(r => r.status === 'scheduled');
  const myCollected = requests.filter(r => r.status === 'collected');

  // Update counters
  const countAvailable = document.getElementById('charityMetricAvailable');
  const countPending = document.getElementById('charityMetricPending');
  const countScheduled = document.getElementById('charityMetricScheduled');
  const countCollected = document.getElementById('charityMetricCollected');

  if (countAvailable) countAvailable.textContent = available.length;
  if (countPending) countPending.textContent = myPending.length;
  if (countScheduled) countScheduled.textContent = myScheduled.length;
  if (countCollected) countCollected.textContent = myCollected.length + 15;

  // Render Urgent Expirations Banner
  const urgentList = document.getElementById('charityUrgentDonationsRow');
  if (urgentList) {
    urgentList.innerHTML = urgent.slice(0, 3).map(d => `
      <div class="col-md-4 mb-3">
        <div class="card border-danger shadow-sm h-100">
          <div class="card-body p-3">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <span class="badge bg-danger"><i class="bi bi-clock-history"></i> ${typeof EcoLang !== 'undefined' ? EcoLang.t('Expires Soon') : 'Expires Soon'}</span>
              <span class="text-muted small">~${d.distanceKm || '2.0'} km</span>
            </div>
            <h6 class="fw-bold mb-1">${typeof EcoLang !== 'undefined' ? EcoLang.t(d.title) : d.title}</h6>
            <div class="text-secondary small mb-2"><i class="bi bi-shop text-success"></i> ${typeof EcoLang !== 'undefined' ? EcoLang.t(d.donorName) : d.donorName}</div>
            <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
              <span class="fw-bold text-dark">${d.quantity} ${typeof EcoLang !== 'undefined' ? EcoLang.t(d.unit) : d.unit}</span>
              <a href="donation-details.html?id=${d.id}" class="btn btn-sm btn-outline-danger py-1 px-2">
                ${typeof EcoLang !== 'undefined' ? EcoLang.t('Rescue Now') : 'Rescue Now'}
              </a>
            </div>
          </div>
        </div>
      </div>
    `).join('');
  }

  // Render Recommended Feed
  const feed = document.getElementById('charityRecommendedFeed');
  if (feed) {
    feed.innerHTML = available.slice(0, 4).map(d => `
      <div class="col-md-6 mb-4">
        <div class="eco-card h-100 p-0 overflow-hidden d-flex flex-column">
          <div class="position-relative" style="height: 160px;">
            <img src="${d.images[0]}" alt="${d.title}" style="width: 100%; height: 100%; object-fit: cover;">
            <span class="donation-category-pill">${d.category}</span>
          </div>
          <div class="p-3 d-flex flex-column flex-grow-1">
            <h6 class="fw-bold mb-1">${typeof EcoLang !== 'undefined' ? EcoLang.t(d.title) : d.title}</h6>
            <div class="text-secondary small mb-2"><i class="bi bi-geo-alt text-success"></i> ${typeof EcoLang !== 'undefined' ? EcoLang.t(d.pickupAddress) : d.pickupAddress}</div>
            <div class="d-flex justify-content-between text-muted small py-2 border-top border-bottom mb-3">
              <span><strong>${d.quantity}</strong> ${typeof EcoLang !== 'undefined' ? EcoLang.t(d.unit) : d.unit}</span>
              <span>${typeof EcoLang !== 'undefined' ? EcoLang.t('Expires:') : 'Exp:'} ${new Date(d.expiresAt).toLocaleDateString()}</span>
            </div>
            <a href="donation-details.html?id=${d.id}" class="btn btn-sm btn-primary-eco w-100 justify-content-center mt-auto">
              ${typeof EcoLang !== 'undefined' ? EcoLang.t('Request Allocation') : 'Request Allocation'}
            </a>
          </div>
        </div>
      </div>
    `).join('');
  }
}

// ==========================================================================
// Explore Donations (Map + Discovery)
// ==========================================================================
function initExploreDonations() {
  const exploreContainer = document.getElementById('exploreDonationsCardsContainer');
  if (!exploreContainer) return;

  let map;
  let markersLayer;
  const mapElement = document.getElementById('exploreDonationsMap');

  if (mapElement && typeof L !== 'undefined') {
    map = L.map('exploreDonationsMap').setView([40.7300, -73.9950], 12);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    markersLayer = L.layerGroup().addTo(map);
  }

  const searchInput = document.getElementById('exploreSearchInput');
  const categorySelect = document.getElementById('exploreCategorySelect');
  const distanceSelect = document.getElementById('exploreDistanceSelect');
  const urgentCheckbox = document.getElementById('exploreUrgentOnly');
  const viewToggleBtn = document.getElementById('exploreMobileViewToggle');
  const mapCol = document.getElementById('exploreMapColumn');

  // Mobile Map / List Toggle
  if (viewToggleBtn && mapCol) {
    let showingMap = false;
    viewToggleBtn.addEventListener('click', () => {
      showingMap = !showingMap;
      if (showingMap) {
        mapCol.classList.remove('map-hidden-mobile');
        exploreContainer.classList.add('d-none');
        viewToggleBtn.innerHTML = '<i class="bi bi-list-ul me-1"></i> Show Cards';
        if (map) map.invalidateSize();
      } else {
        mapCol.classList.add('map-hidden-mobile');
        exploreContainer.classList.remove('d-none');
        viewToggleBtn.innerHTML = '<i class="bi bi-map me-1"></i> Show Map';
      }
    });
  }

  function filterAndRender() {
    let items = EcoStore.getDonations().filter(d => d.status === 'available');

    const searchVal = searchInput ? searchInput.value.toLowerCase().trim() : '';
    const catVal = categorySelect ? categorySelect.value : 'all';
    const distVal = distanceSelect ? parseFloat(distanceSelect.value) : 999;
    const urgentOnly = urgentCheckbox ? urgentCheckbox.checked : false;

    if (searchVal) {
      items = items.filter(d =>
        d.title.toLowerCase().includes(searchVal) ||
        d.description.toLowerCase().includes(searchVal) ||
        d.donorName.toLowerCase().includes(searchVal)
      );
    }

    if (catVal !== 'all') {
      items = items.filter(d => d.category.toLowerCase() === catVal.toLowerCase());
    }

    if (distVal && !isNaN(distVal)) {
      items = items.filter(d => (d.distanceKm || 2) <= distVal);
    }

    if (urgentOnly) {
      items = items.filter(d => d.urgent);
    }

    const countLabel = document.getElementById('exploreResultsCount');
    if (countLabel) countLabel.textContent = `${items.length} donations available`;

    if (items.length === 0) {
      exploreContainer.innerHTML = `
        <div class="empty-state w-100 col-12">
          <div class="empty-state-icon"><i class="bi bi-search"></i></div>
          <h5>No matches found</h5>
          <p class="text-secondary">Try widening your search radius or changing categories.</p>
        </div>
      `;
      if (markersLayer) markersLayer.clearLayers();
      return;
    }

    // Render Cards
    exploreContainer.innerHTML = items.map(d => createDonationCardHTML(d)).join('');

    // Update Map Pins
    if (map && markersLayer) {
      markersLayer.clearLayers();
      const bounds = [];

      items.forEach(d => {
        const coords = d.coordinates || [40.7128, -74.0060];
        bounds.push(coords);

        const customIcon = L.divIcon({
          className: 'custom-leaflet-marker',
          html: '<i class="bi bi-box2-heart-fill"></i>',
          iconSize: [36, 36],
          iconAnchor: [18, 18],
          popupAnchor: [0, -18]
        });

        const marker = L.marker(coords, { icon: customIcon }).addTo(markersLayer);
        marker.bindPopup(`
          <div style="min-width: 180px;">
            <img src="${d.images[0]}" style="width: 100%; height: 90px; object-fit: cover; border-radius: 6px; margin-bottom: 6px;">
            <h6 style="font-weight:700; margin-bottom: 4px; font-size: 0.95rem;">${d.title}</h6>
            <div style="font-size: 0.8rem; color: #64748B;">${d.donorName}</div>
            <div style="font-size: 0.8rem; font-weight: 600; color: #228B55; margin-top: 4px;">${d.quantity} ${d.unit} available</div>
            <a href="donation-details.html?id=${d.id}" class="btn btn-sm btn-primary-eco w-100 py-1 mt-2 text-center" style="font-size:0.78rem;">View Details</a>
          </div>
        `);
      });

      if (bounds.length > 0) {
        map.fitBounds(bounds, { padding: [50, 50] });
      }
    }
  }

  if (searchInput) searchInput.addEventListener('input', filterAndRender);
  if (categorySelect) categorySelect.addEventListener('change', filterAndRender);
  if (distanceSelect) distanceSelect.addEventListener('change', filterAndRender);
  if (urgentCheckbox) urgentCheckbox.addEventListener('change', filterAndRender);

  window.addEventListener('langChanged', () => {
    filterAndRender();
  });

  filterAndRender();
}

// ==========================================================================
// My Requests Page
// ==========================================================================
function initMyRequests() {
  const container = document.getElementById('myRequestsContainer');
  if (!container) return;

  const tabs = document.querySelectorAll('#myRequestsTabs .nav-link');
  let currentFilter = 'all';

  function renderRequests() {
    let requests = EcoStore.getRequests();

    if (currentFilter !== 'all') {
      requests = requests.filter(r => r.status === currentFilter);
    }

    if (requests.length === 0) {
      container.innerHTML = `
        <div class="empty-state">
          <div class="empty-state-icon"><i class="bi bi-clock-history"></i></div>
          <h5>No requests found</h5>
          <p class="text-secondary">Explore available food donations and submit a request to support your community.</p>
          <a href="explore-donations.html" class="btn btn-primary-eco">Find Food Donations</a>
        </div>
      `;
      return;
    }

    container.innerHTML = requests.map(req => {
      let actionButtons = `
        <a href="donation-tracking.html?reqId=${req.id}" class="btn btn-sm btn-outline-primary">
          <i class="bi bi-diagram-3 me-1"></i> Track Milestone
        </a>
      `;

      if (req.status === 'scheduled') {
        actionButtons += `
          <button class="btn btn-sm btn-success ms-2 btn-confirm-pickup" data-id="${req.id}">
            <i class="bi bi-check2-circle me-1"></i> Confirm Handoff
          </button>
        `;
      }

      return `
        <div class="eco-card mb-3 p-4">
          <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
            <div>
              <div class="d-flex align-items-center gap-2 mb-1">
                <h5 class="fw-bold mb-0">${req.donationTitle}</h5>
                <span class="badge-eco badge-${req.status}">${req.status.toUpperCase()}</span>
              </div>
              <div class="text-secondary small">
                <i class="bi bi-shop text-success"></i> Donor: <strong>${req.donorName}</strong> &bull;
                Requested: <strong>${req.requestedQuantity} ${req.unit}</strong> &bull;
                Date: ${new Date(req.requestDate).toLocaleDateString()}
              </div>
              ${req.scheduledPickupDate ? `
                <div class="text-success small fw-bold mt-1">
                  <i class="bi bi-calendar-check me-1"></i> Pickup Scheduled: ${new Date(req.scheduledPickupDate).toLocaleString()}
                </div>
              ` : ''}
              ${req.notes ? `<div class="text-muted small mt-2 fst-italic">"${req.notes}"</div>` : ''}
            </div>
            <div class="d-flex align-items-center flex-wrap gap-2">
              ${actionButtons}
            </div>
          </div>
        </div>
      `;
    }).join('');

    container.querySelectorAll('.btn-confirm-pickup').forEach(btn => {
      btn.addEventListener('click', () => {
        const reqId = btn.dataset.id;
        EcoStore.updateRequestStatus(reqId, 'collected');
        EcoToast.show('Collection successfully confirmed! Thank you for reducing food waste.', 'success');
        renderRequests();
      });
    });
  }

  tabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      e.preventDefault();
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      currentFilter = tab.dataset.status || 'all';
      renderRequests();
    });
  });

  renderRequests();
}

// ==========================================================================
// Donation Tracking Page
// ==========================================================================
function initDonationTracking() {
  const container = document.getElementById('trackingContainer');
  if (!container) return;

  const urlParams = new URLSearchParams(window.location.search);
  const reqId = urlParams.get('reqId') || 'req_201';
  const request = EcoStore.getRequestById(reqId) || EcoStore.getRequests()[0];

  if (!request) {
    container.innerHTML = `
      <div class="empty-state">
        <div class="empty-state-icon"><i class="bi bi-question-circle"></i></div>
        <h5>Tracking Record Not Found</h5>
        <a href="my-requests.html" class="btn btn-primary-eco">View All Requests</a>
      </div>
    `;
    return;
  }

  const donation = EcoStore.getDonationById(request.donationId) || {
    pickupAddress: '452 Elm Street, Downtown Metro',
    handlingInstructions: 'Maintain cold chain. Safe transport.'
  };

  // Populate Details
  document.getElementById('trackDonationTitle').textContent = request.donationTitle;
  document.getElementById('trackDonorName').textContent = request.donorName;
  document.getElementById('trackCharityName').textContent = request.charityName;
  document.getElementById('trackQuantity').textContent = `${request.requestedQuantity} ${request.unit}`;
  document.getElementById('trackAddress').textContent = donation.pickupAddress;
  document.getElementById('trackHandling').textContent = donation.handlingInstructions;

  const statusBadge = document.getElementById('trackStatusBadge');
  if (statusBadge) {
    statusBadge.className = `badge-eco badge-${request.status}`;
    statusBadge.textContent = request.status.toUpperCase();
  }

  // Define 5-stage milestones
  const stages = [
    { key: 'published', title: 'Donation Published', icon: 'bi-megaphone-fill', desc: 'Listing made available to verified charities' },
    { key: 'submitted', title: 'Request Submitted', icon: 'bi-send-fill', desc: `${request.charityName} sent a reservation request` },
    { key: 'approved', title: 'Request Approved', icon: 'bi-check-circle-fill', desc: 'Donor reviewed and accepted allocation' },
    { key: 'scheduled', title: 'Pickup Scheduled', icon: 'bi-calendar-check-fill', desc: 'Time slot confirmed for collection' },
    { key: 'collected', title: 'Collection Confirmed', icon: 'bi-award-fill', desc: 'Food safely delivered and distributed' }
  ];

  let currentStageIndex = 1;
  if (request.status === 'pending') currentStageIndex = 1;
  else if (request.status === 'approved') currentStageIndex = 2;
  else if (request.status === 'scheduled') currentStageIndex = 3;
  else if (request.status === 'collected') currentStageIndex = 4;

  const timelineContainer = document.getElementById('trackingTimelineContainer');
  if (timelineContainer) {
    timelineContainer.innerHTML = stages.map((stage, idx) => {
      let stepClass = '';
      if (idx < currentStageIndex) stepClass = 'completed';
      else if (idx === currentStageIndex) stepClass = 'current';

      return `
        <div class="tracking-step ${stepClass}">
          <div class="tracking-step-icon">
            <i class="bi ${stage.icon}"></i>
          </div>
          <div class="tracking-step-content">
            <div class="tracking-step-title">${stage.title}</div>
            <div class="tracking-step-time">
              ${idx <= currentStageIndex ? 'Completed / Verified' : 'Pending next workflow step'}
            </div>
            <div class="tracking-step-desc">${stage.desc}</div>
          </div>
        </div>
      `;
    }).join('');
  }

  // Setup Advance Workflow Button
  const advanceBtn = document.getElementById('trackAdvanceWorkflowBtn');
  if (advanceBtn) {
    if (request.status === 'scheduled') {
      advanceBtn.innerHTML = '<i class="bi bi-qr-code-scan me-2"></i>Verify Handoff & Complete Collection';
      advanceBtn.classList.remove('d-none');
      advanceBtn.onclick = () => {
        EcoStore.updateRequestStatus(request.id, 'collected');
        EcoToast.show('Collection Verified! All milestones completed.', 'success');
        setTimeout(() => location.reload(), 800);
      };
    } else if (request.status === 'approved') {
      advanceBtn.innerHTML = '<i class="bi bi-clock-history me-2"></i>Confirm Schedule Pickup';
      advanceBtn.classList.remove('d-none');
      advanceBtn.onclick = () => {
        EcoStore.updateRequestStatus(request.id, 'scheduled', 'Tomorrow at 2:00 PM');
        EcoToast.show('Pickup scheduled successfully!', 'success');
        setTimeout(() => location.reload(), 800);
      };
    } else {
      advanceBtn.classList.add('d-none');
    }
  }
}


window.addEventListener('langChanged', () => {
  initCharityDashboard();
  initExploreDonations();
  initMyRequests();
  initDonationTracking();
});
