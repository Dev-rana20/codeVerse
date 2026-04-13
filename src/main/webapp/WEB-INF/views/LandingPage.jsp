<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <!DOCTYPE html>
      <html lang="en" data-theme="dark">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>CodeVerse — Architect the Future</title>
        <meta name="description"
          content="Compete in elite hackathons. Build transformative software, connect with top talent, and claim your place on the global leaderboard." />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link
          href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=JetBrains+Mono:wght@300;400;500;700&display=swap"
          rel="stylesheet" />
        <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
        <style>
          :root {
            --bg-base: #07080f;
            --bg-surface: #0d1020;
            --bg-card: rgba(13, 16, 32, .72);
            --bg-card-hov: rgba(18, 22, 42, .85);
            --accent: #00ffe0;
            --accent-dim: rgba(0, 255, 224, .12);
            --accent-glow: rgba(0, 255, 224, .35);
            --accent2: #7b5cff;
            --accent2-dim: rgba(123, 92, 255, .15);
            --accent3: #ff5c8a;
            --text-primary: #f0f0f5;
            --text-muted: #6b7280;
            --text-sub: #9ca3af;
            --border: rgba(255, 255, 255, .07);
            --border-hov: rgba(0, 255, 224, .25);
            --font-display: 'Syne', sans-serif;
            --font-mono: 'JetBrains Mono', monospace;
            --radius-sm: 10px;
            --radius-md: 18px;
            --radius-lg: 28px;
            --transition: .3s cubic-bezier(.4, 0, .2, 1)
          }

          *,
          *::before,
          *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0
          }

          html {
            scroll-behavior: smooth;
            scrollbar-width: thin;
            scrollbar-color: var(--accent2) var(--bg-surface)
          }

          body {
            background: var(--bg-base);
            color: var(--text-primary);
            font-family: var(--font-mono);
            overflow-x: hidden;
            line-height: 1.6
          }

          a {
            text-decoration: none;
            color: inherit
          }

          img {
            display: block;
            max-width: 100%
          }

          body::after {
            content: '';
            position: fixed;
            width: 8px;
            height: 8px;
            background: var(--accent);
            border-radius: 50%;
            pointer-events: none;
            z-index: 9999;
            transform: translate(-50%, -50%);
            transition: transform .08s ease, opacity .2s;
            top: var(--cy, -20px);
            left: var(--cx, -20px);
            opacity: 0
          }

          .noise-overlay {
            position: fixed;
            inset: 0;
            z-index: 0;
            pointer-events: none;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
            opacity: .5
          }

          .cv-nav {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 48px;
            background: rgba(7, 8, 15, .6);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            transition: padding var(--transition), background var(--transition)
          }

          .cv-nav.scrolled {
            padding: 12px 48px;
            background: rgba(7, 8, 15, .92);
            border-bottom-color: rgba(0, 255, 224, .1)
          }

          .cv-logo {
            font-family: var(--font-display);
            font-size: 1.4rem;
            font-weight: 800;
            letter-spacing: -.03em;
            background: linear-gradient(135deg, #fff 30%, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text
          }

          .cv-logo span {
            color: var(--accent);
            -webkit-text-fill-color: var(--accent)
          }

          .cv-nav-links {
            display: flex;
            align-items: center;
            gap: 36px;
            list-style: none
          }

          .cv-nav-links a {
            font-size: .78rem;
            font-weight: 500;
            letter-spacing: .08em;
            text-transform: uppercase;
            color: var(--text-sub);
            transition: color var(--transition);
            position: relative
          }

          .cv-nav-links a::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            right: 100%;
            height: 1px;
            background: var(--accent);
            transition: right var(--transition)
          }

          .cv-nav-links a:hover {
            color: var(--accent)
          }

          .cv-nav-links a:hover::after {
            right: 0
          }

          .cv-nav-actions {
            display: flex;
            align-items: center;
            gap: 14px
          }

          .btn-nav-ghost {
            font-family: var(--font-mono);
            font-size: .78rem;
            font-weight: 500;
            letter-spacing: .06em;
            color: var(--text-sub);
            padding: 8px 20px;
            border: 1px solid var(--border);
            border-radius: 40px;
            transition: all var(--transition)
          }

          .btn-nav-ghost:hover {
            border-color: var(--accent);
            color: var(--accent)
          }

          .btn-nav-primary {
            font-family: var(--font-mono);
            font-size: .78rem;
            font-weight: 600;
            letter-spacing: .06em;
            padding: 10px 24px;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            color: #000;
            border-radius: 40px;
            border: none;
            transition: all var(--transition);
            box-shadow: 0 0 18px var(--accent-glow)
          }

          .btn-nav-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px var(--accent-glow)
          }

          .hero {
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 48px 80px;
            overflow: hidden
          }

          .hero-orb {
            position: absolute;
            width: 600px;
            height: 600px;
            border-radius: 50%;
            background: radial-gradient(circle, var(--accent-glow), transparent 70%);
            filter: blur(80px);
            opacity: .4;
            animation: float 12s ease-in-out infinite;
            pointer-events: none
          }

          @keyframes float {

            0%,
            100% {
              transform: translate(0, 0) scale(1)
            }

            50% {
              transform: translate(40px, -30px) scale(1.1)
            }
          }

          .hero-content {
            position: relative;
            z-index: 10;
            max-width: 900px;
            text-align: center
          }

          .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 18px;
            background: var(--accent-dim);
            border: 1px solid rgba(0, 255, 224, .3);
            border-radius: 30px;
            font-size: .72rem;
            font-weight: 600;
            letter-spacing: .08em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 24px
          }

          .hero-title {
            font-family: var(--font-display);
            font-size: clamp(2.8rem, 7vw, 5.2rem);
            font-weight: 800;
            line-height: 1.1;
            letter-spacing: -.03em;
            margin-bottom: 24px;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text
          }

          .hero-title em {
            font-style: normal;
            color: var(--accent);
            -webkit-text-fill-color: var(--accent)
          }

          .hero-sub {
            font-size: 1.1rem;
            color: var(--text-sub);
            max-width: 650px;
            margin: 0 auto 40px;
            line-height: 1.7
          }

          .hero-actions {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 18px;
            flex-wrap: wrap
          }

          .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-family: var(--font-mono);
            font-size: .88rem;
            font-weight: 600;
            letter-spacing: .04em;
            padding: 16px 36px;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            color: #000;
            border-radius: 50px;
            border: none;
            transition: all var(--transition);
            box-shadow: 0 4px 24px var(--accent-glow)
          }

          .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 40px var(--accent-glow)
          }

          .btn-ghost {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-family: var(--font-mono);
            font-size: .88rem;
            font-weight: 500;
            padding: 15px 36px;
            border: 1px solid var(--border);
            border-radius: 50px;
            color: var(--text-sub);
            transition: all var(--transition)
          }

          .btn-ghost:hover {
            border-color: var(--accent);
            color: var(--accent)
          }

          .hero-stats {
            display: flex;
            justify-content: center;
            gap: 48px;
            margin-top: 60px;
            flex-wrap: wrap
          }

          .stat-item {
            text-align: center
          }

          .stat-value {
            font-family: var(--font-display);
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--accent);
            display: block;
            margin-bottom: 6px
          }

          .stat-label {
            font-size: .76rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: .08em
          }

          section {
            position: relative;
            padding: 100px 48px;
            z-index: 1
          }

          .section-inner {
            max-width: 1280px;
            margin: 0 auto
          }

          .section-header {
            text-align: center;
            margin-bottom: 64px
          }

          .section-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            background: var(--accent2-dim);
            border: 1px solid rgba(123, 92, 255, .3);
            border-radius: 30px;
            font-size: .68rem;
            font-weight: 600;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: var(--accent2);
            margin-bottom: 16px
          }

          .section-title {
            font-family: var(--font-display);
            font-size: clamp(2rem, 5vw, 3.2rem);
            font-weight: 800;
            line-height: 1.2;
            letter-spacing: -.02em;
            margin-bottom: 16px
          }

          .section-title em {
            font-style: normal;
            color: var(--accent)
          }

          .section-sub {
            font-size: 1.05rem;
            color: var(--text-muted);
            max-width: 700px;
            margin: 0 auto
          }

          .reveal {
            opacity: 0;
            transform: translateY(30px);
            transition: all .8s cubic-bezier(.4, 0, .2, 1)
          }

          .reveal.visible {
            opacity: 1;
            transform: translateY(0)
          }

          .steps-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 32px
          }

          .step-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 32px;
            transition: all var(--transition)
          }

          .step-card:hover {
            background: var(--bg-card-hov);
            border-color: var(--border-hov);
            transform: translateY(-4px)
          }

          .step-num {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 48px;
            height: 48px;
            background: var(--accent-dim);
            border: 1px solid rgba(0, 255, 224, .3);
            border-radius: 50%;
            font-family: var(--font-display);
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--accent);
            margin-bottom: 20px
          }

          .step-title {
            font-family: var(--font-display);
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 10px
          }

          .step-desc {
            font-size: .88rem;
            color: var(--text-muted);
            line-height: 1.6
          }

          .filter-bar {
            display: flex;
            gap: 12px;
            margin-bottom: 40px;
            flex-wrap: wrap;
            justify-content: center
          }

          .filter-pill {
            padding: 10px 24px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 30px;
            font-size: .78rem;
            font-weight: 500;
            letter-spacing: .06em;
            color: var(--text-sub);
            transition: all var(--transition);
            cursor: pointer
          }

          .filter-pill:hover,
          .filter-pill.active {
            background: var(--accent-dim);
            border-color: rgba(0, 255, 224, .4);
            color: var(--accent)
          }

          .hk-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 28px
          }

          .hk-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            overflow: hidden;
            transition: all var(--transition);
            cursor: pointer
          }

          .hk-card:hover {
            border-color: var(--border-hov);
            transform: translateY(-4px);
            box-shadow: 0 8px 32px rgba(0, 255, 224, .08)
          }

          .hk-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: linear-gradient(135deg, var(--accent-dim), var(--accent2-dim))
          }

          .hk-body {
            padding: 24px
          }

          .hk-meta {
            display: flex;
            gap: 12px;
            margin-bottom: 12px;
            flex-wrap: wrap
          }

          .hk-tag {
            padding: 4px 12px;
            background: rgba(123, 92, 255, .15);
            border: 1px solid rgba(123, 92, 255, .3);
            border-radius: 20px;
            font-size: .68rem;
            font-weight: 600;
            letter-spacing: .06em;
            color: var(--accent2)
          }

          .hk-title {
            font-family: var(--font-display);
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 10px
          }

          .hk-desc {
            font-size: .84rem;
            color: var(--text-muted);
            margin-bottom: 18px;
            line-height: 1.5
          }

          .hk-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 16px;
            border-top: 1px solid var(--border)
          }

          .hk-prize {
            font-family: var(--font-display);
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--accent)
          }

          .hk-date {
            font-size: .76rem;
            color: var(--text-muted)
          }

          .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 28px;
            margin-top: 48px
          }

          .feat-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 32px;
            transition: all var(--transition)
          }

          .feat-card:hover {
            background: var(--bg-card-hov);
            border-color: var(--border-hov);
            transform: translateY(-4px)
          }

          .feat-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 56px;
            height: 56px;
            background: var(--accent-dim);
            border: 1px solid rgba(0, 255, 224, .3);
            border-radius: var(--radius-sm);
            font-size: 1.6rem;
            color: var(--accent);
            margin-bottom: 20px
          }

          .feat-title {
            font-family: var(--font-display);
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 10px
          }

          .feat-desc {
            font-size: .88rem;
            color: var(--text-muted);
            line-height: 1.6
          }

          .faq-list {
            max-width: 900px;
            margin: 0 auto
          }

          .faq-item {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            margin-bottom: 16px;
            overflow: hidden;
            transition: all var(--transition)
          }

          .faq-item:hover {
            border-color: var(--border-hov)
          }

          .faq-q {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 24px 28px;
            background: transparent;
            border: none;
            color: var(--text-primary);
            font-family: var(--font-display);
            font-size: 1.1rem;
            font-weight: 700;
            text-align: left;
            cursor: pointer;
            transition: color var(--transition)
          }

          .faq-q:hover {
            color: var(--accent)
          }

          .faq-q i {
            transition: transform var(--transition);
            color: var(--accent)
          }

          .faq-item.open .faq-q i {
            transform: rotate(180deg)
          }

          .faq-a {
            max-height: 0;
            overflow: hidden;
            transition: max-height var(--transition)
          }

          .faq-item.open .faq-a {
            max-height: 300px
          }

          .faq-a-inner {
            padding: 0 28px 24px;
            font-size: .9rem;
            color: var(--text-muted);
            line-height: 1.7
          }

          .cta-band {
            position: relative;
            padding: 120px 48px;
            text-align: center;
            overflow: hidden
          }

          .cta-band-orb {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 800px;
            height: 400px;
            background: radial-gradient(circle, var(--accent-glow), transparent 70%);
            filter: blur(100px);
            opacity: .3;
            pointer-events: none
          }

          .cta-band-title {
            font-family: var(--font-display);
            font-size: clamp(2.4rem, 6vw, 4rem);
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 20px
          }

          .cta-band-title em {
            font-style: normal;
            color: var(--accent)
          }

          .cta-band-sub {
            font-size: 1.1rem;
            color: var(--text-muted);
            margin-bottom: 40px
          }

          .cta-band-actions {
            display: flex;
            justify-content: center;
            gap: 18px;
            flex-wrap: wrap
          }

          footer {
            background: var(--bg-surface);
            border-top: 1px solid var(--border);
            padding: 80px 48px 40px
          }

          .footer-inner {
            max-width: 1280px;
            margin: 0 auto
          }

          .footer-top {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 48px;
            margin-bottom: 48px
          }

          .footer-brand-desc {
            font-size: .84rem;
            color: var(--text-muted);
            margin-top: 12px;
            max-width: 280px;
            line-height: 1.6
          }

          .footer-col-title {
            font-family: var(--font-display);
            font-size: .9rem;
            font-weight: 700;
            margin-bottom: 16px
          }

          .footer-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 10px
          }

          .footer-links a {
            font-size: .82rem;
            color: var(--text-muted);
            transition: color var(--transition)
          }

          .footer-links a:hover {
            color: var(--accent)
          }

          .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 32px;
            border-top: 1px solid var(--border);
            flex-wrap: wrap;
            gap: 20px
          }

          .footer-copy {
            font-size: .78rem;
            color: var(--text-muted)
          }

          .footer-socials {
            display: flex;
            gap: 16px
          }

          .footer-social {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            border: 1px solid var(--border);
            border-radius: 50%;
            color: var(--text-muted);
            transition: all var(--transition)
          }

          .footer-social:hover {
            border-color: var(--accent);
            color: var(--accent);
            transform: translateY(-3px)
          }

          .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .85);
            backdrop-filter: blur(8px);
            z-index: 2000;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: all var(--transition)
          }

          .modal-overlay.open {
            opacity: 1;
            visibility: visible
          }

          .modal-box {
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 48px;
            max-width: 480px;
            width: 90%;
            position: relative;
            transform: scale(.95);
            transition: transform var(--transition)
          }

          .modal-overlay.open .modal-box {
            transform: scale(1)
          }

          .modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: 1px solid var(--border);
            border-radius: 50%;
            color: var(--text-sub);
            cursor: pointer;
            transition: all var(--transition)
          }

          .modal-close:hover {
            border-color: var(--accent);
            color: var(--accent)
          }

          .modal-title {
            font-family: var(--font-display);
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 8px
          }

          .modal-sub {
            font-size: .9rem;
            color: var(--text-muted);
            margin-bottom: 32px
          }

          .modal-field {
            margin-bottom: 20px
          }

          .modal-label {
            display: block;
            font-size: .82rem;
            font-weight: 600;
            color: var(--text-sub);
            margin-bottom: 8px;
            letter-spacing: .04em
          }

          .modal-input {
            width: 100%;
            padding: 14px 18px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            color: var(--text-primary);
            font-family: var(--font-mono);
            font-size: .88rem;
            transition: all var(--transition)
          }

          .modal-input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px var(--accent-dim)
          }

          .modal-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            color: #000;
            border: none;
            border-radius: var(--radius-sm);
            font-family: var(--font-mono);
            font-size: .92rem;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px
          }

          .modal-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px var(--accent-glow)
          }

          @media(max-width:768px) {
            .cv-nav {
              padding: 12px 24px
            }

            .cv-nav-links {
              display: none
            }

            .hero {
              padding: 100px 24px 60px
            }

            .hero-title {
              font-size: 2.4rem
            }

            .hero-stats {
              gap: 28px
            }

            .btn-primary,
            .btn-ghost {
              font-size: .82rem;
              padding: 12px 28px
            }

            section {
              padding: 60px 24px
            }

            .steps-grid,
            .hk-grid,
            .features-grid {
              grid-template-columns: 1fr
            }

            .footer-top {
              grid-template-columns: 1fr
            }
          }
        </style>
      </head>

      <body>
        <div class="noise-overlay"></div>

        <!-- NAVBAR -->
        <nav class="cv-nav" id="navbar">
          <a href="/" class="cv-logo">Code<span>Verse</span></a>
          <ul class="cv-nav-links">
            <li><a href="#discovery">Hackathons</a></li>
            <li><a href="#how">How It Works</a></li>
            <li><a href="#features">Features</a></li>
            <li><a href="#faq">FAQ</a></li>
          </ul>
          <div class="cv-nav-actions">
            <a href="/login" class="btn-nav-ghost">Log In</a>
            <a href="/signup" class="btn-nav-primary" id="navRegisterBtn">Sign Up</a>
          </div>
        </nav>

        <!-- HERO -->
        <section class="hero">
          <div class="hero-orb" style="top:20%;left:30%"></div>
          <div class="hero-orb" style="top:60%;right:20%;animation-delay:-4s"></div>
          <div class="hero-content">
            <div class="hero-badge"><i class="bi bi-lightning-charge-fill"></i>12,400+ Developers Competing</div>
            <h1 class="hero-title">Architect the Future.<br><em>One Hack at a Time.</em></h1>
            <p class="hero-sub">Join elite hackathons, build groundbreaking software, and compete on the global stage.
              Your next breakthrough starts here.</p>
            <div class="hero-actions">
              <a href="/signup" class="btn-primary" id="heroSignupBtn"><i class="bi bi-rocket-takeoff-fill"></i>Start
                Competing — Free</a>
              <a href="#discovery" class="btn-ghost">Explore Hackathons <i class="bi bi-arrow-right"></i></a>
            </div>
            <div class="hero-stats">
              <div class="stat-item"><span class="stat-value">$2.4M+</span><span class="stat-label">Prize Pool</span>
              </div>
              <div class="stat-item"><span class="stat-value">340+</span><span class="stat-label">Events Hosted</span>
              </div>
              <div class="stat-item"><span class="stat-value">89%</span><span class="stat-label">Win Rate</span></div>
            </div>
          </div>
        </section>

        <!-- HOW IT WORKS -->
        <section id="how">
          <div class="section-inner">
            <div class="section-header reveal">
              <div class="section-badge"><i class="bi bi-gear-fill"></i>How It Works</div>
              <h2 class="section-title">From Sign-Up to <em>Victory</em></h2>
              <p class="section-sub">Join CodeVerse in three simple steps and start competing within minutes.</p>
            </div>
            <div class="steps-grid">
              <div class="step-card reveal">
                <div class="step-num">1</div>
                <h3 class="step-title">Create Your Account</h3>
                <p class="step-desc">Sign up for free in under 30 seconds. No credit card required. Build your developer
                  profile and showcase your skills.</p>
              </div>
              <div class="step-card reveal">
                <div class="step-num">2</div>
                <h3 class="step-title">Choose Your Battle</h3>
                <p class="step-desc">Browse active hackathons across AI, Web3, Mobile, and more. Filter by prize,
                  difficulty, and tech stack.</p>
              </div>
              <div class="step-card reveal">
                <div class="step-num">3</div>
                <h3 class="step-title">Build & Win</h3>
                <p class="step-desc">Submit your project before the deadline. Get judged by industry experts. Claim
                  prizes
                  and climb the leaderboard.</p>
              </div>
            </div>
          </div>
        </section>

        <!-- HACKATHONS -->
        <section id="discovery">
          <div class="section-inner">
            <div class="section-header reveal">
              <div class="section-badge"><i class="bi bi-trophy-fill"></i>Active Now</div>
              <h2 class="section-title">Compete in <em>Elite Hackathons</em></h2>
              <p class="section-sub">340+ events across AI, Web3, Mobile, and more. Find your arena.</p>
            </div>
            <div class="filter-bar">
              <button class="filter-pill active">All</button>
              <button class="filter-pill">AI & ML</button>
              <button class="filter-pill">Web3</button>
              <button class="filter-pill">Mobile</button>
              <button class="filter-pill">Cloud</button>
            </div>
            <div class="hk-grid">
              <c:forEach items="${hackathons}" var="hackathon">
                <div class="hk-card" tabindex="0" onclick="location.href='hackathonDetail/${hackathon.hackathonId}'">
                  <c:choose>
                    <c:when test="${fn:containsIgnoreCase(hackathon.eventType, 'AI') or fn:containsIgnoreCase(hackathon.eventType, 'ML')}">
                      <img src="https://images.unsplash.com/photo-1677442135703-1787eea5ce01?q=80&w=800&auto=format&fit=crop" class="hk-img" alt="AI Hackathon">
                    </c:when>
                    <c:when test="${fn:containsIgnoreCase(hackathon.eventType, 'Web3') or fn:containsIgnoreCase(hackathon.eventType, 'Blockchain')}">
                      <img src="https://images.unsplash.com/photo-1639762681485-074b7f938ba0?q=80&w=800&auto=format&fit=crop" class="hk-img" alt="Web3 Hackathon">
                    </c:when>
                    <c:when test="${fn:containsIgnoreCase(hackathon.eventType, 'Mobile')}">
                      <img src="https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?q=80&w=800&auto=format&fit=crop" class="hk-img" alt="Mobile Hackathon">
                    </c:when>
                    <c:when test="${fn:containsIgnoreCase(hackathon.eventType, 'Cloud')}">
                      <img src="https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=800&auto=format&fit=crop" class="hk-img" alt="Cloud Hackathon">
                    </c:when>
                    <c:when test="${fn:containsIgnoreCase(hackathon.eventType, 'Security')}">
                      <img src="https://images.unsplash.com/photo-1550751827-4bd374c3f58b?q=80&w=800&auto=format&fit=crop" class="hk-img" alt="Security Hackathon">
                    </c:when>
                    <c:otherwise>
                      <img src="https://images.unsplash.com/photo-1504384308090-c894fdcc538d?q=80&w=800&auto=format&fit=crop" class="hk-img" alt="Hackathon">
                    </c:otherwise>
                  </c:choose>
                  <div class="hk-body">
                    <div class="hk-meta">
                      <span class="hk-tag">${hackathon.eventType}</span>
                      <span class="hk-tag">${hackathon.status}</span>
                    </div>
                    <h3 class="hk-title">${hackathon.title}</h3>
                    <p class="hk-desc">
                      <c:choose>
                        <c:when test="${not empty hackathon.description.hackathonDetailsText}">
                          ${fn:substring(hackathon.description.hackathonDetailsText, 0,
                          100)}${fn:length(hackathon.description.hackathonDetailsText) > 100 ? '...' : ''}
                        </c:when>
                        <c:otherwise>
                          No description available for this hackathon.
                        </c:otherwise>
                      </c:choose>
                    </p>
                    <div style="font-size:.76rem;color:var(--text-muted);margin-bottom:12px">
                      <i class="bi bi-person-fill" style="color:var(--accent)"></i>
                      ${participantCounts[hackathon.hackathonId] != null ? participantCounts[hackathon.hackathonId] : 0} participants registered
                    </div>
                    <div class="hk-footer">
                      <span class="hk-prize">
                        <c:choose>
                          <c:when test="${not empty hackathon.firstPrize}">₹${hackathon.firstPrize}</c:when>
                          <c:otherwise>TBA</c:otherwise>
                        </c:choose>
                      </span>
                      <span class="hk-date">Starts ${hackathon.eventStartDate}</span>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </section>

        <!-- FEATURES -->
        <section id="features">
          <div class="section-inner">
            <div class="section-header reveal">
              <div class="section-badge"><i class="bi bi-stars"></i>Why CodeVerse</div>
              <h2 class="section-title">Built for <em>Serious Builders</em></h2>
              <p class="section-sub">Everything you need to compete, collaborate, and conquer.</p>
            </div>
            <div class="features-grid">
              <div class="feat-card reveal">
                <div class="feat-icon"><i class="bi bi-speedometer2"></i></div>
                <h3 class="feat-title">Real-Time Leaderboard</h3>
                <p class="feat-desc">Track your rank live. See how you stack up against thousands of developers
                  worldwide.
                </p>
              </div>
              <div class="feat-card reveal">
                <div class="feat-icon"><i class="bi bi-people-fill"></i></div>
                <h3 class="feat-title">Team Collaboration</h3>
                <p class="feat-desc">Form teams, share code, and communicate seamlessly. Built-in Git integration.</p>
              </div>
              <div class="feat-card reveal">
                <div class="feat-icon"><i class="bi bi-award-fill"></i></div>
                <h3 class="feat-title">Expert Judging</h3>
                <p class="feat-desc">Your work reviewed by industry leaders from top tech companies and startups.</p>
              </div>
              <div class="feat-card reveal">
                <div class="feat-icon"><i class="bi bi-currency-dollar"></i></div>
                <h3 class="feat-title">Massive Prize Pools</h3>
                <p class="feat-desc">Compete for $2.4M+ in total prizes. Cash, equity, and sponsorships up for grabs.
                </p>
              </div>
              <div class="feat-card reveal">
                <div class="feat-icon"><i class="bi bi-mortarboard-fill"></i></div>
                <h3 class="feat-title">Learn & Grow</h3>
                <p class="feat-desc">Access workshops, mentorship, and resources from top developers.</p>
              </div>
              <div class="feat-card reveal">
                <div class="feat-icon"><i class="bi bi-globe-americas"></i></div>
                <h3 class="feat-title">Global Network</h3>
                <p class="feat-desc">Connect with 12,400+ developers. Build relationships that last beyond the
                  hackathon.
                </p>
              </div>
            </div>
          </div>
        </section>

        <!-- FAQ -->
        <section id="faq">
          <div class="section-inner">
            <div class="section-header reveal">
              <div class="section-badge"><i class="bi bi-question-circle-fill"></i>FAQ</div>
              <h2 class="section-title">Got <em>Questions?</em></h2>
            </div>
            <div class="faq-list">
              <div class="faq-item reveal">
                <button class="faq-q" aria-expanded="false">Is CodeVerse free to use?<i
                    class="bi bi-chevron-down"></i></button>
                <div class="faq-a">
                  <div class="faq-a-inner">Yes! CodeVerse is completely free for participants. You can join hackathons,
                    compete, and win prizes without any cost.</div>
                </div>
              </div>
              <div class="faq-item reveal">
                <button class="faq-q" aria-expanded="false">How do I join a hackathon?<i
                    class="bi bi-chevron-down"></i></button>
                <div class="faq-a">
                  <div class="faq-a-inner">Create an account, browse active hackathons, and click "Register" on any
                    event.
                    You'll get instant access to the project dashboard.</div>
                </div>
              </div>
              <div class="faq-item reveal">
                <button class="faq-q" aria-expanded="false">Can I participate solo or do I need a team?<i
                    class="bi bi-chevron-down"></i></button>
                <div class="faq-a">
                  <div class="faq-a-inner">Both! You can compete solo or form teams of up to 5 members. Team formation
                    tools are built into the platform.</div>
                </div>
              </div>
              <div class="faq-item reveal">
                <button class="faq-q" aria-expanded="false">What tech stacks are allowed?<i
                    class="bi bi-chevron-down"></i></button>
                <div class="faq-a">
                  <div class="faq-a-inner">Most hackathons accept all major tech stacks. Check each event's guidelines
                    for
                    specific requirements or restrictions.</div>
                </div>
              </div>
              <div class="faq-item reveal">
                <button class="faq-q" aria-expanded="false">How are winners selected?<i
                    class="bi bi-chevron-down"></i></button>
                <div class="faq-a">
                  <div class="faq-a-inner">Projects are judged by industry experts based on innovation, execution,
                    design,
                    and impact. Criteria vary by hackathon.</div>
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- CTA BAND -->
        <section class="cta-band">
          <div class="cta-band-orb"></div>
          <div class="section-inner">
            <h2 class="cta-band-title">Your Next Win<br><em>Starts Here.</em></h2>
            <p class="cta-band-sub">Join 12,400+ developers competing on CodeVerse. Free to start. No credit card
              needed.
            </p>
            <div class="cta-band-actions">
              <a href="/signup" class="btn-primary" id="ctaBandBtn" style="font-size:1rem;padding:18px 48px;"><i
                  class="bi bi-rocket-takeoff-fill"></i>Create Free Account</a>
              <a href="#discovery" class="btn-ghost" style="font-size:1rem;padding:17px 48px;">Browse Hackathons</a>
            </div>
          </div>
        </section>

        <!-- FOOTER -->
        <footer>
          <div class="footer-inner">
            <div class="footer-top">
              <div>
                <a href="/" class="cv-logo">Code<span>Verse</span></a>
                <p class="footer-brand-desc">The elite hackathon platform built for serious builders. Compete,
                  collaborate, and conquer.</p>
              </div>
              <div>
                <h3 class="footer-col-title">Platform</h3>
                <ul class="footer-links">
                  <li><a href="#discovery">Hackathons</a></li>
                  <li><a href="#how">How It Works</a></li>
                  <li><a href="/login">Dashboard</a></li>
                  <li><a href="/past">Past Events</a></li>
                </ul>
              </div>
              <div>
                <h3 class="footer-col-title">Company</h3>
                <ul class="footer-links">
                  <li><a href="/about">About</a></li>
                  <li><a href="/blog">Blog</a></li>
                  <li><a href="/organize">Organize</a></li>
                  <li><a href="/contact">Contact</a></li>
                </ul>
              </div>
              <div>
                <h3 class="footer-col-title">Legal</h3>
                <ul class="footer-links">
                  <li><a href="/terms">Terms of Service</a></li>
                  <li><a href="/privacy">Privacy Policy</a></li>
                  <li><a href="/cookies">Cookie Policy</a></li>
                </ul>
              </div>
            </div>
            <div class="footer-bottom">
              <p class="footer-copy">© 2026 CodeVerse. All rights reserved. Made with ❤️ in India.</p>
              <div class="footer-socials">
                <a href="#" class="footer-social"><i class="bi bi-twitter-x"></i></a>
                <a href="#" class="footer-social"><i class="bi bi-linkedin"></i></a>
                <a href="#" class="footer-social"><i class="bi bi-github"></i></a>
                <a href="#" class="footer-social"><i class="bi bi-discord"></i></a>
              </div>
            </div>
          </div>
        </footer>

        <!-- REGISTER MODAL -->
        <div class="modal-overlay" id="registerModal">
          <div class="modal-box">
            <button class="modal-close" id="modalClose"><i class="bi bi-x-lg"></i></button>
            <h2 class="modal-title">Join CodeVerse</h2>
            <p class="modal-sub">Start competing in elite hackathons — free forever.</p>
            <div class="modal-field">
              <label class="modal-label" for="reg-name">Full Name</label>
              <input class="modal-input" id="reg-name" type="text" placeholder="Your full name" autocomplete="name" />
            </div>
            <div class="modal-field">
              <label class="modal-label" for="reg-email">Email Address</label>
              <input class="modal-input" id="reg-email" type="email" placeholder="you@example.com"
                autocomplete="email" />
            </div>
            <div class="modal-field">
              <label class="modal-label" for="reg-pass">Password</label>
              <input class="modal-input" id="reg-pass" type="password" placeholder="Min. 8 characters"
                autocomplete="new-password" />
            </div>
            <button class="modal-btn" type="button" onclick="window.location='/signup'">Create Account <i
                class="bi bi-arrow-right"></i></button>
            <p style="text-align:center;font-size:.76rem;color:var(--text-muted);margin-top:20px;">Already have an
              account? <a href="/login" style="color:var(--accent);">Log in</a></p>
          </div>
        </div>

        <!-- JAVASCRIPT -->
        <script>
          (function () {
            const navbar = document.getElementById('navbar');
            window.addEventListener('scroll', () => { navbar.classList.toggle('scrolled', window.scrollY > 60) }, { passive: true });
            const overlay = document.getElementById('registerModal'), closeBtn = document.getElementById('modalClose');
            function closeModal() { overlay.classList.remove('open'); document.body.style.overflow = '' }
            closeBtn.addEventListener('click', closeModal);
            overlay.addEventListener('click', e => { if (e.target === overlay) closeModal() });
            document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal() });
            document.querySelectorAll('.faq-q').forEach(btn => {
              btn.addEventListener('click', () => {
                const item = btn.closest('.faq-item'), isOpen = item.classList.contains('open');
                document.querySelectorAll('.faq-item.open').forEach(i => i.classList.remove('open'));
                if (!isOpen) item.classList.add('open');
                btn.setAttribute('aria-expanded', !isOpen);
              });
              btn.addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); btn.click() } });
            });
            document.querySelectorAll('.filter-pill').forEach(pill => {
              pill.addEventListener('click', () => {
                document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
                pill.classList.add('active');
              });
            });
            const reveals = document.querySelectorAll('.reveal'), observer = new IntersectionObserver(entries => {
              entries.forEach(entry => { if (entry.isIntersecting) { entry.target.classList.add('visible'); observer.unobserve(entry.target) } });
            }, { threshold: .12, rootMargin: '0px 0px -40px 0px' });
            reveals.forEach(el => observer.observe(el));
            document.querySelectorAll('a[href^="#"]').forEach(a => {
              a.addEventListener('click', e => {
                const target = document.querySelector(a.getAttribute('href'));
                if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth', block: 'start' }) }
              });
            });
            document.querySelectorAll('.hk-card').forEach(card => {
              card.addEventListener('click', () => window.location.href = '/login');
              card.addEventListener('keydown', e => { if (e.key === 'Enter') window.location.href = '/login' });
            });
          })();
        </script>
      </body>

      </html>