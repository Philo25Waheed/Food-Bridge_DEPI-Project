/**
 * Food Bridge — Core Application & Mock State Engine
 * Version: 1.0 (Frontend Prototype)
 */

// ==========================================================================
// Seed Data Initialization
// ==========================================================================

const DEFAULT_USERS = [
  {
    id: 'user_donor_1',
    name: 'GreenBites Organic Bistro',
    role: 'donor',
    donorType: 'Restaurant',
    email: 'kitchen@greenbites.org',
    phone: '+1 (555) 234-5678',
    address: '452 Elm Street, Downtown Metro',
    coordinates: [40.7128, -74.0060],
    verified: true,
    avatar: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=150&auto=format&fit=crop&q=80',
    joinedDate: '2025-01-15',
    status: 'active',
    stats: { totalDonatedKg: 1420, completedPickups: 38 }
  },
  {
    id: 'user_donor_2',
    name: 'FreshMart Supermarket',
    role: 'donor',
    donorType: 'Supermarket',
    email: 'community@freshmart.com',
    phone: '+1 (555) 345-6789',
    address: '890 Broadway Ave, Metro',
    coordinates: [40.7282, -73.9942],
    verified: true,
    avatar: 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=150&auto=format&fit=crop&q=80',
    joinedDate: '2025-02-01',
    status: 'active',
    stats: { totalDonatedKg: 3890, completedPickups: 74 }
  },
  {
    id: 'user_donor_3',
    name: 'Artisan Metro Bakery',
    role: 'donor',
    donorType: 'Bakery',
    email: 'orders@metrobakery.com',
    phone: '+1 (555) 456-7890',
    address: '124 Market Square, Metro',
    coordinates: [40.7410, -73.9897],
    verified: true,
    avatar: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=150&auto=format&fit=crop&q=80',
    joinedDate: '2025-02-18',
    status: 'active',
    stats: { totalDonatedKg: 640, completedPickups: 22 }
  },
  {
    id: 'user_charity_1',
    name: 'Hope Community Food Pantry',
    role: 'charity',
    orgType: 'Soup Kitchen & Food Pantry',
    email: 'contact@hopepantry.org',
    contactPerson: 'Elena Rostova',
    phone: '+1 (555) 890-1234',
    address: '320 Civic Center Plaza, Metro',
    coordinates: [40.7180, -73.9980],
    verified: true,
    avatar: 'https://images.unsplash.com/photo-1593113598332-cd288d649433?w=150&auto=format&fit=crop&q=80',
    serviceArea: 'Greater Metro Area (Radius 15km)',
    joinedDate: '2024-11-20',
    status: 'active',
    taxId: '501(c)(3) #84-9201934'
  },
  {
    id: 'user_charity_2',
    name: 'Care Haven Shelter Foundation',
    role: 'charity',
    orgType: 'Shelter & Family Support',
    email: 'logistics@carehaven.org',
    contactPerson: 'Marcus Vance',
    phone: '+1 (555) 789-0123',
    address: '742 Maple Blvd, North District',
    coordinates: [40.7580, -73.9855],
    verified: true,
    avatar: 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=150&auto=format&fit=crop&q=80',
    serviceArea: 'North & East Suburbs',
    joinedDate: '2024-12-05',
    status: 'active',
    taxId: '501(c)(3) #93-1029482'
  },
  {
    id: 'user_charity_3',
    name: 'New Dawn Youth Haven',
    role: 'charity',
    orgType: 'Youth Center & Nutrition',
    email: 'director@newdawnyouth.org',
    contactPerson: 'Amina Diop',
    phone: '+1 (555) 901-2345',
    address: '15 Harbor View Rd, Westside',
    coordinates: [40.7060, -74.0150],
    verified: false, // Pending verification in admin view!
    avatar: 'https://images.unsplash.com/photo-1544717305-2782549b5136?w=150&auto=format&fit=crop&q=80',
    serviceArea: 'Westside Waterfront Community',
    joinedDate: '2026-03-10',
    status: 'pending_verification',
    taxId: '501(c)(3) #77-4839201'
  },
  {
    id: 'user_admin_1',
    name: 'Food Bridge Operations Team',
    role: 'admin',
    email: 'ops@foodbridge.org',
    phone: '+1 (555) 111-2222',
    address: 'Food Bridge HQ, Innovation Tower #400',
    verified: true,
    avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
    joinedDate: '2024-01-01',
    status: 'active'
  }
];

