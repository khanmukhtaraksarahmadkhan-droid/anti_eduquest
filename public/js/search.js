// Search controller module
(function() {
  const searchInput          = document.getElementById('search-input');
  const searchBtn            = document.getElementById('search-btn');
  const suggestionsBox       = document.getElementById('suggestions-box');
  const searchResultsSection = document.getElementById('search-results-section');
  const searchResultsGrid    = document.getElementById('search-results-grid');
  const searchCount          = document.getElementById('search-count');
  const searchLoader         = document.getElementById('search-loader');
  const clearSearchBtn       = document.getElementById('clear-search-btn');
  const topStateSelect       = document.getElementById('search-state');
  const topCourseSelect      = document.getElementById('search-course');
  
  // Normal landing sections to hide/show
  const collegesSection = document.getElementById('colleges');
  const coursesSection  = document.getElementById('courses');
  const statesSection   = document.getElementById('states');

  let debounceTimer;

  if (!searchInput) return;

  // Escape HTML characters
  function escapeHTML(str) {
    if (!str) return '';
    return String(str).replace(/[&<>'"]/g, 
      tag => ({
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        "'": '&#39;',
        '"': '&quot;'
      }[tag] || tag)
    );
  }

  // Collect current dropdown filter values
  function getFilterParams() {
    const state  = topStateSelect ? topStateSelect.value : '';
    const stream = topCourseSelect ? topCourseSelect.value : '';
    return { stream, state };
  }

  // Build query string from search + filter params
  function buildSearchURL(query) {
    const params  = getFilterParams();
    const qs      = new URLSearchParams();
    if (query)          qs.set('q',        query);
    if (params.stream)   qs.set('stream',   params.stream);
    if (params.state)    qs.set('state',    params.state);
    return `/api/search?${qs.toString()}`;
  }

  // Debounced input handler for live suggestions
  searchInput.addEventListener('input', () => {
    clearTimeout(debounceTimer);
    const query = searchInput.value.trim();

    if (query.length < 2) {
      hideSuggestions();
      return;
    }

    debounceTimer = setTimeout(() => {
      fetchSuggestions(query);
    }, 250);
  });

  // Handle clicking search button
  searchBtn.addEventListener('click', () => {
    const query = searchInput.value.trim();
    performSearch(query);
  });

  // Handle pressing Enter in the search input
  searchInput.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
      const query = searchInput.value.trim();
      performSearch(query);
    }
  });

  // Trigger search when top-row dropdowns change
  const filterIds = ['search-state','search-course'];
  filterIds.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener('change', () => {
        const query = searchInput.value.trim();
        performSearch(query, false);
      });
    }
  });

  // Close suggestions drawer when clicking outside
  document.addEventListener('click', (e) => {
    if (e.target !== searchInput && e.target !== suggestionsBox) {
      hideSuggestions();
    }
  });

  // Reset search UI back to home sections
  function restoreLandingSections() {
    searchInput.value = '';
    hideSuggestions();
    
    // Reset top-row selects
    filterIds.forEach(id => {
      const el = document.getElementById(id);
      if (el) el.value = '';
    });
    
    // Toggle visibility back to landing
    searchResultsSection.style.display = 'none';
    if (collegesSection) collegesSection.style.display = 'block';
    if (coursesSection)  coursesSection.style.display  = 'block';
    if (statesSection)   statesSection.style.display   = 'block';

    // Clear URL parameters
    if (window.history && window.history.pushState) {
      window.history.pushState(null, '', window.location.pathname);
    }
  }

  if (clearSearchBtn) {
    clearSearchBtn.addEventListener('click', (e) => {
      e.preventDefault();
      restoreLandingSections();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // Handle navbar anchor link clicks: if search view is active, restore landing sections & scroll cleanly
  const navLinkIds = ['link-home', 'link-colleges', 'id-link-courses', 'link-states'];
  navLinkIds.forEach(id => {
    const linkEl = document.getElementById(id);
    if (linkEl) {
      linkEl.addEventListener('click', (e) => {
        // If we are on index.html and search results section is open
        if (searchResultsSection && searchResultsSection.style.display !== 'none') {
          restoreLandingSections();
        }
      });
    }
  });

  // Fetch match recommendations from server
  async function fetchSuggestions(query) {
    try {
      const params = new URLSearchParams();
      if (query) params.set('q', query);
      const topState = topStateSelect ? topStateSelect.value : '';
      if (topState) params.set('state', topState);
      const topCourse = topCourseSelect ? topCourseSelect.value : '';
      if (topCourse) params.set('stream', topCourse);
      const url = `/api/search?${params.toString()}`;
      const res = await fetch(url);
      if (!res.ok) throw new Error('Search failed');
      const matches = await res.json();
      renderSuggestions(matches, query);
    } catch (err) {
      console.error('Suggestions error:', err);
    }
  }

  // Render suggestion entries
  function renderSuggestions(matches, query) {
    if (!suggestionsBox) return;
    if (matches.length === 0) {
      hideSuggestions();
      return;
    }

    const topMatches = matches.slice(0, 6);
    
    suggestionsBox.innerHTML = topMatches.map(match => {
      const reg = new RegExp(`(${query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')})`, 'gi');
      const highlightedName     = match.college_name.replace(reg, '<strong>$1</strong>');
      const highlightedCityState = `${match.city}, ${match.state}`.replace(reg, '<strong>$1</strong>');
      const typeLabel = match.institution_type || match.college_type || 'Institution';
      
      return `
        <div class="suggestion-item" data-id="${match.id}" data-name="${match.college_name}">
          <div class="suggestion-icon">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 10v6M2 10l10-5 10 5-10 5z"></path><path d="M6 12v5c0 2 2 3 6 3s6-1 6-3v-5"></path></svg>
          </div>
          <div class="suggestion-details">
            <span class="suggestion-title">${highlightedName}</span>
            <span class="suggestion-subtitle">${highlightedCityState}</span>
          </div>
          <span class="suggestion-badge">${typeLabel}</span>
        </div>
      `;
    }).join('');

    suggestionsBox.classList.add('active');

    // Add click listeners
    suggestionsBox.querySelectorAll('.suggestion-item').forEach(item => {
      item.addEventListener('click', () => {
        const id = item.getAttribute('data-id');
        window.location.href = `college.html?id=${id}`;
      });
    });
  }

  function hideSuggestions() {
    if (!suggestionsBox) return;
    suggestionsBox.classList.remove('active');
    suggestionsBox.innerHTML = '';
  }

  // Set section titles for search/filter mode
  function setSearchHeader(titleHTML, subtitleText) {
    const titleEl = document.getElementById('search-results-title');
    const subEl   = document.getElementById('search-results-subtitle');
    if (titleEl && titleHTML) titleEl.innerHTML = titleHTML;
    if (subEl && subtitleText) subEl.innerHTML = subtitleText;
  }

  // Execute general text search
  async function performSearch(query, requireInput = true) {
    hideSuggestions();
    
    const params = getFilterParams();
    const hasFilters = Object.values(params).some(v => v !== '');
    
    if (requireInput && !query && !hasFilters) {
      showToast('Please type a search query or apply a filter first.');
      return;
    }

    // Hide Landing Sections & Show Search Grid
    if (collegesSection) collegesSection.style.display = 'none';
    if (coursesSection)  coursesSection.style.display  = 'none';
    if (statesSection)   statesSection.style.display   = 'none';
    
    searchResultsSection.style.display = 'block';
    searchLoader.style.display         = 'flex';
    searchResultsGrid.innerHTML        = '';
    
    setSearchHeader(
      `Search <span>Results</span>`,
      `Found <span id="search-count" style="color: var(--secondary); font-weight: bold;">0</span> matching institutions`
    );

    searchResultsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });

    try {
      const url = buildSearchURL(query);
      const res = await fetch(url);
      if (!res.ok) throw new Error('Search request failed');
      const results = await res.json();
      
      searchLoader.style.display = 'none';
      const countEl = document.getElementById('search-count');
      if (countEl) countEl.textContent = results.length;

      if (results.length === 0) {
        searchResultsGrid.innerHTML = `
          <div class="no-results-panel">
            <div class="no-results-icon">🔍</div>
            <div class="no-results-title">No Institutions Found</div>
            <p class="no-results-desc">We couldn't find any institution matching your search criteria. Try adjusting your filters or search for a different term.</p>
          </div>
        `;
        return;
      }

      searchResultsGrid.innerHTML = results.map(col => renderCollegeCard(col)).join('');
    } catch (error) {
      console.error('Search error:', error);
      searchLoader.style.display = 'none';
      searchResultsGrid.innerHTML = `
        <div class="no-results-panel">
          <div class="no-results-title">Search Error</div>
          <p class="no-results-desc">An error occurred while fetching search results. Please verify your connection.</p>
        </div>
      `;
      showToast('Search request failed. Verify server status.');
    }
  }

  // Filter directly by Course (independent of search bar text)
  window.filterByCourse = async function(courseId, courseName) {
    hideSuggestions();

    // Sync top-row select if matching option exists
    if (topCourseSelect && courseName) {
      const matchOpt = [...topCourseSelect.options].find(o => o.text.toLowerCase().includes(courseName.toLowerCase()) || courseName.toLowerCase().includes(o.text.toLowerCase()));
      if (matchOpt) topCourseSelect.value = matchOpt.value;
    }

    const stateParam = topStateSelect ? topStateSelect.value : '';

    // Update URL query parameters cleanly
    const urlParams = new URLSearchParams();
    if (courseId) urlParams.set('courseId', courseId);
    if (courseName) urlParams.set('course', courseName);
    if (stateParam) urlParams.set('state', stateParam);

    if (window.history && window.history.pushState) {
      window.history.pushState(null, '', `?${urlParams.toString()}`);
    }

    // Toggle Landing Sections
    if (collegesSection) collegesSection.style.display = 'none';
    if (coursesSection)  coursesSection.style.display  = 'none';
    if (statesSection)   statesSection.style.display   = 'none';
    
    searchResultsSection.style.display = 'block';
    searchLoader.style.display         = 'flex';
    searchResultsGrid.innerHTML        = '';

    const label = courseName || 'Selected Course';
    const stateLabel = stateParam ? ` in ${escapeHTML(stateParam)}` : '';
    setSearchHeader(
      `Colleges Offering: <span>${escapeHTML(label)}</span>${escapeHTML(stateLabel)}`,
      `Found <span id="search-count" style="color: var(--secondary); font-weight: bold;">0</span> matching institutions`
    );

    searchResultsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });

    try {
      const apiParams = new URLSearchParams();
      if (courseId) apiParams.set('courseId', courseId);
      if (courseName) apiParams.set('course', courseName);
      if (stateParam) apiParams.set('state', stateParam);

      const res = await fetch(`/api/search?${apiParams.toString()}`);
      if (!res.ok) throw new Error('Course search failed');
      const results = await res.json();

      searchLoader.style.display = 'none';
      const countEl = document.getElementById('search-count');
      if (countEl) countEl.textContent = results.length;

      if (results.length === 0) {
        searchResultsGrid.innerHTML = `
          <div class="no-results-panel">
            <div class="no-results-icon">🎓</div>
            <div class="no-results-title">No Colleges Found</div>
            <p class="no-results-desc">We couldn't find colleges offering <strong>${escapeHTML(label)}</strong>${escapeHTML(stateLabel)} with the selected filters. Try another course or state.</p>
          </div>
        `;
        return;
      }

      searchResultsGrid.innerHTML = results.map(col => renderCollegeCard(col)).join('');
    } catch (err) {
      console.error('Course filter error:', err);
      searchLoader.style.display = 'none';
      searchResultsGrid.innerHTML = `
        <div class="no-results-panel">
          <div class="no-results-title">Filter Error</div>
          <p class="no-results-desc">Unable to load colleges for this course. Please try again.</p>
        </div>
      `;
    }
  };

  // Filter directly by State (independent of search bar text)
  window.filterByState = async function(stateName) {
    hideSuggestions();

    if (topStateSelect && stateName) {
      topStateSelect.value = stateName;
    }

    const courseParam = topCourseSelect ? topCourseSelect.value : '';

    const urlParams = new URLSearchParams();
    if (stateName) urlParams.set('state', stateName);
    if (courseParam) urlParams.set('stream', courseParam);

    if (window.history && window.history.pushState) {
      window.history.pushState(null, '', `?${urlParams.toString()}`);
    }

    if (collegesSection) collegesSection.style.display = 'none';
    if (coursesSection)  coursesSection.style.display  = 'none';
    if (statesSection)   statesSection.style.display   = 'none';

    searchResultsSection.style.display = 'block';
    searchLoader.style.display         = 'flex';
    searchResultsGrid.innerHTML        = '';

    setSearchHeader(
      `Top Colleges in <span>${escapeHTML(stateName)}</span>`,
      `Found <span id="search-count" style="color: var(--secondary); font-weight: bold;">0</span> matching institutions`
    );

    searchResultsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });

    try {
      const apiParams = new URLSearchParams();
      if (stateName) apiParams.set('state', stateName);
      if (courseParam) apiParams.set('stream', courseParam);

      const res = await fetch(`/api/search?${apiParams.toString()}`);
      if (!res.ok) throw new Error('State search failed');
      const results = await res.json();

      searchLoader.style.display = 'none';
      const countEl = document.getElementById('search-count');
      if (countEl) countEl.textContent = results.length;

      if (results.length === 0) {
        searchResultsGrid.innerHTML = `
          <div class="no-results-panel">
            <div class="no-results-icon">📍</div>
            <div class="no-results-title">No Institutions Found</div>
            <p class="no-results-desc">We couldn't find colleges in <strong>${escapeHTML(stateName)}</strong> matching your filters. Try selecting a different state.</p>
          </div>
        `;
        return;
      }

      searchResultsGrid.innerHTML = results.map(col => renderCollegeCard(col)).join('');
    } catch (err) {
      console.error('State filter error:', err);
      searchLoader.style.display = 'none';
      searchResultsGrid.innerHTML = `
        <div class="no-results-panel">
          <div class="no-results-title">Filter Error</div>
          <p class="no-results-desc">Unable to load colleges for this state. Please try again.</p>
        </div>
      `;
    }
  };

  // Check URL query parameters on page load to support shareable deep links (e.g. ?courseId=3 or ?state=Maharashtra)
  function handleInitialURLParams() {
    const urlParams = new URLSearchParams(window.location.search);
    const courseId   = urlParams.get('courseId');
    const courseName = urlParams.get('course') || urlParams.get('courseName');
    const stateName  = urlParams.get('state');
    const query      = urlParams.get('q');

    if (courseId || courseName) {
      window.filterByCourse(courseId, courseName);
    } else if (stateName) {
      window.filterByState(stateName);
    } else if (query) {
      searchInput.value = query;
      performSearch(query, false);
    }
  }

  document.addEventListener('DOMContentLoaded', handleInitialURLParams);
})();
