<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificate - ${user.firstName} ${user.lastName}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --cert-gold: #c5a059;
            --cert-gold-light: #e2c99b;
            --cert-dark: #1a1a1a;
            --cert-white: #ffffff;
            --font-main: 'Outfit', sans-serif;
            --font-accent: 'Playfair Display', serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f0f2f5;
            font-family: var(--font-main);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 2rem;
        }

        .cert-container {
            width: 1000px;
            height: 700px;
            background: var(--cert-white);
            position: relative;
            padding: 60px;
            box-shadow: 0 40px 100px rgba(0,0,0,0.15);
            border: 20px solid var(--cert-dark);
            overflow: hidden;
            text-align: center;
        }

        /* Border Details */
        .cert-container::before {
            content: '';
            position: absolute;
            top: 10px;
            left: 10px;
            right: 10px;
            bottom: 10px;
            border: 2px solid var(--cert-gold);
            pointer-events: none;
        }

        /* Decorative Corners */
        .corner {
            position: absolute;
            width: 100px;
            height: 100px;
            border: 5px solid var(--cert-gold);
            z-index: 2;
        }
        .corner-tl { top: -5px; left: -5px; border-right: none; border-bottom: none; }
        .corner-tr { top: -5px; right: -5px; border-left: none; border-bottom: none; }
        .corner-bl { bottom: -5px; left: -5px; border-right: none; border-top: none; }
        .corner-br { bottom: -5px; right: -5px; border-left: none; border-top: none; }

        /* Content */
        .cert-header {
            margin-bottom: 40px;
        }

        .cert-logo {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--cert-dark);
            margin-bottom: 10px;
            letter-spacing: -1px;
        }
        .cert-logo span { color: var(--cert-gold); }

        .cert-title {
            font-family: var(--font-accent);
            font-size: 4rem;
            color: var(--cert-dark);
            text-transform: uppercase;
            letter-spacing: 5px;
            margin-bottom: 10px;
        }

        .cert-subtitle {
            font-size: 1.2rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .cert-body {
            margin: 40px 0;
        }

        .cert-present {
            font-size: 1.2rem;
            color: #444;
            margin-bottom: 15px;
        }

        .cert-name {
            font-family: var(--font-accent);
            font-size: 3.5rem;
            color: var(--cert-gold);
            margin-bottom: 20px;
            font-style: italic;
        }

        .cert-text {
            font-size: 1.1rem;
            color: #555;
            line-height: 1.6;
            max-width: 700px;
            margin: 0 auto;
        }

        .cert-placement {
            margin-top: 30px;
            padding: 15px 30px;
            background: linear-gradient(135deg, var(--cert-gold), var(--cert-gold-light));
            color: white;
            display: inline-block;
            border-radius: 50px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 10px 20px rgba(197, 160, 89, 0.3);
        }

        .cert-footer {
            margin-top: 60px;
            display: flex;
            justify-content: space-around;
            align-items: flex-end;
        }

        .sig-block {
            width: 200px;
            text-align: center;
        }

        .sig-line {
            border-top: 2px solid #ddd;
            margin-top: 10px;
            padding-top: 10px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--cert-dark);
        }

        .sig-title {
            font-size: 0.75rem;
            color: #888;
            text-transform: uppercase;
        }

        .cert-badge {
            position: absolute;
            bottom: 60px;
            right: 60px;
            width: 120px;
            height: 120px;
        }

        /* Print Controls */
        .controls {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 100;
            display: flex;
            gap: 10px;
        }

        .btn-print {
            background: var(--cert-dark);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .btn-print:hover {
            transform: translateY(-2px);
            background: #333;
        }

        @media print {
            .controls { display: none; }
            body { background: white; padding: 0; }
            .cert-container { 
                box-shadow: none; 
                border-width: 15px;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
        }

        /* Watermark */
        .watermark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-45deg);
            font-size: 8rem;
            color: rgba(0,0,0,0.03);
            font-weight: 900;
            z-index: 0;
            white-space: nowrap;
            pointer-events: none;
        }
    </style>
</head>
<body>

    <div class="controls">
        <button class="btn-print" onclick="window.print()">
            <i class="bi bi-printer"></i> Print Certificate
        </button>
        <button class="btn-print" onclick="window.history.back()" style="background: #666;">
            <i class="bi bi-arrow-left"></i> Back
        </button>
    </div>

    <div class="cert-container">
        <div class="corner corner-tl"></div>
        <div class="corner corner-tr"></div>
        <div class="corner corner-bl"></div>
        <div class="corner corner-br"></div>

        <div class="watermark">CODEVERSE</div>

        <div class="cert-header">
            <div class="cert-logo">CODE<span>VERSE</span></div>
            <h1 class="cert-title">Certificate</h1>
            <div class="cert-subtitle">of Achievement & Participation</div>
        </div>

        <div class="cert-body">
            <p class="cert-present">This is to certify that</p>
            <h2 class="cert-name">${user.firstName} ${user.lastName}</h2>
            <p class="cert-text">
                has successfully participated in the <strong>${hackathon.title}</strong> 
                as a member of team <strong>${team.teamName}</strong>. 
                We recognize their dedication, creativity, and technical contribution 
                towards innovation during this event.
            </p>

            <c:choose>
                <c:when test="${placement == 1}">
                    <div class="cert-placement">
                        <i class="bi bi-trophy-fill me-2"></i> Winner - 1st Place
                    </div>
                </c:when>
                <c:when test="${placement == 2}">
                    <div class="cert-placement" style="background: linear-gradient(135deg, #a8a8a8, #d1d1d1);">
                        <i class="bi bi-award-fill me-2"></i> Runner Up - 2nd Place
                    </div>
                </c:when>
                <c:when test="${placement == 3}">
                    <div class="cert-placement" style="background: linear-gradient(135deg, #cd7f32, #e9967a);">
                        <i class="bi bi-award-fill me-2"></i> 3rd Place
                    </div>
                </c:when>
            </c:choose>
        </div>

        <div class="cert-footer">
            <div class="sig-block">
                <div class="sig-line">CodeVerse Authored</div>
                <div class="sig-title">Event Organizer</div>
            </div>
            <div class="sig-block">
                <div class="sig-line">
                   <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy" />
                </div>
                <div class="sig-title">Date of Issue</div>
            </div>
            <div class="sig-block">
                <div class="sig-line">${hackathon.location}</div>
                <div class="sig-title">Event Venue</div>
            </div>
        </div>

        <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=https://codeverse.com/verify/${hackathon.hackathonId}/${user.userId}" class="cert-badge" alt="Verification QR">
    </div>

</body>
</html>