const DEFAULT_DONATIONS = [
  {
    id: 'don_101',
    title: 'Fresh Farm Organic Produce Crates',
    category: 'Produce',
    description: 'Surplus organic kale, crisp romaine lettuce, heirloom tomatoes, and crisp cucumbers from morning farm deliveries. Inspected, thoroughly washed, and packed in ventilated crates.',
    quantity: 45,
    unit: 'kg',
    images: [
      'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=600&auto=format&fit=crop&q=80',
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_1',
    donorName: 'GreenBites Organic Bistro',
    donorType: 'Restaurant',
    donorVerified: true,
    pickupAddress: '452 Elm Street, Downtown Metro',
    coordinates: [40.7128, -74.0060],
    publishedAt: '2026-10-15T09:30:00Z',
    expiresAt: '2026-10-17T18:00:00Z',
    pickupWindows: 'Daily 2:00 PM – 5:30 PM',
    handlingInstructions: 'Keep chilled between 4°C and 8°C. Handle crates with care.',
    status: 'available', // available, reserved, completed, cancelled
    urgent: false,
    distanceKm: 1.8
  },
  {
    id: 'don_102',
    title: 'Artisanal Sourdough & Multigrain Loaves',
    category: 'Bakery',
    description: 'Freshly baked today at 5 AM. Includes 25 loaves of traditional seeded sourdough, 15 baguettes, and 10 trays of whole-wheat dinner rolls. Perfect condition.',
    quantity: 50,
    unit: 'items',
    images: [
      'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=600&auto=format&fit=crop&q=80',
      'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_3',
    donorName: 'Artisan Metro Bakery',
    donorType: 'Bakery',
    donorVerified: true,
    pickupAddress: '124 Market Square, Metro',
    coordinates: [40.7410, -73.9897],
    publishedAt: '2026-10-15T11:00:00Z',
    expiresAt: '2026-10-16T19:00:00Z',
    pickupWindows: 'Today 4:00 PM – 8:00 PM',
    handlingInstructions: 'Store in cool dry conditions. Suitable for immediate freezing.',
    status: 'available',
    urgent: true,
    distanceKm: 2.4
  },
  {
    id: 'don_103',
    title: 'Gourmet Hot Meal Trays — Roasted Chicken & Rice',
    category: 'Prepared Meals',
    description: 'Prepared for an executive banquet, unserved surplus. Vacuum sealed and blast-chilled in food-grade aluminum trays according to strict HACCP food safety standards.',
    quantity: 35,
    unit: 'meals',
    images: [
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80',
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_1',
    donorName: 'GreenBites Organic Bistro',
    donorType: 'Restaurant',
    donorVerified: true,
    pickupAddress: '452 Elm Street, Downtown Metro',
    coordinates: [40.7128, -74.0060],
    publishedAt: '2026-10-15T14:15:00Z',
    expiresAt: '2026-10-16T12:00:00Z',
    pickupWindows: 'Tonight until 10:00 PM or tomorrow morning 8 AM',
    handlingInstructions: 'Must remain refrigerated at < 3°C until reheating to > 74°C.',
    status: 'available',
    urgent: true,
    distanceKm: 1.8
  },
  {
    id: 'don_104',
    title: 'Bulk Organic Whole Milk & Greek Yogurt',
    category: 'Dairy',
    description: 'Pallet of whole organic pasteurized milk (1L bottles) and Greek probiotic yogurts (500g tubs). 5 days remaining before "Best Before" date.',
    quantity: 60,
    unit: 'units',
    images: [
      'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_2',
    donorName: 'FreshMart Supermarket',
    donorType: 'Supermarket',
    donorVerified: true,
    pickupAddress: '890 Broadway Ave, Metro',
    coordinates: [40.7282, -73.9942],
    publishedAt: '2026-10-14T16:00:00Z',
    expiresAt: '2026-10-20T17:00:00Z',
    pickupWindows: 'Mon-Fri 9:00 AM – 6:00 PM',
    handlingInstructions: 'Strict cold-chain required (2°C - 4°C). Bring insulated coolers.',
    status: 'reserved',
    urgent: false,
    distanceKm: 3.1
  },
  {
    id: 'don_105',
    title: 'Assorted Canned Beans, Soups & Pasta Essentials',
    category: 'Canned Goods',
    description: 'Long shelf-life staples: black beans, diced plum tomatoes, vegetable broth, and durum wheat penne pasta. Pristine condition with 12+ months shelf life.',
    quantity: 120,
    unit: 'cans/boxes',
    images: [
      'https://images.unsplash.com/photo-1584473457406-6240486418e9?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_2',
    donorName: 'FreshMart Supermarket',
    donorType: 'Supermarket',
    donorVerified: true,
    pickupAddress: '890 Broadway Ave, Metro',
    coordinates: [40.7282, -73.9942],
    publishedAt: '2026-10-13T10:00:00Z',
    expiresAt: '2027-08-30T00:00:00Z',
    pickupWindows: 'Anytime during store hours (8 AM - 9 PM)',
    handlingInstructions: 'Dry ambient storage.',
    status: 'available',
    urgent: false,
    distanceKm: 3.1
  },
  {
    id: 'don_106',
    title: 'Sweet Orchard Seasonal Apples & Citrus',
    category: 'Produce',
    description: 'Crisp Honeycrisp apples, navel oranges, and ripe bananas. Excellent for school lunch programs, shelters, or direct community distribution.',
    quantity: 80,
    unit: 'kg',
    images: [
      'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_1',
    donorName: 'GreenBites Organic Bistro',
    donorType: 'Restaurant',
    donorVerified: true,
    pickupAddress: '452 Elm Street, Downtown Metro',
    coordinates: [40.7128, -74.0060],
    publishedAt: '2026-10-15T08:00:00Z',
    expiresAt: '2026-10-19T20:00:00Z',
    pickupWindows: 'Daily 10:00 AM – 4:00 PM',
    handlingInstructions: 'Keep in ventilated crates, avoid direct sunlight.',
    status: 'available',
    urgent: false,
    distanceKm: 1.8
  },
  {
    id: 'don_107',
    title: 'Individually Packaged Gourmet Deli Sandwiches',
    category: 'Prepared Meals',
    description: 'Turkey avocado, smoked mozzarella & pesto, and vegan roasted veggie wraps. Made fresh this morning for a canceled corporate lunch.',
    quantity: 30,
    unit: 'meals',
    images: [
      'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_1',
    donorName: 'GreenBites Organic Bistro',
    donorType: 'Restaurant',
    donorVerified: true,
    pickupAddress: '452 Elm Street, Downtown Metro',
    coordinates: [40.7128, -74.0060],
    publishedAt: '2026-10-15T12:00:00Z',
    expiresAt: '2026-10-16T15:00:00Z',
    pickupWindows: 'Immediate pickup preferred (before 7:00 PM)',
    handlingInstructions: 'Refrigerated transit required.',
    status: 'completed',
    urgent: true,
    distanceKm: 1.8
  },
  {
    id: 'don_108',
    title: 'Frozen Vegetable Medleys & Peas',
    category: 'Frozen Food',
    description: 'Bulk restaurant-grade bags of frozen organic green beans, peas, and mixed sweet corn. Perfect condition, kept in deep freeze at -18°C.',
    quantity: 75,
    unit: 'kg',
    images: [
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&auto=format&fit=crop&q=80'
    ],
    donorId: 'user_donor_2',
    donorName: 'FreshMart Supermarket',
    donorType: 'Supermarket',
    donorVerified: true,
    pickupAddress: '890 Broadway Ave, Metro',
    coordinates: [40.7282, -73.9942],
    publishedAt: '2026-10-12T10:00:00Z',
    expiresAt: '2027-01-15T00:00:00Z',
    pickupWindows: 'Mon-Sat 10:00 AM – 5:00 PM',
    handlingInstructions: 'Must transport in thermal freezer bags or refrigerated van.',
    status: 'available',
    urgent: false,
    distanceKm: 3.1
  }
];

const DEFAULT_REQUESTS = [
  {
    id: 'req_201',
    donationId: 'don_104',
    donationTitle: 'Bulk Organic Whole Milk & Greek Yogurt',
    donorId: 'user_donor_2',
    donorName: 'FreshMart Supermarket',
    charityId: 'user_charity_1',
    charityName: 'Hope Community Food Pantry',
    requestedQuantity: 60,
    unit: 'units',
    requestDate: '2026-10-15T10:30:00Z',
    status: 'scheduled', // pending, approved, scheduled, collected, rejected
    scheduledPickupDate: '2026-10-16T14:00:00Z',
    notes: 'Our refrigerated van will arrive at loading dock B. Contact driver Dave at 555-0199.',
    timeline: [
      { step: 'Published', time: '2026-10-14 16:00', desc: 'Listing created by FreshMart Supermarket' },
      { step: 'Request Submitted', time: '2026-10-15 10:30', desc: 'Hope Community Food Pantry requested 60 units' },
      { step: 'Request Approved', time: '2026-10-15 11:15', desc: 'Donor approved the full requested allocation' },
      { step: 'Pickup Scheduled', time: '2026-10-15 13:00', desc: 'Scheduled for Oct 16 at 2:00 PM (Dock B)' },
      { step: 'Collection Confirmed', time: null, desc: 'Awaiting handoff verification code' }
    ]
  },
  {
    id: 'req_202',
    donationId: 'don_107',
    donationTitle: 'Individually Packaged Gourmet Deli Sandwiches',
    donorId: 'user_donor_1',
    donorName: 'GreenBites Organic Bistro',
    charityId: 'user_charity_2',
    charityName: 'Care Haven Shelter Foundation',
    requestedQuantity: 30,
    unit: 'meals',
    requestDate: '2026-10-15T12:45:00Z',
    status: 'collected',
    scheduledPickupDate: '2026-10-15T16:00:00Z',
    notes: 'Directly distributed to evening shelter residents.',
    timeline: [
      { step: 'Published', time: '2026-10-15 12:00', desc: 'Listing created by GreenBites' },
      { step: 'Request Submitted', time: '2026-10-15 12:45', desc: 'Care Haven requested 30 meals' },
      { step: 'Request Approved', time: '2026-10-15 13:10', desc: 'GreenBites approved the request' },
      { step: 'Pickup Scheduled', time: '2026-10-15 14:00', desc: 'Pickup confirmed for 4:00 PM' },
      { step: 'Collection Confirmed', time: '2026-10-15 16:25', desc: 'Food handed over safely and verified' }
    ]
  },
  {
    id: 'req_203',
    donationId: 'don_101',
    donationTitle: 'Fresh Farm Organic Produce Crates',
    donorId: 'user_donor_1',
    donorName: 'GreenBites Organic Bistro',
    charityId: 'user_charity_1',
    charityName: 'Hope Community Food Pantry',
    requestedQuantity: 25,
    unit: 'kg',
    requestDate: '2026-10-15T15:00:00Z',
    status: 'pending',
    scheduledPickupDate: null,
    notes: 'We can collect tomorrow morning around 11 AM if approved.',
    timeline: [
      { step: 'Published', time: '2026-10-15 09:30', desc: 'Listing published' },
      { step: 'Request Submitted', time: '2026-10-15 15:00', desc: 'Hope Community requested 25 kg' }
    ]
  }
];

const DEFAULT_NOTIFICATIONS = [
  {
    id: 'notif_1',
    forUserRole: 'donor',
    forUserId: 'user_donor_1',
    title: 'New Donation Request',
    message: 'Hope Community Food Pantry requested 25 kg of "Fresh Farm Organic Produce Crates".',
    time: '25 mins ago',
    type: 'request',
    read: false,
    link: 'donor-dashboard.html'
  },
  {
    id: 'notif_2',
    forUserRole: 'charity',
    forUserId: 'user_charity_1',
    title: 'Pickup Confirmed',
    message: 'Your pickup of 60 units of milk & yogurt from FreshMart is confirmed for tomorrow 2:00 PM.',
    time: '2 hours ago',
    type: 'pickup',
    read: false,
    link: 'donation-tracking.html?reqId=req_201'
  },
  {
    id: 'notif_3',
    forUserRole: 'donor',
    forUserId: 'user_donor_1',
    title: 'Donation Expiring Soon',
    message: 'Your listing "Gourmet Hot Meal Trays" expires in 22 hours. 35 meals still available.',
    time: '4 hours ago',
    type: 'urgent',
    read: true,
    link: 'manage-donations.html'
  },
  {
    id: 'notif_4',
    forUserRole: 'admin',
    forUserId: 'user_admin_1',
    title: 'New Charity Verification Pending',
    message: 'New Dawn Youth Haven uploaded verification documents awaiting review.',
    time: '5 hours ago',
    type: 'verification',
    read: false,
    link: 'manage-organizations.html'
  },
  {
    id: 'notif_5',
    forUserRole: 'charity',
    forUserId: 'user_charity_2',
    title: 'Collection Completed',
    message: 'Successfully collected 30 meals from GreenBites. 18.5 kg CO2 emission diverted!',
    time: 'Yesterday',
    type: 'impact',
    read: true,
    link: 'my-requests.html'
  }
];

const DEFAULT_REPORTS = [
  {
    id: 'rep_1',
    targetType: 'listing',
    targetTitle: 'Bulk Rice Bags (Expired packaging)',
    reportedBy: 'Care Haven Shelter',
    reason: 'Packaging seal broken on arrival, unsuitable for pantry distribution.',
    date: '2026-10-14',
    status: 'pending', // pending, resolved, dismissed
    severity: 'medium'
  },
  {
    id: 'rep_2',
    targetType: 'user',
    targetTitle: 'Corner Deli & Bakery',
    reportedBy: 'City Food Project',
    reason: 'Repeatedly failed to show up during scheduled pickup windows.',
    date: '2026-10-12',
    status: 'resolved',
    severity: 'low'
  }
];

// ==========================================================================
// EcoStore (Local Storage Persistence Layer)
// ==========================================================================

const EcoStore = {
  KEY_DATA: 'ecodonate_storage_v1',
  KEY_CURRENT_ROLE: 'ecodonate_current_role',
  KEY_CURRENT_USER_ID: 'ecodonate_current_user_id',

  init() {
    if (!localStorage.getItem(this.KEY_DATA)) {
      this.resetData();
    }
    if (!localStorage.getItem(this.KEY_CURRENT_ROLE)) {
      // Default persona: Donor
      localStorage.setItem(this.KEY_CURRENT_ROLE, 'donor');
      localStorage.setItem(this.KEY_CURRENT_USER_ID, 'user_donor_1');
    }
  },

  resetData() {
    const freshData = {
      users: DEFAULT_USERS,
      donations: DEFAULT_DONATIONS,
      requests: DEFAULT_REQUESTS,
      notifications: DEFAULT_NOTIFICATIONS,
      reports: DEFAULT_REPORTS
    };
    localStorage.setItem(this.KEY_DATA, JSON.stringify(freshData));
    localStorage.setItem(this.KEY_CURRENT_ROLE, 'donor');
    localStorage.setItem(this.KEY_CURRENT_USER_ID, 'user_donor_1');
  },

  getData() {
    this.init();
    try {
      return JSON.parse(localStorage.getItem(this.KEY_DATA));
    } catch (e) {
      console.error('Data corrupted, reinitializing EcoStore', e);
      this.resetData();
      return JSON.parse(localStorage.getItem(this.KEY_DATA));
    }
  },

  saveData(data) {
    localStorage.setItem(this.KEY_DATA, JSON.stringify(data));
  },

  getCurrentRole() {
    return localStorage.getItem(this.KEY_CURRENT_ROLE) || 'donor';
  },

  getCurrentUser() {
    const data = this.getData();
    const currentId = localStorage.getItem(this.KEY_CURRENT_USER_ID);
    return data.users.find(u => u.id === currentId) || data.users[0];
  },

  setSession(role, userId) {
    localStorage.setItem(this.KEY_CURRENT_ROLE, role);
    if (userId) {
      localStorage.setItem(this.KEY_CURRENT_USER_ID, userId);
    } else {
      const data = this.getData();
      const defaultForRole = data.users.find(u => u.role === role);
      if (defaultForRole) {
        localStorage.setItem(this.KEY_CURRENT_USER_ID, defaultForRole.id);
      }
    }
  },

  // Donations APIs
  getDonations() {
    return this.getData().donations;
  },

  getDonationById(id) {
    return this.getData().donations.find(d => d.id === id);
  },

  addDonation(donation) {
    const data = this.getData();
    donation.id = 'don_' + Date.now();
    donation.publishedAt = new Date().toISOString();
    donation.status = 'available';
    data.donations.unshift(donation);

    // Add mock notification for charities
    data.notifications.unshift({
      id: 'notif_' + Date.now(),
      forUserRole: 'charity',
      forUserId: 'all',
      title: 'New Donation Nearby',
      message: `${donation.donorName} listed "${donation.title}" (${donation.quantity} ${donation.unit}).`,
      time: 'Just now',
      type: 'request',
      read: false,
      link: `donation-details.html?id=${donation.id}`
    });

    this.saveData(data);
    return donation;
  },

  updateDonation(id, updatedFields) {
    const data = this.getData();
    const idx = data.donations.findIndex(d => d.id === id);
    if (idx !== -1) {
      data.donations[idx] = { ...data.donations[idx], ...updatedFields };
      this.saveData(data);
      return data.donations[idx];
    }
    return null;
  },

  cancelDonation(id) {
    return this.updateDonation(id, { status: 'cancelled' });
  },

  // Requests APIs
  getRequests() {
    return this.getData().requests;
  },

  getRequestById(id) {
    return this.getData().requests.find(r => r.id === id);
  },

  createRequest(requestData) {
    const data = this.getData();
    const newReq = {
      id: 'req_' + Date.now(),
      donationId: requestData.donationId,
      donationTitle: requestData.donationTitle,
      donorId: requestData.donorId,
      donorName: requestData.donorName,
      charityId: requestData.charityId,
      charityName: requestData.charityName,
      requestedQuantity: requestData.requestedQuantity,
      unit: requestData.unit,
      requestDate: new Date().toISOString(),
      status: 'pending',
      scheduledPickupDate: null,
      notes: requestData.notes || '',
      timeline: [
        { step: 'Published', time: new Date().toLocaleString(), desc: 'Listing published' },
        { step: 'Request Submitted', time: new Date().toLocaleString(), desc: `${requestData.charityName} requested ${requestData.requestedQuantity} ${requestData.unit}` }
      ]
    };
    data.requests.unshift(newReq);

    // Notify donor
    data.notifications.unshift({
      id: 'notif_' + Date.now(),
      forUserRole: 'donor',
      forUserId: requestData.donorId,
      title: 'New Donation Request',
      message: `${requestData.charityName} requested ${requestData.requestedQuantity} ${requestData.unit} of "${requestData.donationTitle}".`,
      time: 'Just now',
      type: 'request',
      read: false,
      link: 'donor-dashboard.html'
    });

    this.saveData(data);
    return newReq;
  },

  updateRequestStatus(id, newStatus, extraNotes) {
    const data = this.getData();
    const req = data.requests.find(r => r.id === id);
    if (!req) return null;

    req.status = newStatus;
    const nowTime = new Date().toLocaleString();

    if (newStatus === 'approved') {
      req.timeline.push({ step: 'Request Approved', time: nowTime, desc: 'Donor approved the request allocation' });
      // Update donation status to reserved if full qty taken
      const don = data.donations.find(d => d.id === req.donationId);
      if (don) don.status = 'reserved';
    } else if (newStatus === 'scheduled') {
      req.scheduledPickupDate = extraNotes || new Date(Date.now() + 86400000).toISOString();
      req.timeline.push({ step: 'Pickup Scheduled', time: nowTime, desc: `Pickup set for: ${req.scheduledPickupDate}` });
    } else if (newStatus === 'collected') {
      req.timeline.push({ step: 'Collection Confirmed', time: nowTime, desc: 'Donation picked up and verified by recipient' });
      const don = data.donations.find(d => d.id === req.donationId);
      if (don) don.status = 'completed';
    } else if (newStatus === 'rejected') {
      req.timeline.push({ step: 'Request Rejected', time: nowTime, desc: extraNotes || 'Request could not be accommodated' });
    }

    this.saveData(data);
    return req;
  },

  // Notifications APIs
  getNotifications(role) {
    const data = this.getData();
    if (!role || role === 'all') return data.notifications;
    return data.notifications.filter(n => n.forUserRole === role || n.forUserId === 'all');
  },

  markNotificationRead(id) {
    const data = this.getData();
    const notif = data.notifications.find(n => n.id === id);
    if (notif) {
      notif.read = true;
      this.saveData(data);
    }
  },

  markAllNotificationsRead() {
    const data = this.getData();
    data.notifications.forEach(n => n.read = true);
    this.saveData(data);
  },

  // Users & Orgs APIs
  getUsers() {
    return this.getData().users;
  },

  toggleUserStatus(id) {
    const data = this.getData();
    const u = data.users.find(user => user.id === id);
    if (u) {
      u.status = u.status === 'active' ? 'suspended' : 'active';
      this.saveData(data);
      return u;
    }
    return null;
  },

  updateOrgStatus(id, newStatus, reason) {
    const data = this.getData();
    const u = data.users.find(user => user.id === id);
    if (u) {
      u.status = newStatus;
      u.verified = (newStatus === 'verified' || newStatus === 'active');
      if (reason) u.rejectionReason = reason;
      this.saveData(data);
      return u;
    }
    return null;
  },

  // Reports
  getReports() {
    return this.getData().reports;
  },

  resolveReport(id, resolution) {
    const data = this.getData();
    const r = data.reports.find(report => report.id === id);
    if (r) {
      r.status = resolution; // resolved or dismissed
      this.saveData(data);
      return r;
    }
    return null;
  }
};

// ==========================================================================
// Toast Notification Engine
// ==========================================================================
const EcoToast = {
  container: null,

  init() {
    if (!this.container) {
      this.container = document.createElement('div');
      this.container.className = 'toast-container';
      document.body.appendChild(this.container);
    }
  },

  show(message, type = 'success', duration = 3500) {
    this.init();
    const toast = document.createElement('div');
    toast.className = `eco-toast ${type}`;

    let icon = 'bi-check-circle-fill text-success';
    if (type === 'error') icon = 'bi-exclamation-octagon-fill text-danger';
    if (type === 'warning') icon = 'bi-exclamation-triangle-fill text-warning';
    if (type === 'info') icon = 'bi-info-circle-fill text-primary';

    toast.innerHTML = `
      <i class="bi ${icon} fs-5 mt-1"></i>
      <div class="flex-grow-1">
        <div class="fw-bold text-dark" style="font-size: 0.92rem;">${type.toUpperCase()}</div>
        <div class="text-secondary" style="font-size: 0.85rem;">${message}</div>
      </div>
      <button type="button" class="btn-close btn-sm ms-2" aria-label="Close"></button>
    `;

    toast.querySelector('.btn-close').onclick = () => toast.remove();
    this.container.appendChild(toast);

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateX(100%)';
      toast.style.transition = 'all 0.3s ease';
      setTimeout(() => toast.remove(), 300);
    }, duration);
  }
};

// ==========================================================================
// Theme Management Engine (Dark / Light Mode)
// ==========================================================================
const EcoTheme = {
  KEY_THEME: 'ecodonate_theme',

  get() {
    const saved = localStorage.getItem(this.KEY_THEME);
    if (saved) return saved;
    // Default to system preference or light
    if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      return 'dark';
    }
    return 'light';
  },

  set(theme) {
    localStorage.setItem(this.KEY_THEME, theme);
    document.documentElement.setAttribute('data-theme', theme);
    document.documentElement.setAttribute('data-bs-theme', theme);
    if (document.body) {
      document.body.setAttribute('data-theme', theme);
      document.body.setAttribute('data-bs-theme', theme);
    }
    this.updateToggleButtons(theme);
    window.dispatchEvent(new CustomEvent('themeChanged', { detail: { theme } }));
  },

  toggle() {
    const current = this.get();
    const next = current === 'dark' ? 'light' : 'dark';
    this.set(next);
    const isAr = (localStorage.getItem('ecodonate_lang') || 'en') === 'ar';
    if (isAr) {
      EcoToast.show(next === 'dark' ? 'تم تفعيل الوضع الليلي 🌙' : 'تم تفعيل الوضع النهاري ☀️', 'info');
    } else {
      EcoToast.show(next === 'dark' ? 'Dark Mode Enabled 🌙' : 'Light Mode Enabled ☀️', 'info');
    }
  },

  updateToggleButtons(theme) {
    const isAr = (localStorage.getItem('ecodonate_lang') || 'en') === 'ar';
    document.querySelectorAll('.theme-toggle-btn').forEach(btn => {
      if (theme === 'dark') {
        const txt = isAr ? 'نهاري' : 'Light';
        btn.innerHTML = `<i class="bi bi-sun-fill text-warning"></i> <span class="d-none d-sm-inline">${txt}</span>`;
        btn.setAttribute('title', isAr ? 'التحويل للوضع النهاري' : 'Switch to Light Mode');
      } else {
        const txt = isAr ? 'ليلي' : 'Dark';
        btn.innerHTML = `<i class="bi bi-moon-stars-fill"></i> <span class="d-none d-sm-inline">${txt}</span>`;
        btn.setAttribute('title', isAr ? 'التحويل للوضع الليلي' : 'Switch to Dark Mode');
      }
    });
  },

  init() {
    this.set(this.get());
  }
};

// ==========================================================================
// Internationalization Engine (English / Arabic RTL — 100% Complete)
// ==========================================================================
const I18N_DICTIONARY = {
  ar: {
  "Food Bridge": "جسر الغذاء",
  "EcoDonate": "جسر الغذاء",
  "Food Bridge Platform": "منصة جسر الغذاء",
  "Food-Bridge Platform": "منصة جسر الغذاء",
  "Food-Bridge": "جسر الغذاء",
  "Share More. Waste Less. Change Lives.": "شارك أكثر. هدر أقل. غيّر حياة الناس.",
  "Share More. Waste Less.": "شارك أكثر. هدر أقل.",
  "Change Lives.": "غيّر حياة الناس.",
  "Surplus Food Redistribution Engine": "منظومة إعادة توجيه الفائض الغذائي",
  "Food Bridge connects restaurants, supermarkets, and local suppliers with verified charities to redistribute fresh, edible surplus before it expires.": "تربط منصة جسر الغذاء المطاعم والمتاجر والموردين بالجمعيات الخيرية المعتمدة لإعادة توزيع الفائض الغذائي الطازج والصالح للأكل قبل انتهاء صلاحيته.",
  "EcoDonate connects restaurants, supermarkets, and local suppliers with verified charities to redistribute fresh, edible surplus before it expires.": "تربط منصة جسر الغذاء المطاعم والمتاجر والموردين بالجمعيات الخيرية المعتمدة لإعادة توزيع الفائض الغذائي الطازج والصالح للأكل قبل انتهاء صلاحيته.",
  "120+ verified partners active across Metro areas": "أكثر من 120 شريك موثق في جميع المناطق",
  "120+ verified partners": "أكثر من 120 شريك موثق",
  "active across Metro areas": "في جميع مناطق المدينة",
  "Avg Pickup Time": "متوسط وقت الاستلام",
  "Under 2.5 Hours": "أقل من ساعتين ونصف",
  "Food Bridge — Share More. Waste Less. Change Lives.": "جسر الغذاء — شارك أكثر. هدر أقل. غيّر حياة الناس.",
  "About Us — Food Bridge": "من نحن — جسر الغذاء",
  "Log In — Food Bridge": "تسجيل الدخول — جسر الغذاء",
  "Register — Food Bridge": "إنشاء حساب — جسر الغذاء",
  "Donor Hub — Food Bridge": "مركز المتبرع — جسر الغذاء",
  "Charity Hub — Food Bridge": "مركز الجمعيات — جسر الغذاء",
  "Explore Food Donations — Food Bridge": "استكشاف التبرعات — جسر الغذاء",
  "Publish Donation — Food Bridge": "نشر تبرع — جسر الغذاء",
  "Manage My Listings — Food Bridge": "إدارة التبرعات — جسر الغذاء",
  "Donation Details — Food Bridge": "تفاصيل التبرع — جسر الغذاء",
  "My Requests — Food Bridge": "طلباتي — جسر الغذاء",
  "Donation Milestone Tracking — Food Bridge": "تتبع التبرع — جسر الغذاء",
  "Notifications — Food Bridge": "الإشعارات — جسر الغذاء",
  "Profile & Settings — Food Bridge": "الملف الشخصي والإعدادات — جسر الغذاء",
  "Admin Operations Center — Food Bridge": "مركز عمليات الإدارة — جسر الغذاء",
  "Manage Users — Food Bridge Admin": "إدارة المستخدمين — لوحة الإدارة",
  "Manage Organizations — Food Bridge Admin": "إدارة المنظمات — لوحة الإدارة",
  "Manage Reports & Disputes — Food Bridge Admin": "إدارة البلاغات والشكاوى — لوحة الإدارة",
  "Home": "الرئيسية",
  "How It Works": "كيف تعمل المنصة",
  "Find Food": "البحث عن طعام",
  "Find Donations": "استكشاف التبرعات",
  "Our Impact": "أثرنا المجتمعي",
  "About Us": "من نحن",
  "Log In": "تسجيل الدخول",
  "Get Started": "ابدأ الآن",
  "Sign In to Dashboard": "الدخول إلى لوحة التحكم",
  "Create an Account": "إنشاء حساب جديد",
  "Sign Out": "تسجيل الخروج",
  "Donate Now": "تبرع الآن",
  "Explore Map": "استكشاف الخريطة",
  "Explore Available Surplus Food": "استكشاف الفائض الغذائي المتاح",
  "Switch Language": "تغيير اللغة",
  "Switch Language (English / العربية)": "تغيير اللغة (الإنجليزية / العربية)",
  "Toggle Dark/Light Mode": "تبديل الوضع الليلي / النهاري",
  "Toggle Theme": "تبديل المظهر",
  "Simulated Community Impact": "الأثر المجتمعي للمنصة",
  "Quantifiable Change, One Meal at a Time": "تغيير ملموس، وجبة تلو الأخرى",
  "Real-time metrics demonstrating the power of connecting excess supply with local demand.": "مؤشرات مباشرة توضح أثر ربط الفائض الغذائي بالاحتياج الفعلي في المجتمع.",
  "Surplus Food Rescued": "فائض غذائي تم إنقاذه",
  "+24% this month": "+24% هذا الشهر",
  "Meals Redistributed": "وجبات أعيد توزيعها",
  "98% satisfaction": "98% نسبة الرضا",
  "CO2 Equivalent Diverted": "انبعاثات كربون تم تفاديها",
  "Landfill prevention": "حماية من مكبات النفايات",
  "Verified Organizations": "المنظمات المعتمدة",
  "100% vetted": "100% جهات معتمدة",
  "100% verified": "100% موثقة",
  "1,420 kg": "1,420 كجم",
  "45 kg": "45 كجم",
  "60 units": "60 وحدة",
  "Max: 45 kg": "الحد الأقصى: 45 كجم",
  "0 unread": "0 غير مقروء",
  "0 found": "0 نتائج",
  "+18% MoM": "+18% شهرياً",
  "Rescued Food Volume (kg)": "حجم الغذاء المنقذ (كجم)",
  "Rescued (kg)": "منقذ (كجم)",
  "Rescued Food (kg)": "الغذاء المنقذ (كجم)",
  "CO2 Offset (kg)": "انبعاثات كربون تم تفاديها (كجم)",
  "Meals Served Equivalent": "ما يعادل وجبات موزعة",
  "Last 6 Months": "آخر 6 أشهر",
  "Platform Donation Volume (Past 6 Months)": "حجم تبرعات المنصة (خلال آخر 6 أشهر)",
  "Category Distribution": "توزيع الفئات الغذائية",
  "Simple & Efficient Workflow": "خطوات عمل بسيطة وفعالة",
  "How Food Bridge Works": "كيف تعمل منصة جسر الغذاء",
  "How EcoDonate Works": "كيف تعمل منصة جسر الغذاء",
  "Three straightforward steps that turn prospective waste into community nourishment.": "ثلاث خطوات يسيرة تحول الفائض المحتمل إلى غذاء نافع للمجتمع.",
  "1. Share a Donation": "1. انشر تبرعاً",
  "Food businesses or individuals post surplus food with photos, quantity, pickup windows, and safe handling notes in under 2 minutes.": "تقوم المنشآت أو الأفراد بنشر الفائض الغذائي مع الصور والكميات ومواعيد الاستلام وإرشادات الحفظ في أقل من دقيقتين.",
  "2. Connect with a Charity": "2. تواصل مع الجمعيات",
  "Verified shelters and food banks get instant notifications, discover nearby items via the interactive map, and request required allocations.": "تتلقى دور الإيواء وبنوك الطعام المعتمدة إشعارات فورية، وتستكشف التبرعات القريبة عبر الخريطة التفاعلية، وتطلب الحصص المطلوبة.",
  "3. Make an Impact": "3. اصنع فارقاً حقيقياً",
  "Coordinate easy contactless or scheduled pickup, verify collection with digital codes, and view transparent environmental metrics.": "تنسيق استلام مجدول أو فوري بسهولة، وتوثيق التسليم برموز رقمية موحدة مع تقارير أثر بيئي شفافة.",
  "Live Availability": "المتاح الآن",
  "Featured Available Donations": "أحدث التبرعات المتاحة",
  "High-quality food items ready for immediate pickup by registered charities.": "أغذية عالية الجودة جاهزة للاستلام الفوري من قبل الجمعيات الخيرية المسجلة.",
  "Explore All on Map": "استكشاف الكل على الخريطة",
  "Designed for Every Partner": "مصممة لتلائم جميع الشركاء",
  "Whether you have food to give or people to feed, Food Bridge streamlines every step.": "سواء كان لديك طعام تود التبرع به أو مستفيدون ترعاهم، تسهل منصة جسر الغذاء كل مرحلة.",
  "Whether you have food to give or people to feed, EcoDonate streamlines every step.": "سواء كان لديك طعام تود التبرع به أو مستفيدون ترعاهم، تسهل منصة جسر الغذاء كل مرحلة.",
  "For Donors & Businesses": "للمتبرعين والشركات",
  "Reduce costly waste disposal, qualify for tax deductions, and elevate your corporate sustainability profile.": "قلل تكاليف التخلص من النفايات، واستفد من الإعفاءات الضريبية، وعزز ملف الاستدامة المؤسسية.",
  "Instant Listing:": "نشر فوري:",
  "Publish surplus items in seconds with automated expiry clocks.": "انشر المواد الفائضة في ثوانٍ مع مؤقتات انتهاء الصلاحية التلقائية.",
  "Strict Verification:": "توثيق صارم:",
  "Only approved 501(c)(3) charities can request your listings.": "الجمعيات الخيرية المعتمدة رسمياً فقط هي من تستطيع طلب التبرعات.",
  "Tax & ESG Reports:": "تقارير بيئية وضريبية:",
  "Download certified weight logs for environmental reporting.": "حمّل سجلات أوزان معتمدة لتقارير الاستدامة البيئية والمسؤولية المجتمعية.",
  "Start Donating Today": "ابدأ التبرع اليوم",
  "For Charitable Organizations": "للجمعيات الخيرية والمنظمات",
  "Supply your pantries and kitchens with fresh produce, proteins, and pantry staples without cost.": "أمّن مطابخك ومستودعاتك بالمنتجات الطازجة والبروتينات والمؤن الأساسية بدون أي تكلفة.",
  "Interactive Map Discovery:": "استكشاف تفاعلي عبر الخريطة:",
  "Filter by distance radius, food group, and urgency.": "تصفية التبرعات حسب النطاق الجغرافي ونوع الغذاء ومستوى العجلة.",
  "Predictable Pickups:": "مواعيد استلام دقيقة:",
  "Coordinate logistics and receiving schedules seamlessly.": "نسّق مواعيد الاستلام والخدمات اللوجستية بكل سلاسة.",
  "End-to-End Tracking:": "تتبع شامل للمراحل:",
  "5-stage milestone tracking from request to handoff.": "متابعة من 5 مراحل من لحظة تقديم الطلب حتى التسليم النهائي.",
  "Register Your Organization": "سجّل منظمتك الآن",
  "Community Voices": "آراء وتجارب المجتمع",
  "What Our Partners Say": "ماذا يقول شركاؤنا",
  "Stories from the front lines of local food rescue and distribution.": "قصص واقعية من الميدان لإنقاذ الغذاء وتوزيعه.",
  "Chef Marco Rossi": "الشيف ماركو روسي",
  "Artisan Metro Bakery": "مخبز مترو الحرفي",
  "Elena Rostova": "إيلينا روستوفا",
  "Hope Community Food Pantry": "بنك طعام الأمل المجتمعي",
  "Marcus Vance": "ماركوس فانس",
  "Care Haven Shelter": "مؤسسة مأوى الرعاية",
  "Care Haven Shelter Foundation": "مؤسسة مأوى الرعاية",
  "Hope Food Pantry": "بنك طعام الأمل",
  "Hope Community Pantry": "بنك طعام الأمل المجتمعي",
  "GreenBites Bistro": "مطعم جرين بايتس",
  "GreenBites Organic Bistro": "مطعم جرين بايتس العضوي",
  "FreshMart Supermarket": "سوبرماركت فريش مارت",
  "New Dawn Youth Haven": "مأوى الفجر للشباب",
  "\"Instead of dumping 40 kg of pristine artisan bread each evening, EcoDonate enables Hope Food Pantry to collect it right at our closing bell. It's effortless and meaningful.\"": "\"بدلاً من إهدار 40 كجم من الخبز الطازج كل مساء، مكنتنا المنصة من تسليمه لبنك طعام الأمل عند موعد الإغلاق مباشرة دون أي جهد.\"",
  "\"The interactive discovery map has transformed our morning supply run. We immediately see which supermarkets have produce ready, eliminating hours of phone calls.\"": "\"خريطة الاستكشاف التفاعلية أحدثت نقلة نوعية في جولتنا الصباحية، نرى فوراً المتاجر التي لديها خضار جاهزة بدون اتصالات مطولة.\"",
  "\"Being able to review digital verification documents and manage incoming requests in a unified dashboard has made safety compliance bulletproof.\"": "\"القدرة على فحص وثائق التوثيق وإدارة الطلبات في لوحة تحكم واحدة جعلت الالتزام بمعايير السلامة مضموناً تماماً.\"",
  "Common Inquiries": "الأسئلة الشائعة",
  "Frequently Asked Questions": "الأسئلة الأكثر تداولاً",
  "Everything you need to know about food safety, pickup coordination, and eligibility.": "كل ما تحتاج معرفته عن معايير سلامة الأغذية وتنسيق الاستلام وشروط الأهلية.",
  "How is food safety maintained on Food Bridge?": "كيف يتم ضمان سلامة وجودة الغذاء عبر منصة جسر الغذاء؟",
  "How is food safety maintained on EcoDonate?": "كيف يتم ضمان سلامة وجودة الغذاء عبر منصة جسر الغذاء؟",
  "Donors must adhere to standard HACCP food safety standards and specify required storage conditions (e.g., cold-chain between 2°C–4°C). Furthermore, food items must be within recognized safe consumption windows upon handoff.": "يلتزم المتبرعون بمعايير سلامة الأغذية المعتمدة (HACCP) وتحديد شروط التخزين كالتبريد بين 2 إلى 4 درجات مئوية، مع ضمان تسليم الأطعمة ضمن مدة الصلاحية الآمنة.",
  "Who is eligible to request food donations?": "من الجهات المؤهلة لطلب تبرعات الطعام؟",
  "Only verified non-profit organizations, registered shelters, and accredited soup kitchens that complete our identity and tax-exempt verification check can claim food allocations.": "يحق فقط للجمعيات الأهلية المسجلة ودور الإيواء والمطابخ الخيرية المعتمدة التي تجتاز فحص التوثيق الرسمي استلام الحصص الغذائية.",
  "Are there any fees to list or request food?": "هل توجد أي رسوم لنشر أو استلام التبرعات؟",
  "No. Food Bridge is completely free for donors and charitable recipients. Our mission is pure resource efficiency and humanitarian support.": "لا، منصة جسر الغذاء مجانية تماماً للمتبرعين والجهات الخيرية، هدفنا هو الاستدامة البيئية وتقديم الدعم الإنساني.",
  "No. EcoDonate is completely free for donors and charitable recipients. Our mission is pure resource efficiency and humanitarian support.": "لا، منصة جسر الغذاء مجانية تماماً للمتبرعين والجهات الخيرية، هدفنا هو الاستدامة البيئية وتقديم الدعم الإنساني.",
  "How does pickup verification work?": "كيف تعمل آلية توثيق استلام التبرع؟",
  "When a request is approved, both parties receive a synchronized collection pass with unique confirmation verification codes to ensure accountable handoffs.": "بمجرد اعتماد الطلب، يحصل الطرفان على تصريح استلام رقمي موحد يحتوي على كود تحقق فريد لضمان تسليم رسمي وموثق.",
  "Ready to Make an Environmental & Social Impact?": "هل أنت مستعد لإحداث أثر بيئي ومجتمعي حقيقي؟",
  "Join hundreds of businesses and community organizations who are ensuring no good meal goes to waste.": "انضم إلى مئات الشركات والجمعيات التي تعمل معاً لضمان عدم إهدار أي وجبة صالحة للأكل.",
  "Get Started Now": "ابدأ رحلتك الآن",
  "Browse Live Listings": "تصفح القوائم المتاحة",
  "Food Bridge is an intelligent surplus redistribution platform bridging excess food suppliers with verified charities.": "جسر الغذاء هي منصة ذكية لإعادة توجيه الفائض الغذائي تربط المنشآت الغذائية بالجمعيات الخيرية المعتمدة.",
  "EcoDonate is an intelligent surplus redistribution platform bridging excess food suppliers with verified charities.": "جسر الغذاء هي منصة ذكية لإعادة توجيه الفائض الغذائي تربط المنشآت الغذائية بالجمعيات الخيرية المعتمدة.",
  "Platform": "المنصة",
  "Resources": "المصادر",
  "Contact Us": "تواصل معنا",
  "Privacy Policy": "سياسة الخصوصية",
  "Terms of Service": "شروط الاستخدام",
  "Food Safety Standards": "معايير سلامة الغذاء",
  "Food Safety Charter": "ميثاق سلامة الغذاء",
  "Security & Compliance": "الأمان والامتثال",
  "Verified Organizations List": "قائمة الجمعيات المعتمدة",
  "ESG Impact Reporting": "تقارير الاستدامة البيئية والمجتمعية",
  "Platform Operations": "مركز عمليات المنصة",
  "System Status": "حالة المنظومة",
  "API Documentation": "توثيق واجهة البرمجة",
  "© 2026 Food Bridge Platform. All rights reserved.": "© 2026 منصة جسر الغذاء. جميع الحقوق محفوظة.",
  "© 2026 EcoDonate / Food-Bridge Platform. All rights reserved.": "© 2026 منصة جسر الغذاء. جميع الحقوق محفوظة.",
  "© 2026 Food Bridge. All rights reserved.": "© 2026 جسر الغذاء. جميع الحقوق محفوظة.",
  "© 2026 Food Bridge. Interactive Frontend Prototype.": "© 2026 جسر الغذاء. نموذج واجهة تفاعلي.",
  "© 2026 Food Bridge. Prototype Demonstration.": "© 2026 جسر الغذاء. نسخة عرض تجريبية.",
  "Sign In to Your Account": "تسجيل الدخول إلى حسابك",
  "Enter your credentials to access the Food Bridge portal.": "أدخل بياناتك للوصول إلى بوابة جسر الغذاء.",
  "Enter your credentials to access the EcoDonate portal.": "أدخل بياناتك للوصول إلى بوابة جسر الغذاء.",
  "Select Demo Role to Fast-Fill": "اختر دوراً تجريبياً للملء السريع",
  "Select Demo Account...": "اختر حساباً تجريبياً...",
  "Food Donor (GreenBites Bistro)": "متبرع بالغذاء (مطعم جرين بايتس)",
  "Charity (Hope Food Pantry)": "جمعية خيرية (بنك طعام الأمل)",
  "Platform Admin (Operations Team)": "إدارة المنصة (فريق العمليات)",
  "Remember my session on this device": "تذكر جلستي على هذا الجهاز",
  "Forgot?": "نسيت كلمة المرور؟",
  "Don't have an account?": "ليس لديك حساب؟",
  "Already have an account?": "هل لديك حساب بالفعل؟",
  "Already registered?": "هل أنت مسجل بالفعل؟",
  "Already registered? Log In": "هل أنت مسجل بالفعل؟ سجل الدخول",
  "Log In Here": "سجل الدخول هنا",
  "New to Food Bridge?": "جديد في جسر الغذاء؟",
  "New to EcoDonate?": "جديد في جسر الغذاء؟",
  "or log in with email": "أو سجل الدخول ببريدك الإلكتروني",
  "Instant Demo 1-Click Login:": "الدخول السريع التجريبي بضغطة واحدة:",
  "Join the Food Bridge Network": "انضم إلى شبكة جسر الغذاء",
  "Join the EcoDonate Network": "انضم إلى شبكة جسر الغذاء",
  "Choose your role to start donating surplus food or receiving nutrition for your community.": "اختر نوع حسابك لبدء التبرع بالفائض أو استقبال المواد الغذائية لمجتمعك.",
  "I want to donate food": "أرغب في التبرع بالطعام",
  "I am a charitable organization": "أنا جمعية خيرية / جهة مستفيدة",
  "Complete Registration": "إتمام التسجيل",
  "Create an Account & Join Network": "إنشاء الحساب والانضمام للمنصة",
  "Create Account & Join Network": "إنشاء الحساب والانضمام للمنصة",
  "Select Your Account Type": "حدد نوع الحساب",
  "Food Donor": "متبرع بالغذاء",
  "Charitable Organization": "جمعية خيرية / جهة مستفيدة",
  "Work / Contact Email": "البريد الإلكتروني للعمل",
  "Phone Number": "رقم الهاتف",
  "Business / Donor Name": "اسم المنشأة أو المتبرع",
  "Primary Pickup Location / Address": "عنوان وموقع الاستلام الرئيسي",
  "Organization Name": "اسم المنظمة الخيرية",
  "Primary Contact Person": "الشخص المسؤول للتواصل",
  "Tax ID / Non-Profit Registration": "الرقم الضريبي أو رقم تسجيل الجمعية",
  "Tax ID / NGO Registration": "الرقم الضريبي / رقم تسجيل الجمعية",
  "Tax ID / Registration": "الرقم الضريبي / التسجيل",
  "Headquarters / Depot Address": "عنوان المقر أو المستودع الرئيسي",
  "Service Area Coverage": "نطاق التغطية الجغرافية للخدمة",
  "Upload Non-Profit Verification Document (PDF / Image)": "رفع وثيقة توثيق الجمعية (ملف PDF أو صورة)",
  "Click or drag registration documents here": "اضغط أو اسحب وثائق التسجيل هنا",
  "Accepted formats: PDF, JPG, PNG (Max 10MB)": "الصيغ المقبولة: PDF, JPG, PNG (بحد أقصى 10 ميجابايت)",
  "I agree to the": "أوافق على",
  "Full name of director or coordinator": "الاسم الكامل للمدير أو المنسق المسؤول",
  "Min. 8 characters": "8 أحرف على الأقل",
  "Min. 6 characters": "6 أحرف على الأقل",
  "Re-type password": "أعد كتابة كلمة المرور",
  "Donor Hub": "مركز المتبرع",
  "Charity Hub": "مركز الجمعيات",
  "Overview & Activity": "نظرة عامة والنشاط",
  "Dashboard": "لوحة التحكم",
  "Create Donation": "إنشاء تبرع",
  "Manage Donations": "إدارة التبرعات",
  "Manage My Listings": "إدارة تبرعاتي",
  "Explore Donations": "استكشاف التبرعات",
  "My Requests": "طلباتي",
  "Donation Tracking": "تتبع التبرع",
  "Notifications": "الإشعارات",
  "Settings & Profile": "الإعدادات والملف الشخصي",
  "User Directory": "دليل المستخدمين",
  "Reports & Compliance": "البلاغات والامتثال",
  "Quick Navigation": "التنقل السريع",
  "Simulated Role": "الدور التجريبي",
  "Accredited 501(c)(3) Charitable Partner": "منظمة خيرية معتمدة رسمياً",
  "Your organization is fully verified. You have instant collection access to all donor categories.": "منظمتك موثقة بالكامل. لديك صلاحية استلام فورية لجميع فئات التبرعات.",
  "Active Privileges": "صلاحيات نشطة",
  "Within 5km radius": "ضمن نطاق 5 كم",
  "Nearby Available": "متاح في الجوار",
  "Discover nearby surplus food allocations, manage logistics, and verify collections.": "استكشف حصص الفائض الغذائي القريبة، نسّق النقل، ووثق عمليات الاستلام.",
  "Recommended for Hope Community Kitchen": "موصى به لمطبخ الأمل المجتمعي",
  "Needs action": "يتطلب إجراء",
  "Live on map": "متاح على الخريطة",
  "Awaiting donor": "بانتظار المتبرع",
  "Collection Completed": "اكتمل الاستلام",
  "Collection Confirmed": "تم تأكيد الاستلام",
  "Pickup Confirmed": "تم تأكيد موعد الاستلام",
  "Confirmed Quantity:": "الكمية المؤكدة:",
  "VERIFICATION PIN: 7842": "رمز التحقق: 7842",
  "Verification Pass #ECO-8924": "تصريح الاستلام #ECO-8924",
  "Present this code or QR pass to the donor at loading dock.": "أبرز هذا الرمز أو تصريح QR للمتبرع عند رصيف التحميل.",
  "These items need immediate rescue before they must be discarded.": "هذه الأصناف تحتاج لإنقاذ فوري قبل أن تضطر المنشأة لإتلافها.",
  "Urgent: Expiring Within 24 Hours": "عاجل: تنتهي الصلاحية خلال 24 ساعة",
  "Urgent Only (<24h)": "العاجل فقط (أقل من 24 ساعة)",
  "Urgent Only (&lt;24h)": "العاجل فقط (أقل من 24 ساعة)",
  "Urgent Only": "العاجل فقط",
  "View All Urgent": "عرض كل العاجل",
  "Ready tomorrow": "جاهز غداً",
  "Upcoming Pickup Reminders": "تذكير بمواعيد الاستلام القادمة",
  "Notification & Dispatch Alerts": "إشعارات وتنبيهات الإرسال",
  "Real-time alerts regarding donation requests, scheduled pickups, and urgent expirations.": "تنبيهات فورية لطلبات التبرع ومواعيد الاستلام والتبرعات وشيكة الانتهاء.",
  "Get an alert 1 hour prior to scheduled vehicle arrival.": "تلقي تنبيه قبل ساعة من وصول مركبة الاستلام المجدولة.",
  "Receive immediate notifications when a charity claims your food listing.": "تلقي إشعارات فورية بمجرد طلب جمعية خيرية لقائمتك الغذائية.",
  "Receive weekly reports on food rescued in our metropolitan community.": "تلقي تقارير أسبوعية عن الغذاء المنقذ في نطاق المدينة.",
  "Weekly email report detailing rescued kilograms and avoided emissions.": "تقرير بريدي أسبوعي يفصل الكيلوجرامات المنقذة والانبعاثات المتفادية.",
  "Get weekly impact stories and notifications on local food rescue drives.": "احصل على قصص الأثر الأسبوعية وإشعارات حملات إنقاذ الغذاء المحلية.",
  "Submitting this request sends an instant alert to the donor to confirm allocation.": "إرسال هذا الطلب يُرسل تنبيهاً فورياً للمتبرع لتأكيد الحصة المطلوبة.",
  "You may request a partial amount if you do not have full cold-storage capacity.": "يمكنك طلب جزء من الكمية إذا لم تكن سعة التبريد لديك كافية لاستيعاب الكل.",
  "Clears client-side test changes and restores fresh realistic sample listings.": "يمسح التغييرات التجريبية ويعيد البيانات الافتراضية الطازجة للمنصة.",
  "Reset Prototype Sample Data": "إعادة ضبط البيانات التجريبية",
  "Reset Sample Data": "إعادة ضبط البيانات",
  "DONOR PARTNER": "شريك متبرع",
  "Donor Partner": "شريك متبرع",
  "Charity Partner": "شريك خيري",
  "Verified Recipient": "جهة مستفيدة موثقة",
  "Admin Director": "مدير النظام",
  "Platform Ops": "إدارة العمليات",
  "Account Holder": "صاحب الحساب",
  "Active Session": "جلسة نشطة",
  "Active User": "مستخدم نشط",
  "Display, Language & Theme Preferences": "تفضيلات العرض واللغة والمظهر",
  "Color Theme (المظهر)": "المظهر اللوني (Theme)",
  "Interface Language (اللغة)": "لغة الواجهة (Language)",
  "☀️ Light Theme (نهاري)": "☀️ الوضع النهاري (Light)",
  "🌙 Dark Theme (ليلي)": "🌙 الوضع الليلي (Dark)",
  "🇪🇬 العربية (Arabic - RTL)": "🇪🇬 العربية (Arabic - RTL)",
  "🇺🇸 English": "🇺🇸 English (الإنجليزية)",
  "Account Profile Overview": "نظرة عامة على الملف الشخصي",
  "Manage contact details, organization information, security, and notification alerts.": "إدارة بيانات التواصل، ومعلومات المنظمة، وإعدادات الأمان، والتنبيهات.",
  "Organization & Profile Information": "معلومات المنظمة والملف التعريفي",
  "Password & Security": "كلمة المرور والأمان",
  "Current Password": "كلمة المرور الحالية",
  "New Password": "كلمة المرور الجديدة",
  "Confirm New Password": "تأكيد كلمة المرور الجديدة",
  "Update Password": "تحديث كلمة المرور",
  "Change photo": "تغيير الصورة",
  "Full Name / Organization Name": "الاسم الكامل / اسم المنشأة",
  "Fresh Farm Organic Produce Crates": "صناديق خضار وفواكه طازجة من المزرعة",
  "Surplus organic kale, crisp romaine lettuce, heirloom tomatoes, and crisp cucumbers from morning farm deliveries. Inspected, thoroughly washed, and packed in ventilated crates.": "فائض من الكيل العضوي، وخس روماني طازج، وطماطم بلدية، وخيار مقرمش من توريدات الصباح. مفحوصة ومغسولة بعناية ومعبأة في صناديق مهواة.",
  "Artisanal Sourdough & Multigrain Loaves": "أرغفة خبز بلدي وحبوب كاملة حرفية",
  "Freshly baked today at 5 AM. Includes 25 loaves of traditional seeded sourdough, 15 baguettes, and 10 trays of whole-wheat dinner rolls. Perfect condition.": "مخبوزة طازجة اليوم في الساعة 5 صباحاً. تشمل 25 رغيف خبز بلدي بالحبوب، و15 باجيت، و10 صواني خبز عشاء قمح كامل. بحالة ممتازة.",
  "Gourmet Hot Meal Trays — Roasted Chicken & Rice": "صواني وجبات ساخنة فاخرة — دجاج مشوي مع أرز",
  "Prepared for an executive banquet, unserved surplus. Vacuum sealed and blast-chilled in food-grade aluminum trays according to strict HACCP food safety standards.": "معدة لوليمة رسمية، فائض لم يُقدم. مغلفة بإحكام ومبردة بالصدمة في صواني ألومنيوم غذائية وفق معايير سلامة الغذاء HACCP.",
  "Bulk Organic Whole Milk & Greek Yogurt": "كميات حليب عضوي كامل الدسم وزبادي يوناني",
  "Pallet of whole organic pasteurized milk (1L bottles) and Greek probiotic yogurts (500g tubs). 5 days remaining before \"Best Before\" date.": "شحنة حليب عضوي مبستر (عبوات 1 لتر) وزبادي يوناني بروبيوتيك (علب 500 جم). متبقي 5 أيام قبل تاريخ انتهاء الصلاحية.",
  "Assorted Canned Beans, Soups & Pasta Essentials": "تشكيلة معلبات فاصوليا، حساء ومكرونة أساسية",
  "Long shelf-life staples: black beans, diced plum tomatoes, vegetable broth, and durum wheat penne pasta. Pristine condition with 12+ months shelf life.": "مواد أساسية طويلة الصلاحية: فاصوليا سوداء، طماطم مقطعة، مرق خضار، ومكرونة بيني قمح صلب. بحالة ممتازة مع صلاحية تتجاوز 12 شهراً.",
  "Sweet Orchard Seasonal Apples & Citrus": "تفاح وحمضيات موسمية من البستان",
  "Crisp Honeycrisp apples, navel oranges, and ripe bananas. Excellent for school lunch programs, shelters, or direct community distribution.": "تفاح هوني كريسب مقرمش، وبرتقال، وموز ناضج. ممتاز لبرامج الوجبات المدرسية، ودور الإيواء، أو التوزيع المجتمعي المباشر.",
  "Frozen Vegetable Medleys & Peas": "تشكيلة خضروات وبازلاء مجمدة",
  "Individually Packaged Gourmet Deli Sandwiches": "ساندويتشات ديلي فاخرة مغلفة فردياً",
  "Surplus organic produce harvested fresh. Inspected and sorted in clean crates.": "فائض منتجات عضوية طازجة، مفحوصة ومفرزة في صناديق نظيفة.",
  "Keep chilled between 4°C and 8°C. Handle crates with care.": "يُحفظ مبرداً بين 4 إلى 8 درجات مئوية. تُعامل الصناديق بعناية.",
  "Store in cool dry conditions. Suitable for immediate freezing.": "يُحفظ في مكان بارد وجاف. مناسب للتجميد الفوري.",
  "Must remain refrigerated at < 3°C until reheating to > 74°C.": "يجب أن يظل مبرداً عند أقل من 3 درجات مئوية حتى إعادة التسخين لأكثر من 74 مئوية.",
  "Strict cold-chain required (2°C - 4°C). Bring insulated coolers.": "يلزم سلسلة تبريد صارمة (2-4 درجات مئوية). يرجى إحضار صناديق تبريد معزولة.",
  "Strict cold chain. Bring insulated crates.": "سلسلة تبريد صارمة. يرجى إحضار صناديق معزولة.",
  "Dry ambient storage.": "تخزين جاف في درجة حرارة الغرفة.",
  "Daily 2:00 PM – 5:30 PM": "يومياً من 2:00 ظهراً حتى 5:30 مساءً",
  "Today 4:00 PM – 8:00 PM": "اليوم من 4:00 عصراً حتى 8:00 مساءً",
  "Tonight until 10:00 PM or tomorrow morning 8 AM": "الليلة حتى 10:00 مساءً أو غداً صباحاً 8:00",
  "Mon-Fri 9:00 AM – 6:00 PM": "الإثنين-الجمعة 9:00 صباحاً – 6:00 مساءً",
  "Anytime during store hours (8 AM - 9 PM)": "في أي وقت خلال ساعات العمل (8 ص - 9 م)",
  "452 Elm Street, Downtown Metro": "452 شارع إلم، وسط المدينة",
  "890 Broadway Ave, Metro": "890 جادة برودواي، المدينة",
  "890 Broadway Ave, Loading Dock B": "890 جادة برودواي، رصيف التحميل ب",
  "124 Market Square, Metro": "124 ميدان السوق، المدينة",
  "320 Civic Center Plaza, Metro": "320 ساحة مركز المدينة",
  "742 Maple Blvd, North District": "742 شارع مابل، الحي الشمالي",
  "15 Harbor View Rd, Westside": "15 طريق هاربور فيو، ويست سايد",
  "Food Bridge HQ, Innovation Tower #400": "مقر جسر الغذاء، برج الابتكار #400",
  "1. Food Item Details": "1. تفاصيل المادة الغذائية",
  "2. Upload Photos": "2. رفع الصور",
  "3. Pickup Coordination & Location": "3. تنسيق وموقع الاستلام",
  "Drag and drop donation photos here": "اسحب وأفلت صور التبرع هنا",
  "or click to browse from your device (JPG, PNG, WebP up to 5MB)": "أو اضغط للتصفح من جهازك (JPG, PNG, WebP حتى 5 ميجابايت)",
  "Be descriptive so receiving pantries can plan their distribution.": "كن دقيقاً في الوصف لتتمكن بنوك الطعام من تخطيط التوزيع.",
  "Provide details on freshness, contents, allergens (nuts, gluten, dairy), and packaging.": "اذكر تفاصيل الطزاجة، والمكونات، ومسببات الحساسية (مكسرات، جلوتين، ألبان)، والتغليف.",
  "Interactive Pin Location (Click or drag marker to set exact receiving point)": "تحديد الموقع تفاعلياً (اضغط أو اسحب العلامة لتحديد نقطة الاستلام بدقة)",
  "Logistics Notes / Estimated Pickup Time": "ملاحظات لوجستية / الوقت المقدر للاستلام",
  "Pickup Facility / Street Address": "منشأة الاستلام / عنوان الشارع",
  "Handling Requirements:": "شروط الحفظ والتعامل:",
  "Service Radius:": "نطاق الخدمة:",
  "Tax Registration:": "التسجيل الضريبي:",
  "Donor Facility:": "منشأة المتبرع:",
  "IRS_501c3_Determination_Letter.pdf": "خطاب_توثيق_الجمعية_الرسمي.pdf",
  "Document Size: 1.4 MB • Uploaded: March 10, 2026": "حجم الملف: 1.4 ميجابايت • تم الرفع: 10 مارس 2026",
  "Close Inspector": "إغلاق المعاينة",
  "Review Verification Queue": "مراجعة قائمة التوثيق",
  "Review tax-exempt documents and approve organization collection privileges.": "مراجعة وثائق الإعفاء الضريبي والموافقة على صلاحيات استلام التبرعات.",
  "Charity Verification Approvals Queue": "قائمة طلبات توثيق الجمعيات الخيرية",
  "Approved organizations gain direct access to food categories including prepared hot meals and perishables. Ensure tax ID legitimacy.": "تحصل الجمعيات المعتمدة على وصول مباشر لفئات الأغذية بما فيها الوجبات الساخنة والأطعمة سريعة التلف. تأكد من صحة رقم التسجيل.",
  "Vetting non-profit 501(c)(3) status and inspecting compliance documents before food collection.": "التأكد من الصفة الخيرية الرسمية وفحص مستندات المطابقة قبل السماح باستلام الأغذية.",
  "Vetting Actions": "إجراءات الفحص والتوثيق",
  "Inspect Docs": "فحص المستندات",
  "Active Moderation Tickets": "تذاكر المراجعة النشطة",
  "Investigate reported food quality violations, packaging defects, and pickup disputes.": "التحقيق في بلاغات مخالفات جودة الغذاء وعيوب التغليف وخلافات مواعيد الاستلام.",
  "Reports & Listing Moderation Queue": "قائمة مراجعة البلاغات والإعلانات",
  "Platform User Directory": "دليل مستخدمي المنصة",
  "Search, inspect account privileges, and moderate donors and charity organizations.": "البحث في الحسابات وفحص الصلاحيات وإدارة المتبرعين والجمعيات الخيرية.",
  "Showing 1 to 7 of 7 registered accounts": "عرض 1 إلى 7 من أصل 7 حسابات مسجلة",
  "Platform Operations & Compliance Center": "مركز عمليات المنصة والامتثال",
  "System health, organizational vetting queues, and metropolitan food rescue metrics.": "كفاءة النظام، وقوائم فحص المنظمات، ومؤشرات إنقاذ الغذاء في المدينة.",
  "My Recent Donation Listings": "تبرعاتي المنشورة مؤخراً",
  "Review, edit, and track status transitions across all your published donations.": "مراجعة وتعديل وتتبع مراحل جميع تبرعاتك المنشورة.",
  "List excess food items to notify verified local charities for scheduled collection.": "انشر فائض الغذاء لإشعار الجمعيات المعتمدة فوراً لجدولة الاستلام.",
  "Track approval statuses, pickup coordination, and verify received distributions.": "تتبع حالات الموافقة، وتنسيق الاستلام، وتوثيق الحصص المستلمة.",
  "Filter nearby donations, inspect on OpenStreetMap, and claim allocations.": "تصفية التبرعات القريبة، ومعاينتها على الخريطة، وطلب الحصص المطلوبة.",
  "Stay Updated": "ابقَ على اطلاع",
  "No spam. Unsubscribe anytime.": "لا رسائل مزعجة، يمكنك إلغاء الاشتراك في أي وقت.",
  "Globally, more than": "عالمياً، أكثر من",
  "1.3 billion tons": "1.3 مليار طن",
  "of food is wasted annually — nearly one-third of all agricultural output. At the same time, over 800 million individuals go to bed hungry.": "من الغذاء يُهدر سنوياً — ما يقرب من ثلث الإنتاج الزراعي العالمي. وفي الوقت نفسه، ينام أكثر من 800 مليون شخص جائعين.",
  "Produce": "خضار وفواكه",
  "Produce (Fruit & Veg)": "خضار وفواكه",
  "Produce (Fruits & Veggies)": "خضار وفواكه طازجة",
  "Bakery": "مخبوزات",
  "Bakery & Breads": "مخبوزات وخبز طازج",
  "Prepared Meals": "وجبات جاهزة",
  "Prepared / Cooked Meals": "وجبات مطهية وجاهزة",
  "Dairy": "ألبان وأجبان",
  "Dairy & Eggs": "ألبان وبيض",
  "Dairy & Milk": "ألبان وحليب",
  "Canned Goods": "معلبات ومؤن",
  "Canned & Dry Goods": "معلبات ومواد جافة",
  "Canned & Pantry": "معلبات ومؤن غذائية",
  "Juices & Beverages": "عصائر ومشروبات",
  "Beverages": "مشروبات",
  "Meat & Poultry": "لحوم ودواجن",
  "Frozen": "مجمدات",
  "Other": "أخرى",
  "Boxes / Crates": "صناديق / كراتين",
  "Individual Units": "وحدات فردية",
  "Kilograms & Meals": "كيلوجرامات ووجبات",
  "Kilograms (kg)": "كيلوجرام (كجم)",
  "Portions / Meals": "حصص / وجبات",
  "Liters": "لترات",
  "kg": "كجم",
  "units": "وحدة",
  "items": "قطعة",
  "meals": "وجبة",
  "cans/boxes": "علبة/كرتونة",
  "boxes": "صندوق",
  "crates": "قفص",
  "tons": "طن",
  "AVAILABLE": "متاح",
  "PENDING": "قيد الانتظار",
  "APPROVED": "معتمد",
  "SCHEDULED": "مجدول",
  "COMPLETED": "مكتمل",
  "CANCELLED": "ملغي",
  "REJECTED": "مرفوض",
  "RESERVED": "محجوز",
  "Available": "متاح",
  "Pending": "قيد الانتظار",
  "Approved": "معتمد",
  "Scheduled": "مجدول",
  "Completed": "مكتمل",
  "Cancelled": "ملغي",
  "Rejected": "مرفوض",
  "Reserved": "محجوز",
  "Urgent": "عاجل",
  "Verified": "موثق",
  "Vetted": "معتمد",
  "Active": "نشط",
  "Suspended": "موقوف",
  "Live": "متاح الآن",
  "Live Queue": "قائمة مباشرة",
  "Open Reports": "بلاغات مفتوحة",
  "Pending Orgs": "منظمات قيد الانتظار",
  "Verified Orgs": "منظمات موثقة",
  "All Roles": "جميع الأدوار",
  "All Account Statuses": "جميع الحالات",
  "All Donations": "جميع التبرعات",
  "Active Only": "النشطة فقط",
  "Suspended Only": "الموقوفة فقط",
  "Target Listing / Entity": "الإعلان / الجهة المعنية",
  "Date Filed": "تاريخ البلاغ",
  "Review Action": "إجراء المراجعة",
  "Action": "الإجراء",
  "Actions": "الإجراءات",
  "Status": "الحالة",
  "Role": "الدور",
  "Joined": "تاريخ الانضمام",
  "Joined Date": "تاريخ الانضمام",
  "Date": "التاريخ",
  "Total Users": "إجمالي المستخدمين",
  "Total": "الإجمالي",
  "Pickups": "الاستلامات",
  "Requests": "الطلبات",
  "Incoming Requests": "الطلبات الواردة",
  "Scheduled Pickups": "الاستلامات المجدولة",
  "Donation Details": "تفاصيل التبرع",
  "Donation Published": "تم نشر التبرع",
  "Donation Expiring Soon": "تبرع وشيك الانتهاء",
  "Issue Reported": "تم الإبلاغ عن مشكلة",
  "New Charity Verification Pending": "طلب توثيق جمعية جديدة قيد الانتظار",
  "New Donation Nearby": "تبرع جديد في الجوار",
  "New Donation Request": "طلب تبرع جديد",
  "New Item": "عنصر جديد",
  "Next": "التالي",
  "Previous": "السابق",
  "Title": "العنوان",
  "Category": "الفئة",
  "Category / Organization Type": "الفئة / نوع المنظمة",
  "Quantity": "الكمية",
  "Quantity Requested": "الكمية المطلوبة",
  "Expires": "ينتهي في",
  "Urgent / Expiry": "الاستعجال / الصلاحية",
  "Donor": "المتبرع",
  "Donor Category": "فئة المتبرع",
  "Donor:": "المتبرع:",
  "Charity:": "الجمعية:",
  "Admin:": "الإدارة:",
  "Email:": "البريد:",
  "Phone:": "الهاتف:",
  "Address:": "العنوان:",
  "Location:": "الموقع:",
  "Primary Contact": "جهة الاتصال الأساسية",
  "Contact Email": "بريد التواصل",
  "Requested by": "مقدم الطلب",
  "Request More Food": "طلب المزيد من الطعام",
  "Request Allocation": "طلب حصة غذائية",
  "Request This Donation": "طلب هذا التبرع",
  "View Details & Request": "التفاصيل وطلب الحصة",
  "View Details": "عرض التفاصيل",
  "Edit Listing": "تعديل القائمة",
  "Edit Donation Listing": "تعديل قائمة التبرع",
  "Cancel Listing": "إلغاء القائمة",
  "Confirm Handoff": "تأكيد التسليم",
  "Track Milestone": "تتبع المراحل",
  "Save Draft": "حفظ كمسودة",
  "Save Profile Changes": "حفظ التعديلات",
  "Save Changes": "حفظ التغييرات",
  "Approve": "موافقة",
  "Reject": "رفض",
  "Resolve": "حل النزاع",
  "Dismiss": "تجاهل",
  "Mark as read": "تعيين كمقروء",
  "Mark All as Read": "تعيين الكل كمقروء",
  "View All Organizations": "عرض جميع المنظمات",
  "Safety Compliance": "الامتثال لمعايير السلامة",
  "Compliance Standard Note": "ملاحظة معايير الامتثال",
  "Verification Document Inspection": "فحص وثائق التوثيق",
  "Verification Status": "حالة التوثيق",
  "Charitable Organization Verification": "توثيق المنظمات الخيرية",
  "Organization Type": "نوع المنظمة",
  "Organization & Address": "المنظمة والعنوان",
  "User / Organization": "المستخدم / المنظمة",
  "User Profile": "ملف المستخدم",
  "Administrators": "المديرون",
  "Charities": "الجمعيات الخيرية",
  "Donors": "المتبرعون",
  "Tools": "الأدوات",
  "Explorer": "المستكشف",
  "Dashboards": "لوحات التحكم",
  "Platform Views": "واجهات المنصة",
  "Type": "النوع",
  "Reason": "السبب",
  "Reporter": "مقدم البلاغ",
  "Search by food, donor name, or address...": "ابحث بالصنف الغذائي، اسم المتبرع، أو العنوان...",
  "Search by name, email, or address...": "ابحث بالاسم، البريد، أو العنوان...",
  "Search by title, address, or contents...": "ابحث بالعنوان، الموقع، أو المحتويات...",
  "Enter your email": "أدخل بريدك الإلكتروني",
  "e.g. 40": "مثال: 40",
  "e.g. 501(c)(3) #84-9201934": "مثال: رقم التسجيل #84-9201934",
  "e.g. Fresh Organic Garden Produce Crates": "مثال: صناديق خضار وفواكه طازجة من المزرعة",
  "e.g. Greater Metro Area, 15km Radius": "مثال: نطاق المدينة الكبرى، قطر 15 كم",
  "e.g. GreenBites Bistro or John Doe": "مثال: مطعم جرين بايتس أو فلان الفلاني",
  "e.g. Keep chilled under 4°C. Bring thermal bags.": "مثال: يُحفظ مبرداً تحت 4 درجات. يرجى إحضار حقائب حرارية.",
  "e.g. Metro Hope Food Pantry": "مثال: بنك طعام الأمل",
  "e.g. Our refrigerated transit van will collect tomorrow at 11:30 AM. Contact driver Dave.": "مثال: ستصل شاحنتنا المبردة للاستلام غداً 11:30 صباحاً. سائق المركبة: أحمد.",
  "e.g. Today 2:00 PM – 6:00 PM or Tomorrow morning": "مثال: اليوم 2:00 ظهراً – 6:00 مساءً أو غداً صباحاً",
  "Street Address, City": "عنوان الشارع، المدينة",
  "Street Address, City, Postal Code": "عنوان الشارع، المدينة، الرمز البريدي",
  "Our Story & Purpose": "قصتنا وأهدافنا",
  "Bridging Abundance with Need": "جسر يربط الوفرة بالاحتياج",
  "Connecting food businesses and communities to eliminate edible food waste and nourish people in need.": "ربط المنشآت الغذائية والمجتمعات للقضاء على هدر الطعام الصالح للأكل وإطعام المحتاجين.",
  "Connecting food businesses, supermarkets, and local communities to eliminate edible food waste and nourish people in need.": "ربط المنشآت الغذائية والمتاجر والمجتمعات المحلية للقضاء على هدر الطعام الصالح للأكل وإطعام المحتاجين.",
  "We believe that no edible meal should end up in a landfill while our neighbors face food insecurity.": "نؤمن بأنه لا ينبغي أن تنتهي أي وجبة صالحة للأكل في مكب النفايات بينما يعاني أفراد في مجتمعنا من انعدام الأمن الغذائي.",
  "Our Mission": "رسالتنا",
  "To build a friction-free, hyper-local digital pipeline that empowers commercial food outlets, grocers, and community donors to divert surplus nutrition directly to local food banks, shelters, and families in need before expiration.": "بناء منظومة رقمية محلية سلسة تمكّن المطاعم والمتاجر والمتبرعين من تحويل الفائض الغذائي مباشرة إلى بنوك الطعام والملاجئ والأسر المحتاجة قبل انتهاء صلاحيته.",
  "Our Vision": "رؤيتنا",
  "A zero-waste future where every municipality operates an intelligent circular economy for food — where logistics barriers vanish, food security is safeguarded, and environmental stewardship is a seamless part of every business.": "مستقبل خالٍ من الهدر تدير فيه كل مدينة اقتصاداً دائرياً ذكياً للغذاء، حيث تزول العوائق اللوجستية، ويُصان الأمن الغذائي، وتصبح حماية البيئة جزءاً طبيعياً من عمل كل منشأة.",
  "The Staggering Paradox of Food Waste": "المفارقة الصادمة لهدر الغذاء",
  "The Critical Challenge": "التحدي المصيري",
  "Decomposing organic waste in municipal landfills generates 8-10% of total anthropogenic greenhouse gas emissions (methane). The solution is not necessarily producing more food; it is distributing surplus with smart, instantaneous coordination.": "يولّد تحلل النفايات العضوية في المكبات 8-10% من إجمالي انبعاثات الغازات الدفيئة (الميثان). الحل لا يكمن بالضرورة في إنتاج المزيد من الغذاء، بل في توزيع الفائض بتنسيق ذكي وفوري.",
  "Global food supply discarded each year": "من الإمداد الغذائي العالمي يُهدر سنوياً",
  "Of global greenhouse emissions from food waste": "من الانبعاثات العالمية ناتجة عن هدر الغذاء",
  "What Guides Our Platform": "المبادئ التي توجه منصتنا",
  "Integrity, accountability, and safety are embedded into every line of code.": "النزاهة والمسؤولية والسلامة متأصلة في كل تفاصيل منصتنا.",
  "Food Safety First": "سلامة الغذاء أولاً",
  "Comprehensive cold-chain guidelines, blast-chill protocols, and transparent expiry counters ensure safe consumption.": "إرشادات صارمة لسلسلة التبريد وبروتوكولات التبريد السريع ومؤقتات انتهاء شفافة لضمان الاستهلاك الآمن.",
  "Vetted Recipient Network": "شبكة مستفيدين موثقة",
  "Every organization undergoes tax-exempt non-profit verification, ensuring donations go directly to authentic social good.": "تخضع كل منظمة لفحص التوثيق الرسمي لضمان وصول التبرعات مباشرة للعمل الإنساني الموثوق.",
  "Measurable ESG Tracking": "مؤشرات بيئية ومجتمعية قابلة للقياس",
  "Transparent reporting converts every kilogram saved into verified CO2 abatement and tax-deductible metrics.": "تقارير شفافة تحول كل كيلوجرام يتم إنقاذه إلى خفض موثق لانبعاثات الكربون وبيانات معتمدة للإعفاء الضريبي.",
  "Join the Food-Bridge Movement": "انضم إلى مبادرة جسر الغذاء",
  "Sign up in minutes as a donor or a verified charitable recipient and start closing the food waste gap today.": "سجل خلال دقائق كمتبرع أو جهة خيرية معتمدة وابدأ في سد فجوة هدر الغذاء اليوم.",
  "Sign Up Free": "سجل مجاناً",
  "Account": "الحساب",
  "Administration": "الإدارة",
  "Admin Center": "مركز الإدارة",
  "Admin Ops": "عمليات الإدارة",
  "All Alerts": "جميع التنبيهات",
  "All Categories": "جميع الفئات",
  "All Listings": "جميع الإعلانات",
  "All Requests": "جميع الطلبات",
  "Active Listings": "الإعلانات النشطة",
  "Any Distance": "أي مسافة",
  "Available Collection Windows": "مواعيد الاستلام المتاحة",
  "Available Pickup Windows": "مواعيد الاستلام المتاحة",
  "Available Quantity:": "الكمية المتاحة:",
  "Back to Listings": "العودة إلى القوائم",
  "Browse Donations": "تصفح التبرعات",
  "Browse Food": "تصفح الطعام",
  "Cancel": "إلغاء",
  "Charity Tools": "أدوات الجمعيات",
  "Claim This Donation": "طلب هذا التبرع",
  "Close": "إغلاق",
  "Collection Milestone Progress": "مراحل تقدم الاستلام",
  "Community Newsletter": "النشرة الإخبارية المجتمعية",
  "Completed Pickups": "الاستلامات المكتملة",
  "Confirm & Submit Request": "تأكيد وإرسال الطلب",
  "Confirm Password": "تأكيد كلمة المرور",
  "Description & Ingredients": "الوصف والمكونات",
  "Detailed Description & Ingredients": "الوصف التفصيلي والمكونات",
  "Digital Handoff Pass": "تصريح التسليم الرقمي",
  "Document Attached": "المستند مرفق",
  "Document hash verified against federal non-profit database.": "تم التحقق من الوثيقة ومطابقتها مع السجل الرسمي للمنظمات غير الربحية.",
  "Donation Title": "عنوان التبرع",
  "Donor Tools": "أدوات المتبرع",
  "Email Address": "البريد الإلكتروني",
  "Expiration Date & Time": "تاريخ ووقت انتهاء الصلاحية",
  "Expiration:": "تاريخ الانتهاء:",
  "Explore Food": "استكشاف الطعام",
  "Food Safety Compliance Note": "ملاحظة الالتزام بمعايير سلامة الأغذية",
  "Frozen Food": "أطعمة مجمدة",
  "GPS Pinned Coordinates": "إحداثيات الموقع عبر GPS",
  "Handling & Storage Instructions": "إرشادات الحفظ والتعامل",
  "Join Network": "الانضمام للمنصة",
  "Leaflet": "ليفليت",
  "List Donation": "نشر التبرع",
  "Manage Food Listings": "إدارة القوائم الغذائية",
  "Manage Users": "إدارة المستخدمين",
  "Manage surplus donations, approve charity requests, and track your environmental impact.": "إدارة التبرعات الفائضة، والموافقة على طلبات الجمعيات، وتتبع أثرك البيئي.",
  "My Allocation Requests": "طلبات الحصص الخاصة بي",
  "My Listings": "تبرعاتي",
  "Navigation": "التنقل",
  "Notification Center": "مركز الإشعارات",
  "Open Full Certificate": "فتح الشهادة كاملة",
  "Organization": "المنظمة",
  "Password": "كلمة المرور",
  "Pending Requests": "الطلبات قيد الانتظار",
  "Pickup Location Map": "خريطة موقع الاستلام",
  "Pickup Logistics Information": "معلومات النقل والاستلام",
  "Pickup Scheduled": "تم جدولة الاستلام",
  "Pickup Street Address": "عنوان شارع الاستلام",
  "Pickup Tracking": "تتبع الاستلام",
  "Privacy": "الخصوصية",
  "Profile & Account Settings": "إعدادات الملف الشخصي والحساب",
  "Publish Donation": "نشر التبرع",
  "Publish New Surplus Donation": "نشر تبرع فائض جديد",
  "Published By Verified Donor": "منشور بواسطة متبرع موثق",
  "Reports & Moderation": "البلاغات والمراجعة",
  "Request Approved": "تمت الموافقة على الطلب",
  "Request Food Donation": "طلب تبرع غذائي",
  "Request Submitted": "تم إرسال الطلب",
  "Request full or partial quantities for your charitable distribution program.": "طلب كميات كلية أو جزئية لبرنامج التوزيع الخيري الخاص بك.",
  "Requesting organization • Accredited Recipient": "المنظمة الطالبة • جهة مستفيدة معتمدة",
  "Review Listing": "مراجعة القائمة",
  "Review": "مراجعة",
  "Safe Handling & Storage Instructions": "إرشادات الحفظ الآمن والتخزين",
  "Show Map": "عرض الخريطة",
  "Sign In": "تسجيل الدخول",
  "Sign in to your Food Bridge account to manage your listings and requests.": "سجل الدخول إلى حسابك في جسر الغذاء لإدارة قوائمك وطلباتك.",
  "Sign in to your EcoDonate account to manage your listings and requests.": "سجل الدخول إلى حسابك في جسر الغذاء لإدارة قوائمك وطلباتك.",
  "Subscribe": "اشتراك",
  "Terms": "الشروط",
  "Tomorrow, 6:00 PM": "غداً، 6:00 مساءً",
  "Total Rescued": "إجمالي المنقذ",
  "Track Requests": "تتبع الطلبات",
  "Unit of Measure": "وحدة القياس",
  "Unread Only": "غير المقروء فقط",
  "Upcoming Pickups": "الاستلامات القادمة",
  "Verify Charities": "توثيق الجمعيات",
  "View All Listings": "عرض جميع القوائم",
  "Welcome Back": "مرحباً بك مجدداً",
  "Within 10 km": "ضمن نطاق 10 كم",
  "Within 2 km": "ضمن نطاق 2 كم",
  "Within 5 km": "ضمن نطاق 5 كم",
  "Workflows": "مسارات العمل",
  "1 Donation Expiring Soon!": "تبرع واحد أوشك على انتهاء الصلاحية!",
  "38 successful community pickups completed through Food Bridge.": "تم إتمام 38 عملية استلام مجتمعية ناجحة عبر جسر الغذاء.",
  "38 successful community pickups completed through EcoDonate.": "تم إتمام 38 عملية استلام مجتمعية ناجحة عبر جسر الغذاء.",
  "No users found matching your criteria.": "لم يتم العثور على مستخدمين يطابقون معايير البحث.",
  "No requests found": "لا توجد طلبات",
  "Explore available food donations and submit a request to support your community.": "استكشف تبرعات الطعام المتاحة وقدم طلباً لدعم مجتمعك.",
  "Find Food Donations": "البحث عن تبرعات الطعام",
  "Tracking Record Not Found": "سجل التتبع غير موجود",
  "View All Requests": "عرض جميع الطلبات",
  "Listing made available to verified charities": "تمت إتاحة القائمة للجمعيات المعتمدة",
  "sent a reservation request": "أرسلت طلب حجز",
  "Donor reviewed and accepted allocation": "قام المتبرع بمراجعة الحصة واعتمادها",
  "Time slot confirmed for collection": "تم تأكيد موعد الاستلام",
  "Food safely delivered and distributed": "تم تسليم الطعام وتوزيعه بأمان",
  "Completed / Verified": "مكتمل وموثق",
  "Pending next workflow step": "بانتظار المرحلة التالية",
  "Verify Handoff & Complete Collection": "توثيق التسليم وإتمام الاستلام",
  "Confirm Schedule Pickup": "تأكيد جدولة الاستلام",
  "Collection Verified! All milestones completed.": "تم توثيق الاستلام! اكتملت جميع المراحل بنجاح.",
  "Pickup scheduled successfully!": "تمت جدولة الاستلام بنجاح!",
  "No notifications to display": "لا توجد إشعارات لعرضها",
  "You're all caught up with your latest platform alerts.": "أنت مطلع على كافة تنبيهات المنصة الحديثة.",
  "View Event": "معاينة الحدث",
  "Notification marked as read": "تم تعيين الإشعار كمقروء",
  "All notifications marked as read": "تم تعيين جميع الإشعارات كمقروءة",
  "Profile picture updated!": "تم تحديث الصورة الشخصية!",
  "Profile details saved successfully!": "تم حفظ بيانات الملف الشخصي بنجاح!",
  "Logging in as Donor (GreenBites Organic Bistro)...": "جاري تسجيل الدخول كمتبرع (مطعم جرين بايتس العضوي)...",
  "Logging in as Verified Charity (Hope Food Pantry)...": "جاري تسجيل الدخول كجمعية موثقة (بنك طعام الأمل)...",
  "Logging in as Administrator (Operations Team)...": "جاري تسجيل الدخول كمسؤول منصة (فريق العمليات)...",
  "Invalid credentials. Use demo fast-fill buttons.": "بيانات الدخول غير صحيحة. يرجى استخدام أزرار الدخول التجريبي السريع.",
  "Registration successful! Welcome to the network.": "تم التسجيل بنجاح! مرحباً بك في المنصة.",
  "Passwords do not match.": "كلمتا المرور غير متطابقتين.",
  "Please fill in all required fields.": "يرجى تعبئة جميع الحقول المطلوبة.",
  "Please upload verification documentation.": "يرجى رفع وثائق توثيق المنظمة.",
  "Rescue Now": "إنقاذ الآن",
  "Expires Soon": "ينتهي قريباً",
  "Expires:": "تاريخ الصلاحية:",
  "Your pickup of 60 units of milk & yogurt from FreshMart is confirmed for tomorrow 2:00 PM.": "تم تأكيد استلام 60 وحدة من الحليب والزبادي من سوبرماركت فريش مارت لغداً في الساعة 2:00 ظهراً.",
  "Your listing \"Gourmet Hot Meal Trays\" expires in 22 hours. 35 meals still available.": "قائمتك \"صواني وجبات ساخنة فاخرة\" تنتهي صلاحيتها خلال 22 ساعة. لا يزال 35 وجبة متاحة.",
  "New Dawn Youth Haven uploaded verification documents awaiting review.": "قام مأوى الفجر للشباب برفع وثائق التوثيق بانتظار المراجعة.",
  "Successfully collected 30 meals from GreenBites. 18.5 kg CO2 emission diverted!": "تم استلام 30 وجبة بنجاح من مطعم جرين بايتس. تم تفادي 18.5 كجم من انبعاثات الكربون!",
  "2 hours ago": "منذ ساعتين",
  "4 hours ago": "منذ 4 ساعات",
  "5 hours ago": "منذ 5 ساعات",
  "Yesterday": "أمس",
  "Our refrigerated van will arrive at loading dock B. Contact driver Dave at 555-0199.": "ستصل شاحنتنا المبردة إلى رصيف التحميل ب. للتواصل مع السائق ديف: 555-0199.",
  "Bakery / Café": "مخبز / مقهى",
  "Collected": "تم الاستلام",
  "Community Center Pantry": "مستودع المركز المجتمعي",
  "Food Bridge Operations HQ": "المقر الرئيسي لعمليات جسر الغذاء",
  "Emergency Shelter": "مأوى طوارئ",
  "Event Catering": "تموين فعاليات",
  "Farm / Producer": "مزرعة / منتج",
  "Food Bank": "بنك طعام",
  "Food Rescue & ESG Impact History": "سجل إنقاذ الغذاء وأثر الاستدامة",
  "Food bank, soup kitchen, shelter, or community pantry": "بنك طعام، مطبخ خيري، ملجأ، أو مستودع مجتمعي",
  "Individual Donor": "متبرع فردي",
  "Instant Request SMS & Email": "إشعارات فورية عبر الرسائل القصيرة والبريد",
  "Interactive Metropolitan Map": "خريطة تفاعلية للمدينة",
  "Join our network to donate surplus food or collect meals for your community.": "انضم إلى شبكتنا للتبرع بالفائض الغذائي أو استلام وجبات لمجتمعك.",
  "Leaflet / OpenStreetMap": "ليفليت / خريطة الشارع المفتوحة",
  "Restaurant": "مطعم",
  "Restaurant, grocery, bakery, farm, or corporate kitchen": "مطعم، بقالة، مخبز، مزرعة، أو مطبخ شركة",
  "Soup Kitchen": "مطبخ خيري",
  "Supermarket": "سوبرماركت",
  "Updating quantity automatically notifies subscribed recipient pantries.": "تحديث الكمية يُرسل تنبيهاً تلقائياً لبنوك الطعام المستفيدة المشتركة.",
  "Verified handoffs": "عمليات تسليم موثقة",
  "Weekly ESG & CO2 Impact Summary": "ملخص أسبوعي لأثر الاستدامة البيئية وخفض الكربون",
  "Westside Waterfront Community": "مجتمع واجهة ويست سايد البحرية",
  "Youth Care Center": "مركز رعاية الشباب",
  "contact@organization.org": "contact@organization.org",
  "name@organization.org": "name@organization.org",
  "501(c)(3) #77-4839201": "ترخيص رقم 501(c)(3) #77-4839201",
  "\"Gourmet Hot Meal Trays\" expires in less than 24 hours. Consider accepting pending requests immediately.": "قائمة \"صواني وجبات ساخنة فاخرة\" تنتهي صلاحيتها خلال أقل من 24 ساعة. يُرجى قبول الطلبات المعلقة فوراً."
},
  en: {}
};

// Build reverse dictionary for 100% bidirectional translation
for (const [en, ar] of Object.entries(I18N_DICTIONARY.ar)) {
  const enClean = en.trim();
  const arClean = ar.trim();
  if (I18N_DICTIONARY.en[arClean] && (enClean.includes('EcoDonate') || enClean.includes('Food-Bridge'))) {
    continue;
  }
  I18N_DICTIONARY.en[arClean] = enClean;
}
I18N_DICTIONARY.en['جسر الغذاء'] = 'Food Bridge';
I18N_DICTIONARY.en['منصة جسر الغذاء'] = 'Food Bridge Platform';
I18N_DICTIONARY.en['كيف تعمل منصة جسر الغذاء'] = 'How Food Bridge Works';

const EcoLang = {
  KEY_LANG: 'ecodonate_lang',
  nodeOriginals: new WeakMap(),
  _observer: null,

  get() {
    return localStorage.getItem(this.KEY_LANG) || 'en';
  },

  t(text, forceLang) {
    if (!text || typeof text !== 'string') return text;
    const lang = forceLang || this.get();
    const trimmed = text.trim();
    if (!trimmed) return text;

    if (lang === 'ar') {
      if (I18N_DICTIONARY.ar[trimmed]) return I18N_DICTIONARY.ar[trimmed];
      if (I18N_DICTIONARY.ar[text]) return I18N_DICTIONARY.ar[text];
      const norm = trimmed.replace(/\s+/g, ' ');
      if (I18N_DICTIONARY.ar[norm]) return I18N_DICTIONARY.ar[norm];
      return text;
    } else {
      if (I18N_DICTIONARY.en[trimmed]) return I18N_DICTIONARY.en[trimmed];
      if (I18N_DICTIONARY.en[text]) return I18N_DICTIONARY.en[text];
      const norm = trimmed.replace(/\s+/g, ' ');
      if (I18N_DICTIONARY.en[norm]) return I18N_DICTIONARY.en[norm];
      return text;
    }
  },

  set(lang) {
    localStorage.setItem(this.KEY_LANG, lang);
    document.documentElement.setAttribute('lang', lang);
    document.documentElement.setAttribute('dir', lang === 'ar' ? 'rtl' : 'ltr');
    if (document.body) {
      document.body.setAttribute('dir', lang === 'ar' ? 'rtl' : 'ltr');
    }
    this.applyTranslations(lang);
    this.updateSelector(lang);
    if (typeof EcoTheme !== 'undefined' && EcoTheme.updateToggleButtons) {
      EcoTheme.updateToggleButtons(EcoTheme.get());
    }
    EcoToast.show(
      lang === 'ar' ? 'تم تحويل الموقع بالكامل إلى اللغة العربية 🇪🇬' : 'Site fully switched to English 🇺🇸',
      'info'
    );
    window.dispatchEvent(new CustomEvent('langChanged', { detail: { lang } }));
  },

  updateSelector(lang) {
    const isAr = lang === 'ar';
    document.querySelectorAll('.lang-toggle-btn').forEach(btn => {
      if (isAr) {
        btn.innerHTML = '<i class="bi bi-translate me-1"></i> <span class="badge bg-success" style="font-size:0.75rem;">العربية</span> <span class="text-secondary small ms-1">EN</span>';
        btn.setAttribute('title', 'التبديل إلى الإنجليزية (Switch to English)');
      } else {
        btn.innerHTML = '<i class="bi bi-translate me-1"></i> <span class="badge bg-primary" style="font-size:0.75rem;">English</span> <span class="text-secondary small ms-1">عربي</span>';
        btn.setAttribute('title', 'التبديل إلى العربية (Switch to Arabic)');
      }
    });

    document.querySelectorAll('.current-lang-text').forEach(el => {
      el.textContent = isAr ? 'العربية' : 'English';
    });

    const sel = document.getElementById('globalLangSelector');
    if (sel) sel.value = lang;
    const profSel = document.getElementById('profileLangSelect');
    if (profSel) profSel.value = lang;
  },

  applyTranslations(lang) {
    // 1. Document Title
    const curTitle = document.title;
    if (lang === 'ar') {
      const arTitle = this.t(curTitle, 'ar');
      if (arTitle !== curTitle) document.title = arTitle;
    } else {
      const enTitle = this.t(curTitle, 'en');
      if (enTitle !== curTitle) document.title = enTitle;
    }

    // 2. TreeWalker on Text Nodes
    const walker = document.createTreeWalker(
      document.body,
      NodeFilter.SHOW_TEXT,
      {
        acceptNode: (node) => {
          const p = node.parentElement;
          if (!p) return NodeFilter.FILTER_REJECT;
          const tag = p.tagName;
          if (tag === 'SCRIPT' || tag === 'STYLE' || tag === 'NOSCRIPT') {
            return NodeFilter.FILTER_REJECT;
          }
          if (!node.nodeValue.trim()) return NodeFilter.FILTER_REJECT;
          return NodeFilter.FILTER_ACCEPT;
        }
      }
    );

    let textNode;
    while ((textNode = walker.nextNode())) {
      const raw = textNode.nodeValue;
      const trimmed = raw.trim();
      if (!trimmed) continue;

      let orig = this.nodeOriginals.get(textNode);
      if (orig === undefined) {
        orig = raw;
        this.nodeOriginals.set(textNode, orig);
      }

      const trimmedOrig = orig.trim();

      if (lang === 'ar') {
        const trans = this.t(trimmedOrig, 'ar');
        if (trans !== trimmedOrig) {
          textNode.nodeValue = orig.replace(trimmedOrig, trans);
        }
      } else {
        // English
        if (orig && !/[\u0600-\u06FF]/.test(trimmedOrig)) {
          textNode.nodeValue = orig;
        } else {
          const en = this.t(trimmed, 'en');
          if (en !== trimmed) {
            textNode.nodeValue = raw.replace(trimmed, en);
          }
        }
      }
    }

    // 3. Placeholders
    document.querySelectorAll('input[placeholder], textarea[placeholder]').forEach(inp => {
      const ph = inp.getAttribute('placeholder');
      if (!inp.getAttribute('data-en-placeholder')) {
        inp.setAttribute('data-en-placeholder', ph);
      }
      const enPh = inp.getAttribute('data-en-placeholder');
      inp.setAttribute('placeholder', lang === 'ar' ? this.t(enPh, 'ar') : enPh);
    });

    // 4. Options
    document.querySelectorAll('option').forEach(opt => {
      const txt = opt.innerText.trim();
      if (!opt.getAttribute('data-en-text')) {
        opt.setAttribute('data-en-text', txt);
      }
      const enTxt = opt.getAttribute('data-en-text');
      opt.innerText = lang === 'ar' ? this.t(enTxt, 'ar') : enTxt;
    });

    // 5. Titles
    document.querySelectorAll('[title]').forEach(el => {
      if (el.classList.contains('lang-toggle-btn') || el.classList.contains('theme-toggle-btn')) return;
      const t = el.getAttribute('title');
      if (!el.getAttribute('data-en-title')) {
        el.setAttribute('data-en-title', t);
      }
      const enTitle = el.getAttribute('data-en-title');
      el.setAttribute('title', lang === 'ar' ? this.t(enTitle, 'ar') : enTitle);
    });
  },

  setupObserver() {
    if (this._observer || !window.MutationObserver) return;
    this._observer = new MutationObserver(() => {
      this._observer.disconnect();
      this.applyTranslations(this.get());
      this._observer.observe(document.body, { childList: true, subtree: true });
    });
    this._observer.observe(document.body, { childList: true, subtree: true });
  },

  init() {
    const lang = this.get();
    document.documentElement.setAttribute('lang', lang);
    document.documentElement.setAttribute('dir', lang === 'ar' ? 'rtl' : 'ltr');
    if (document.body) {
      document.body.setAttribute('dir', lang === 'ar' ? 'rtl' : 'ltr');
    }
    this.applyTranslations(lang);
    this.updateSelector(lang);
    this.setupObserver();
  }
};

// ==========================================================================
// Demo Role Switcher Bar (Removed per user request)
// ==========================================================================
function renderDemoRoleBar() {
  // Prototype demo bar removed per user request
}

// Mobile sidebar toggle initializer
function setupMobileSidebar() {
  const toggleBtn = document.querySelector('.sidebar-toggle-btn');
  const sidebar = document.querySelector('.app-sidebar');
  const backdrop = document.querySelector('.sidebar-backdrop');

  if (toggleBtn && sidebar) {
    toggleBtn.addEventListener('click', () => {
      sidebar.classList.toggle('sidebar-open');
      if (backdrop) backdrop.classList.toggle('active');
    });
  }

  if (backdrop && sidebar) {
    backdrop.addEventListener('click', () => {
      sidebar.classList.remove('sidebar-open');
      backdrop.classList.remove('active');
    });
  }
}

// Automatically ensure every dashboard topbar has theme & lang quick toggles
function injectTopbarControls() {
  const isDark = EcoTheme.get() === 'dark';
  const isAr = EcoLang.get() === 'ar';
  const langText = isAr ? 'English' : 'العربية';

  document.querySelectorAll('.dashboard-topbar .topbar-right').forEach(bar => {
    let group = bar.querySelector('.topbar-quick-controls');
    if (!group) {
      group = document.createElement('div');
      group.className = 'd-flex align-items-center gap-1 topbar-quick-controls me-2';
      group.innerHTML = `
        <button class="btn btn-sm btn-ghost p-1 px-2 theme-toggle-btn" onclick="EcoTheme.toggle()" title="Toggle Dark/Light Mode" aria-label="Toggle Theme">
          <i class="bi ${isDark ? 'bi-sun-fill text-warning' : 'bi-moon-stars-fill'}"></i>
        </button>
        <button class="btn btn-sm btn-ghost p-1 px-2 lang-toggle-btn" onclick="EcoLang.set(EcoLang.get() === 'ar' ? 'en' : 'ar')" title="Switch Language (English / العربية)" aria-label="Switch Language">
          <i class="bi bi-translate me-1"></i> <span class="small current-lang-text">${langText}</span>
        </button>
      `;
      bar.insertBefore(group, bar.firstChild);
    }
  });

  document.querySelectorAll('.public-navbar .collapse .d-flex').forEach(container => {
    if (!container.querySelector('.lang-toggle-btn')) {
      const controls = document.createElement('div');
      controls.className = 'd-inline-flex align-items-center gap-2 me-2';
      controls.innerHTML = `
        <button class="btn btn-sm btn-ghost p-2 theme-toggle-btn" onclick="EcoTheme.toggle()" title="Toggle Dark/Light Mode" aria-label="Toggle Theme">
          <i class="bi ${isDark ? 'bi-sun-fill text-warning' : 'bi-moon-stars-fill'}"></i>
        </button>
        <button class="btn btn-sm btn-ghost px-2 lang-toggle-btn" onclick="EcoLang.set(EcoLang.get() === 'ar' ? 'en' : 'ar')" title="Switch Language (English / العربية)" aria-label="Switch Language">
          <i class="bi bi-translate me-1"></i> <span class="current-lang-text">${langText}</span>
        </button>
      `;
      container.insertBefore(controls, container.firstChild);
    }
  });
}

// Update unread notification indicators in header/sidebar
function updateNotificationBadges() {
  const currentRole = EcoStore.getCurrentRole();
  const notifs = EcoStore.getNotifications(currentRole);
  const unreadCount = notifs.filter(n => !n.read).length;

  document.querySelectorAll('.unread-notif-count').forEach(el => {
    el.textContent = unreadCount;
    el.style.display = unreadCount > 0 ? 'inline-block' : 'none';
  });
}

if (typeof window !== 'undefined') {
  window.EcoStore = EcoStore;
  window.EcoTheme = EcoTheme;
  window.EcoLang = EcoLang;
  window.EcoToast = EcoToast;
  window.I18N_DICTIONARY = I18N_DICTIONARY;
}

// Auto-run on DOM Ready
document.addEventListener('DOMContentLoaded', () => {
  EcoStore.init();
  EcoTheme.init();
  // Demo bar removed per user request
  EcoLang.init();
  injectTopbarControls();
  setupMobileSidebar();
  updateNotificationBadges();
});
