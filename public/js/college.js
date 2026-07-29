// College details client controller
(function() {
  const API_BASE = '/api';

  // Extract query parameter '?id='
  function getCollegeIdFromURL() {
    const params = new URLSearchParams(window.location.search);
    return params.get('id');
  }

  // Toast notification helper for details page
  function showDetailsToast(message) {
    const wrapper = document.getElementById('toast-wrapper');
    if (!wrapper) return;

    const toast = document.createElement('div');
    toast.className = 'toast error';
    toast.innerHTML = `
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
      <span>${message}</span>
    `;
    wrapper.appendChild(toast);
    setTimeout(() => {
      toast.remove();
    }, 4500);
  }

  // Generate logo initials background colors deterministically
  function getLogoColorGradient(initials) {
    const colors = [
      'linear-gradient(135deg, #8b5cf6 0%, #06b6d4 100%)',
      'linear-gradient(135deg, #3b82f6 0%, #10b981 100%)',
      'linear-gradient(135deg, #f59e0b 0%, #ec4899 100%)',
      'linear-gradient(135deg, #6366f1 0%, #a855f7 100%)',
      'linear-gradient(135deg, #ec4899 0%, #f43f5e 100%)',
      'linear-gradient(135deg, #14b8a6 0%, #0ea5e9 100%)'
    ];
    let sum = 0;
    for (let i = 0; i < initials.length; i++) {
      sum += initials.charCodeAt(i);
    }
    return colors[sum % colors.length];
  }

  // Indian Rupee currency format (e.g. ₹1,50,000)
  function formatRupees(amount) {
    if (!amount || amount === 0) return '—';
    return new Intl.NumberFormat('en-IN', {
      style: 'currency',
      currency: 'INR',
      maximumFractionDigits: 0
    }).format(amount);
  }

  // Render stream badge pills
  function renderStreamBadges(streamsStr, container) {
    if (!streamsStr || !container) return;
    const streams = streamsStr.split(',').map(s => s.trim()).filter(s => s);
    if (streams.length === 0) return;

    const STREAM_COLORS = {
      'Engineering': '#3b82f6', 'Computer Science': '#6366f1',
      'Information Technology': '#8b5cf6', 'Artificial Intelligence': '#f59e0b',
      'Data Science': '#10b981', 'Cyber Security': '#ef4444',
      'Management': '#f97316', 'Medical': '#10b981',
      'Pharmacy': '#22c55e', 'Nursing': '#ec4899',
      'Law': '#d97706', 'Architecture': '#7c3aed',
      'Agriculture': '#16a34a', 'Commerce': '#0ea5e9',
      'Arts': '#a855f7', 'Science': '#06b6d4',
      'Design': '#f97316', 'Fine Arts': '#ec4899',
      'Hotel Management': '#d97706', 'Education': '#2563eb',
      'Polytechnic': '#64748b', 'Ayurveda': '#65a30d',
      'Homeopathy': '#65a30d', 'Unani': '#65a30d',
    };

    container.innerHTML = streams.map(s => {
      const color = STREAM_COLORS[s] || '#6366f1';
      return `<span class="stream-pill" style="background:${color}20;color:${color};border:1px solid ${color}40;">${s}</span>`;
    }).join('');
  }

  // Render approval badges
  function renderApprovalBadges(approvalsStr, container) {
    if (!approvalsStr || !container) return;
    const approvals = approvalsStr.split(',').map(a => a.trim()).filter(a => a);
    if (approvals.length === 0) return;

    const APPROVAL_COLORS = {
      'AICTE': '#3b82f6', 'NAAC': '#10b981', 'NBA': '#6366f1',
      'NMC': '#ef4444', 'BCI': '#d97706', 'PCI': '#22c55e',
      'INC': '#ec4899', 'COA': '#7c3aed', 'ICAR': '#16a34a',
      'DCI': '#f97316', 'NCHMCT': '#d97706', 'UGC': '#0ea5e9',
      'VCI': '#65a30d', 'CCRH': '#65a30d', 'AACSB': '#6366f1',
      'AMBA': '#8b5cf6',
    };

    container.innerHTML = approvals.map(a => {
      const color = APPROVAL_COLORS[a] || '#64748b';
      return `<span class="approval-badge" style="background:${color}15;color:${color};border:1px solid ${color}35;">${a}</span>`;
    }).join('');
    container.style.display = 'flex';
    container.style.flexWrap = 'wrap';
    container.style.gap = '0.4rem';
  }

  // Load and populate college data
  async function loadCollegeDetails() {
    const id       = getCollegeIdFromURL();
    const loader   = document.getElementById('detail-card-loader');
    const mainCard = document.getElementById('detail-main-card');
    const bodyGrid = document.getElementById('detail-body-grid');

    if (!id) {
      showDetailsToast('Institution ID missing. Redirecting...');
      setTimeout(() => { window.location.href = 'index.html'; }, 3000);
      return;
    }

    try {
      const res = await fetch(`${API_BASE}/colleges/${id}`);
      if (!res.ok) {
        if (res.status === 404) {
          throw new Error('Institution profile does not exist.');
        } else {
          throw new Error('Could not fetch institution details.');
        }
      }
      const college = await res.json();
      
      // Element references
      const elLogo        = document.getElementById('col-detail-logo');
      const elName        = document.getElementById('col-detail-name');
      const elUniversity  = document.getElementById('col-detail-university');
      const elLocation    = document.getElementById('col-detail-location');
      const elEstd        = document.getElementById('col-detail-estd');
      const elEstdCont    = document.getElementById('col-detail-estd-container');
      const elNaac        = document.getElementById('col-detail-naac');
      const elType        = document.getElementById('col-detail-type');
      const elInstType    = document.getElementById('col-detail-inst-type');
      const elAicte       = document.getElementById('col-detail-aicte');
      const elApprovalsRow= document.getElementById('col-detail-approvals-row');
      const elDesc        = document.getElementById('col-detail-desc');
      const elAddress     = document.getElementById('col-detail-address');
      const elPincode     = document.getElementById('col-detail-pincode');
      const elPhone       = document.getElementById('col-detail-phone');
      const elEmail       = document.getElementById('col-detail-email');
      const elWebsite     = document.getElementById('col-detail-website');

      const elSidebarNaac      = document.getElementById('sidebar-naac');
      const elSidebarOwnership = document.getElementById('sidebar-ownership');
      const elSidebarEstd      = document.getElementById('sidebar-estd');
      const elSidebarAicte     = document.getElementById('sidebar-aicte');
      const elSidebarApprSect  = document.getElementById('sidebar-approvals-section');
      const elSidebarApprBadges= document.getElementById('sidebar-approvals-badges');
      const coursesTbody       = document.getElementById('col-detail-courses-tbody');

      // Streams panel
      const streamsPanel     = document.getElementById('streams-panel');
      const streamsContainer = document.getElementById('col-detail-streams-list');

      // 1. Main Header
      const initials = college.logo || college.college_name.split(' ').map(n => n[0]).join('').substring(0, 4).toUpperCase();
      elLogo.textContent  = initials;
      elLogo.style.background = getLogoColorGradient(initials);
      elName.textContent  = college.college_name;
      elUniversity.textContent = college.university === 'Autonomous'
        ? 'Autonomous Institution'
        : `Affiliated to ${college.university}`;
      elLocation.textContent = `${college.city}, ${college.state}`;

      // Established Year
      if (college.established_year && elEstd && elEstdCont) {
        elEstd.textContent = `Est. ${college.established_year}`;
        elEstdCont.style.display = 'flex';
      }

      // Main badges
      elNaac.textContent = `NAAC: ${college.naac_grade || 'N/A'}`;
      elType.textContent = `${college.ownership || college.college_type} Institution`;
      if (college.institution_type && elInstType) {
        elInstType.textContent = college.institution_type;
        elInstType.style.display = 'inline-flex';
      }
      elAicte.textContent = college.aicte_approved ? 'AICTE Approved' : 'Non-AICTE';

      // Approval badges row in header
      if (college.approvals && elApprovalsRow) {
        renderApprovalBadges(college.approvals, elApprovalsRow);
      }

      // 2. Sidebar stats
      if (elSidebarNaac)      elSidebarNaac.textContent      = college.naac_grade || 'N/A';
      if (elSidebarOwnership) elSidebarOwnership.textContent = college.ownership || college.college_type || '—';
      if (elSidebarEstd)      elSidebarEstd.textContent      = college.established_year || '—';
      if (elSidebarAicte)     elSidebarAicte.textContent     = college.aicte_approved ? 'Approved' : 'N/A';

      // Sidebar approval badges
      if (college.approvals && elSidebarApprBadges && elSidebarApprSect) {
        renderApprovalBadges(college.approvals, elSidebarApprBadges);
        elSidebarApprSect.style.display = 'block';
      }

      // 3. Description
      elDesc.textContent = college.description || 'No description available for this institution.';

      // 4. Streams offered panel
      if (college.streams && streamsPanel && streamsContainer) {
        const streamsArr = college.streams.split(',').map(s => s.trim()).filter(s => s);
        if (streamsArr.length > 0) {
          streamsPanel.style.display = 'block';
          renderStreamBadges(college.streams, streamsContainer);
        }
      }

      // 5. Contact details
      elAddress.textContent = college.address || 'N/A';
      if (college.pincode && elPincode) {
        elPincode.textContent = `PIN: ${college.pincode}`;
      }
      elPhone.textContent = college.phone || 'N/A';
      elEmail.textContent = college.email || 'N/A';
      elWebsite.textContent = college.website
        ? college.website.replace(/^https?:\/\/(www\.)?/, '')
        : 'Visit Site';
      elWebsite.href = college.website || '#';

      // 6. Courses table
      if (college.courses && college.courses.length > 0) {
        coursesTbody.innerHTML = college.courses.map(course => {
          const streamColor = '#6366f1';
          return `
            <tr>
              <td><strong>${course.course_name}</strong></td>
              <td><span class="stream-pill it">${course.stream}</span></td>
              <td><span class="duration-value">${course.duration}</span></td>
              <td><span class="fee-value">${formatRupees(course.fees)}</span> <span style="font-size: 0.8rem; color: var(--text-muted);">/ Year</span></td>
              <td>${course.eligibility}</td>
            </tr>
          `;
        }).join('');
      } else {
        coursesTbody.innerHTML = `
          <tr>
            <td colspan="5" style="text-align: center; padding: 2rem; color: var(--text-muted);">
              No course information available at this time.
            </td>
          </tr>
        `;
      }

      // Hide Loader & Show content cards
      if (loader)   loader.style.display   = 'none';
      if (mainCard) mainCard.style.display  = 'flex';
      if (bodyGrid) bodyGrid.style.display  = 'grid';

      // Set Document Title
      document.title = `${college.college_name} | EduQuest`;

    } catch (error) {
      console.error('Error fetching college details:', error);
      if (loader) loader.style.display = 'none';
      showDetailsToast(error.message || 'Server connection error. Redirecting...');
      setTimeout(() => { window.location.href = 'index.html'; }, 3500);
    }
  }

  // Handle sticky header scroll effect for details page
  window.addEventListener('scroll', () => {
    const header = document.getElementById('main-header');
    if (header) {
      if (window.scrollY > 50) {
        header.classList.add('scrolled');
      } else {
        header.classList.remove('scrolled');
      }
    }
  });

  // Run on load
  document.addEventListener('DOMContentLoaded', loadCollegeDetails);
})();
