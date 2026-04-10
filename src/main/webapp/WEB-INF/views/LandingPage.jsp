<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>CodeVerse — Architect the Future</title>
  <meta name="description" content="Compete in elite hackathons. Build transformative software, connect with top talent, and claim your place on the global leaderboard." />

  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=JetBrains+Mono:wght@300;400;500;700&display=swap" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />

  <style>
    /* ════════════════════════════════════════════
       DESIGN TOKENS
    ════════════════════════════════════════════ */
    :root {
      --bg-base:      #07080f;
      --bg-surface:   #0d1020;
      --bg-card:      rgba(13,16,32,0.72);
      --bg-card-hov:  rgba(18,22,42,0.85);

      --accent:       #00ffe0;
      --accent-dim:   rgba(0,255,224,0.12);
      --accent-glow:  rgba(0,255,224,0.35);
      --accent2:      #7b5cff;
      --accent2-dim:  rgba(123,92,255,0.15);
      --accent3:      #ff5c8a;

      --text-primary: #f0f0f5;
      --text-muted:   #6b7280;
      --text-sub:     #9ca3af;
      --border:       rgba(255,255,255,0.07);
      --border-hov:   rgba(0,255,224,0.25);

      --font-display: 'Syne', sans-serif;
      --font-mono:    'JetBrains Mono', monospace;

      --radius-sm:    10px;
      --radius-md:    18px;
      --radius-lg:    28px;

      --transition:   0.3s cubic-bezier(0.4,0,0.2,1);
    }

    /* ════════════════════════════════════════════
       GLOBAL RESET
    ════════════════════════════════════════════ */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    html {
      scroll-behavior: smooth;
      scrollbar-width: thin;
      scrollbar-color: var(--accent2) var(--bg-surface);
    }

    body {
      background: var(--bg-base);
      color: var(--text-primary);
      font-family: var(--font-mono);
      overflow-x: hidden;
      line-height: 1.6;
    }

    a { text-decoration: none; color: inherit; }
    img { display: block; max-width: 100%; }

    /* Custom cursor dot */
    body::after {
      content: '';
      position: fixed;
      width: 8px; height: 8px;
      background: var(--accent);
      border-radius: 50%;
      pointer-events: none;
      z-index: 9999;
      transform: translate(-50%, -50%);
      transition: transform 0.08s ease, opacity 0.2s;
      top: var(--cy, -20px);
      left: var(--cx, -20px);
      opacity: 0;
    }

    /* ════════════════════════════════════════════
       NOISE TEXTURE OVERLAY
    ════════════════════════════════════════════ */
    .noise-overlay {
      position: fixed; inset: 0; z-index: 0;
      pointer-events: none;
      background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
      opacity: 0.5;
    }

    /* ════════════════════════════════════════════
       NAVBAR
    ════════════════════════════════════════════ */
    .cv-nav {
      position: fixed; top: 0; left: 0; right: 0; z-index: 1000;
      display: flex; align-items: center; justify-content: space-between;
      padding: 18px 48px;
      background: rgba(7,8,15,0.6);
      backdrop-filter: blur(20px);
      border-bottom: 1px solid var(--border);
      transition: padding var(--transition), background var(--transition);
    }
    .cv-nav.scrolled {
      padding: 12px 48px;
      background: rgba(7,8,15,0.92);
      border-bottom-color: rgba(0,255,224,0.1);
    }

    .cv-logo {
      font-family: var(--font-display);
      font-size: 1.4rem;
      font-weight: 800;
      letter-spacing: -0.03em;
      background: linear-gradient(135deg, #fff 30%, var(--accent));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    .cv-logo span { color: var(--accent); -webkit-text-fill-color: var(--accent); }

    .cv-nav-links {
      display: flex; align-items: center; gap: 36px;
      list-style: none;
    }
    .cv-nav-links a {
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: var(--text-sub);
      transition: color var(--transition);
      position: relative;
    }
    .cv-nav-links a::after {
      content: '';
      position: absolute;
      bottom: -4px; left: 0; right: 100%;
      height: 1px;
      background: var(--accent);
      transition: right var(--transition);
    }
    .cv-nav-links a:hover { color: var(--accent); }
    .cv-nav-links a:hover::after { right: 0; }

    .cv-nav-actions { display: flex; align-items: center; gap: 14px; }

    .btn-nav-ghost {
      font-family: var(--font-mono);
      font-size: 0.78rem;
      font-weight: 500;
      letter-spacing: 0.06em;
      color: var(--text-sub);
      padding: 8px 20px;
      border: 1px solid var(--border);
      border-radius: 40px;
      transition: all var(--transition);
    }
    .btn-nav-ghost:hover { border-color: var(--accent); color: var(--accent); }

    .btn-nav-cta {
      font-family: var(--font-mono);
      font-size: 0.78rem;
      font-weight: 700;
      letter-spacing: 0.06em;
      color: #000;
      padding: 9px 22px;
      background: var(--accent);
      border-radius: 40px;
      transition: all var(--transition);
    }
    .btn-nav-cta:hover { background: #00d4b8; box-shadow: 0 0 24px var(--accent-glow); }

    .nav-burger { display: none; cursor: pointer; }

    /* ════════════════════════════════════════════
       HERO
    ════════════════════════════════════════════ */
    .hero {
      position: relative;
      min-height: 100vh;
      display: flex; align-items: center; justify-content: center;
      overflow: hidden;
      padding: 120px 24px 80px;
    }

    /* Animated grid background */
    .hero-grid {
      position: absolute; inset: 0; z-index: 0;
      background-image:
        linear-gradient(rgba(0,255,224,0.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(0,255,224,0.04) 1px, transparent 1px);
      background-size: 48px 48px;
      mask-image: radial-gradient(ellipse 80% 60% at 50% 50%, black 30%, transparent 100%);
      animation: grid-drift 20s linear infinite;
    }
    @keyframes grid-drift {
      from { transform: translateY(0); }
      to   { transform: translateY(48px); }
    }

    /* Glow orbs */
    .hero-orb {
      position: absolute;
      border-radius: 50%;
      pointer-events: none;
      filter: blur(80px);
      z-index: 1;
    }
    .hero-orb-1 {
      width: 600px; height: 600px;
      top: -100px; left: -100px;
      background: radial-gradient(circle, rgba(123,92,255,0.2) 0%, transparent 65%);
      animation: orb-float 12s ease-in-out infinite alternate;
    }
    .hero-orb-2 {
      width: 500px; height: 500px;
      bottom: -80px; right: -80px;
      background: radial-gradient(circle, rgba(0,255,224,0.15) 0%, transparent 65%);
      animation: orb-float 9s ease-in-out infinite alternate-reverse;
    }
    .hero-orb-3 {
      width: 300px; height: 300px;
      top: 40%; left: 55%;
      background: radial-gradient(circle, rgba(255,92,138,0.12) 0%, transparent 65%);
      animation: orb-float 15s ease-in-out infinite alternate;
    }
    @keyframes orb-float {
      from { transform: translate(0, 0) scale(1); }
      to   { transform: translate(40px, 30px) scale(1.1); }
    }

    .hero-content {
      position: relative; z-index: 3;
      text-align: center;
      max-width: 900px;
      animation: hero-rise 1.2s cubic-bezier(0.2,0.8,0.2,1) both;
    }
    @keyframes hero-rise {
      from { opacity: 0; transform: translateY(48px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .hero-eyebrow {
      display: inline-flex; align-items: center; gap: 10px;
      font-size: 0.72rem;
      font-weight: 700;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--accent);
      background: var(--accent-dim);
      border: 1px solid rgba(0,255,224,0.18);
      padding: 7px 20px;
      border-radius: 40px;
      margin-bottom: 36px;
      animation: hero-rise 1.2s 0.1s both;
    }
    .hero-eyebrow-dot {
      width: 6px; height: 6px;
      border-radius: 50%;
      background: var(--accent);
      box-shadow: 0 0 8px var(--accent);
      animation: pulse-dot 1.6s ease-in-out infinite;
    }
    @keyframes pulse-dot {
      0%, 100% { opacity: 1; transform: scale(1); }
      50%       { opacity: 0.4; transform: scale(0.7); }
    }

    .hero-title {
      font-family: var(--font-display);
      font-size: clamp(3rem, 7vw, 5.8rem);
      font-weight: 800;
      line-height: 1.05;
      letter-spacing: -0.04em;
      margin-bottom: 28px;
      animation: hero-rise 1.2s 0.15s both;
    }
    .hero-title-line1 { display: block; color: var(--text-primary); }
    .hero-title-line2 {
      display: block;
      background: linear-gradient(120deg, var(--accent) 0%, var(--accent2) 60%, var(--accent3) 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      background-size: 200% 200%;
      animation: gradient-shift 5s ease-in-out infinite alternate, hero-rise 1.2s 0.15s both;
    }
    @keyframes gradient-shift {
      from { background-position: 0% 50%; }
      to   { background-position: 100% 50%; }
    }

    .hero-sub {
      font-size: clamp(1rem, 1.8vw, 1.15rem);
      color: var(--text-sub);
      line-height: 1.85;
      max-width: 600px;
      margin: 0 auto 52px;
      animation: hero-rise 1.2s 0.25s both;
    }

    .hero-cta {
      display: flex; align-items: center; justify-content: center;
      gap: 16px; flex-wrap: wrap;
      animation: hero-rise 1.2s 0.35s both;
    }

    .btn-primary {
      display: inline-flex; align-items: center; gap: 10px;
      padding: 16px 40px;
      background: var(--accent);
      color: #000;
      font-family: var(--font-mono);
      font-weight: 700;
      font-size: 0.9rem;
      letter-spacing: 0.04em;
      border-radius: 50px;
      transition: all var(--transition);
      position: relative; overflow: hidden;
    }
    .btn-primary::before {
      content: '';
      position: absolute; inset: 0;
      background: linear-gradient(135deg, transparent 0%, rgba(255,255,255,0.15) 100%);
      opacity: 0;
      transition: opacity var(--transition);
    }
    .btn-primary:hover { background: #00d4b8; transform: translateY(-3px); box-shadow: 0 16px 48px var(--accent-glow); color: #000; }
    .btn-primary:hover::before { opacity: 1; }
    .btn-primary:active { transform: translateY(-1px); }

    .btn-ghost {
      display: inline-flex; align-items: center; gap: 10px;
      padding: 15px 40px;
      background: rgba(255,255,255,0.03);
      color: var(--text-primary);
      font-family: var(--font-mono);
      font-weight: 600;
      font-size: 0.9rem;
      border: 1px solid var(--border);
      border-radius: 50px;
      transition: all var(--transition);
      backdrop-filter: blur(10px);
    }
    .btn-ghost:hover { border-color: var(--accent); color: var(--accent); background: var(--accent-dim); transform: translateY(-3px); }

    /* Hero stats */
    .hero-stats {
      display: flex; align-items: center; justify-content: center;
      gap: 48px; flex-wrap: wrap;
      margin-top: 72px;
      padding-top: 48px;
      border-top: 1px solid var(--border);
      animation: hero-rise 1.2s 0.45s both;
    }
    .hero-stat { text-align: center; }
    .hero-stat-num {
      font-family: var(--font-display);
      font-size: 2.2rem;
      font-weight: 800;
      background: linear-gradient(135deg, var(--text-primary), var(--accent));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      line-height: 1;
      margin-bottom: 6px;
    }
    .hero-stat-label {
      font-size: 0.72rem;
      font-weight: 500;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--text-muted);
    }
    .hero-stat-divider {
      width: 1px; height: 48px;
      background: linear-gradient(to bottom, transparent, var(--border), transparent);
    }

    /* ════════════════════════════════════════════
       SECTION COMMONS
    ════════════════════════════════════════════ */
    .section { padding: 110px 0; position: relative; }
    .section-inner { max-width: 1180px; margin: 0 auto; padding: 0 32px; }

    .section-label {
      display: inline-block;
      font-size: 0.68rem;
      font-weight: 700;
      letter-spacing: 0.18em;
      text-transform: uppercase;
      color: var(--accent);
      margin-bottom: 14px;
    }

    .section-title {
      font-family: var(--font-display);
      font-size: clamp(2rem, 4vw, 2.9rem);
      font-weight: 800;
      letter-spacing: -0.03em;
      color: var(--text-primary);
      line-height: 1.15;
      margin-bottom: 20px;
    }
    .section-title em { font-style: normal; color: var(--accent); }

    .section-sub {
      font-size: 1rem;
      color: var(--text-sub);
      line-height: 1.75;
      max-width: 560px;
    }

    /* ════════════════════════════════════════════
       DISCOVERY / HACKATHON CARDS
    ════════════════════════════════════════════ */
    .discovery { background: var(--bg-base); }

    .discovery-header {
      text-align: center;
      margin-bottom: 64px;
    }
    .discovery-header .section-sub { margin: 0 auto; }

    /* Filter pills */
    .filter-pills {
      display: flex; align-items: center; justify-content: center;
      gap: 10px; flex-wrap: wrap;
      margin-bottom: 48px;
    }
    .filter-pill {
      font-family: var(--font-mono);
      font-size: 0.75rem;
      font-weight: 600;
      padding: 7px 20px;
      border-radius: 30px;
      border: 1px solid var(--border);
      color: var(--text-muted);
      cursor: pointer;
      transition: all var(--transition);
      background: transparent;
    }
    .filter-pill.active, .filter-pill:hover {
      border-color: var(--accent);
      color: var(--accent);
      background: var(--accent-dim);
    }

    .hackathon-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
      gap: 24px;
    }

    .hk-card {
      background: var(--bg-card);
      backdrop-filter: blur(16px);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      overflow: hidden;
      display: flex; flex-direction: column;
      transition: all 0.4s cubic-bezier(0.4,0,0.2,1);
      position: relative;
      cursor: pointer;
    }
    .hk-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0; height: 1px;
      background: linear-gradient(90deg, transparent, var(--accent), transparent);
      opacity: 0;
      transition: opacity var(--transition);
    }
    .hk-card:hover {
      transform: translateY(-10px);
      border-color: var(--border-hov);
      background: var(--bg-card-hov);
      box-shadow: 0 32px 80px rgba(0,0,0,0.5), 0 0 40px rgba(0,255,224,0.06);
    }
    .hk-card:hover::before { opacity: 1; }

    /* Colorful top accent per status */
    .hk-card-accent {
      height: 3px;
      background: linear-gradient(90deg, var(--accent), var(--accent2));
    }
    .hk-card-accent.ongoing { background: linear-gradient(90deg, var(--accent), #00c896); }
    .hk-card-accent.upcoming { background: linear-gradient(90deg, var(--accent2), var(--accent3)); }

    .hk-card-head { padding: 26px 28px 16px; }

    .hk-badge {
      display: inline-flex; align-items: center; gap: 6px;
      font-size: 0.65rem;
      font-weight: 700;
      letter-spacing: 0.12em;
      text-transform: uppercase;
      padding: 5px 14px;
      border-radius: 30px;
      margin-bottom: 16px;
    }
    .hk-badge.ONGOING, .hk-badge.OPEN, .hk-badge.IN_PROGRESS {
      background: var(--accent-dim); color: var(--accent);
      border: 1px solid rgba(0,255,224,0.2);
    }
    .hk-badge.UPCOMING {
      background: var(--accent2-dim); color: #a78bfa;
      border: 1px solid rgba(123,92,255,0.25);
    }
    .hk-badge-dot { width: 5px; height: 5px; border-radius: 50%; background: currentColor; animation: pulse-dot 1.6s ease-in-out infinite; }

    .hk-title {
      font-family: var(--font-display);
      font-size: 1.3rem;
      font-weight: 700;
      color: var(--text-primary);
      line-height: 1.35;
      margin-bottom: 6px;
    }

    .hk-card-body {
      padding: 0 28px 20px;
      display: flex; flex-direction: column; gap: 10px;
      flex-grow: 1;
    }

    .hk-info {
      display: flex; align-items: center; gap: 12px;
      font-size: 0.82rem; color: var(--text-muted);
    }
    .hk-info-icon {
      width: 32px; height: 32px;
      display: flex; align-items: center; justify-content: center;
      background: var(--accent-dim);
      border-radius: 8px;
      color: var(--accent);
      flex-shrink: 0;
      font-size: 0.95rem;
    }

    .hk-tags {
      display: flex; flex-wrap: wrap; gap: 6px;
      margin-top: 6px;
    }
    .hk-tag {
      font-size: 0.65rem;
      font-weight: 600;
      letter-spacing: 0.06em;
      text-transform: uppercase;
      padding: 3px 10px;
      border-radius: 20px;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border);
      color: var(--text-muted);
    }

    .hk-card-foot {
      padding: 16px 28px;
      border-top: 1px solid var(--border);
      display: flex; align-items: center; justify-content: space-between;
    }
    .hk-price { font-size: 0.9rem; font-weight: 700; }
    .hk-price.free { color: #4ade80; }
    .hk-price.paid { color: var(--text-primary); }

    .hk-cta-link {
      display: inline-flex; align-items: center; gap: 6px;
      font-size: 0.76rem;
      font-weight: 600;
      color: var(--text-muted);
      padding: 7px 16px;
      border: 1px solid var(--border);
      border-radius: 20px;
      transition: all var(--transition);
    }
    .hk-card:hover .hk-cta-link { border-color: var(--accent); color: var(--accent); }

    /* ════════════════════════════════════════════
       FEATURES
    ════════════════════════════════════════════ */
    .features { background: var(--bg-surface); }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 2px;
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      overflow: hidden;
      margin-top: 72px;
    }

    .feat-card {
      padding: 48px 40px;
      background: var(--bg-card);
      transition: background var(--transition);
      position: relative;
      overflow: hidden;
    }
    .feat-card::after {
      content: '';
      position: absolute;
      bottom: 0; left: 0; right: 0; height: 2px;
      background: linear-gradient(90deg, var(--accent), var(--accent2));
      transform: scaleX(0);
      transform-origin: left;
      transition: transform 0.4s ease;
    }
    .feat-card:hover { background: var(--bg-card-hov); }
    .feat-card:hover::after { transform: scaleX(1); }

    .feat-icon-wrap {
      width: 52px; height: 52px;
      border-radius: 14px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.4rem;
      margin-bottom: 24px;
      position: relative;
    }
    .feat-icon-wrap.cyan { background: var(--accent-dim); color: var(--accent); box-shadow: 0 0 20px rgba(0,255,224,0.12); }
    .feat-icon-wrap.purple { background: var(--accent2-dim); color: #a78bfa; box-shadow: 0 0 20px rgba(123,92,255,0.12); }
    .feat-icon-wrap.pink { background: rgba(255,92,138,0.12); color: var(--accent3); box-shadow: 0 0 20px rgba(255,92,138,0.1); }

    .feat-title {
      font-family: var(--font-display);
      font-size: 1.2rem;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: 12px;
    }
    .feat-desc { font-size: 0.88rem; color: var(--text-sub); line-height: 1.75; }

    .feat-number {
      position: absolute;
      top: 28px; right: 32px;
      font-family: var(--font-display);
      font-size: 4rem;
      font-weight: 800;
      color: rgba(255,255,255,0.02);
      line-height: 1;
      user-select: none;
    }

    /* ════════════════════════════════════════════
       HOW IT WORKS
    ════════════════════════════════════════════ */
    .how { background: var(--bg-base); }

    .how-content {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 80px;
      align-items: center;
      margin-top: 72px;
    }

    .how-steps { display: flex; flex-direction: column; gap: 0; }

    .how-step {
      display: flex; gap: 24px;
      padding: 32px 0;
      border-bottom: 1px solid var(--border);
      position: relative;
      cursor: default;
      transition: all var(--transition);
    }
    .how-step:last-child { border-bottom: none; }
    .how-step:hover .how-step-icon { border-color: var(--accent); box-shadow: 0 0 20px var(--accent-glow); }

    .how-step-icon {
      flex-shrink: 0;
      width: 48px; height: 48px;
      border-radius: 14px;
      border: 1px solid var(--border);
      display: flex; align-items: center; justify-content: center;
      font-size: 1.1rem;
      color: var(--accent);
      transition: all var(--transition);
      position: relative;
    }
    .how-step-num {
      position: absolute;
      top: -8px; right: -8px;
      width: 18px; height: 18px;
      background: var(--accent);
      color: #000;
      font-size: 0.55rem;
      font-weight: 700;
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
    }

    .how-step-title {
      font-family: var(--font-display);
      font-size: 1.05rem;
      font-weight: 700;
      color: var(--text-primary);
      margin-bottom: 6px;
    }
    .how-step-desc { font-size: 0.83rem; color: var(--text-sub); line-height: 1.7; }

    /* Visual panel for "how it works" */
    .how-visual {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: 36px;
      position: relative;
      overflow: hidden;
    }
    .how-visual::before {
      content: '';
      position: absolute; inset: 0;
      background: radial-gradient(ellipse at 80% 20%, rgba(0,255,224,0.08) 0%, transparent 60%);
    }

    .how-terminal-bar {
      display: flex; align-items: center; gap: 8px;
      margin-bottom: 28px;
    }
    .how-terminal-dot { width: 10px; height: 10px; border-radius: 50%; }
    .how-terminal-dot:nth-child(1) { background: #ff5f57; }
    .how-terminal-dot:nth-child(2) { background: #febc2e; }
    .how-terminal-dot:nth-child(3) { background: #28c840; }

    .how-terminal-line {
      font-size: 0.8rem;
      line-height: 2;
      margin-bottom: 4px;
    }
    .how-terminal-line .prompt { color: var(--accent); }
    .how-terminal-line .cmd { color: var(--text-primary); }
    .how-terminal-line .out { color: var(--text-muted); padding-left: 16px; }
    .how-terminal-line .success { color: #4ade80; }
    .how-terminal-line .accent2 { color: #a78bfa; }

    .how-terminal-cursor {
      display: inline-block;
      width: 8px; height: 14px;
      background: var(--accent);
      animation: blink 1.1s step-end infinite;
      vertical-align: middle;
    }
    @keyframes blink { 0%, 100% { opacity: 1; } 50% { opacity: 0; } }

    /* ════════════════════════════════════════════
       TESTIMONIALS
    ════════════════════════════════════════════ */
    .testimonials { background: var(--bg-surface); overflow: hidden; }

    .testimonials-header {
      display: flex; align-items: flex-end; justify-content: space-between;
      margin-bottom: 64px;
      flex-wrap: wrap; gap: 24px;
    }

    .testimonials-track-wrap {
      position: relative;
      overflow: hidden;
    }
    .testimonials-track-wrap::before,
    .testimonials-track-wrap::after {
      content: '';
      position: absolute; top: 0; bottom: 0; z-index: 2;
      width: 120px;
      pointer-events: none;
    }
    .testimonials-track-wrap::before { left: 0; background: linear-gradient(to right, var(--bg-surface), transparent); }
    .testimonials-track-wrap::after  { right: 0; background: linear-gradient(to left, var(--bg-surface), transparent); }

    .testimonials-track {
      display: flex; gap: 24px;
      animation: marquee 30s linear infinite;
      width: max-content;
    }
    .testimonials-track:hover { animation-play-state: paused; }
    @keyframes marquee {
      from { transform: translateX(0); }
      to   { transform: translateX(-50%); }
    }

    .testi-card {
      width: 340px;
      flex-shrink: 0;
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-md);
      padding: 28px;
      transition: border-color var(--transition);
    }
    .testi-card:hover { border-color: var(--border-hov); }

    .testi-quote {
      font-size: 0.9rem;
      color: var(--text-sub);
      line-height: 1.75;
      margin-bottom: 24px;
      position: relative;
    }
    .testi-quote::before {
      content: '"';
      font-family: var(--font-display);
      font-size: 3rem;
      color: var(--accent);
      opacity: 0.3;
      position: absolute;
      top: -12px; left: -8px;
      line-height: 1;
    }

    .testi-author { display: flex; align-items: center; gap: 14px; }
    .testi-avatar {
      width: 40px; height: 40px;
      border-radius: 50%;
      background: linear-gradient(135deg, var(--accent2), var(--accent));
      display: flex; align-items: center; justify-content: center;
      font-size: 1rem;
      color: #fff;
      font-weight: 700;
      font-family: var(--font-display);
      flex-shrink: 0;
    }
    .testi-name { font-size: 0.88rem; font-weight: 600; color: var(--text-primary); }
    .testi-role { font-size: 0.75rem; color: var(--text-muted); }

    .testi-stars { color: #fbbf24; font-size: 0.75rem; margin-top: 4px; letter-spacing: 2px; }

    /* ════════════════════════════════════════════
       SPONSORS
    ════════════════════════════════════════════ */
    .sponsors { background: var(--bg-base); padding: 70px 0; }

    .sponsors-label {
      text-align: center;
      font-size: 0.7rem;
      font-weight: 700;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: var(--text-muted);
      margin-bottom: 40px;
    }

    .sponsors-row {
      display: flex; align-items: center; justify-content: center;
      gap: 56px; flex-wrap: wrap;
    }

    .sponsor-logo {
      font-family: var(--font-display);
      font-size: 1.25rem;
      font-weight: 800;
      color: rgba(255,255,255,0.2);
      letter-spacing: -0.04em;
      transition: color var(--transition);
      cursor: default;
    }
    .sponsor-logo:hover { color: rgba(255,255,255,0.6); }

    /* ════════════════════════════════════════════
       FAQ
    ════════════════════════════════════════════ */
    .faq { background: var(--bg-surface); }

    .faq-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
      margin-top: 64px;
    }

    .faq-item {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-md);
      overflow: hidden;
      transition: border-color var(--transition);
    }
    .faq-item:hover { border-color: var(--border-hov); }
    .faq-item.open { border-color: rgba(0,255,224,0.2); }

    .faq-q {
      display: flex; align-items: center; justify-content: space-between;
      padding: 22px 26px;
      cursor: pointer;
      gap: 16px;
    }
    .faq-q-text {
      font-family: var(--font-display);
      font-size: 0.95rem;
      font-weight: 700;
      color: var(--text-primary);
    }
    .faq-icon {
      flex-shrink: 0;
      width: 28px; height: 28px;
      border-radius: 50%;
      border: 1px solid var(--border);
      display: flex; align-items: center; justify-content: center;
      color: var(--text-muted);
      font-size: 0.85rem;
      transition: all var(--transition);
    }
    .faq-item.open .faq-icon { background: var(--accent-dim); border-color: var(--accent); color: var(--accent); transform: rotate(45deg); }

    .faq-a {
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.4s cubic-bezier(0.4,0,0.2,1);
    }
    .faq-item.open .faq-a { max-height: 200px; }
    .faq-a-inner {
      padding: 0 26px 22px;
      font-size: 0.85rem;
      color: var(--text-sub);
      line-height: 1.75;
      border-top: 1px solid var(--border);
      padding-top: 16px;
    }

    /* ════════════════════════════════════════════
       CTA BAND
    ════════════════════════════════════════════ */
    .cta-band {
      background: var(--bg-base);
      padding: 120px 0;
      text-align: center;
      position: relative;
      overflow: hidden;
    }
    .cta-band-orb {
      position: absolute;
      width: 700px; height: 700px;
      top: 50%; left: 50%;
      transform: translate(-50%, -50%);
      background: radial-gradient(circle, rgba(123,92,255,0.18) 0%, transparent 60%);
      pointer-events: none;
    }
    .cta-band-title {
      font-family: var(--font-display);
      font-size: clamp(2.4rem, 5vw, 4rem);
      font-weight: 800;
      letter-spacing: -0.04em;
      color: var(--text-primary);
      margin-bottom: 20px;
      position: relative; z-index: 1;
    }
    .cta-band-title em { font-style: normal; color: var(--accent); }
    .cta-band-sub {
      font-size: 1rem;
      color: var(--text-sub);
      margin-bottom: 48px;
      position: relative; z-index: 1;
    }
    .cta-band-actions {
      display: flex; align-items: center; justify-content: center;
      gap: 16px; flex-wrap: wrap;
      position: relative; z-index: 1;
    }

    /* ════════════════════════════════════════════
       FOOTER
    ════════════════════════════════════════════ */
    footer {
      background: var(--bg-surface);
      border-top: 1px solid var(--border);
      padding: 64px 0 40px;
    }
    .footer-inner {
      max-width: 1180px; margin: 0 auto; padding: 0 32px;
    }
    .footer-top {
      display: grid;
      grid-template-columns: 1.5fr 1fr 1fr 1fr;
      gap: 48px;
      margin-bottom: 56px;
      padding-bottom: 56px;
      border-bottom: 1px solid var(--border);
    }
    .footer-brand-desc {
      font-size: 0.83rem;
      color: var(--text-muted);
      line-height: 1.75;
      margin-top: 14px;
      max-width: 260px;
    }
    .footer-col-title {
      font-family: var(--font-display);
      font-size: 0.8rem;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: var(--text-primary);
      margin-bottom: 20px;
    }
    .footer-links { list-style: none; display: flex; flex-direction: column; gap: 12px; }
    .footer-links a {
      font-size: 0.82rem;
      color: var(--text-muted);
      transition: color var(--transition);
    }
    .footer-links a:hover { color: var(--accent); }

    .footer-bottom {
      display: flex; align-items: center; justify-content: space-between;
      flex-wrap: wrap; gap: 16px;
    }
    .footer-copy {
      font-size: 0.75rem;
      color: var(--text-muted);
    }
    .footer-socials { display: flex; gap: 16px; }
    .footer-social {
      width: 34px; height: 34px;
      border: 1px solid var(--border);
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      color: var(--text-muted);
      font-size: 0.9rem;
      transition: all var(--transition);
    }
    .footer-social:hover { border-color: var(--accent); color: var(--accent); background: var(--accent-dim); }

    /* ════════════════════════════════════════════
       SCROLL REVEAL
    ════════════════════════════════════════════ */
    .reveal {
      opacity: 0;
      transform: translateY(28px);
      transition: opacity 0.7s ease, transform 0.7s cubic-bezier(0.2,0.8,0.2,1);
    }
    .reveal.visible { opacity: 1; transform: translateY(0); }
    .reveal-delay-1 { transition-delay: 0.1s; }
    .reveal-delay-2 { transition-delay: 0.2s; }
    .reveal-delay-3 { transition-delay: 0.3s; }

    /* ════════════════════════════════════════════
       RESPONSIVE
    ════════════════════════════════════════════ */
    @media (max-width: 1024px) {
      .features-grid { grid-template-columns: 1fr 1fr; }
      .footer-top { grid-template-columns: 1fr 1fr; }
      .how-content { grid-template-columns: 1fr; gap: 48px; }
      .how-visual { order: -1; }
    }
    @media (max-width: 768px) {
      .cv-nav { padding: 16px 24px; }
      .cv-nav-links, .cv-nav-actions { display: none; }
      .nav-burger { display: block; }
      .features-grid { grid-template-columns: 1fr; }
      .faq-grid { grid-template-columns: 1fr; }
      .footer-top { grid-template-columns: 1fr 1fr; }
      .hero-stats { gap: 28px; }
      .hero-stat-divider { display: none; }
    }
    @media (max-width: 480px) {
      .section-inner { padding: 0 20px; }
      .footer-top { grid-template-columns: 1fr; }
      .hackathon-grid { grid-template-columns: 1fr; }
      .hero-title { font-size: 2.5rem; }
    }

    /* ════════════════════════════════════════════
       REGISTER MODAL
    ════════════════════════════════════════════ */
    .modal-overlay {
      position: fixed; inset: 0; z-index: 2000;
      background: rgba(0,0,0,0.75);
      backdrop-filter: blur(8px);
      display: flex; align-items: center; justify-content: center;
      opacity: 0; pointer-events: none;
      transition: opacity 0.3s ease;
      padding: 20px;
    }
    .modal-overlay.open { opacity: 1; pointer-events: all; }
    .modal-box {
      background: var(--bg-surface);
      border: 1px solid rgba(0,255,224,0.15);
      border-radius: var(--radius-lg);
      padding: 48px;
      max-width: 480px; width: 100%;
      transform: translateY(24px);
      transition: transform 0.35s cubic-bezier(0.2,0.8,0.2,1);
      position: relative;
    }
    .modal-overlay.open .modal-box { transform: translateY(0); }
    .modal-close {
      position: absolute; top: 20px; right: 20px;
      width: 32px; height: 32px;
      border-radius: 50%;
      border: 1px solid var(--border);
      background: none;
      color: var(--text-muted);
      cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      font-size: 0.85rem;
      transition: all var(--transition);
    }
    .modal-close:hover { border-color: var(--accent); color: var(--accent); }

    .modal-title {
      font-family: var(--font-display);
      font-size: 1.7rem;
      font-weight: 800;
      letter-spacing: -0.03em;
      margin-bottom: 8px;
    }
    .modal-sub { font-size: 0.85rem; color: var(--text-muted); margin-bottom: 36px; }

    .modal-field { margin-bottom: 20px; }
    .modal-label { display: block; font-size: 0.72rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; color: var(--text-muted); margin-bottom: 8px; }
    .modal-input {
      width: 100%; padding: 12px 18px;
      background: rgba(255,255,255,0.04);
      border: 1px solid var(--border);
      border-radius: var(--radius-sm);
      color: var(--text-primary);
      font-family: var(--font-mono);
      font-size: 0.88rem;
      outline: none;
      transition: border-color var(--transition);
    }
    .modal-input:focus { border-color: var(--accent); }
    .modal-input::placeholder { color: var(--text-muted); }

    .modal-btn {
      width: 100%;
      padding: 14px;
      background: var(--accent);
      color: #000;
      font-family: var(--font-mono);
      font-weight: 700;
      font-size: 0.9rem;
      border: none;
      border-radius: 50px;
      cursor: pointer;
      transition: all var(--transition);
      margin-top: 8px;
    }
    .modal-btn:hover { background: #00d4b8; box-shadow: 0 12px 40px var(--accent-glow); }
  </style>
</head>
<body>

<div class="noise-overlay" aria-hidden="true"></div>

<!-- ══════════════════════════════════════
     NAVBAR
══════════════════════════════════════ -->
<nav class="cv-nav" id="navbar" aria-label="Main navigation">
  <a href="/" class="cv-logo" aria-label="CodeVerse home">Code<span>Verse</span></a>

  <ul class="cv-nav-links" role="list">
    <li><a href="#discovery">Hackathons</a></li>
    <li><a href="#how">How It Works</a></li>
    <li><a href="#sponsors">Sponsors</a></li>
    <li><a href="#faq">FAQ</a></li>
  </ul>

  <div class="cv-nav-actions">
    <a href="/login" class="btn-nav-ghost">Log In</a>
    <a href="#" class="btn-nav-cta" id="navRegisterBtn">Join Free</a>
  </div>

  <button class="nav-burger" aria-label="Open menu" aria-expanded="false">
    <i class="bi bi-list" style="font-size:1.5rem;color:var(--text-primary)"></i>
  </button>
</nav>


<!-- ══════════════════════════════════════
     HERO
══════════════════════════════════════ -->
<section class="hero" aria-labelledby="hero-title">
  <div class="hero-grid" aria-hidden="true"></div>
  <div class="hero-orb hero-orb-1" aria-hidden="true"></div>
  <div class="hero-orb hero-orb-2" aria-hidden="true"></div>
  <div class="hero-orb hero-orb-3" aria-hidden="true"></div>

  <div class="hero-content">
    <div class="hero-eyebrow" role="note">
      <span class="hero-eyebrow-dot" aria-hidden="true"></span>
      Season 4 — Global Hackathon Platform
    </div>

    <h1 class="hero-title" id="hero-title">
      <span class="hero-title-line1">Architect the Future.</span>
      <span class="hero-title-line2">Unleash Your Code.</span>
    </h1>

    <p class="hero-sub">
      Compete in elite hackathons. Build transformative software, connect with top engineering talent, and claim your place on the global leaderboard.
    </p>

    <div class="hero-cta">
      <a href="#discovery" class="btn-primary" aria-label="Explore open hackathons">
        <i class="bi bi-rocket-takeoff-fill" aria-hidden="true"></i>
        Explore Hackathons
      </a>
      <a href="#" class="btn-ghost" id="heroSignupBtn">
        Create Free Account
        <i class="bi bi-arrow-right" aria-hidden="true"></i>
      </a>
    </div>

    <div class="hero-stats" aria-label="Platform statistics">
      <div class="hero-stat">
        <div class="hero-stat-num" data-count="12400">12.4k</div>
        <div class="hero-stat-label">Participants</div>
      </div>
      <div class="hero-stat-divider" aria-hidden="true"></div>
      <div class="hero-stat">
        <div class="hero-stat-num">340+</div>
        <div class="hero-stat-label">Projects Submitted</div>
      </div>
      <div class="hero-stat-divider" aria-hidden="true"></div>
      <div class="hero-stat">
        <div class="hero-stat-num">₹18L+</div>
        <div class="hero-stat-label">Prize Pool</div>
      </div>
      <div class="hero-stat-divider" aria-hidden="true"></div>
      <div class="hero-stat">
        <div class="hero-stat-num">96</div>
        <div class="hero-stat-label">Hackathons Run</div>
      </div>
    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     DISCOVERY — HACKATHON CARDS
══════════════════════════════════════ -->
<section class="section discovery" id="discovery" aria-labelledby="discovery-title">
  <div class="section-inner">
    <div class="discovery-header reveal">
      <p class="section-label">Open &amp; Upcoming</p>
      <h2 class="section-title" id="discovery-title">Discover <em>Hackathons</em></h2>
      <p class="section-sub">Every hackathon is a launchpad. Filter by status, type, or prize and find your perfect challenge.</p>
    </div>

    <!-- Filter Pills -->
    <div class="filter-pills reveal" role="group" aria-label="Filter hackathons">
      <button class="filter-pill active">All</button>
      <button class="filter-pill">Ongoing</button>
      <button class="filter-pill">Upcoming</button>
      <button class="filter-pill">Free Entry</button>
      <button class="filter-pill">Team</button>
    </div>

    <!-- Cards Grid -->
    <div class="hackathon-grid" role="list">

      <!-- Card 1 – ONGOING -->
      <article class="hk-card reveal" role="listitem" tabindex="0" aria-label="Hackathon: BioTech Innovate 2025">
        <div class="hk-card-accent ongoing" aria-hidden="true"></div>
        <div class="hk-card-head">
          <span class="hk-badge ONGOING"><span class="hk-badge-dot" aria-hidden="true"></span>Ongoing</span>
          <h3 class="hk-title">BioTech Innovate 2025</h3>
        </div>
        <div class="hk-card-body">
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-calendar2-week"></i></span>
            <span>Jan 15 → Feb 15, 2025</span>
          </div>
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-geo-alt"></i></span>
            <span>Virtual Event</span>
          </div>
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-people"></i></span>
            <span>2–5 members per team</span>
          </div>
          <div class="hk-tags">
            <span class="hk-tag">AI/ML</span>
            <span class="hk-tag">Healthcare</span>
            <span class="hk-tag">Python</span>
          </div>
        </div>
        <div class="hk-card-foot">
          <span class="hk-price free"><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Free Entry</span>
          <a href="/login" class="hk-cta-link" aria-label="View details for BioTech Innovate 2025">View Details <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
        </div>
      </article>

      <!-- Card 2 – UPCOMING -->
      <article class="hk-card reveal reveal-delay-1" role="listitem" tabindex="0" aria-label="Hackathon: FinTech Frontiers">
        <div class="hk-card-accent upcoming" aria-hidden="true"></div>
        <div class="hk-card-head">
          <span class="hk-badge UPCOMING"><span class="hk-badge-dot" aria-hidden="true"></span>Upcoming</span>
          <h3 class="hk-title">FinTech Frontiers</h3>
        </div>
        <div class="hk-card-body">
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-calendar2-week"></i></span>
            <span>Mar 01 → Mar 30, 2025</span>
          </div>
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-geo-alt"></i></span>
            <span>Mumbai, India</span>
          </div>
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-people"></i></span>
            <span>3–6 members per team</span>
          </div>
          <div class="hk-tags">
            <span class="hk-tag">Blockchain</span>
            <span class="hk-tag">Node.js</span>
            <span class="hk-tag">Web3</span>
          </div>
        </div>
        <div class="hk-card-foot">
          <span class="hk-price paid">Entry: ₹499</span>
          <a href="/login" class="hk-cta-link" aria-label="View details for FinTech Frontiers">View Details <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
        </div>
      </article>

      <!-- Card 3 – ONGOING -->
      <article class="hk-card reveal reveal-delay-2" role="listitem" tabindex="0" aria-label="Hackathon: ClimateCode Challenge">
        <div class="hk-card-accent ongoing" aria-hidden="true"></div>
        <div class="hk-card-head">
          <span class="hk-badge ONGOING"><span class="hk-badge-dot" aria-hidden="true"></span>Ongoing</span>
          <h3 class="hk-title">ClimateCode Challenge</h3>
        </div>
        <div class="hk-card-body">
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-calendar2-week"></i></span>
            <span>Jan 20 → Feb 20, 2025</span>
          </div>
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-geo-alt"></i></span>
            <span>Virtual Event</span>
          </div>
          <div class="hk-info">
            <span class="hk-info-icon" aria-hidden="true"><i class="bi bi-people"></i></span>
            <span>1–4 members per team</span>
          </div>
          <div class="hk-tags">
            <span class="hk-tag">Sustainability</span>
            <span class="hk-tag">IoT</span>
            <span class="hk-tag">React</span>
          </div>
        </div>
        <div class="hk-card-foot">
          <span class="hk-price free"><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Free Entry</span>
          <a href="/login" class="hk-cta-link" aria-label="View details for ClimateCode Challenge">View Details <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
        </div>
      </article>

    </div><!-- /hackathon-grid -->
  </div>
</section>


<!-- ══════════════════════════════════════
     FEATURES
══════════════════════════════════════ -->
<section class="section features" id="features" aria-labelledby="features-title">
  <div class="section-inner">
    <div class="reveal">
      <p class="section-label">Why CodeVerse</p>
      <h2 class="section-title" id="features-title">Built for Builders,<br><em>Not Bureaucracy</em></h2>
    </div>

    <div class="features-grid reveal">

      <div class="feat-card">
        <span class="feat-number" aria-hidden="true">01</span>
        <div class="feat-icon-wrap cyan" aria-hidden="true"><i class="bi bi-shield-check"></i></div>
        <h3 class="feat-title">Verified Competitions</h3>
        <p class="feat-desc">Every hackathon is vetted and managed by real organizers. No spam, no scams — just genuine challenges worth your time.</p>
      </div>

      <div class="feat-card">
        <span class="feat-number" aria-hidden="true">02</span>
        <div class="feat-icon-wrap purple" aria-hidden="true"><i class="bi bi-people-fill"></i></div>
        <h3 class="feat-title">Smart Team Builder</h3>
        <p class="feat-desc">Create or join teams with invite-based flow, role assignments, and real-time collaboration status. One team per event, enforced.</p>
      </div>

      <div class="feat-card">
        <span class="feat-number" aria-hidden="true">03</span>
        <div class="feat-icon-wrap pink" aria-hidden="true"><i class="bi bi-trophy-fill"></i></div>
        <h3 class="feat-title">Live Leaderboards</h3>
        <p class="feat-desc">See rankings update in real-time as judges score projects. Transparent scoring criteria and public results for every event.</p>
      </div>

      <div class="feat-card">
        <span class="feat-number" aria-hidden="true">04</span>
        <div class="feat-icon-wrap cyan" aria-hidden="true"><i class="bi bi-send-fill"></i></div>
        <h3 class="feat-title">Streamlined Submissions</h3>
        <p class="feat-desc">Upload your project, add a GitHub link, write your pitch — all in one clean form. Judges see exactly what you intended.</p>
      </div>

      <div class="feat-card">
        <span class="feat-number" aria-hidden="true">05</span>
        <div class="feat-icon-wrap purple" aria-hidden="true"><i class="bi bi-bell-fill"></i></div>
        <h3 class="feat-title">Smart Notifications</h3>
        <p class="feat-desc">Get email alerts for team invites, deadline reminders, result announcements, and announcements from organizers.</p>
      </div>

      <div class="feat-card">
        <span class="feat-number" aria-hidden="true">06</span>
        <div class="feat-icon-wrap pink" aria-hidden="true"><i class="bi bi-graph-up-arrow"></i></div>
        <h3 class="feat-title">Participant Analytics</h3>
        <p class="feat-desc">Your personal dashboard tracks every hackathon you've joined, submitted, and won — a living portfolio of your skills.</p>
      </div>

    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     HOW IT WORKS
══════════════════════════════════════ -->
<section class="section how" id="how" aria-labelledby="how-title">
  <div class="section-inner">
    <div class="reveal">
      <p class="section-label">Participation Guide</p>
      <h2 class="section-title" id="how-title">Zero to Submitted<br><em>in 4 Steps</em></h2>
    </div>

    <div class="how-content">
      <div class="how-steps" role="list">

        <div class="how-step reveal" role="listitem">
          <div class="how-step-icon">
            <i class="bi bi-person-plus-fill" aria-hidden="true"></i>
            <span class="how-step-num" aria-hidden="true">1</span>
          </div>
          <div>
            <h3 class="how-step-title">Create Your Account</h3>
            <p class="how-step-desc">Sign up free in under 30 seconds. Add your skills, GitHub, and preferred tech stack to your profile — judges and teammates can see it.</p>
          </div>
        </div>

        <div class="how-step reveal reveal-delay-1" role="listitem">
          <div class="how-step-icon">
            <i class="bi bi-search" aria-hidden="true"></i>
            <span class="how-step-num" aria-hidden="true">2</span>
          </div>
          <div>
            <h3 class="how-step-title">Find &amp; Register</h3>
            <p class="how-step-desc">Browse open hackathons, filter by theme, prize, or team size, and register with one click. Free and paid events available.</p>
          </div>
        </div>

        <div class="how-step reveal reveal-delay-2" role="listitem">
          <div class="how-step-icon">
            <i class="bi bi-people-fill" aria-hidden="true"></i>
            <span class="how-step-num" aria-hidden="true">3</span>
          </div>
          <div>
            <h3 class="how-step-title">Build Your Team</h3>
            <p class="how-step-desc">Create a team or join one via invite link. Coordinate roles, share ideas, and collaborate — all tracked inside CodeVerse.</p>
          </div>
        </div>

        <div class="how-step reveal reveal-delay-3" role="listitem">
          <div class="how-step-icon">
            <i class="bi bi-send-fill" aria-hidden="true"></i>
            <span class="how-step-num" aria-hidden="true">4</span>
          </div>
          <div>
            <h3 class="how-step-title">Submit &amp; Win</h3>
            <p class="how-step-desc">Upload your project before the deadline. Judges review, rank, and announce winners — prizes are distributed digitally.</p>
          </div>
        </div>

      </div>

      <!-- Terminal Visual -->
      <div class="how-visual reveal" aria-label="Platform preview terminal">
        <div class="how-terminal-bar" aria-hidden="true">
          <span class="how-terminal-dot"></span>
          <span class="how-terminal-dot"></span>
          <span class="how-terminal-dot"></span>
          <span style="font-size:0.7rem;color:var(--text-muted);margin-left:10px;">codeverse — participant@terminal</span>
        </div>
        <div class="how-terminal-line"><span class="prompt">❯ </span><span class="cmd">cv register --hackathon "BioTech Innovate 2025"</span></div>
        <div class="how-terminal-line"><span class="out">✓ Registration confirmed. ID: CV-8421</span></div>
        <div class="how-terminal-line"><span class="out">✓ Confirmation email sent to dev@example.com</span></div>
        <div class="how-terminal-line">&nbsp;</div>
        <div class="how-terminal-line"><span class="prompt">❯ </span><span class="cmd">cv team create --name "ByteBuilders" --size 4</span></div>
        <div class="how-terminal-line"><span class="out accent2">⬡ Team created · Invite link generated</span></div>
        <div class="how-terminal-line"><span class="out">  → https://codeverse.io/join/BB-8421</span></div>
        <div class="how-terminal-line">&nbsp;</div>
        <div class="how-terminal-line"><span class="prompt">❯ </span><span class="cmd">cv submit --project ./bytegen-ai --demo https://...</span></div>
        <div class="how-terminal-line"><span class="out success">✓ Project submitted successfully!</span></div>
        <div class="how-terminal-line"><span class="out success">✓ Awaiting judge review · Good luck 🚀</span></div>
        <div class="how-terminal-line">&nbsp;</div>
        <div class="how-terminal-line"><span class="prompt">❯ </span><span class="how-terminal-cursor" aria-hidden="true"></span></div>
      </div>
    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     TESTIMONIALS
══════════════════════════════════════ -->
<section class="section testimonials" id="testimonials" aria-labelledby="testi-title">
  <div class="section-inner">
    <div class="testimonials-header reveal">
      <div>
        <p class="section-label">Participant Voices</p>
        <h2 class="section-title" id="testi-title">What Builders <em>Say</em></h2>
      </div>
      <p class="section-sub" style="max-width:360px;">Real reviews from real participants across our last three seasons.</p>
    </div>
  </div>

  <div class="testimonials-track-wrap" aria-label="Scrolling testimonials" role="region">
    <div class="testimonials-track" aria-live="off">

      <!-- Duplicated set for seamless loop -->
      <div class="testi-card">
        <p class="testi-quote">The team invitation system is incredibly smooth. We formed our squad in minutes and got straight to building. Best hackathon platform I've used.</p>
        <div class="testi-author">
          <div class="testi-avatar" aria-hidden="true">A</div>
          <div>
            <div class="testi-name">Aryan Mehta</div>
            <div class="testi-role">Full-stack Developer · Mumbai</div>
            <div class="testi-stars" aria-label="5 out of 5 stars">★★★★★</div>
          </div>
        </div>
      </div>

      <div class="testi-card">
        <p class="testi-quote">Judging panel was transparent and the scoring rubric was visible to all. For once I felt like I understood WHY we placed where we did.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#ff5c8a,#7b5cff)" aria-hidden="true">P</div>
          <div>
            <div class="testi-name">Priya Sharma</div>
            <div class="testi-role">AI Engineer · Bangalore</div>
            <div class="testi-stars" aria-label="5 out of 5 stars">★★★★★</div>
          </div>
        </div>
      </div>

      <div class="testi-card">
        <p class="testi-quote">We won ₹50k in the FinTech hackathon. The submission portal was dead simple and the whole experience felt genuinely professional.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#00ffe0,#00c896)" aria-hidden="true">K</div>
          <div>
            <div class="testi-name">Karan Patel</div>
            <div class="testi-role">Backend Developer · Ahmedabad</div>
            <div class="testi-stars" aria-label="5 out of 5 stars">★★★★★</div>
          </div>
        </div>
      </div>

      <div class="testi-card">
        <p class="testi-quote">CodeVerse is the only platform where I've found quality teammates easily. The profile system shows actual skills, not just buzzwords.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#fbbf24,#f59e0b)" aria-hidden="true">S</div>
          <div>
            <div class="testi-name">Sneha Reddy</div>
            <div class="testi-role">Product Manager · Hyderabad</div>
            <div class="testi-stars" aria-label="5 out of 5 stars">★★★★★</div>
          </div>
        </div>
      </div>

      <div class="testi-card">
        <p class="testi-quote">Organized three hackathons on here as an admin. The dashboard makes managing 200+ participants feel like managing 20. Really impressive tooling.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#7b5cff,#00ffe0)" aria-hidden="true">R</div>
          <div>
            <div class="testi-name">Rahul Singh</div>
            <div class="testi-role">Hackathon Organizer · Delhi</div>
            <div class="testi-stars" aria-label="5 out of 5 stars">★★★★★</div>
          </div>
        </div>
      </div>

      <!-- Duplicate for seamless loop -->
      <div class="testi-card" aria-hidden="true">
        <p class="testi-quote">The team invitation system is incredibly smooth. We formed our squad in minutes and got straight to building. Best hackathon platform I've used.</p>
        <div class="testi-author">
          <div class="testi-avatar">A</div>
          <div>
            <div class="testi-name">Aryan Mehta</div>
            <div class="testi-role">Full-stack Developer · Mumbai</div>
            <div class="testi-stars">★★★★★</div>
          </div>
        </div>
      </div>
      <div class="testi-card" aria-hidden="true">
        <p class="testi-quote">Judging panel was transparent and the scoring rubric was visible to all. For once I felt like I understood WHY we placed where we did.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#ff5c8a,#7b5cff)">P</div>
          <div>
            <div class="testi-name">Priya Sharma</div>
            <div class="testi-role">AI Engineer · Bangalore</div>
            <div class="testi-stars">★★★★★</div>
          </div>
        </div>
      </div>
      <div class="testi-card" aria-hidden="true">
        <p class="testi-quote">We won ₹50k in the FinTech hackathon. The submission portal was dead simple and the whole experience felt genuinely professional.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#00ffe0,#00c896)">K</div>
          <div>
            <div class="testi-name">Karan Patel</div>
            <div class="testi-role">Backend Developer · Ahmedabad</div>
            <div class="testi-stars">★★★★★</div>
          </div>
        </div>
      </div>
      <div class="testi-card" aria-hidden="true">
        <p class="testi-quote">CodeVerse is the only platform where I've found quality teammates easily. The profile system shows actual skills, not just buzzwords.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#fbbf24,#f59e0b)">S</div>
          <div>
            <div class="testi-name">Sneha Reddy</div>
            <div class="testi-role">Product Manager · Hyderabad</div>
            <div class="testi-stars">★★★★★</div>
          </div>
        </div>
      </div>
      <div class="testi-card" aria-hidden="true">
        <p class="testi-quote">Organized three hackathons on here as an admin. The dashboard makes managing 200+ participants feel like managing 20. Really impressive tooling.</p>
        <div class="testi-author">
          <div class="testi-avatar" style="background:linear-gradient(135deg,#7b5cff,#00ffe0)">R</div>
          <div>
            <div class="testi-name">Rahul Singh</div>
            <div class="testi-role">Hackathon Organizer · Delhi</div>
            <div class="testi-stars">★★★★★</div>
          </div>
        </div>
      </div>

    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     SPONSORS
══════════════════════════════════════ -->
<section class="sponsors" id="sponsors" aria-label="Platform sponsors">
  <div class="section-inner">
    <p class="sponsors-label">Trusted by teams from</p>
    <div class="sponsors-row" role="list">
      <span class="sponsor-logo" role="listitem">TechCorp</span>
      <span class="sponsor-logo" role="listitem">NovaSystems</span>
      <span class="sponsor-logo" role="listitem">PixelLabs</span>
      <span class="sponsor-logo" role="listitem">DataBridge</span>
      <span class="sponsor-logo" role="listitem">Cloudify</span>
      <span class="sponsor-logo" role="listitem">BuildOS</span>
    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     FAQ
══════════════════════════════════════ -->
<section class="section faq" id="faq" aria-labelledby="faq-title">
  <div class="section-inner">
    <div style="text-align:center;margin-bottom:0" class="reveal">
      <p class="section-label">Got Questions?</p>
      <h2 class="section-title" id="faq-title">Frequently <em>Asked</em></h2>
    </div>

    <div class="faq-grid" role="list">

      <div class="faq-item reveal" role="listitem">
        <div class="faq-q" role="button" tabindex="0" aria-expanded="false" aria-controls="faq-1">
          <span class="faq-q-text">Is CodeVerse free to join?</span>
          <span class="faq-icon" aria-hidden="true"><i class="bi bi-plus"></i></span>
        </div>
        <div class="faq-a" id="faq-1" role="region">
          <p class="faq-a-inner">Yes — creating an account is completely free. Individual hackathons may have entry fees set by organizers, which will be clearly shown on each event card.</p>
        </div>
      </div>

      <div class="faq-item reveal reveal-delay-1" role="listitem">
        <div class="faq-q" role="button" tabindex="0" aria-expanded="false" aria-controls="faq-2">
          <span class="faq-q-text">Can I participate solo or only in teams?</span>
          <span class="faq-icon" aria-hidden="true"><i class="bi bi-plus"></i></span>
        </div>
        <div class="faq-a" id="faq-2" role="region">
          <p class="faq-a-inner">It depends on the hackathon. Each event sets its own minimum and maximum team size. Some allow solo participation (min 1), while others require full squads.</p>
        </div>
      </div>

      <div class="faq-item reveal reveal-delay-2" role="listitem">
        <div class="faq-q" role="button" tabindex="0" aria-expanded="false" aria-controls="faq-3">
          <span class="faq-q-text">How does judging work?</span>
          <span class="faq-icon" aria-hidden="true"><i class="bi bi-plus"></i></span>
        </div>
        <div class="faq-a" id="faq-3" role="region">
          <p class="faq-a-inner">Judges are assigned by the organizer and score each submitted project on the hackathon's predefined criteria. Scores are tallied automatically and rankings go live once judging closes.</p>
        </div>
      </div>

      <div class="faq-item reveal reveal-delay-3" role="listitem">
        <div class="faq-q" role="button" tabindex="0" aria-expanded="false" aria-controls="faq-4">
          <span class="faq-q-text">Can I be on multiple teams across different hackathons?</span>
          <span class="faq-icon" aria-hidden="true"><i class="bi bi-plus"></i></span>
        </div>
        <div class="faq-a" id="faq-4" role="region">
          <p class="faq-a-inner">Yes, but only one team per hackathon per user. You can compete in multiple simultaneous events as long as you join a different team for each one.</p>
        </div>
      </div>

      <div class="faq-item reveal" role="listitem">
        <div class="faq-q" role="button" tabindex="0" aria-expanded="false" aria-controls="faq-5">
          <span class="faq-q-text">How do I organize my own hackathon?</span>
          <span class="faq-icon" aria-hidden="true"><i class="bi bi-plus"></i></span>
        </div>
        <div class="faq-a" id="faq-5" role="region">
          <p class="faq-a-inner">Organizer access is available through our Admin panel. Contact our team to get your institution or company whitelisted as an organizer. Setup takes less than 10 minutes.</p>
        </div>
      </div>

      <div class="faq-item reveal reveal-delay-1" role="listitem">
        <div class="faq-q" role="button" tabindex="0" aria-expanded="false" aria-controls="faq-6">
          <span class="faq-q-text">What happens after I submit my project?</span>
          <span class="faq-icon" aria-hidden="true"><i class="bi bi-plus"></i></span>
        </div>
        <div class="faq-a" id="faq-6" role="region">
          <p class="faq-a-inner">You'll receive a confirmation email and your submission appears in your dashboard. Judges are notified and begin reviewing. Results are emailed and posted on the hackathon's leaderboard page.</p>
        </div>
      </div>

    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     CTA BAND
══════════════════════════════════════ -->
<section class="cta-band" aria-labelledby="cta-title">
  <div class="cta-band-orb" aria-hidden="true"></div>
  <div class="section-inner">
    <h2 class="cta-band-title" id="cta-title">
      Your Next Win<br><em>Starts Here.</em>
    </h2>
    <p class="cta-band-sub">Join 12,400+ developers competing on CodeVerse. Free to start. No credit card needed.</p>
    <div class="cta-band-actions">
      <a href="#" class="btn-primary" id="ctaBandBtn" style="font-size:1rem;padding:18px 48px;">
        <i class="bi bi-rocket-takeoff-fill" aria-hidden="true"></i>
        Create Free Account
      </a>
      <a href="#discovery" class="btn-ghost" style="font-size:1rem;padding:17px 48px;">Browse Hackathons</a>
    </div>
  </div>
</section>


<!-- ══════════════════════════════════════
     FOOTER
══════════════════════════════════════ -->
<footer role="contentinfo">
  <div class="footer-inner">
    <div class="footer-top">

      <div>
        <a href="/" class="cv-logo" aria-label="CodeVerse home">Code<span>Verse</span></a>
        <p class="footer-brand-desc">The elite hackathon platform built for serious builders. Compete, collaborate, and conquer.</p>
      </div>

      <div>
        <h3 class="footer-col-title">Platform</h3>
        <ul class="footer-links" role="list">
          <li><a href="#discovery">Hackathons</a></li>
          <li><a href="#how">How It Works</a></li>
          <li><a href="/login">Dashboard</a></li>
          <li><a href="/past">Past Events</a></li>
        </ul>
      </div>

      <div>
        <h3 class="footer-col-title">Company</h3>
        <ul class="footer-links" role="list">
          <li><a href="/about">About</a></li>
          <li><a href="/blog">Blog</a></li>
          <li><a href="/organize">Organize</a></li>
          <li><a href="/contact">Contact</a></li>
        </ul>
      </div>

      <div>
        <h3 class="footer-col-title">Legal</h3>
        <ul class="footer-links" role="list">
          <li><a href="/terms">Terms of Service</a></li>
          <li><a href="/privacy">Privacy Policy</a></li>
          <li><a href="/cookies">Cookie Policy</a></li>
        </ul>
      </div>

    </div>

    <div class="footer-bottom">
      <p class="footer-copy">© 2025 CodeVerse. All rights reserved. Made with ❤️ in India.</p>
      <div class="footer-socials" role="list" aria-label="Social links">
        <a href="#" class="footer-social" role="listitem" aria-label="Twitter"><i class="bi bi-twitter-x"></i></a>
        <a href="#" class="footer-social" role="listitem" aria-label="LinkedIn"><i class="bi bi-linkedin"></i></a>
        <a href="#" class="footer-social" role="listitem" aria-label="GitHub"><i class="bi bi-github"></i></a>
        <a href="#" class="footer-social" role="listitem" aria-label="Discord"><i class="bi bi-discord"></i></a>
      </div>
    </div>
  </div>
</footer>


<!-- ══════════════════════════════════════
     REGISTER MODAL
══════════════════════════════════════ -->
<div class="modal-overlay" id="registerModal" role="dialog" aria-modal="true" aria-labelledby="modal-title">
  <div class="modal-box">
    <button class="modal-close" id="modalClose" aria-label="Close registration modal">
      <i class="bi bi-x-lg" aria-hidden="true"></i>
    </button>
    <h2 class="modal-title" id="modal-title">Join CodeVerse</h2>
    <p class="modal-sub">Start competing in elite hackathons — free forever.</p>

    <div class="modal-field">
      <label class="modal-label" for="reg-name">Full Name</label>
      <input class="modal-input" id="reg-name" type="text" placeholder="Your full name" autocomplete="name" />
    </div>
    <div class="modal-field">
      <label class="modal-label" for="reg-email">Email Address</label>
      <input class="modal-input" id="reg-email" type="email" placeholder="you@example.com" autocomplete="email" />
    </div>
    <div class="modal-field">
      <label class="modal-label" for="reg-pass">Password</label>
      <input class="modal-input" id="reg-pass" type="password" placeholder="Min. 8 characters" autocomplete="new-password" />
    </div>

    <button class="modal-btn" type="button" onclick="window.location='/signup'">
      Create Account <i class="bi bi-arrow-right" aria-hidden="true"></i>
    </button>

    <p style="text-align:center;font-size:0.76rem;color:var(--text-muted);margin-top:20px;">
      Already have an account? <a href="/login" style="color:var(--accent);">Log in</a>
    </p>
  </div>
</div>


<!-- ══════════════════════════════════════
     JAVASCRIPT
══════════════════════════════════════ -->
<script>
(function() {

  /* ── Navbar scroll state ── */
  const navbar = document.getElementById('navbar');
  window.addEventListener('scroll', () => {
    navbar.classList.toggle('scrolled', window.scrollY > 60);
  }, { passive: true });

  /* ── Modal logic ── */
  const overlay = document.getElementById('registerModal');
  const closeBtn = document.getElementById('modalClose');
  const openers = ['navRegisterBtn', 'heroSignupBtn', 'ctaBandBtn'];

  function openModal() {
    overlay.classList.add('open');
    document.body.style.overflow = 'hidden';
    overlay.querySelector('.modal-input').focus();
  }
  function closeModal() {
    overlay.classList.remove('open');
    document.body.style.overflow = '';
  }

  openers.forEach(id => {
    const el = document.getElementById(id);
    if (el) el.addEventListener('click', e => { e.preventDefault(); openModal(); });
  });
  closeBtn.addEventListener('click', closeModal);
  overlay.addEventListener('click', e => { if (e.target === overlay) closeModal(); });
  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

  /* ── FAQ accordion ── */
  document.querySelectorAll('.faq-q').forEach(btn => {
    btn.addEventListener('click', () => {
      const item = btn.closest('.faq-item');
      const isOpen = item.classList.contains('open');
      document.querySelectorAll('.faq-item.open').forEach(i => i.classList.remove('open'));
      if (!isOpen) item.classList.add('open');
      btn.setAttribute('aria-expanded', !isOpen);
    });
    btn.addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); btn.click(); } });
  });

  /* ── Filter pills (UI only) ── */
  document.querySelectorAll('.filter-pill').forEach(pill => {
    pill.addEventListener('click', () => {
      document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
      pill.classList.add('active');
    });
  });

  /* ── Scroll reveal ── */
  const reveals = document.querySelectorAll('.reveal');
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });
  reveals.forEach(el => observer.observe(el));

  /* ── Smooth anchor scroll ── */
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const target = document.querySelector(a.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  /* ── Hackathon card → login redirect ── */
  document.querySelectorAll('.hk-card').forEach(card => {
    card.addEventListener('click', () => window.location.href = '/login');
    card.addEventListener('keydown', e => {
      if (e.key === 'Enter') window.location.href = '/login';
    });
  });

})();
</script>

</body>
</html>