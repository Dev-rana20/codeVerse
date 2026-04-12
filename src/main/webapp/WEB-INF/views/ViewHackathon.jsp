<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%-- Page Identity --%>
<c:set var="pageTitle" value="Hackathon Console" scope="request" />
<c:set var="activePage" value="hackathons" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/components/Head.jsp"%>
    <style>
        .hc-wrapper {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .hc-hero {
            background: linear-gradient(135deg, #1A1F35 0%, #0B0E14 100%);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }
        
        .hc-hero::after {
            content: '';
            position: absolute;
            top: -20%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(0, 255, 224, 0.05) 0%, transparent 70%);
            border-radius: 50%;
        }

        .hc-hero__header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 20px;
            position: relative;
            z-index: 1;
        }

        .hc-hero__title h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-top: 10px;
            margin-bottom: 5px;
            background: linear-gradient(90deg, #fff, #a5b4fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hc-hero__actions {
            display: flex;
            gap: 12px;
        }

        .hc-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
            margin-bottom: 30px;
        }

        .hc-prop-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .hc-prop-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.03);
        }

        .hc-prop-item:last-child {
            border-bottom: none;
        }

        .hc-prop-label {
            color: #6b7280;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            font-family: var(--font-mono);
        }

        .hc-prop-value {
            font-weight: 600;
            color: #d1d5db;
        }

        .prize-card-mini {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 16px;
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.3s ease;
        }

        .prize-card-mini:hover {
            background: rgba(255, 255, 255, 0.04);
            transform: translateY(-2px);
        }

        .prize-icon {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .prize-1 { background: rgba(255, 215, 0, 0.1); color: #ffd700; border: 1px solid rgba(255, 215, 0, 0.2); }
        .prize-2 { background: rgba(192, 192, 192, 0.1); color: #c0c0c0; border: 1px solid rgba(192, 192, 192, 0.2); }
        .prize-3 { background: rgba(205, 127, 50, 0.1); color: #cd7f32; border: 1px solid rgba(205, 127, 50, 0.2); }

        .timeline-box {
            background: #0D1020;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 24px;
        }

        .timeline-indicator {
            position: relative;
            padding-left: 30px;
        }

        .timeline-indicator::before {
            content: '';
            position: absolute;
            left: 5px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: rgba(255, 255, 255, 0.05);
        }

        .timeline-step {
            position: relative;
            margin-bottom: 24px;
        }

        .timeline-step::after {
            content: '';
            position: absolute;
            left: -29px;
            top: 4px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #4F46E5;
            box-shadow: 0 0 10px rgba(79, 70, 229, 0.5);
        }

        .timeline-step.deadline::after {
            background: #EF4444;
            box-shadow: 0 0 10px rgba(239, 68, 68, 0.5);
        }

        .poster-img {
            width: 100%;
            max-height: 500px;
            object-fit: contain;
            border-radius: 16px;
            background: rgba(0,0,0,0.2);
            padding: 10px;
        }
        
    </style>
</head>

<body data-page="hackathons">

    <%@ include file="/WEB-INF/views/components/navbar.jsp"%>

    <div class="cv-shell">

        <%@ include file="/WEB-INF/views/components/SidebarAdmin.jsp"%>

        <main class="cv-content">
            <div class="hc-wrapper">
                
                <!-- HERO SECTION -->
                <div class="hc-hero">
                    <div class="hc-hero__header">
                        <div class="hc-hero__title">
                            <div class="cv-page-eyebrow">
                                <i class="bi bi-gear-fill"></i> Admin Console
                            </div>
                            <h1>${hackathon.title}</h1>
                            <div class="d-flex gap-2 mt-2">
                                <span class="cv-badge cv-badge--${fn:toLowerCase(hackathon.status)}">
                                    <span class="cv-badge__dot"></span> ${hackathon.status}
                                </span>
                                <span class="cv-badge bg-dark border-secondary">
                                    <i class="bi bi-tag-fill me-1"></i> ${hackathon.eventType}
                                </span>
                                <span class="cv-badge bg-dark border-secondary">
                                    <i class="bi bi-cash-stack me-1"></i> ${hackathon.payment}
                                </span>
                            </div>
                        </div>
                        <div class="hc-hero__actions">
                            <a href="editHackathon?hackathonId=${hackathon.hackathonId}" class="btn-cv btn-cv--warning">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="listHackathon" class="btn-cv btn-cv--ghost">
                                <i class="bi bi-chevron-left me-1"></i> Back
                            </a>
                        </div>
                    </div>
                </div>

                <div class="hc-info-grid">
                    <!-- LOGISTICS CARD -->
                    <div class="cv-card">
                        <div class="cv-card__header">
                            <i class="bi bi-info-circle-fill text-accent"></i>
                            <h3>General Logistics</h3>
                        </div>
                        <div class="cv-card__body">
                            <div class="hc-prop-list">
                                <div class="hc-prop-item">
                                    <span class="hc-prop-label">internal id</span>
                                    <span class="hc-prop-value">#${hackathon.hackathonId}</span>
                                </div>
                                <div class="hc-prop-item">
                                    <span class="hc-prop-label">Location</span>
                                    <span class="hc-prop-value">${hackathon.location}</span>
                                </div>
                                <div class="hc-prop-item">
                                    <span class="hc-prop-label">Team Constraints</span>
                                    <span class="hc-prop-value">${hackathon.minTeamSize} - ${hackathon.maxTeamSize} Members</span>
                                </div>
                                <div class="hc-prop-item">
                                    <span class="hc-prop-label">Target Role ID</span>
                                    <span class="hc-prop-value">${hackathon.userTypeId}</span>
                                </div>
                                <c:if test="${fn:toUpperCase(hackathon.payment) == 'PAID'}">
                                    <div class="hc-prop-item">
                                        <span class="hc-prop-label">Registration Fee</span>
                                        <span class="hc-prop-value text-success">₹ ${hackathon.fee}</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- PRIZES CARD -->
                    <div class="cv-card">
                        <div class="cv-card__header">
                            <i class="bi bi-trophy-fill text-accent"></i>
                            <h3>Reward System</h3>
                        </div>
                        <div class="cv-card__body">
                            <div class="d-flex flex-column gap-3">
                                <div class="prize-card-mini">
                                    <div class="prize-icon prize-1">🥇</div>
                                    <div>
                                        <div class="hc-prop-label">First Prize</div>
                                        <div class="hc-prop-value">${hackathon.firstPrize != null ? hackathon.firstPrize : 'TBA'}</div>
                                    </div>
                                </div>
                                <div class="prize-card-mini">
                                    <div class="prize-icon prize-2">🥈</div>
                                    <div>
                                        <div class="hc-prop-label">Second Prize</div>
                                        <div class="hc-prop-value">${hackathon.secondPrize != null ? hackathon.secondPrize : 'TBA'}</div>
                                    </div>
                                </div>
                                <div class="prize-card-mini">
                                    <div class="prize-icon prize-3">🥉</div>
                                    <div>
                                        <div class="hc-prop-label">Third Prize</div>
                                        <div class="hc-prop-value">${hackathon.thirdPrize != null ? hackathon.thirdPrize : 'TBA'}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- TIMELINE CARD -->
                    <div class="cv-card">
                        <div class="cv-card__header">
                            <i class="bi bi-calendar3 text-accent"></i>
                            <h3>Execution Timeline</h3>
                        </div>
                        <div class="cv-card__body">
                            <div class="timeline-indicator">
                                <div class="timeline-step">
                                    <div class="hc-prop-label">Registration Window</div>
                                    <div class="hc-prop-value small">${hackathon.registrationStartDate} to ${hackathon.registrationEndDate}</div>
                                </div>
                                <div class="timeline-step">
                                    <div class="hc-prop-label">Event Period</div>
                                    <div class="hc-prop-value small">
                                        ${hackathon.eventStartDate != null ? hackathon.eventStartDate : 'TBA'} 
                                        to 
                                        ${hackathon.eventEndDate != null ? hackathon.eventEndDate : 'TBA'}
                                    </div>
                                </div>
                                <div class="timeline-step deadline">
                                    <div class="hc-prop-label text-danger">Submission Deadline</div>
                                    <div class="hc-prop-value text-danger">${hackathon.submissionDeadline != null ? hackathon.submissionDeadline : 'TBA'}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- WINNERS SECTION (IF COMPLETED) -->
                <c:if test="${not empty winners}">
                    <div class="cv-card mb-4" style="border: 2px solid rgba(0, 255, 224, 0.2); background: rgba(0, 255, 224, 0.02);">
                        <div class="cv-card__header">
                            <i class="bi bi-stars text-accent"></i>
                            <h3>Official Winners</h3>
                        </div>
                        <div class="cv-card__body p-0">
                            <table class="cv-table">
                                <thead>
                                    <tr>
                                        <th style="width: 150px">Placement</th>
                                        <th>Winning Team</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="w" items="${winners}">
                                        <tr>
                                            <td>
                                                <span class="cv-badge bg-dark border-secondary">
                                                    <c:choose>
                                                        <c:when test="${w.placement == 1}">👑 1st</c:when>
                                                        <c:when test="${w.placement == 2}">✨ 2nd</c:when>
                                                        <c:when test="${w.placement == 3}">🎖 3rd</c:when>
                                                        <c:otherwise>${w.placement}th</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td style="font-weight: 700; font-size: 1.1rem; color: #fff;">${w.teamName}</td>
                                            <td class="text-end">
                                                <button class="btn-cv btn-cv--ghost btn-cv--sm">View details</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>

                <!-- DESCRIPTION & POSTER -->
                <div class="row g-4">
                    <div class="col-lg-7">
                        <div class="cv-card h-100">
                            <div class="cv-card__header">
                                <i class="bi bi-text-left text-accent"></i>
                                <h3>Program Description</h3>
                            </div>
                            <div class="cv-card__body">
                                <c:choose>
                                    <c:when test="${not empty hackathonDescriptionEntity.hackathonDetailsText}">
                                        <div style="line-height: 1.8; color: #9ca3af; white-space: pre-line;">
                                            ${hackathonDescriptionEntity.hackathonDetailsText}
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5 text-muted">
                                            <i class="bi bi-file-earmark-x d-block mb-3 opacity-20" style="font-size: 2rem"></i>
                                            No description provided for this event.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="cv-card h-100">
                            <div class="cv-card__header">
                                <i class="bi bi-image text-accent"></i>
                                <h3>Event Poster</h3>
                            </div>
                            <div class="cv-card__body text-center d-flex align-items-center justify-content-center">
                                <c:choose>
                                    <c:when test="${not empty hackathonDescriptionEntity.hackathonDetailsURL}">
                                        <img src="${hackathonDescriptionEntity.hackathonDetailsURL}" class="poster-img" alt="Hackathon Poster">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="p-5 border-dashed rounded text-muted" style="border: 2px dashed rgba(255,255,255,0.05)">
                                            <i class="bi bi-images d-block mb-2" style="font-size: 2rem"></i>
                                            No poster uploaded
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/views/components/Footer.jsp"%>
    <%@ include file="/WEB-INF/views/components/Scripts.jsp"%>

</body>
</html>