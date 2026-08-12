// Global shared variables and helpers
const API_BASE = '/api';

// Stream → color class map for variety in course cards
const STREAM_COLORS = {
  'Engineering':          'linear-gradient(135deg,#3b82f6,#06b6d4)',
  'Computer Science':     'linear-gradient(135deg,#6366f1,#8b5cf6)',
  'Information Technology':'linear-gradient(135deg,#8b5cf6,#06b6d4)',
  'Artificial Intelligence':'linear-gradient(135deg,#f59e0b,#ef4444)',
  'Data Science':         'linear-gradient(135deg,#10b981,#3b82f6)',
  'Cyber Security':       'linear-gradient(135deg,#ef4444,#f43f5e)',
  'Management':           'linear-gradient(135deg,#f59e0b,#ec4899)',
  'Medical':              'linear-gradient(135deg,#10b981,#14b8a6)',
  'Pharmacy':             'linear-gradient(135deg,#22c55e,#16a34a)',
  'Nursing':              'linear-gradient(135deg,#ec4899,#f43f5e)',
  'Law':                  'linear-gradient(135deg,#8b4513,#d97706)',
  'Architecture':         'linear-gradient(135deg,#7c3aed,#4f46e5)',
  'Agriculture':          'linear-gradient(135deg,#16a34a,#4ade80)',
  'Commerce':             'linear-gradient(135deg,#0ea5e9,#6366f1)',
  'Arts':                 'linear-gradient(135deg,#ec4899,#a855f7)',
  'Science':              'linear-gradient(135deg,#06b6d4,#3b82f6)',
  'Design':               'linear-gradient(135deg,#f97316,#ec4899)',
  'Fine Arts':            'linear-gradient(135deg,#a855f7,#ec4899)',
  'Hotel Management':     'linear-gradient(135deg,#d97706,#f59e0b)',
  'Education':            'linear-gradient(135deg,#2563eb,#0ea5e9)',
  'Polytechnic':          'linear-gradient(135deg,#64748b,#94a3b8)',
  'Aviation':             'linear-gradient(135deg,#0284c7,#0ea5e9)',
  'Animation':            'linear-gradient(135deg,#7c3aed,#ec4899)',
  'Ayurveda':             'linear-gradient(135deg,#65a30d,#22c55e)',
  'Mass Media':           'linear-gradient(135deg,#f43f5e,#f97316)',
  'Paramedical':          'linear-gradient(135deg,#14b8a6,#06b6d4)',
};

// Handle sticky header scroll effect
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

// Toast notification helper
function showToast(message, type = 'error') {
  const wrapper = document.getElementById('toast-wrapper');
  if (!wrapper) return;

  const toast = document.createElement('div');
  toast.className = `toast ${type}`;
  toast.innerHTML = `
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
    <span>${message}</span>
  `;
  wrapper.appendChild(toast);

  // Auto-remove after 4 seconds
  setTimeout(() => {
    toast.style.animation = 'slideUp 0.3s forwards reverse cubic-bezier(0.4, 0, 0.2, 1)';
    toast.addEventListener('animationend', () => {
      toast.remove();
    });
  }, 4000);
}

