
/* ── Countdown Timer ─────────────────────── */
(function() {
    const wrap = document.getElementById('countdown');
    if (!wrap) return;
    const deadline = parseInt(wrap.dataset.deadline || '0', 10);
    if (!deadline) return;

    function tick() {
        const diff = deadline - Date.now();
        if (diff <= 0) {
            ['d', 'h', 'm', 's'].forEach(u => document.getElementById('cd-' + u).textContent = '00');
            return;
        }
        const d = Math.floor(diff / 86400000);
        const h = Math.floor((diff % 86400000) / 3600000);
        const m = Math.floor((diff % 3600000) / 60000);
        const s = Math.floor((diff % 60000) / 1000);
        document.getElementById('cd-d').textContent = String(d).padStart(2, '0');
        document.getElementById('cd-h').textContent = String(h).padStart(2, '0');
        document.getElementById('cd-m').textContent = String(m).padStart(2, '0');
        document.getElementById('cd-s').textContent = String(s).padStart(2, '0');
    }
    tick();
    setInterval(tick, 1000);
})();

/* ── Animate XP bar on load ──────────────── */
window.addEventListener('load', () => {
    const bar = document.getElementById('xpBar');
    if (bar) {
        const target = bar.style.width;
        bar.style.width = '0%';
        setTimeout(() => { bar.style.width = target; }, 300);
    }
});
