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
  
  // Normal landing sections to hide/show
  const collegesSection = document.getElementById('colleges');
  const coursesSection  = document.getElementById('courses');
  const statesSection   = document.getElementById('states');

  let debounceTimer;

  if (!searchInput) return;

  // Collect current filter values
  function getFilterParams() {
    const type      = document.getElementById('filter-type')      ? document.getElementById('filter-type').value      : '';
    const stream    = document.getElementById('filter-stream')    ? document.getElementById('filter-stream').value    : '';
    const state     = document.getElementById('filter-state')     ? document.getElementById('filter-state').value     : '';
    const ownership = document.getElementById('filter-ownership') ? document.getElementById('filter-ownership').value : '';
    const naac      = document.getElementById('filter-naac')      ? document.getElementById('filter-naac').value      : '';
    const approval  = document.getElementById('filter-approval')  ? document.getElementById('filter-approval').value  : '';
    return { type, stream, state, ownership, naac, approval };
  }

  // Build query string from search + filter params
  function buildSearchURL(query) {
    const params  = getFilterParams();
    const qs      = new URLSearchParams();
    if (query)          qs.set('q',        query);
    if (params.type)     qs.set('type',     params.type);
    if (params.stream)   qs.set('stream',   params.stream);
    if (params.state)    qs.set('state',    params.state);
    if (params.ownership)qs.set('ownership',params.ownership);
    if (params.naac)     qs.set('naac',     params.naac);
    if (params.approval) qs.set('approval', params.approval);
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

  // Trigger search when filter dropdowns change
  const filterIds = ['filter-type','filter-stream','filter-state','filter-ownership','filter-naac','filter-approval'];
  filterIds.forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener('change', () => {
        const query = searchInput.value.trim();
        performSearch(query);
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
  if (clearSearchBtn) {
    clearSearchBtn.addEventListener('click', (e) => {
      e.preventDefault();
      searchInput.value = '';
      hideSuggestions();
      
      // Reset filters
      filterIds.forEach(id => {
        const el = document.getElementById(id);
        if (el) el.value = '';
      });
      const resetBtn = document.getElementById('filters-reset-btn');
      if (resetBtn) resetBtn.style.display = 'none';
      
      // Toggle visibility
      searchResultsSection.style.display = 'none';
      if (collegesSection) collegesSection.style.display = 'block';
      if (coursesSection)  coursesSection.style.display  = 'block';
      if (statesSection)   statesSection.style.display   = 'block';
      
      // Scroll to top smoothly
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  // Fetch match recommendations from server
  async function fetchSuggestions(query) {
    try {
      const url = `/api/search?q=${encodeURIComponent(query)}`;
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
    suggestionsBox.classList.remove('active');
    suggestionsBox.innerHTML = '';
  }

  // Run full search listing query
  async function performSearch(query) {
    hideSuggestions();
    
    const params = getFilterParams();
    const hasFilters = Object.values(params).some(v => v !== '');
    
    if (!query && !hasFilters) {
      showToast('Please type a search query or apply a filter first.');
      return;
    }

    // Toggle Landing Sections
    if (collegesSection) collegesSection.style.display = 'none';
    if (coursesSection)  coursesSection.style.display  = 'none';
    if (statesSection)   statesSection.style.display   = 'none';
    
    searchResultsSection.style.display = 'block';
    searchLoader.style.display         = 'flex';
    searchResultsGrid.innerHTML        = '';
    
    searchResultsSection.scrollIntoView({ behavior: 'smooth', block: 'start' });

    try {
      const url = buildSearchURL(query);
      const res = await fetch(url);
      if (!res.ok) throw new Error('Search request failed');
      const results = await res.json();
      
      searchLoader.style.display = 'none';
      searchCount.textContent    = results.length;

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

      // Render cards using helper from app.js
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

  // Escape HTML characters
  function escapeHTML(str) {
    return str.replace(/[&<>'"]/g, 
      tag => ({
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        "'": '&#39;',
        '"': '&quot;'
      }[tag] || tag)
    );
  }
})();