// Generate logo initials background colors deterministically based on name
function getLogoColorClass(initials) {
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

// Helper to compile a HTML college card
function renderCollegeCard(college) {
  const initials = college.logo || college.college_name.split(' ').map(n => n[0]).join('').substring(0, 4).toUpperCase();
  const bgGradient = getLogoColorClass(initials);

  // Determine display type label
  const typeLabel = college.institution_type || college.college_type || 'Institution';
  const ownershipLabel = college.ownership || college.college_type || '';

  let name = (college.college_name || '').trim();
  let rawWeb = college.website ? college.website.trim() : '';

  // Vidyalankar Polytechnic explicit guard
  if (name.toLowerCase().includes('vidyalankar polytechnic') && (rawWeb.includes('vpmthane') || !rawWeb || rawWeb === 'N/A')) {
    rawWeb = 'https://vpt.edu.in';
  }

  let websiteUrl = '#';
  if (rawWeb && rawWeb !== 'N/A' && rawWeb !== '#' && rawWeb !== 'undefined' && rawWeb !== 'null') {
    websiteUrl = /^https?:\/\//i.test(rawWeb) ? rawWeb : `https://${rawWeb}`;
  } else {
    websiteUrl = `https://www.google.com/search?q=${encodeURIComponent(name + ' official website')}`;
  }

  return `
    <article class="college-card">
      <div class="card-header">
        <div class="college-logo-placeholder" style="background: ${bgGradient}">
          ${initials}
        </div>
        <div class="college-basic-info">
          <h3 class="college-title">${college.college_name}</h3>
          <span class="college-location">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2a8 8 0 0 0-8 8c0 5.25 8 12 8 12s8-6.75 8-12a8 8 0 0 0-8-8z"></path><circle cx="12" cy="10" r="3"></circle></svg>
            ${college.city}, ${college.state}
          </span>
        </div>
      </div>
      <div class="card-body">
        <p class="college-desc-snippet">${college.description || 'No description available.'}</p>
        <div class="college-tags">
          <span class="tag-badge naac">NAAC: ${college.naac_grade || 'N/A'}</span>
          <span class="tag-badge type">${typeLabel}</span>
          <span class="tag-badge approved">${ownershipLabel}</span>
        </div>
      </div>
      <div class="card-footer">
        <a href="${websiteUrl}" target="_blank" rel="noopener noreferrer" class="college-website-link">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
          Visit Site
        </a>
        <button class="btn-details" onclick="viewCollegeDetails(${college.id})">View Details</button>
      </div>
    </article>
  `;
}

// Redirect helper to view details page
function viewCollegeDetails(id) {
  window.location.href = `college.html?id=${id}`;
}

// Animating stats count-up
function animateCountUp(element, target, duration = 1500) {
  let start = 0;
  const stepTime = Math.abs(Math.floor(duration / target));
  
  if (target <= 0) {
    element.textContent = target;
    return;
  }

  const timer = setInterval(() => {
    start += Math.max(1, Math.floor(target / 100));
    element.textContent = start;
    if (start >= target) {
      element.textContent = target;
      clearInterval(timer);
    }
  }, Math.max(stepTime, 15));
}

function formatStatValue(key, value) {
  if (key === 'colleges' && value >= 300) return '300+';
  if (key === 'courses'  && value >= 60)  return '60+';
  return `${value}`;
}

// Fetch dashboard statistical metrics
async function loadStats() {
  const statColleges = document.getElementById('stat-colleges');
  const statCourses  = document.getElementById('stat-courses');
  const statStates   = document.getElementById('stat-states');
  
  if (!statColleges || !statCourses || !statStates) return;

  try {
    const res = await fetch(`${API_BASE}/stats`);
    if (!res.ok) throw new Error('Stats retrieval failed');
    const data = await res.json();
    
    const collegesText = formatStatValue('colleges', data.colleges);
    const coursesText  = formatStatValue('courses', data.courses);
    const statesText   = formatStatValue('states', data.states);

    if (collegesText === `${data.colleges}`) {
      animateCountUp(statColleges, data.colleges);
    } else {
      statColleges.textContent = collegesText;
    }

    if (coursesText === `${data.courses}`) {
      animateCountUp(statCourses, data.courses);
    } else {
      statCourses.textContent = coursesText;
    }

    if (statesText === `${data.states}`) {
      animateCountUp(statStates, data.states);
    } else {
      statStates.textContent = statesText;
    }

    setHeroMetrics(data);
  } catch (error) {
    console.error('Stats load error:', error);
    statColleges.textContent = '0';
    statCourses.textContent  = '0';
    statStates.textContent   = '0';
  }
}

function setHeroMetrics(stats) {
  const heroColleges = document.getElementById('hero-colleges-count');
  const heroCourses  = document.getElementById('hero-courses-count');
  const heroStates   = document.getElementById('hero-states-count');
  const heroBadge    = document.getElementById('hero-feature-badge');

  if (heroColleges) heroColleges.textContent = formatStatValue('colleges', stats.colleges);
  if (heroCourses) heroCourses.textContent  = formatStatValue('courses', stats.courses);
  if (heroStates) heroStates.textContent   = formatStatValue('states', stats.states);
  if (heroBadge) {
    heroBadge.textContent = stats.colleges >= 300 ? '300+ Colleges' : `${stats.colleges} Colleges`;
  }
}

// Fetch and populate filter dropdowns
async function loadFilters() {
  try {
    const res = await fetch(`${API_BASE}/filters`);
    if (!res.ok) throw new Error('Filters load failed');
    const filters = await res.json();

    // Institution Type dropdown
    const typeSelect = document.getElementById('filter-type');
    if (typeSelect && filters.institution_types) {
      filters.institution_types.forEach(t => {
        const opt = document.createElement('option');
        opt.value = t;
        opt.textContent = t;
        typeSelect.appendChild(opt);
      });
    }

    // Stream dropdown
    const streamSelect = document.getElementById('filter-stream');
    if (streamSelect && filters.streams) {
      filters.streams.forEach(s => {
        const opt = document.createElement('option');
        opt.value = s;
        opt.textContent = s;
        streamSelect.appendChild(opt);
      });
    }

    // State dropdown
    const stateSelect = document.getElementById('filter-state');
    if (stateSelect && filters.states) {
      filters.states.forEach(s => {
        const opt = document.createElement('option');
        opt.value = s;
        opt.textContent = s;
        stateSelect.appendChild(opt);
      });
    }

  } catch (error) {
    console.error('Filters load error:', error);
  }
}

// Filters panel toggle
function initFiltersPanel() {
  const toggleBtn  = document.getElementById('filters-toggle-btn');
  const resetBtn   = document.getElementById('filters-reset-btn');
  const filtersGrid = document.getElementById('filters-grid');
  const label      = document.getElementById('filters-toggle-label');

  if (!toggleBtn || !filtersGrid) return;

  toggleBtn.addEventListener('click', () => {
    const isOpen = filtersGrid.style.display !== 'none';
    filtersGrid.style.display = isOpen ? 'none' : 'grid';
    toggleBtn.setAttribute('aria-expanded', String(!isOpen));
    label.textContent = isOpen ? 'Advanced Filters' : 'Hide Filters';
  });

  // Show reset button when any filter changes
  const selects = filtersGrid.querySelectorAll('.filter-select');
  selects.forEach(sel => {
    sel.addEventListener('change', () => {
      const hasActive = [...selects].some(s => s.value !== '');
      if (resetBtn) resetBtn.style.display = hasActive ? 'flex' : 'none';
    });
  });

  // Reset all filters
  if (resetBtn) {
    resetBtn.addEventListener('click', () => {
      selects.forEach(s => { s.value = ''; });
      resetBtn.style.display = 'none';
    });
  }
}

// Fetch and render featured colleges
async function loadFeaturedColleges() {
  const grid   = document.getElementById('featured-colleges-grid');
  const loader = document.getElementById('colleges-loader');
  if (!grid) return;

  try {
    const res = await fetch(`${API_BASE}/colleges`);
    if (!res.ok) throw new Error('Colleges load failed');
    const colleges = await res.json();
    
    // Show top 6 featured
    const featured = colleges.slice(0, 6);
    
    if (loader) loader.style.display = 'none';
    grid.innerHTML = featured.map(col => renderCollegeCard(col)).join('');
    renderTopColleges(colleges);
  } catch (error) {
    console.error('Featured colleges load error:', error);
    if (loader) loader.style.display = 'none';
    grid.innerHTML = `
      <div class="no-results-panel">
        <div class="no-results-title">Failed to load institutions</div>
        <p class="no-results-desc">Could not connect to the server database. Please ensure the backend is running.</p>
      </div>
    `;
    renderTopColleges([]);
    showToast('Failed to load featured institutions. Check connection.');
  }
}

// Fetch and render top courses block
async function loadTopCourses() {
  const grid   = document.getElementById('courses-list-grid');
  const loader = document.getElementById('courses-loader');
  if (!grid) return;

  try {
    const res = await fetch(`${API_BASE}/courses`);
    if (!res.ok) throw new Error('Courses load failed');
    const courses = await res.json();
    
    if (loader) loader.style.display = 'none';
    grid.innerHTML = courses.map(course => {
      const gradient = STREAM_COLORS[course.stream] || 'linear-gradient(135deg,#6366f1,#8b5cf6)';
      return `
        <div class="course-card" onclick="searchByStream('${course.stream}')" style="cursor: pointer;">
          <span class="course-stream-badge" style="background:${gradient};color:#fff;">${course.stream}</span>
          <h3 class="course-title">${course.course_name}</h3>
          <div class="course-meta">
            <span>Duration: <strong class="duration-value">${course.duration}</strong></span>
          </div>
        </div>
      `;
    }).join('');
  } catch (error) {
    console.error('Courses load error:', error);
    if (loader) loader.style.display = 'none';
    grid.innerHTML = `<p class="loading-text">Unable to load courses registry.</p>`;
  }
}

// Fetch and render states list
async function loadStatesList() {
  const grid   = document.getElementById('states-list-grid');
  const loader = document.getElementById('states-loader');
  if (!grid) return;

  try {
    const res = await fetch(`${API_BASE}/states`);
    if (!res.ok) throw new Error('States load failed');
    const states = await res.json();
    
    // Get all colleges to count per state
    const collegesRes = await fetch(`${API_BASE}/colleges`);
    const colleges = collegesRes.ok ? await collegesRes.json() : [];
    
    const stateCounts = {};
    colleges.forEach(col => {
      stateCounts[col.state] = (stateCounts[col.state] || 0) + 1;
    });

    if (loader) loader.style.display = 'none';
    grid.innerHTML = states.map(state => {
      const count = stateCounts[state] || 0;
      return `
        <div class="state-item-card" onclick="searchByTerm('${state}')">
          <div class="state-icon-avatar">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2a8 8 0 0 0-8 8c0 5.25 8 12 8 12s8-6.75 8-12a8 8 0 0 0-8-8z"></path><circle cx="12" cy="10" r="3"></circle></svg>
          </div>
          <h3 class="state-item-name">${state}</h3>
          <span class="state-college-count">${count} ${count === 1 ? 'Institution' : 'Institutions'}</span>
        </div>
      `;
    }).join('');
  } catch (error) {
    console.error('States list load error:', error);
    if (loader) loader.style.display = 'none';
    grid.innerHTML = `<p class="loading-text">Unable to load states catalog.</p>`;
  }
}

function renderTopColleges(colleges) {
  const list = document.getElementById('top-college-list');
  if (!list) return;
  if (!Array.isArray(colleges) || colleges.length === 0) {
    list.innerHTML = `<div class="no-results-panel"><div class="no-results-title">No top institutions available</div></div>`;
    return;
  }

  list.innerHTML = colleges.slice(0, 3).map(college => {
    const initials = (college.logo || college.college_name).split(' ').map(w => w[0]).join('').slice(0, 3).toUpperCase();
    return `
      <article class="top-college-item">
        <div class="top-college-media">${initials}</div>
        <div class="top-college-info">
          <div class="top-college-name">${college.college_name}</div>
          <div class="top-college-meta">${college.city}, ${college.state}</div>
          <div class="top-college-stats"><span>${college.naac_grade || 'N/A'}</span><span>${college.ownership || 'Unknown'}</span></div>
        </div>
        <a href="college.html?id=${college.id}" class="btn btn-secondary btn-sm">View Details</a>
      </article>
    `;
  }).join('');
}

// Expose trigger search by term
window.searchByTerm = function(term) {
  const searchInput = document.getElementById('search-input');
  if (searchInput) {
    searchInput.value = term;
    const searchBtn = document.getElementById('search-btn');
    if (searchBtn) searchBtn.click();
  }
};

// Search by stream (uses filter-stream dropdown if available, else text search)
window.searchByStream = function(stream) {
  const streamSelect = document.getElementById('filter-stream');
  if (streamSelect) {
    // Open filters panel if closed
    const filtersGrid = document.getElementById('filters-grid');
    if (filtersGrid && filtersGrid.style.display === 'none') {
      filtersGrid.style.display = 'grid';
      const label = document.getElementById('filters-toggle-label');
      if (label) label.textContent = 'Hide Filters';
    }
    // Set stream filter
    streamSelect.value = stream;
    // Show reset button
    const resetBtn = document.getElementById('filters-reset-btn');
    if (resetBtn) resetBtn.style.display = 'flex';
  }
  // Trigger search with empty text but stream filter set
  const searchBtn = document.getElementById('search-btn');
  if (searchBtn) searchBtn.click();
};

window.filterByStream = function(stream) {
  window.searchByStream(stream);
};

// Initialize index page elements
document.addEventListener('DOMContentLoaded', () => {
  loadStats();
  loadFilters();
  initFiltersPanel();
  loadFeaturedColleges();
  loadTopCourses();
  loadStatesList();
});
