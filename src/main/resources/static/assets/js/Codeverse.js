/* ============================================================
   CODEVERSE — Global JavaScript  v2.0
   Place at: src/main/resources/static/assets/js/codeverse.js
   ============================================================ */

(function () {
  'use strict';

  /* ── 1. SIDEBAR TOGGLE ─────────────────────────────────────
     Handles desktop collapse and mobile drawer open/close
  ──────────────────────────────────────────────────────────── */
  function initSidebar() {
    const sidebar  = document.getElementById('cvSidebar');
    const overlay  = document.getElementById('cvSidebarOverlay');
    const toggles  = document.querySelectorAll('[data-cv-sidebar-toggle]');
    if (!sidebar) return;

    const COLLAPSED_KEY = 'cv_sidebar_collapsed';
    const isMobile = () => window.innerWidth < 992;

    // Restore desktop collapsed state from localStorage
    if (!isMobile() && localStorage.getItem(COLLAPSED_KEY) === '1') {
      sidebar.classList.add('collapsed');
      document.body.classList.add('sidebar-collapsed');
    }

    toggles.forEach(btn => {
      btn.addEventListener('click', () => {
        if (isMobile()) {
          // Mobile: slide drawer
          const open = sidebar.classList.toggle('mobile-open');
          if (overlay) overlay.classList.toggle('active', open);
        } else {
          // Desktop: collapse/expand
          const collapsed = sidebar.classList.toggle('collapsed');
          document.body.classList.toggle('sidebar-collapsed', collapsed);
          localStorage.setItem(COLLAPSED_KEY, collapsed ? '1' : '0');
        }
      });
    });

    // Close mobile sidebar on overlay click
    if (overlay) {
      overlay.addEventListener('click', () => {
        sidebar.classList.remove('mobile-open');
        overlay.classList.remove('active');
      });
    }

    // Close mobile sidebar on window resize to desktop
    window.addEventListener('resize', () => {
      if (!isMobile()) {
        sidebar.classList.remove('mobile-open');
        if (overlay) overlay.classList.remove('active');
      }
    });
  }


  /* ── 2. ACTIVE NAV LINK ────────────────────────────────────
     Auto-marks the current page's sidebar link as active
     based on data-cv-page matching body's data-page attribute
  ──────────────────────────────────────────────────────────── */
  function initActiveNav() {
    const currentPage = document.body.dataset.page || '';
    if (!currentPage) return;

    document.querySelectorAll('.cv-nav-item[data-page]').forEach(item => {
      item.classList.remove('active');
      if (item.dataset.page === currentPage) {
        item.classList.add('active');
      }
    });
  }


  /* ── 3. AVATAR DROPDOWN ────────────────────────────────────
     Toggle the profile dropdown menu
  ──────────────────────────────────────────────────────────── */
  function initDropdown() {
    document.querySelectorAll('[data-cv-dropdown]').forEach(trigger => {
      const menuId = trigger.dataset.cvDropdown;
      const menu   = document.getElementById(menuId);
      if (!menu) return;

      trigger.addEventListener('click', (e) => {
        e.stopPropagation();
        menu.classList.toggle('open');
      });

      document.addEventListener('click', (e) => {
        if (!menu.contains(e.target) && !trigger.contains(e.target)) {
          menu.classList.remove('open');
        }
      });
    });
  }


  /* ── 4. COUNTDOWN TIMER ────────────────────────────────────
     Usage:
     <div data-cv-countdown="<Unix ms timestamp>"
          data-cv-cd-d="#elemId"
          data-cv-cd-h="#elemId"
          data-cv-cd-m="#elemId"
          data-cv-cd-s="#elemId">
  ──────────────────────────────────────────────────────────── */
  function initCountdowns() {
    document.querySelectorAll('[data-cv-countdown]').forEach(el => {
      const deadline = parseInt(el.dataset.cvCountdown, 10);
      if (!deadline) return;
      const d = document.querySelector(el.dataset.cvCdD);
      const h = document.querySelector(el.dataset.cvCdH);
      const m = document.querySelector(el.dataset.cvCdM);
      const s = document.querySelector(el.dataset.cvCdS);

      function tick() {
        const diff = deadline - Date.now();
        if (diff <= 0) {
          [d,h,m,s].forEach(n => { if (n) n.textContent = '00'; });
          return;
        }
        if (d) d.textContent = String(Math.floor(diff / 86400000)).padStart(2,'0');
        if (h) h.textContent = String(Math.floor((diff % 86400000) / 3600000)).padStart(2,'0');
        if (m) m.textContent = String(Math.floor((diff % 3600000) / 60000)).padStart(2,'0');
        if (s) s.textContent = String(Math.floor((diff % 60000) / 1000)).padStart(2,'0');
      }
      tick();
      setInterval(tick, 1000);
    });
  }


  /* ── 5. ANIMATED PROGRESS BARS ─────────────────────────────
     Usage: <div class="cv-progress__bar" data-width="75%"></div>
  ──────────────────────────────────────────────────────────── */
  function initProgressBars() {
    const animate = () => {
      document.querySelectorAll('.cv-progress__bar[data-width]').forEach(bar => {
        const target = bar.dataset.width;
        bar.style.width = '0%';
        setTimeout(() => { bar.style.width = target; }, 250);
      });
    };
    if (document.readyState === 'complete') animate();
    else window.addEventListener('load', animate);
  }


  /* ── 6. FLASH ALERT AUTO-DISMISS ───────────────────────────
     Usage: <div class="cv-alert cv-alert--success" data-cv-dismiss="4000">
  ──────────────────────────────────────────────────────────── */
  function initAlertDismiss() {
    document.querySelectorAll('.cv-alert[data-cv-dismiss]').forEach(alert => {
      const delay = parseInt(alert.dataset.cvDismiss, 10) || 4000;
      setTimeout(() => {
        alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        alert.style.opacity = '0';
        alert.style.transform = 'translateY(-8px)';
        setTimeout(() => alert.remove(), 500);
      }, delay);
    });
  }


  /* ── 7. CONFIRM DIALOGS ────────────────────────────────────
     Usage: <button data-cv-confirm="Are you sure?">Delete</button>
  ──────────────────────────────────────────────────────────── */
  function initConfirmDialogs() {
    document.addEventListener('click', (e) => {
      const btn = e.target.closest('[data-cv-confirm]');
      if (!btn) return;
      if (!window.confirm(btn.dataset.cvConfirm || 'Are you sure?')) {
        e.preventDefault();
        e.stopPropagation();
      }
    });
  }


  /* ── 8. TOOLTIP ────────────────────────────────────────────
     Usage: <button data-cv-tip="Edit profile">
  ──────────────────────────────────────────────────────────── */
  function initTooltips() {
    let tip = null;
    document.addEventListener('mouseover', (e) => {
      const el = e.target.closest('[data-cv-tip]');
      if (!el) return;
      tip = document.createElement('div');
      tip.textContent = el.dataset.cvTip;
      Object.assign(tip.style, {
        position:'fixed', background:'#1a2030', border:'1px solid rgba(255,255,255,0.1)',
        color:'#e8eaf6', fontFamily:'var(--font-mono)', fontSize:'0.65rem',
        padding:'0.28rem 0.6rem', borderRadius:'4px', pointerEvents:'none',
        zIndex:'9999', whiteSpace:'nowrap', boxShadow:'0 4px 16px rgba(0,0,0,0.4)',
      });
      document.body.appendChild(tip);
    });
    document.addEventListener('mousemove', (e) => {
      if (tip) { tip.style.left = (e.clientX + 12) + 'px'; tip.style.top = (e.clientY - 8) + 'px'; }
    });
    document.addEventListener('mouseout', (e) => {
      if (e.target.closest('[data-cv-tip]') && tip) { tip.remove(); tip = null; }
    });
  }


  /* ── 9. NOTIFICATION BADGE LIVE REFRESH ────────────────────
     Polls /api/notifications/count every 60s
     Endpoint should return plain text number e.g. "3"
  ──────────────────────────────────────────────────────────── */
  function initNotifPoll() {
    const badge = document.getElementById('cvNotifBadge');
    if (!badge) return;
    function refresh() {
      fetch('/api/notifications/count', { credentials: 'same-origin' })
        .then(r => r.ok ? r.text() : Promise.reject())
        .then(text => {
          const count = parseInt(text.trim(), 10) || 0;
          badge.textContent = count;
          badge.style.display = count > 0 ? 'flex' : 'none';
        })
        .catch(() => {});
    }
    refresh();
    setInterval(refresh, 60000);
  }


  /* ── 10. FILTER + SEARCH + TABS ────────────────────────────
     Generic list filtering system for any grid of cards.

     Markup:
       body data-page="hackathons"
       <div data-cv-tabs="gridId">
         <button class="cv-tab active" data-filter="all">All</button>
         <button class="cv-tab" data-filter="open">Open</button>
       </div>
       <input id="cvSearch" />
       <select id="cvTypeFilter" />
       <select id="cvPayFilter" />
       <select id="cvTeamFilter" />
       <span data-cv-visible-count></span>
       <span data-cv-total-count></span>
       <div data-cv-no-results style="display:none"></div>
       <div id="gridId">
         <div data-cv-item
              data-status="open"
              data-type="Online"
              data-payment="Free"
              data-minteam="2"
              data-maxteam="5"
              data-title="Hack Title"
              data-location="Bangalore">
         </div>
       </div>
  ──────────────────────────────────────────────────────────── */
  function initFilterGrid() {
    document.querySelectorAll('[data-cv-tabs]').forEach(tabContainer => {
      const tabs    = tabContainer.querySelectorAll('.cv-tab');
      const gridId  = tabContainer.dataset.cvTabs;
      const grid    = gridId ? document.getElementById(gridId) : null;
      if (!grid) return;

      const items    = Array.from(grid.querySelectorAll('[data-cv-item]'));
      const search   = document.getElementById('cvSearch');
      const typeF    = document.getElementById('cvTypeFilter');
      const payF     = document.getElementById('cvPayFilter');
      const teamF    = document.getElementById('cvTeamFilter');
      const visEl    = document.querySelector('[data-cv-visible-count]');
      const totEl    = document.querySelector('[data-cv-total-count]');
      const noRes    = document.querySelector('[data-cv-no-results]');

      if (totEl) totEl.textContent = items.length;
      let activeFilter = 'all';

      function matchTeam(min, max, f) {
        if (!f) return true;
        min = parseInt(min)||1; max = parseInt(max)||99;
        if (f==='1')   return min===1&&max===1;
        if (f==='2-3') return min<=3&&max>=2;
        if (f==='4-5') return min<=5&&max>=4;
        if (f==='6+')  return max>=6;
        return true;
      }

      function run() {
        const q   = search ? search.value.trim().toLowerCase() : '';
        const typ = typeF  ? typeF.value  : '';
        const pay = payF   ? payF.value   : '';
        const tm  = teamF  ? teamF.value  : '';
        let vis   = 0;

        items.forEach(item => {
          const show =
            (activeFilter==='all' || (item.dataset.status||'').toLowerCase()===activeFilter) &&
            (!q   || (item.dataset.title||'').toLowerCase().includes(q) || (item.dataset.location||'').toLowerCase().includes(q)) &&
            (!typ || item.dataset.type===typ) &&
            (!pay || item.dataset.payment===pay) &&
            matchTeam(item.dataset.minteam, item.dataset.maxteam, tm);
          item.style.display = show ? '' : 'none';
          if (show) vis++;
        });

        if (visEl) visEl.textContent = vis;
        if (noRes) noRes.style.display = (vis===0 && items.length>0) ? 'block' : 'none';
      }

      tabs.forEach(tab => {
        tab.addEventListener('click', () => {
          tabs.forEach(t => t.classList.remove('active'));
          tab.classList.add('active');
          activeFilter = tab.dataset.filter || 'all';
          run();
        });
      });

      [search, typeF, payF, teamF].forEach(el => {
        if (el) el.addEventListener('input', run);
        if (el) el.addEventListener('change', run);
      });

      run();
    });
  }


  /* ── BOOT ──────────────────────────────────────────────────── */
  document.addEventListener('DOMContentLoaded', () => {
    initSidebar();
    initActiveNav();
    initDropdown();
    initCountdowns();
    initProgressBars();
    initAlertDismiss();
    initConfirmDialogs();
    initTooltips();
    initNotifPoll();
    initFilterGrid();
  });

})();
