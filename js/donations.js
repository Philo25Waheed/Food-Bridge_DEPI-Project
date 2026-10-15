/**
 * Food Bridge — Donation Operations & Workflow Handlers
 */

// Helper to render consistent donation card HTML across pages
function createDonationCardHTML(donation) {
  const isAr = typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar';
  const titleText = isAr ? EcoLang.t(donation.title) : (EcoLang.t(donation.title, 'en') || donation.title);
  const descText = isAr ? EcoLang.t(donation.description) : (EcoLang.t(donation.description, 'en') || donation.description);
  const donorText = isAr ? EcoLang.t(donation.donorName) : (EcoLang.t(donation.donorName, 'en') || donation.donorName);
  const categoryText = isAr ? EcoLang.t(donation.category) : (EcoLang.t(donation.category, 'en') || donation.category);
  const unitText = isAr ? EcoLang.t(donation.unit) : (EcoLang.t(donation.unit, 'en') || donation.unit);
  const statusUpper = donation.status.toUpperCase();
  const statusText = isAr ? EcoLang.t(statusUpper) : statusUpper;
  const urgentText = isAr ? 'عاجل' : 'Urgent';
  const verifiedText = isAr ? 'موثق' : 'Verified';
  const btnText = isAr ? 'التفاصيل وطلب الحصة' : 'View Details & Request';
  const awayText = isAr ? 'تقريباً' : 'away';
  const expText = isAr ? 'الصلاحية:' : 'Exp:';

  const urgencyBadge = donation.urgent
    ? `<span class="donation-urgency-pill"><i class="bi bi-clock-history"></i> ${urgentText}</span>`
    : '';

  const statusBadge = `<span class="badge-eco badge-${donation.status}">${statusText}</span>`;

  return `
    <div class="col-md-6 col-lg-4 mb-4" data-donation-id="${donation.id}">
      <div class="donation-card h-100">
        <div class="donation-image-wrap">
          <img src="${donation.images[0]}" alt="${titleText}" loading="lazy">
          <span class="donation-category-pill">${categoryText}</span>
          ${urgencyBadge}
        </div>
        <div class="donation-body">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <h5 class="donation-title">${titleText}</h5>
          </div>
          <div class="donation-donor-info">
            <i class="bi bi-shop text-success"></i>
            <span>${donorText}</span>
            ${donation.donorVerified ? `<span class="badge-verified"><i class="bi bi-patch-check-fill"></i> ${verifiedText}</span>` : ''}
          </div>
          <p class="text-secondary small mb-3 text-truncate-2" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 38px;">
            ${descText}
          </p>
          <div class="donation-meta-grid">
            <div class="donation-meta-item">
              <i class="bi bi-box-seam"></i>
              <span><strong>${donation.quantity}</strong> ${unitText}</span>
            </div>
            <div class="donation-meta-item">
              <i class="bi bi-geo-alt"></i>
              <span>~${donation.distanceKm || '2.0'} km ${awayText}</span>
            </div>
            <div class="donation-meta-item">
              <i class="bi bi-hourglass-split"></i>
              <span>${expText} ${new Date(donation.expiresAt).toLocaleDateString()}</span>
            </div>
            <div class="donation-meta-item">
              <i class="bi bi-activity"></i>
              <span>${statusBadge}</span>
            </div>
          </div>
          <div class="donation-footer">
            <a href="donation-details.html?id=${donation.id}" class="btn btn-sm btn-primary-eco w-100 justify-content-center">
              <i class="bi bi-eye"></i> ${btnText}
            </a>
          </div>
        </div>
      </div>
    </div>
  `;
}

