<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="${hack.title} - Details" scope="request" />
<c:set var="activePage" value="hackathons" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/Head.jsp" %>
    <style>
        .page-wrapper {
            max-width: 1300px;
            margin: 0 auto;
        }

        /* --- HERO SECTION --- */
        .hack-hero-banner {
            position: relative;
            background: linear-gradient(135deg, #161b2c 0%, #0b0f1a 100%), 
                        url('https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&q=80&w=2000');
            background-blend-mode: overlay;
            background-size: cover;
            background-position: center;
            border-radius: 24px;
            padding: 80px 40px;
            margin-bottom: 40px;
            border: 1px solid rgba(255, 255, 255, 0.05);
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        .hack-hero-banner::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 70% 30%, rgba(0, 255, 224, 0.1) 0%, transparent 60%);
        }

        .hack-hero-content {
            position: relative;
            z-index: 2;
        }

        .hack-title {
            font-size: 3.5rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            margin-bottom: 20px;
            background: linear-gradient(to right, #fff, #a5b4fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* --- INFO CARDS --- */
        .details-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 30px;
        }

        @media (max-width: 1100px) {
            .details-grid { grid-template-columns: 1fr; }
        }

        .info-card-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-box {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .stat-box:hover {
            background: rgba(255, 255, 255, 0.04);
            border-color: rgba(0, 255, 224, 0.2);
            transform: translateY(-5px);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            background: rgba(0, 255, 224, 0.1);
            border: 1px solid rgba(0, 255, 224, 0.2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00ffe0;
            font-size: 1.25rem;
        }

        .stat-label {
            display: block;
            font-size: 0.75rem;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 4px;
        }

        .stat-value {
            font-weight: 700;
            color: #f3f4f6;
            font-size: 1.05rem;
        }

        /* --- PRIZE BLOCKS --- */
        .prizes-wrap {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 30px;
        }

        @media (max-width: 768px) {
            .prizes-wrap { grid-template-columns: 1fr; }
        }

        .prize-tile {
            position: relative;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 24px;
            text-align: center;
            overflow: hidden;
        }

        .prize-tile::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
        }

        .prize-1::before { background: #ffd700; box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3); }
        .prize-2::before { background: #c0c0c0; box-shadow: 0 4px 15px rgba(192, 192, 192, 0.2); }
        .prize-3::before { background: #cd7f32; box-shadow: 0 4px 15px rgba(205, 127, 50, 0.2); }

        .prize-rank {
            font-size: 0.8rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            margin-bottom: 12px;
            display: block;
        }

        .prize-amount {
            font-size: 1.5rem;
            font-weight: 800;
            color: #fff;
        }

        /* --- SIDEBAR COMPONENTS --- */
        .register-box {
            background: linear-gradient(180deg, rgba(79, 70, 229, 0.1) 0%, rgba(13, 16, 32, 0.5) 100%);
            border: 1px solid rgba(79, 70, 229, 0.2);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            text-align: center;
        }

        .team-mini-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 12px;
            transition: all 0.2s;
        }

        .team-mini-card:hover { border-color: #00ffe0; }

        .timeline-vertical { position: relative; padding-left: 20px; }
        .timeline-vertical::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 2px;
            background: rgba(255,255,255,0.05);
        }

        .timeline-node {
            position: relative;
            padding-bottom: 20px;
        }

        .timeline-node::after {
            content: '';
            position: absolute;
            left: -24.5px;
            top: 4px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #4b5563;
        }

        .timeline-node.active::after {
            background: #00ffe0;
            box-shadow: 0 0 10px #00ffe0;
        }

        /* --- UTILS --- */
        .desc-text {
            color: #9ca3af;
            line-height: 1.8;
            font-size: 1rem;
            white-space: pre-line;
        }
    </style>
</head>
<body>

<%@ include file="../components/navbar.jsp" %>

<div class="cv-shell">
    <%@ include file="../components/Sidebar.jsp" %>

    <main class="cv-content">
        <div class="page-wrapper">

            <c:if test="${not empty success}">
                <div class="alert alert-success cv-msg mb-4">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger cv-msg mb-4">${error}</div>
            </c:if>

            <!-- HERO -->
            <div class="hack-hero-banner">
                <div class="hack-hero-content">
                    <div class="cv-page-eyebrow">
                        <i class="bi bi-rocket-takeoff"></i> Active Challenge
                    </div>
                    <h1 class="hack-title">${hack.title}</h1>
                    <div class="d-flex gap-3 align-items-center">
                        <span class="cv-badge cv-badge--${fn:toLowerCase(hack.status)}">
                            <span class="cv-badge__dot"></span> ${hack.status}
                        </span>
                        <div class="text-muted-cv small font-mono">
                            <i class="bi bi-eye me-1"></i> Public Console
                        </div>
                    </div>
                </div>
            </div>

            <div class="details-grid">
                <!-- MAIN CONTENT AREA -->
                <div class="details-left">
                    
                    <!-- TOP STATS -->
                    <div class="info-card-group">
                        <div class="stat-box">
                            <div class="stat-icon"><i class="bi bi-globe"></i></div>
                            <div>
                                <span class="stat-label">Format</span>
                                <span class="stat-value">${hack.eventType}</span>
                            </div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-icon"><i class="bi bi-people"></i></div>
                            <div>
                                <span class="stat-label">Participants</span>
                                <span class="stat-value">${participantCount} Registered</span>
                            </div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-icon"><i class="bi bi-cash-stack"></i></div>
                            <div>
                                <span class="stat-label">Access</span>
                                <span class="stat-value">${hack.payment}</span>
                            </div>
                        </div>
                    </div>

                    <!-- LOGISTICS CARDS -->
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="cv-card h-100">
                                <div class="cv-card__header">
                                    <i class="bi bi-geo-alt-fill text-accent"></i>
                                    <h3>Venue & Location</h3>
                                </div>
                                <div class="cv-card__body">
                                    <p class="text-white mb-2" style="font-weight: 600;">${hack.location}</p>
                                    <p class="text small">Check the event communication channel for physical venue access codes or digital meeting links.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="cv-card h-100">
                                <div class="cv-card__header">
                                    <i class="bi bi-person-check-fill text-accent"></i>
                                    <h3>Team Constraints</h3>
                                </div>
                                <div class="cv-card__body">
                                    <p class="text-white mb-2" style="font-weight: 600;">${hack.minTeamSize} to ${hack.maxTeamSize} Members</p>
                                    <p class="text small">Teams must stay within these limits to be eligible for official evaluation. Solo participation if min=1.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PRIZES SECTION -->
                    <div class="cv-card mb-4">
                        <div class="cv-card__header">
                            <i class="bi bi-trophy-fill text-accent"></i>
                            <h3>Performance Incentives</h3>
                        </div>
                        <div class="cv-card__body">
                            <div class="prizes-wrap">
                                <div class="prize-tile prize-1">
                                    <span class="prize-rank" style="color:#ffd700">🥇 First Place</span>
                                    <div class="prize-amount">${hack.firstPrize != null ? hack.firstPrize : 'TBA'}</div>
                                </div>
                                <div class="prize-tile prize-2">
                                    <span class="prize-rank" style="color:#c0c0c0">🥈 Second Place</span>
                                    <div class="prize-amount">${hack.secondPrize != null ? hack.secondPrize : 'TBA'}</div>
                                </div>
                                <div class="prize-tile prize-3">
                                    <span class="prize-rank" style="color:#cd7f32">🥉 Third Place</span>
                                    <div class="prize-amount">${hack.thirdPrize != null ? hack.thirdPrize : 'TBA'}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- DESCRIPTION -->
                    <div class="cv-card mb-4">
                        <div class="cv-card__header">
                            <i class="bi bi-file-earmark-text text-accent"></i>
                            <h3>Challenge Description</h3>
                        </div>
                        <div class="cv-card__body">
                            <div class="desc-text">${description.hackathonDetailsText}</div>
                            <c:if test="${not empty description.hackathonDetailsURL}">
                                <div class="mt-4 pt-4" style="border-top: 1px solid rgba(255,255,255,0.05)">
                                    <a href="${description.hackathonDetailsURL}" target="_blank" class="btn-cv btn-cv--ghost w-100">
                                        <i class="bi bi-file-earmark-pdf me-2"></i> Download Guidelines & Assets
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>

                </div>

                <!-- SIDEBAR / ACTIONS AREA -->
                <div class="details-right">
                    
                    <!-- JOIN ACTION -->
                    <div class="register-box">
                        <h4 class="mb-2">Get Started</h4>
                        <p class="small text-muted mb-4">Register to unlock team formation and submissions.</p>
                        
                        <c:choose>
                            <c:when test="${isRegistered}">
                                <div class="cv-pill cv-pill--ongoing w-100 py-3" style="border: 1px solid #00ffe0">
                                    <i class="bi bi-check-circle-fill me-2"></i> You are Registered
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${fn:toLowerCase(hack.status) == 'close'}">
                                        <div class="alert alert-secondary py-2 small">Registrations Closed</div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${fn:toUpperCase(hack.payment) == 'PAID'}">
                                                <div class="mb-3 font-mono text-accent" style="font-weight: 800;">Fee: ₹ ${hack.fee}</div>
                                                <a href="/hackathons/${hack.hackathonId}/checkout" class="btn-cv btn-cv--primary w-100">Pay & Register</a>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="/hackathons/${hack.hackathonId}/register" method="post">
                                                    <button type="submit" class="btn-cv btn-cv--primary w-100">Register Now</button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- TIMELINE SIDEBAR -->
                    <div class="cv-card mb-4">
                        <div class="cv-card__header">
                            <i class="bi bi-clock-history text-accent"></i>
                            <h3>Milestones</h3>
                        </div>
                        <div class="cv-card__body">
                            <div class="timeline-vertical">
                                <div class="timeline-node ${isRegistered ? 'active' : ''}">
                                    <div class="stat-label">Registration Starts</div>
                                    <div class="text-white small">${hack.registrationStartDate}</div>
                                </div>
                                <div class="timeline-node">
                                    <div class="stat-label">Registration Deadline</div>
                                    <div class="text-white small">${hack.registrationEndDate}</div>
                                </div>
                                <div class="timeline-node">
                                    <div class="stat-label">Hackathon Event</div>
                                    <div class="text-white small">${hack.eventStartDate != null ? hack.eventStartDate : 'TBA'}</div>
                                </div>
                                <div class="timeline-node">
                                    <div class="stat-label text-danger">Submission Deadline</div>
                                    <div class="text-danger small font-weight-bold">${hack.submissionDeadline != null ? hack.submissionDeadline : 'TBA'}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- AVAILABLE TEAMS -->
                    <c:if test="${isRegistered}">
                        <div class="cv-card">
                            <div class="cv-card__header d-flex justify-content-between">
                                <h3>Active Teams</h3>
                                <span class="badge bg-dark">${fn:length(teams)}</span>
                            </div>
                            <div class="cv-card__body">
                                <c:choose>
                                    <c:when test="${empty teams}">
                                        <div class="text-center py-4 text-muted small">No teams created yet</div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="t" items="${teams}">
                                            <div class="team-mini-card">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <div style="font-weight: 700; color: #fff;">${t.teamName}</div>
                                                    <span class="small text-accent">${fn:length(t.members)}/${hack.maxTeamSize}</span>
                                                </div>
                                                <div class="small text-muted mb-3">Leader: ${t.teamLeader.firstName}</div>
                                                <form action="/team/requestJoin" method="post">
                                                    <input type="hidden" name="teamId" value="${t.hackathonTeamId}" />
                                                    <button type="submit" class="btn-cv btn-cv--ghost btn-cv--sm w-100">Join Team</button>
                                                </form>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                                <div class="mt-4 pt-3" style="border-top: 1px dashed rgba(255,255,255,0.05)">
                                    <c:choose>
                                        <c:when test="${hasCreatedTeam}">
                                            <div class="text-center text-success small"><i class="bi bi-check2-circle"></i> You are a team leader</div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/participant/team-register?hackathonId=${hack.hackathonId}" class="btn-cv btn-cv--ghost w-100">
                                                <i class="bi bi-plus-circle me-1"></i> Create My Team
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <a href="/hackathons" class="btn btn-link text-muted-cv w-100 mt-3 small text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i> Discover More
                    </a>
                </div>
            </div>

        </div>
    </main>
</div>

<%@ include file="../components/Footer.jsp" %>
<%@ include file="../components/Scripts.jsp" %>

<script>
    setTimeout(() => {
        const msgs = document.querySelectorAll('.cv-msg');
        msgs.forEach(msg => {
            msg.style.transition = "0.5s";
            msg.style.opacity = "0";
            setTimeout(() => msg.remove(), 500);
        });
    }, 4000);
</script>

</body>
</html>