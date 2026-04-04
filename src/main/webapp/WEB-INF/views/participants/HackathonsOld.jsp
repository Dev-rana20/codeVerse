<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CodeVerse — Hackathons</title>

  <link rel="preconnect" href="https://fonts.googleapis.com"/>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&family=Syne:wght@400;600;700;800&display=swap" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

  <style>
    /* ─── VARIABLES ─────────────────────────── */
    :root {
      --bg-base:       #090c12;
      --bg-card:       #0f1420;
      --bg-card-hover: #141928;
      --border:        rgba(255,255,255,0.07);
      --accent:        #00ffe0;
      --accent-dim:    rgba(0,255,224,0.12);
      --accent2:       #7b5cff;
      --accent2-dim:   rgba(123,92,255,0.12);
      --danger:        #ff4b6e;
      --warn:          #ffb347;
      --success:       #22c55e;
      --success-dim:   rgba(34,197,94,0.12);
      --text-primary:  #e8eaf6;
      --text-muted:    #6b7280;
      --font-display:  'Syne', sans-serif;
      --font-mono:     'Space Mono', monospace;
      --radius:        14px;
      --radius-sm:     8px;
      --transition:    0.22s cubic-bezier(.4,0,.2,1);
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html { scroll-behavior: smooth; }

    body {
      background: var(--bg-base);
      color: var(--text-primary);
      font-family: var(--font-display);
      min-height: 100vh;
      overflow-x: hidden;
    }

    body::before {
      content: '';
      position: fixed; inset: 0;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.03'/%3E%3C/svg%3E");
      pointer-events: none; z-index: 0; opacity: 0.5;
    }

    /* ─── NAVBAR ────────────────────────────── */
    .cv-navbar {
      position: sticky; top: 0; z-index: 100;
      background: rgba(9,12,18,0.85);
      backdrop-filter: blur(18px);
      -webkit-backdrop-filter: blur(18px);
      border-bottom: 1px solid var(--border);
      padding: 0.75rem 0;
    }
    .cv-navbar .brand {
      font-family: var(--font-mono); font-size: 1.25rem; font-weight: 700;
      color: var(--accent); letter-spacing: -0.5px; text-decoration: none;
    }
    .cv-navbar .brand span { color: var(--text-primary); }
    .nav-link-cv {
      color: var(--text-muted) !important;
      font-size: 0.85rem; font-weight: 600;
      letter-spacing: 0.04em; text-transform: uppercase;
      transition: color var(--transition); padding: 0.4rem 0.8rem !important;
    }
    .nav-link-cv:hover, .nav-link-cv.active { color: var(--accent) !important; }
    .avatar-btn {
      width: 36px; height: 36px; border-radius: 50%;
      border: 2px solid var(--accent); overflow: hidden; cursor: pointer;
      transition: box-shadow var(--transition);
    }
    .avatar-btn:hover { box-shadow: 0 0 0 3px var(--accent-dim); }
    .avatar-btn img   { width: 100%; height: 100%; object-fit: cover; }

    /* ─── PAGE HERO ─────────────────────────── */
    .page-hero { padding: 3rem 0 2rem; position: relative; overflow: hidden; }
    .page-hero::after {
      content: '';
      position: absolute; top: -80px; right: -100px;
      width: 500px; height: 500px; border-radius: 50%;
      background: radial-gradient(circle, rgba(0,255,224,0.05) 0%, transparent 70%);
      pointer-events: none;
    }
    .page-hero-label {
      font-family: var(--font-mono); font-size: 0.68rem;
      letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--accent); margin-bottom: 0.6rem;
    }
    .page-hero-title {
      font-size: clamp(1.8rem, 4vw, 2.6rem);
      font-weight: 800; letter-spacing: -0.04em;
      line-height: 1.1; margin-bottom: 0.6rem;
    }
    .page-hero-sub {
      font-size: 0.88rem; color: var(--text-muted); font-family: var(--font-mono);
    }

    /* ─── SECTION TITLE ─────────────────────── */
    .section-title {
      font-size: 0.7rem; font-family: var(--font-mono);
      letter-spacing: 0.14em; text-transform: uppercase;
      color: var(--accent); margin-bottom: 1rem;
      display: flex; align-items: center; gap: 0.6rem;
    }
    .section-title::after { content: ''; flex: 1; height: 1px; background: var(--border); }

    /* ─── FILTER BAR ────────────────────────── */
    .filter-bar {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius);
      padding: 1.1rem 1.3rem;
      display: flex; flex-wrap: wrap; gap: 0.75rem;
      align-items: center; margin-bottom: 1rem;
    }
    .search-wrap { position: relative; flex: 1; min-width: 200px; }
    .search-wrap i {
      position: absolute; left: 0.9rem; top: 50%;
      transform: translateY(-50%);
      color: var(--text-muted); font-size: 0.9rem; pointer-events: none;
    }
    .cv-input {
      width: 100%;
      background: var(--bg-base); border: 1px solid var(--border);
      border-radius: var(--radius-sm); color: var(--text-primary);
      font-family: var(--font-mono); font-size: 0.8rem;
      padding: 0.55rem 0.9rem 0.55rem 2.3rem; outline: none;
      transition: border-color var(--transition);
    }
    .cv-input:focus { border-color: var(--accent); }
    .cv-input::placeholder { color: var(--text-muted); }

    .cv-select {
      background: var(--bg-base); border: 1px solid var(--border);
      border-radius: var(--radius-sm); color: var(--text-primary);
      font-family: var(--font-mono); font-size: 0.78rem;
      padding: 0.55rem 2rem 0.55rem 0.9rem; outline: none; cursor: pointer;
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%236b7280' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
      background-repeat: no-repeat; background-position: right 0.7rem center;
      transition: border-color var(--transition); min-width: 140px;
    }
    .cv-select:focus { border-color: var(--accent); }
    .cv-select option { background: var(--bg-card); }

    .filter-count {
      font-family: var(--font-mono); font-size: 0.72rem;
      color: var(--text-muted); margin-left: auto; white-space: nowrap;
    }
    .filter-count span { color: var(--accent); font-weight: 700; }

    /* active filter pills */
    .active-filters { display: flex; flex-wrap: wrap; gap: 0.4rem; margin-bottom: 1.2rem; min-height: 1px; }
    .filter-pill {
      display: inline-flex; align-items: center; gap: 0.35rem;
      font-family: var(--font-mono); font-size: 0.65rem; font-weight: 700;
      letter-spacing: 0.06em; text-transform: uppercase;
      padding: 0.2rem 0.6rem; border-radius: 20px;
      background: var(--accent-dim); border: 1px solid rgba(0,255,224,0.2);
      color: var(--accent); cursor: pointer;
      transition: background var(--transition);
    }
    .filter-pill:hover { background: rgba(0,255,224,0.2); }

    /* ─── HACK CARD ─────────────────────────── */
    .hack-card {
      background: var(--bg-card); border: 1px solid var(--border);
      border-radius: var(--radius); overflow: hidden;
      display: flex; flex-direction: column; height: 100%;
      transition: transform var(--transition), border-color var(--transition), box-shadow var(--transition);
    }
    .hack-card:hover {
      transform: translateY(-4px);
      border-color: rgba(0,255,224,0.2);
      box-shadow: 0 12px 40px rgba(0,255,224,0.05);
    }

    .hack-card-banner { height: 5px; background: linear-gradient(90deg, var(--border), var(--border)); }
    .hack-card-banner.open     { background: linear-gradient(90deg, var(--accent), var(--accent2)); }
    .hack-card-banner.live     { background: linear-gradient(90deg, #00b4ff, var(--accent)); }
    .hack-card-banner.upcoming { background: linear-gradient(90deg, var(--accent2), #b44fff); }
    .hack-card-banner.closed   { background: linear-gradient(90deg, #2a2a3a, #3a3a4a); }

    .hack-card-body { padding: 1.2rem 1.3rem; flex: 1; display: flex; flex-direction: column; }

    .status-badge {
      display: inline-flex; align-items: center; gap: 0.35rem;
      font-family: var(--font-mono); font-size: 0.62rem; font-weight: 700;
      letter-spacing: 0.08em; text-transform: uppercase;
      padding: 0.2rem 0.55rem; border-radius: 20px; margin-bottom: 0.85rem;
    }
    .status-badge .dot { width: 5px; height: 5px; border-radius: 50%; background: currentColor; }
    .status-badge.open     { background: var(--accent-dim);           color: var(--accent); }
    .status-badge.live     { background: rgba(0,180,255,0.12);        color: #00b4ff; }
    .status-badge.upcoming { background: var(--accent2-dim);          color: var(--accent2); }
    .status-badge.closed   { background: rgba(255,255,255,0.05);      color: var(--text-muted); }
    .status-badge.live .dot { animation: pulse-dot 1.2s ease-in-out infinite; }
    @keyframes pulse-dot { 0%,100%{opacity:1}50%{opacity:0.3} }

    .hack-title { font-size: 1rem; font-weight: 700; line-height: 1.3; margin-bottom: 0.35rem; }
    .hack-org   { font-size: 0.75rem; color: var(--text-muted); font-family: var(--font-mono); margin-bottom: 0.9rem; }

    .hack-tags  { display: flex; flex-wrap: wrap; gap: 0.35rem; margin-bottom: 0.9rem; }
    .hack-tag {
      font-family: var(--font-mono); font-size: 0.6rem; font-weight: 700;
      letter-spacing: 0.06em; text-transform: uppercase;
      padding: 0.15rem 0.5rem; border-radius: 20px;
      background: rgba(255,255,255,0.05); border: 1px solid var(--border); color: var(--text-muted);
    }
    .hack-tag.free { background: var(--success-dim); border-color: rgba(34,197,94,0.2); color: var(--success); }
    .hack-tag.paid { background: rgba(255,179,71,0.12); border-color: rgba(255,179,71,0.2); color: var(--warn); }

    .hack-meta { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: auto; padding-top: 0.9rem; border-top: 1px solid var(--border); }
    .hack-meta-item { font-size: 0.7rem; font-family: var(--font-mono); color: var(--text-muted); display: flex; align-items: center; gap: 0.3rem; }
    .hack-meta-item i { color: var(--accent); font-size: 0.75rem; }

    .hack-card-footer { padding: 0.85rem 1.3rem; border-top: 1px solid var(--border); display: flex; gap: 0.5rem; align-items: center; }

    .registered-tag {
      margin-left: auto;
      display: inline-flex; align-items: center; gap: 0.3rem;
      font-family: var(--font-mono); font-size: 0.6rem; font-weight: 700;
      text-transform: uppercase; letter-spacing: 0.06em;
      color: var(--success); background: var(--success-dim);
      border: 1px solid rgba(34,197,94,0.2); border-radius: 20px; padding: 0.15rem 0.5rem;
    }

    /* ─── BUTTONS ───────────────────────────── */
    .btn-cv-primary {
      background: var(--accent); color: #000; border: none;
      border-radius: var(--radius-sm); font-family: var(--font-mono);
      font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em; padding: 0.45rem 1rem;
      transition: opacity var(--transition), transform var(--transition);
      text-decoration: none; display: inline-flex; align-items: center; gap: 0.35rem;
      cursor: pointer; white-space: nowrap;
    }
    .btn-cv-primary:hover { opacity: 0.85; transform: translateY(-1px); color: #000; }

    .btn-cv-ghost {
      background: transparent; color: var(--text-muted); border: 1px solid var(--border);
      border-radius: var(--radius-sm); font-family: var(--font-mono);
      font-size: 0.75rem; font-weight: 700; letter-spacing: 0.05em; padding: 0.45rem 1rem;
      transition: border-color var(--transition), color var(--transition);
      text-decoration: none; display: inline-flex; align-items: center; gap: 0.35rem;
      cursor: pointer; white-space: nowrap;
    }
    .btn-cv-ghost:hover { border-color: var(--accent); color: var(--accent); }

    /* ─── EMPTY STATE ───────────────────────── */
    .empty-state {
      text-align: center; padding: 5rem 1rem; color: var(--text-muted);
      border: 1px solid var(--border); border-radius: var(--radius); background: var(--bg-card);
    }
    .empty-state i  { font-size: 3rem; opacity: 0.15; margin-bottom: 1rem; display: block; }
    .empty-state h3 { font-size: 1rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.4rem; }
    .empty-state p  { font-size: 0.82rem; font-family: var(--font-mono); }

    /* ─── ANIMATIONS ────────────────────────── */
    .fade-up { opacity: 0; transform: translateY(20px); animation: fadeUp 0.5s ease forwards; }
    @keyframes fadeUp { to { opacity: 1; transform: translateY(0); } }
    .fade-up:nth-child(1){ animation-delay:0.05s } .fade-up:nth-child(2){ animation-delay:0.10s }
    .fade-up:nth-child(3){ animation-delay:0.15s } .fade-up:nth-child(4){ animation-delay:0.20s }
    .fade-up:nth-child(5){ animation-delay:0.25s } .fade-up:nth-child(6){ animation-delay:0.30s }
    .fade-up:nth-child(7){ animation-delay:0.35s } .fade-up:nth-child(8){ animation-delay:0.40s }

    .hack-card-wrap.hidden { display: none !important; }

    a { color: inherit; }
    ::-webkit-scrollbar       { width: 6px; }
    ::-webkit-scrollbar-track { background: var(--bg-base); }
    ::-webkit-scrollbar-thumb { background: #222c3c; border-radius: 3px; }

    @media (max-width: 768px) {
      .filter-bar { flex-direction: column; align-items: stretch; }
      .filter-count { margin-left: 0; }
    }
  </style>
</head>
<body>

<%-- ══════════════ NAVBAR ══════════════ --%>
<jsp:include page="navbar.jsp"></jsp:include>


<%-- ══════════════ CONTENT ══════════════ --%>
<div class="container">

  <%-- Hero --%>
  <div class="page-hero">
    <div class="page-hero-label fade-up"><i class="bi bi-collection me-1"></i>Explore</div>
    <h1 class="page-hero-title fade-up">All Hackathons</h1>
    <p class="page-hero-sub fade-up">Browse, filter, and register for upcoming challenges.</p>
  </div>

  <%-- Filter bar --%>
  <div class="filter-bar fade-up">
    <div class="search-wrap">
      <i class="bi bi-search"></i>
      <input type="text" id="searchInput" class="cv-input" placeholder="Search by title..." autocomplete="off"/>
    </div>

    <select class="cv-select" id="filterStatus">
      <option value="">All Status</option>
      <option value="open">Open</option>
      <option value="ongoing">Ongoing</option>
      <option value="upcoming">Upcoming</option>
      <option value="closed">Closed</option>
    </select>

    <select class="cv-select" id="filterType">
      <option value="">All Types</option>
      <option value="online">Online</option>
      <option value="offline">Offline</option>
      <option value="hybrid">Hybrid</option>
    </select>

    <select class="cv-select" id="filterPayment">
      <option value="">Free &amp; Paid</option>
      <option value="free">Free</option>
      <option value="paid">Paid</option>
    </select>

    <select class="cv-select" id="filterTeam">
      <option value="">Any Team Size</option>
      <option value="solo">Solo (1)</option>
      <option value="duo">Duo (2)</option>
      <option value="small">Small (3–4)</option>
      <option value="large">Large (5+)</option>
    </select>

    <div class="filter-count">
      Showing <span id="visibleCount">0</span> of <span id="totalCount">0</span>
    </div>
  </div>

  <%-- Active filter pills --%>
  <div class="active-filters" id="activePills"></div>

  <%-- Grid --%>
  <div class="section-title">All Hackathons</div>

  <c:choose>
    <c:when test="${not empty hackathonList}">

      <div class="row g-3" id="hackGrid">
        <c:forEach var="hack" items="${hackathonList}">
          <div class="col-12 col-sm-6 col-lg-4 hack-card-wrap fade-up"
               data-title="${hack.title}"
               data-status="${hack.status}"
               data-type="${hack.eventType}"
               data-payment="${hack.payment}"
               data-minteam="${hack.minTeamSize}"
               data-maxteam="${hack.maxTeamSize}">

            <div class="hack-card">
              <div class="hack-card-banner ${hack.status}"></div>

              <div class="hack-card-body">
                <span class="status-badge ${hack.status}">
                  <span class="dot"></span> ${hack.status}
                </span>

                <div class="hack-title">${hack.title}</div>
                <div class="hack-org">
                  <i class="bi bi-building me-1"></i>
                  CodeVerse
                </div>

                <div class="hack-tags">
                  <span class="hack-tag">
                    <c:choose>
                      <c:when test="${hack.eventType == 'Online'}"><i class="bi bi-globe me-1"></i></c:when>
                      <c:when test="${hack.eventType == 'Offline'}"><i class="bi bi-geo-alt me-1"></i></c:when>
                      <c:otherwise><i class="bi bi-diagram-3 me-1"></i></c:otherwise>
                    </c:choose>
                    ${hack.eventType}
                  </span>
                  <span class="hack-tag ${hack.payment == 'Free' ? 'free' : 'paid'}">
                    <c:choose>
                      <c:when test="${hack.payment == 'Free'}"><i class="bi bi-gift me-1"></i></c:when>
                      <c:otherwise><i class="bi bi-cash-stack me-1"></i></c:otherwise>
                    </c:choose>
                    ${hack.payment}
                  </span>
                </div>

                <div class="hack-meta">
                  <div class="hack-meta-item">
                    <i class="bi bi-calendar-range"></i>
                   ${hack.registrationStartDate}
                    &nbsp;–&nbsp;
                    ${hack.registrationEndDate}
                  </div>
                  <div class="hack-meta-item">
                    <i class="bi bi-people"></i>
                    ${hack.minTeamSize}–${hack.maxTeamSize} members
                  </div>
                  <c:if test="${not empty hack.location}">
                    <div class="hack-meta-item">
                      <i class="bi bi-geo-alt"></i> ${hack.location}
                    </div>
                  </c:if>
                </div>
              </div>

              <div class="hack-card-footer">
                <a href="hackathonDetail/${hack.hackathonId}" class="btn-cv-primary">
                  <i class="bi bi-arrow-right"></i> View
                </a>
               <c:choose>
					<c:when test="false">
					  <span class="registered-tag">Registered</span>
					</c:when>
                  <c:when test="${hack.status == 'open' || hack.status == 'upcoming'}">
                    <a href="/participant/hackathon/${hack.hackathonId}/join" class="btn-cv-ghost">
                      <i class="bi bi-lightning-charge"></i> Register
                    </a>
                  </c:when>
                  <c:otherwise>
                    <span class="hack-tag" style="margin-left:auto">Closed</span>
                  </c:otherwise>
                </c:choose>
              </div>

            </div>
          </div>
        </c:forEach>
      </div>

      <div id="noResults" style="display:none;margin-top:1rem">
        <div class="empty-state">
          <i class="bi bi-funnel"></i>
          <h3>No matches found</h3>
          <p>Try adjusting your filters or search query.</p>
        </div>
      </div>

    </c:when>
    <c:otherwise>
      <div class="empty-state">
        <i class="bi bi-calendar-x"></i>
        <h3>No hackathons yet</h3>
        <p>Check back soon — new challenges are on the way.</p>
      </div>
    </c:otherwise>
  </c:choose>

  <div style="margin-bottom:4rem"></div>
</div>


<%-- ══════════════ FOOTER ══════════════ --%>

<jsp:include page="footer.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(function () {
  const searchInput   = document.getElementById('searchInput');
  const filterStatus  = document.getElementById('filterStatus');
  const filterType    = document.getElementById('filterType');
  const filterPayment = document.getElementById('filterPayment');
  const filterTeam    = document.getElementById('filterTeam');
  const grid          = document.getElementById('hackGrid');
  const noResults     = document.getElementById('noResults');
  const visibleEl     = document.getElementById('visibleCount');
  const totalEl       = document.getElementById('totalCount');
  const pillsEl       = document.getElementById('activePills');

  if (!grid) return;

  const cards = Array.from(grid.querySelectorAll('.hack-card-wrap'));
  totalEl.textContent = cards.length;

  function applyFilters() {
    const q       = searchInput.value.trim().toLowerCase();
    const status  = filterStatus.value.toLowerCase();
    const type    = filterType.value.toLowerCase();
    const payment = filterPayment.value.toLowerCase();
    const team    = filterTeam.value;

    let visible = 0;

    cards.forEach(card => {
      const title = (card.dataset.title   || '').toLowerCase();
      const cStat = (card.dataset.status  || '').toLowerCase();
      const cType = (card.dataset.type    || '').toLowerCase();
      const cPay  = (card.dataset.payment || '').toLowerCase();
      const minT  = parseInt(card.dataset.minteam || '1', 10);
      const maxT  = parseInt(card.dataset.maxteam || '99', 10);

      let show = true;

      if (q      && !title.includes(q))   show = false;
      if (status && cStat !== status)      show = false;
      if (type   && cType !== type)        show = false;
      if (payment && cPay !== payment)     show = false;

      if (team === 'solo'  && !(minT === 1 && maxT === 1))   show = false;
      if (team === 'duo'   && !(minT <= 2 && maxT >= 2))     show = false;
      if (team === 'small' && !(minT <= 4 && maxT >= 3))     show = false;
      if (team === 'large' && maxT < 5)                      show = false;

      card.classList.toggle('hidden', !show);
      if (show) visible++;
    });

    visibleEl.textContent = visible;
    if (noResults) noResults.style.display = visible === 0 ? 'block' : 'none';
    renderPills();
  }

  const pillDefs = [
    { el: filterStatus,  label: v => 'Status: '  + v },
    { el: filterType,    label: v => 'Type: '    + v },
    { el: filterPayment, label: v => 'Payment: ' + v },
    { el: filterTeam,    label: v => 'Team: '    + v },
  ];

  function renderPills() {
    pillsEl.innerHTML = '';
    pillDefs.forEach(({ el, label }) => {
      if (!el.value) return;
      const pill = document.createElement('span');
      pill.className = 'filter-pill';
      pill.innerHTML = label(el.value) + ' <i class="bi bi-x"></i>';
      pill.addEventListener('click', () => { el.value = ''; applyFilters(); });
      pillsEl.appendChild(pill);
    });
    if (searchInput.value.trim()) {
      const pill = document.createElement('span');
      pill.className = 'filter-pill';
      pill.innerHTML = 'Search: "' + searchInput.value.trim() + '" <i class="bi bi-x"></i>';
      pill.addEventListener('click', () => { searchInput.value = ''; applyFilters(); });
      pillsEl.appendChild(pill);
    }
  }

  [searchInput, filterStatus, filterType, filterPayment, filterTeam]
    .forEach(el => el.addEventListener('input', applyFilters));

  applyFilters();
})();
</script>

</body>
</html>