// ==========================================================================
// Create Donation Page Logic
// ==========================================================================
function initCreateDonation() {
  const form = document.getElementById('createDonationForm');
  if (!form) return;

  // Initialize Map Picker with Leaflet
  let map, marker;
  const mapElement = document.getElementById('pickupLocationPickerMap');
  const defaultCoords = [40.7128, -74.0060];

  if (mapElement && typeof L !== 'undefined') {
    map = L.map('pickupLocationPickerMap').setView(defaultCoords, 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    marker = L.marker(defaultCoords, { draggable: true }).addTo(map);
    marker.bindPopup('Drag marker to set exact pickup point').openPopup();

    marker.on('dragend', function (e) {
      const pos = e.target.getLatLng();
      const coordInput = document.getElementById('donationCoordinates');
      if (coordInput) coordInput.value = `${pos.lat.toFixed(4)}, ${pos.lng.toFixed(4)}`;
      EcoToast.show(`Location pinned: ${pos.lat.toFixed(4)}, ${pos.lng.toFixed(4)}`, 'info');
    });

    map.on('click', function(e) {
      marker.setLatLng(e.latlng);
      const coordInput = document.getElementById('donationCoordinates');
      if (coordInput) coordInput.value = `${e.latlng.lat.toFixed(4)}, ${e.latlng.lng.toFixed(4)}`;
    });
  }

  // Image Upload Handling & Preview
  const imageInput = document.getElementById('donationImagesInput');
  const dropzone = document.getElementById('donationDropzone');
  const previewGrid = document.getElementById('imagePreviewGrid');
  let selectedImages = [
    'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=600&auto=format&fit=crop&q=80'
  ];

  function renderPreviews() {
    if (!previewGrid) return;
    previewGrid.innerHTML = '';
    selectedImages.forEach((src, idx) => {
      const div = document.createElement('div');
      div.className = 'preview-thumbnail';
      div.innerHTML = `
        <img src="${src}" alt="Preview ${idx + 1}">
        <button type="button" class="preview-remove-btn" data-index="${idx}">&times;</button>
      `;
      div.querySelector('.preview-remove-btn').onclick = () => {
        selectedImages.splice(idx, 1);
        renderPreviews();
      };
      previewGrid.appendChild(div);
    });
  }
  renderPreviews();

  if (dropzone && imageInput) {
    dropzone.addEventListener('click', () => imageInput.click());
    dropzone.addEventListener('dragover', (e) => {
      e.preventDefault();
      dropzone.classList.add('dragover');
    });
    dropzone.addEventListener('dragleave', () => dropzone.classList.remove('dragover'));
    dropzone.addEventListener('drop', (e) => {
      e.preventDefault();
      dropzone.classList.remove('dragover');
      if (e.dataTransfer.files && e.dataTransfer.files[0]) {
        handleFileSelect(e.dataTransfer.files[0]);
      }
    });

    imageInput.addEventListener('change', (e) => {
      if (e.target.files && e.target.files[0]) {
        handleFileSelect(e.target.files[0]);
      }
    });
  }

  function handleFileSelect(file) {
    const reader = new FileReader();
    reader.onload = (e) => {
      selectedImages.push(e.target.result);
      renderPreviews();
      EcoToast.show('Photo added to donation preview', 'success');
    };
    reader.readAsDataURL(file);
  }

  // Submit Handler
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const submitBtn = form.querySelector('button[type="submit"]');
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Publishing...';

    const title = document.getElementById('donationTitle').value.trim();
    const category = document.getElementById('donationCategory').value;
    const quantity = parseFloat(document.getElementById('donationQuantity').value);
    const unit = document.getElementById('donationUnit').value;
    const description = document.getElementById('donationDescription').value.trim();
    const expiresAt = document.getElementById('donationExpiresAt').value;
    const pickupAddress = document.getElementById('donationPickupAddress').value.trim();
    const pickupWindows = document.getElementById('donationPickupWindows').value.trim();
    const handlingInstructions = document.getElementById('donationHandling').value.trim();

    if (!title || !quantity || !pickupAddress || !expiresAt) {
      EcoToast.show('Please fill in all required fields.', 'error');
      submitBtn.disabled = false;
      submitBtn.innerHTML = '<i class="bi bi-cloud-arrow-up me-2"></i>Publish Donation';
      return;
    }

    const currentUser = EcoStore.getCurrentUser();

    const newDonation = {
      title,
      category,
      quantity,
      unit,
      description,
      images: selectedImages.length > 0 ? selectedImages : ['https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=600&auto=format&fit=crop&q=80'],
      donorId: currentUser.id,
      donorName: currentUser.name,
      donorType: currentUser.donorType || 'Restaurant / Donor',
      donorVerified: true,
      pickupAddress,
      coordinates: defaultCoords,
      expiresAt: new Date(expiresAt).toISOString(),
      pickupWindows: pickupWindows || 'Daily 9:00 AM - 5:00 PM',
      handlingInstructions: handlingInstructions || 'Standard food-safe transport.',
      urgent: false,
      distanceKm: 1.2
    };

    EcoStore.addDonation(newDonation);
    EcoToast.show('Donation published successfully! Verified charities have been notified.', 'success');

    setTimeout(() => {
      window.location.href = 'manage-donations.html';
    }, 1200);
  });
}

