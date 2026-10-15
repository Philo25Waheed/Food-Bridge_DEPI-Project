# Food Bridge — Frontend UI/UX Platform

An enterprise-quality, responsive web application connecting restaurants, grocers, and commercial suppliers with verified charitable food banks and shelters to eliminate edible food waste and nourish local communities.

---

## 🌟 Executive Summary

**Food Bridge** provides an interactive digital pipeline to redistribute surplus food before expiration. It supports three distinct stakeholder experiences:
1. **Donors (Restaurants, Supermarkets, Bakeries, Individuals):** Quickly publish surplus food, configure safe cold-chain handling, set pickup windows, approve incoming charity allocations, and track their ESG / CO2 impact metrics.
2. **Charities (Soup Kitchens, Food Banks, Shelters, Community Pantries):** Discover nearby available food through an interactive **Leaflet OpenStreetMap** interface, request full or partial allocations, coordinate vehicle dispatch, and verify handoffs with digital collection passes.
3. **Platform Administrators:** Verify 501(c)(3) documentation, manage user account privileges, moderate listing quality reports, and oversee regional food rescue analytics.

---

## 🎨 Design System & Visual Identity

The interface was designed to reflect environmental consciousness, trust, and modern software ergonomics:

- **Primary Forest Green (`#228B55`):** Represents freshness, vitality, and ecological responsibility.
- **Secondary Teal (`#2A9D8F`):** Represents logistics coordination, trust, and cleanliness.
- **Light Eco Surface (`#F8FAF7` / `#FFFFFF`):** High-contrast, clean layout with subtle shadows.
- **Status Indicators:**
  - **Success (`#16A34A`):** Verified organizations, completed collections, safe handling.
  - **Urgent / Expiring Soon (`#DC2626` / `#E76F51`):** Items expiring in < 24 hours requiring fast rescue.
  - **Warning (`#F59E0B`):** Pending approvals, reservations awaiting donor review.
  - **Info (`#2563EB`):** Scheduled pickups, transport logistics, and milestones.
- **Typography:** `Plus Jakarta Sans` for clean, bold headings; `Inter` for highly legible data tables and forms.
- **Iconography:** Bootstrap Icons (`bi-*`) throughout navigation, status badges, and interactive controls.

---

## 🧭 Page Architecture (18 Completed Pages)

### Public & Marketing
1. [`index.html`](index.html) — **Landing Page**: Compelling hero section with headline *"Share More. Waste Less. Change Lives."*, simulated impact metrics, 3-step "How It Works", live featured donation cards dynamically rendered from local state, donor vs. charity comparison, testimonials, FAQ accordion, and footer.
2. [`about.html`](about.html) — **About Us**: Global food waste paradox data, mission and vision, core values, safety charter, and community call-to-action.
3. [`login.html`](login.html) — **Authentication**: Email/password authentication, show/hide password toggle, remember me checkbox, validation feedback, and **1-click Fast Persona Logins** (Donor, Charity, Admin).
4. [`register.html`](register.html) — **Registration**: Role switcher between Donor and Charity, conditional form fields (business type, service area, tax ID), and interactive document upload dropzone preview.

### Donor Hub
5. [`donor-dashboard.html`](donor-dashboard.html) — **Donor Hub**: Real-time KPI summary cards (Rescued kg, Active listings, Pending requests, Completed pickups), **Chart.js 6-month impact graph**, urgent expiration ticker, interactive incoming requests review queue (Approve / Reject), and recent donations table.
6. [`create-donation.html`](create-donation.html) — **Publish Donation**: Structured donation creation form with title, category, quantity & unit, drag & drop image preview, expiration datetime, **interactive Leaflet location picker with draggable pin**, pickup windows, and safe handling instructions.
7. [`manage-donations.html`](manage-donations.html) — **My Listings**: Searchable and filterable donation directory with status tabs (All, Available, Reserved, Completed, Cancelled), category filters, edit listing modal, and cancellation confirmation.

### Charity Hub & Discovery
8. [`charity-dashboard.html`](charity-dashboard.html) — **Charity Hub**: Available nearby metrics, urgent <24h expiring foods row, recommended distribution feed, and quick dispatch links.
9. [`explore-donations.html`](explore-donations.html) — **Explore Food**: Split layout featuring live donation cards alongside an **interactive Leaflet OpenStreetMap** with custom green pins, popups, category pills, radius filter (<2km, <5km, <10km), urgency switch, and mobile Map/List toggle.
10. [`donation-details.html`](donation-details.html) — **Donation Details**: High-resolution image view, food safety instructions, verified donor badge, embedded Leaflet pickup map, and interactive **Request Donation Modal** with quantity stepper validation.
11. [`my-requests.html`](my-requests.html) — **My Requests**: Request status tabs (Pending, Approved, Scheduled, Collected, Rejected) with direct tracking links and handoff confirmation triggers.
12. [`donation-tracking.html`](donation-tracking.html) — **Pickup Tracking**: 5-stage milestone tracker (Published &rarr; Requested &rarr; Approved &rarr; Scheduled &rarr; Collected) with timestamps, donor facility contacts, and digital collection QR pass (`#ECO-8924`).

