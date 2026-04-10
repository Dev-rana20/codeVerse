<%-- ============================================================
     CODEVERSE — Scripts Fragment
     Path: src/main/webapp/WEB-INF/views/components/scripts.jsp

     Include at the very end of every view, just before </body>:
       <%@ include file="components/scripts.jsp" %>
     </body>
   ============================================================ --%>

<!-- Bootstrap 5 JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- CodeVerse Global JS -->
<!-- CodeVerse Global JS -->
<script src="/assets/js/Codeverse.js"></script>

<!-- Theme Toggle Logic -->
<script>
    (function() {
        const themeToggles = document.querySelectorAll('[data-cv-theme-toggle]');
        
        const updateTheme = (isLight) => {
            if (isLight) {
                document.documentElement.classList.add('light-mode');
                localStorage.setItem('cv-theme', 'light');
            } else {
                document.documentElement.classList.remove('light-mode');
                localStorage.setItem('cv-theme', 'dark');
            }
        };

        themeToggles.forEach(toggle => {
            toggle.addEventListener('click', () => {
                const isLight = !document.documentElement.classList.contains('light-mode');
                updateTheme(isLight);
            });
        });
    })();
</script>

<script>
    setTimeout(() => {
        const success = document.querySelector('.alert-success');
        const error = document.querySelector('.alert-danger');

        if (success) {
            success.style.transition = "0.5s";
            success.style.opacity = "0";
            setTimeout(() => success.remove(), 500);
        }

        if (error) {
            error.style.transition = "0.5s";
            error.style.opacity = "0";
            setTimeout(() => error.remove(), 500);
        }
    }, 2000);
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {

	const bell = document.querySelector('[data-cv-dropdown="cvNotifMenu"]');

	if(bell){

	bell.addEventListener("click", function(){

	fetch("/participant/notifications/data")
	.then(res => res.text())
	.then(html => {

	document.getElementById("cvNotificationList")
	.innerHTML = html;

	});

	});

	}

	});
</script>
<!-- FILTER SCRIPT -->
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

  if (!grid) return;

  const cards = Array.from(grid.querySelectorAll('.hack-card-wrap'));
  totalEl.textContent = cards.length;

  function applyFilters() {
    const q       = searchInput.value.toLowerCase();
    const status  = filterStatus.value.toLowerCase();
    const type    = filterType.value.toLowerCase();
    const payment = filterPayment.value.toLowerCase();
    const team    = filterTeam.value;

    let visible = 0;

    cards.forEach(card => {
      const title = (card.dataset.title || '').toLowerCase();
      const cStat = (card.dataset.status || '').toLowerCase();
      const cType = (card.dataset.type || '').toLowerCase();
      const cPay  = (card.dataset.payment || '').toLowerCase();
      const minT  = parseInt(card.dataset.minteam || '1');
      const maxT  = parseInt(card.dataset.maxteam || '99');

      let show = true;

      if (q && !title.includes(q)) show = false;
      if (status) {
          let matches = false;
          if (status === 'open') {
              matches = (cStat === 'upcoming' || cStat === 'ongoing');
          } else if (status === 'ongoing') {
              matches = (cStat === 'ongoing' || cStat === 'in_progress');
          } else if (status === 'upcoming') {
              matches = (cStat === 'upcoming');
          } else if (status === 'close' || status === 'closed') {
              matches = (cStat === 'close' || cStat === 'completed');
          }
          if (!matches) show = false;
      }
      if (type && cType !== type) show = false;
      if (payment && cPay !== payment) show = false;

      if (team === 'solo' && !(minT === 1 && maxT === 1)) show = false;
      if (team === 'duo' && !(minT <= 2 && maxT >= 2)) show = false;
      if (team === 'small' && !(minT <= 4 && maxT >= 3)) show = false;
      if (team === 'large' && maxT < 5) show = false;

      card.style.display = show ? '' : 'none';
      if (show) visible++;
    });

    if (visibleEl) visibleEl.textContent = visible;
    if (noResults) noResults.style.display = (visible === 0 && cards.length > 0) ? 'block' : 'none';
  }

  [searchInput, filterStatus, filterType, filterPayment, filterTeam]
    .forEach(el => {
        if (el) {
            el.addEventListener('input', applyFilters);
            el.addEventListener('change', applyFilters);
        }
    });

  applyFilters();
})();
</script>