// ==========================================================================
// Donation Details Page Logic
// ==========================================================================
function initDonationDetails() {
  const detailsContainer = document.getElementById('donationDetailsContainer');
  if (!detailsContainer) return;

  const urlParams = new URLSearchParams(window.location.search);
  const donationId = urlParams.get('id') || 'don_101';
  const donation = EcoStore.getDonationById(donationId) || EcoStore.getDonations()[0];

  if (!donation) {
    detailsContainer.innerHTML = `
      <div class="empty-state">
        <div class="empty-state-icon"><i class="bi bi-exclamation-circle"></i></div>
        <h4>Donation Not Found</h4>
        <p class="text-muted">The listing you are looking for may have been removed or completed.</p>
        <a href="explore-donations.html" class="btn btn-primary-eco">Browse All Donations</a>
      </div>
    `;
    return;
  }

  // Populate data in page
  const isAr = typeof EcoLang !== 'undefined' && EcoLang.get() === 'ar';
  document.getElementById('detailsTitle').textContent = isAr ? EcoLang.t(donation.title) : (EcoLang.t(donation.title, 'en') || donation.title);
  document.getElementById('detailsCategory').textContent = isAr ? EcoLang.t(donation.category) : (EcoLang.t(donation.category, 'en') || donation.category);
  document.getElementById('detailsDescription').textContent = isAr ? EcoLang.t(donation.description) : (EcoLang.t(donation.description, 'en') || donation.description);
  document.getElementById('detailsQuantity').textContent = `${donation.quantity} ${isAr ? EcoLang.t(donation.unit) : (EcoLang.t(donation.unit, 'en') || donation.unit)}`;
  document.getElementById('detailsExpires').textContent = (isAr ? 'ينتهي في: ' : 'Expires: ') + new Date(donation.expiresAt).toLocaleDateString() + ' ' + (isAr ? 'الساعة' : 'at') + ' ' + new Date(donation.expiresAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  document.getElementById('detailsAddress').textContent = isAr ? EcoLang.t(donation.pickupAddress) : (EcoLang.t(donation.pickupAddress, 'en') || donation.pickupAddress);
  document.getElementById('detailsWindows').textContent = isAr ? EcoLang.t(donation.pickupWindows) : (EcoLang.t(donation.pickupWindows, 'en') || donation.pickupWindows);
  document.getElementById('detailsHandling').textContent = isAr ? EcoLang.t(donation.handlingInstructions) : (EcoLang.t(donation.handlingInstructions, 'en') || donation.handlingInstructions);
  document.getElementById('detailsDonorName').textContent = isAr ? EcoLang.t(donation.donorName) : (EcoLang.t(donation.donorName, 'en') || donation.donorName);
  document.getElementById('detailsDonorType').textContent = isAr ? EcoLang.t(donation.donorType) : (EcoLang.t(donation.donorType, 'en') || donation.donorType);
  document.getElementById('detailsMainImage').src = donation.images[0];

  const statusBadge = document.getElementById('detailsStatusBadge');
  if (statusBadge) {
    statusBadge.className = `badge-eco badge-${donation.status}`;
    statusBadge.textContent = isAr ? EcoLang.t(donation.status.toUpperCase()) : donation.status.toUpperCase();
  }

  // Leaflet map setup for details page
  const detailsMapEl = document.getElementById('detailsMap');
  if (detailsMapEl && typeof L !== 'undefined') {
    const coords = donation.coordinates || [40.7128, -74.0060];
    const map = L.map('detailsMap').setView(coords, 14);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '© OpenStreetMap'
    }).addTo(map);

    L.marker(coords).addTo(map)
      .bindPopup(`<strong>${donation.donorName}</strong><br>${donation.pickupAddress}`)
      .openPopup();
  }

  // Setup Request Donation Modal
  const requestBtn = document.getElementById('openRequestModalBtn');
  const requestModal = document.getElementById('requestDonationModal');
  const requestQtyInput = document.getElementById('reqQuantityInput');
  const maxQtyLabel = document.getElementById('reqMaxQuantityLabel');

  if (maxQtyLabel) maxQtyLabel.textContent = `Max: ${donation.quantity} ${donation.unit}`;
  if (requestQtyInput) {
    requestQtyInput.max = donation.quantity;
    requestQtyInput.value = donation.quantity;
  }

  const submitReqForm = document.getElementById('submitRequestForm');
  if (submitReqForm) {
    submitReqForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const reqQty = parseFloat(requestQtyInput.value);
      const notes = document.getElementById('reqNotesInput').value.trim();

      if (reqQty <= 0 || reqQty > donation.quantity) {
        EcoToast.show(`Requested quantity must be between 1 and ${donation.quantity}.`, 'error');
        return;
      }

      const currentUser = EcoStore.getCurrentUser();
      const newReq = EcoStore.createRequest({
        donationId: donation.id,
        donationTitle: donation.title,
        donorId: donation.donorId,
        donorName: donation.donorName,
        charityId: currentUser.id,
        charityName: currentUser.name,
        requestedQuantity: reqQty,
        unit: donation.unit,
        notes: notes
      });

      // Close modal
      const modalInstance = bootstrap.Modal.getInstance(requestModal);
      if (modalInstance) modalInstance.hide();

      EcoToast.show(`Request for ${reqQty} ${donation.unit} submitted to ${donation.donorName}!`, 'success');
      setTimeout(() => {
        window.location.href = `donation-tracking.html?reqId=${newReq.id}`;
      }, 1200);
    });
  }
}

// Execute on DOM Ready
document.addEventListener('DOMContentLoaded', () => {
  initCreateDonation();
  initDonationDetails();
});

window.addEventListener('langChanged', () => {
  initDonationDetails();
});