### Administration & Operations
13. [`admin-dashboard.html`](admin-dashboard.html) — **Admin Center**: System metrics (Total users, verified charities, active listings, landfill diversion), **Chart.js Monthly Trends and Category Distribution**, and pending verification queue.
14. [`manage-users.html`](manage-users.html) — **Manage Users**: Searchable table with role and status filtering, user profile modal, and working Suspend / Reactivate controls.
15. [`manage-organizations.html`](manage-organizations.html) — **Verify Charities**: Non-profit 501(c)(3) verification queue, document inspection modal, and instant Approve/Reject workflows.
16. [`manage-reports.html`](manage-reports.html) — **Reports & Moderation**: Quality disputes queue with working Resolve and Dismiss actions.

### Account & Shared Utilities
17. [`notifications.html`](notifications.html) — **Notifications**: Categorized alert center (Requests, Pickups, Urgent Expirations) with unread indicators, "Mark as Read", and "Mark All as Read" actions.
18. [`profile.html`](profile.html) — **Profile & Settings**: Avatar photo upload with instant preview, organization details, notification preference toggles, password update form, and **Reset Prototype Data** control.

---

## ⚡ Interactive Engine, Multi-Language & Dark Mode

All workflows are powered by a zero-dependency client state engine (`EcoStore`, `EcoTheme`, `EcoLang` in `js/app.js`):
- **Arabic (العربية) & English (EN) Localization:**
  - One-click language switching between **English (LTR)** and **Arabic (RTL)**.
  - Native Right-to-Left layout mirroring (`dir="rtl"` and `lang="ar"`).
  - High-elegance **Cairo** Arabic font integration (`font-family: 'Cairo'`).
  - Comprehensive translation dictionary covering navigation, metrics, statuses, categories, and form placeholders.
  - Directional icon flipping and mobile drawer repositioning.
  - Language preference persisted in `localStorage`.
- **Dark Theme (الوضع الليلي) & Light Theme (الوضع النهاري):**
  - Instant theme switching between eco-light surfaces and deep dark backgrounds (`#0B130E` / `#131E17`).
  - Dynamic **Leaflet map tile filter** for dark mode compatibility.
  - Theme-aware **Chart.js** re-rendering (updating text, axes, and grid lines dynamically).
  - Bootstrap 5 `data-bs-theme="dark"` synchronisation.
  - Theme preference persisted in `localStorage`.
- **Mobile-First Responsive Engineering:**
  - Designed and verified for small mobile (`360px`, `390px`), tablets (`768px`), and wide screens (`1280px`, `1440px`).
  - Sliding off-canvas sidebar drawer with backdrop overlay.
  - Responsive tables with horizontal touch scrolling.
  - Dedicated **Mobile Map / Cards View Toggle** on discovery pages.
- **Top Demo Bar & In-Header Controls:** Persistent top bar with instant **Persona Switcher** (Donor, Charity, Admin), **Language Selector**, **Theme Toggle**, and **Reset Demo Data**.
- **Toast Notifications:** Real-time feedback alerts for user interactions.

---

## 🚀 Setup & Execution Instructions

Because the project uses standard HTML5, CSS3, and modern JavaScript, no build step or node compilation is required:

### Option 1: Direct File Open
Double click `index.html` in any modern web browser (Google Chrome, Microsoft Edge, Firefox, Safari).

### Option 2: Local HTTP Server (Recommended for Map Tiles)
Run any lightweight static server in the root directory:

```bash
# Using Python
python -m http.server 8000

# Using Node.js
npx serve .
```

Then navigate to `http://localhost:8000` in your browser.

---

## 🛡️ Prototype Notes & Security Guidelines

- **Simulated Authentication:** Login and registration forms validate inputs and manage role state in `localStorage` for prototype review. In accordance with security standards, **no real passwords, tokens, or private identity documents are transmitted or stored insecurely**.
- **Sample Data:** All donor addresses, weights, food listings, and charity organizations are realistic demo models designed for product testing and grading.
