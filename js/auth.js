/**
 * Food Bridge — Authentication & Registration Handler
 */

document.addEventListener('DOMContentLoaded', () => {
  // Password Visibility Toggle
  setupPasswordToggles();

  // Login Page Logic
  setupLoginForm();

  // Registration Page Logic
  setupRegisterForm();
});

function setupPasswordToggles() {
  document.querySelectorAll('.password-toggle-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const input = btn.closest('.input-group').querySelector('input');
      const icon = btn.querySelector('i');
      if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('bi-eye');
        icon.classList.add('bi-eye-slash');
      } else {
        input.type = 'password';
        icon.classList.remove('bi-eye-slash');
        icon.classList.add('bi-eye');
      }
    });
  });
}

function setupLoginForm() {
  const loginForm = document.getElementById('loginForm');
  if (!loginForm) return;

  // Preset demo account buttons
  document.querySelectorAll('.btn-demo-login').forEach(btn => {
    btn.addEventListener('click', (e) => {
      const role = e.currentTarget.dataset.role;
      const emailInput = document.getElementById('loginEmail');
      const passInput = document.getElementById('loginPassword');

      if (role === 'donor') {
        if (emailInput) emailInput.value = 'kitchen@greenbites.org';
        if (passInput) passInput.value = '••••••••';
        EcoStore.setSession('donor', 'user_donor_1');
        EcoToast.show('Logging in as Donor (GreenBites Organic Bistro)...', 'success');
        setTimeout(() => window.location.href = 'donor-dashboard.html', 800);
      } else if (role === 'charity') {
        if (emailInput) emailInput.value = 'contact@hopepantry.org';
        if (passInput) passInput.value = '••••••••';
        EcoStore.setSession('charity', 'user_charity_1');
        EcoToast.show('Logging in as Verified Charity (Hope Food Pantry)...', 'success');
        setTimeout(() => window.location.href = 'charity-dashboard.html', 800);
      } else if (role === 'admin') {
        if (emailInput) emailInput.value = 'ops@foodbridge.org';
        if (passInput) passInput.value = '••••••••';
        EcoStore.setSession('admin', 'user_admin_1');
        EcoToast.show('Logging in as Platform Administrator...', 'info');
        setTimeout(() => window.location.href = 'admin-dashboard.html', 800);
      }
    });
  });

  loginForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const email = document.getElementById('loginEmail').value.trim();
    const pass = document.getElementById('loginPassword').value.trim();

    if (!email || !email.includes('@')) {
      EcoToast.show('Please provide a valid email address.', 'error');
      document.getElementById('loginEmail').classList.add('is-invalid');
      return;
    }

    if (!pass || pass.length < 6) {
      EcoToast.show('Password must be at least 6 characters long.', 'error');
      document.getElementById('loginPassword').classList.add('is-invalid');
      return;
    }

    // Determine role by matching demo users
    const users = EcoStore.getUsers();
    const matched = users.find(u => u.email.toLowerCase() === email.toLowerCase());

    if (matched) {
      EcoStore.setSession(matched.role, matched.id);
      EcoToast.show(`Welcome back, ${matched.name}!`, 'success');
      setTimeout(() => {
        if (matched.role === 'admin') window.location.href = 'admin-dashboard.html';
        else if (matched.role === 'charity') window.location.href = 'charity-dashboard.html';
        else window.location.href = 'donor-dashboard.html';
      }, 700);
    } else {
      // Default to donor for unknown email in prototype demo
      EcoStore.setSession('donor', 'user_donor_1');
      EcoToast.show('Demo login successful! Directing to Donor Dashboard...', 'success');
      setTimeout(() => window.location.href = 'donor-dashboard.html', 700);
    }
  });
}

function setupRegisterForm() {
  const registerForm = document.getElementById('registerForm');
  if (!registerForm) return;

  const roleRadios = document.querySelectorAll('input[name="registrationRole"]');
  const donorFields = document.getElementById('donorFieldsContainer');
  const charityFields = document.getElementById('charityFieldsContainer');

  roleRadios.forEach(radio => {
    radio.addEventListener('change', () => {
      if (radio.value === 'charity') {
        if (donorFields) donorFields.style.display = 'none';
        if (charityFields) charityFields.style.display = 'block';
      } else {
        if (donorFields) donorFields.style.display = 'block';
        if (charityFields) charityFields.style.display = 'none';
      }
    });
  });

  // Document upload preview in charity registration
  const docUploadInput = document.getElementById('orgVerificationDoc');
  const docUploadPreview = document.getElementById('docUploadPreview');
  if (docUploadInput && docUploadPreview) {
    docUploadInput.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if (file) {
        docUploadPreview.innerHTML = `
          <div class="alert alert-success d-flex align-items-center gap-2 mb-0 py-2">
            <i class="bi bi-file-earmark-pdf-fill fs-5 text-success"></i>
            <div>
              <strong>${file.name}</strong> (${(file.size / 1024).toFixed(1)} KB)
              <div class="text-muted small">Verification document ready for review</div>
            </div>
          </div>
        `;
      }
    });
  }

  registerForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const selectedRole = document.querySelector('input[name="registrationRole"]:checked').value;
    const email = document.getElementById('regEmail').value.trim();
    const pass = document.getElementById('regPassword').value;
    const confirmPass = document.getElementById('regConfirmPassword').value;

    if (!email || !email.includes('@')) {
      EcoToast.show('Please enter a valid email address.', 'error');
      return;
    }

    if (pass.length < 6) {
      EcoToast.show('Password must be at least 6 characters.', 'error');
      return;
    }

    if (pass !== confirmPass) {
      EcoToast.show('Passwords do not match. Please verify.', 'error');
      return;
    }

    let orgName = '';
    let newUserId = 'user_' + Date.now();

    if (selectedRole === 'charity') {
      orgName = document.getElementById('charityOrgName').value.trim();
      if (!orgName) {
        EcoToast.show('Please provide the Charitable Organization Name.', 'error');
        return;
      }
      EcoToast.show('Organization registration submitted! Status: Pending Document Verification.', 'info');
      // Create registered charity with pending status
      EcoStore.setSession('charity', 'user_charity_1');
      setTimeout(() => window.location.href = 'charity-dashboard.html', 1200);
    } else {
      orgName = document.getElementById('donorFullName').value.trim();
      if (!orgName) {
        EcoToast.show('Please provide your name or business name.', 'error');
        return;
      }
      EcoToast.show('Donor registration successful! Welcome to Food Bridge.', 'success');
      EcoStore.setSession('donor', 'user_donor_1');
      setTimeout(() => window.location.href = 'donor-dashboard.html', 1200);
    }
  });
}

function handleLogout() {
  EcoToast.show('Logging out from session...', 'info');
  setTimeout(() => {
    window.location.href = 'login.html';
  }, 500);
}
