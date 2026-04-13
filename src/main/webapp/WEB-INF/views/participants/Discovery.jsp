<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="pageTitle" value="Participant Discovery" scope="request" />
<c:set var="activePage" value="discovery" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="../components/Head.jsp" %>
    <style>
        .cv-discovery-table {
            border-collapse: separate;
            border-spacing: 0 8px;
            width: 100%;
        }
        
        .cv-discovery-table tr {
            background: var(--bg-card);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        
        .cv-discovery-table tr:hover {
            transform: scale(1.005);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
            background: var(--bg-card-hover);
        }
        
        .cv-discovery-table td {
            padding: 16px;
            vertical-align: middle;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
        }
        
        .cv-discovery-table td:first-child {
            border-left: 1px solid var(--border);
            border-top-left-radius: var(--radius-sm);
            border-bottom-left-radius: var(--radius-sm);
            width: 320px;
        }
        
        .cv-discovery-table td:last-child {
            border-right: 1px solid var(--border);
            border-top-right-radius: var(--radius-sm);
            border-bottom-right-radius: var(--radius-sm);
            text-align: right;
        }
        
        .participant-profile {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        
        .participant-avatar {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--accent-dim);
            flex-shrink: 0;
        }
        
        .participant-info .name {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-primary);
            line-height: 1.2;
        }
        
        .participant-info .role {
            font-size: 0.72rem;
            font-family: var(--font-mono);
            color: var(--accent);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .skill-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 4px;
        }
        
        .skill-badge {
            font-size: 0.65rem;
            padding: 2px 8px;
            border-radius: 4px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--border);
            color: var(--text-muted);
            font-family: var(--font-mono);
        }
        
        .discovery-search-wrap {
            position: relative;
            margin-bottom: 2rem;
        }
        
        .discovery-search-wrap i {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }
        
        .discovery-search-input {
            width: 100%;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 14px 14px 14px 3rem;
            color: var(--text-primary);
            font-family: var(--font-mono);
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        
        .discovery-search-input:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 4px var(--accent-dim);
        }
        
        .bio-excerpt {
            font-size: 0.82rem;
            color: var(--text-muted);
            max-width: 400px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body class="cv-scope">
    <%@ include file="../components/navbar.jsp" %>

    <div class="cv-shell">
        <%@ include file="../components/Sidebar.jsp" %>

        <main class="cv-content">
            <div class="cv-page-header">
                <div class="cv-page-header__left">
                    <div class="cv-page-eyebrow">
                        <i class="bi bi-people-fill"></i> Networking
                    </div>
                    <h1 class="cv-page-title">Discover Participants</h1>
                    <p class="cv-page-subtitle">Connect with talented developers and designers across the platform.</p>
                </div>
            </div>

            <div class="discovery-search-wrap">
                <i class="bi bi-search"></i>
                <input type="text" id="participantSearch" class="discovery-search-input" 
                       placeholder="Search by name, skills, or role...">
            </div>

            <div class="cv-table-container">
                <table class="cv-discovery-table" id="discoveryTable">
                    <thead>
                        <tr style="background: transparent; box-shadow: none; transform: none;">
                            <th style="padding: 0 16px 12px; font-family: var(--font-mono); font-size: 0.65rem; color: var(--text-muted); text-transform: uppercase;">Participant</th>
                            <th style="padding: 0 16px 12px; font-family: var(--font-mono); font-size: 0.65rem; color: var(--text-muted); text-transform: uppercase;">About</th>
                            <th style="padding: 0 16px 12px; font-family: var(--font-mono); font-size: 0.65rem; color: var(--text-muted); text-transform: uppercase;">Expertise</th>
                            <th style="padding: 0 16px 12px; font-family: var(--font-mono); font-size: 0.65rem; color: var(--text-muted); text-transform: uppercase;"></th>
                        </tr>
                    </thead>
                    <tbody id="discoveryBody">
                        <c:forEach var="p" items="${participants}">
                            <c:set var="detail" value="${detailMap[p.userId]}" />
                            <tr class="discovery-row" data-search="${fn:toLowerCase(p.firstName)} ${fn:toLowerCase(p.lastName)} ${fn:toLowerCase(detail.skills)} ${fn:toLowerCase(detail.qualification)}">
                                <td>
                                    <div class="participant-profile">
                                        <c:choose>
                                            <c:when test="${not empty p.profilePicURL}">
                                                <img src="${p.profilePicURL}" alt="${p.firstName}" class="participant-avatar">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://api.dicebear.com/7.x/initials/svg?seed=${p.firstName}" 
                                                     alt="${p.firstName}" class="participant-avatar">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="participant-info">
                                            <div class="name">${p.firstName} ${p.lastName}</div>
                                            <div class="role">${not empty detail.qualification ? detail.qualification : 'Innovator'}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="bio-excerpt" title="${detail.bio}">
                                        ${not empty detail.bio ? detail.bio : 'Coding enthusiast and problem solver.'}
                                    </div>
                                </td>
                                <td>
                                    <div class="skill-badges">
                                        <c:if test="${not empty detail.skills}">
                                            <c:forEach var="skill" items="${fn:split(detail.skills, ',')}" varStatus="st">
                                                <c:if test="${st.index < 4}">
                                                    <span class="skill-badge">${fn:trim(skill)}</span>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${fn:length(fn:split(detail.skills, ',')) > 4}">
                                                <span class="skill-badge" style="background: var(--accent-dim); color: var(--accent);">+${fn:length(fn:split(detail.skills, ',')) - 4}</span>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <a href="/participant/profile/${p.userId}" class="btn-cv btn-cv--ghost btn-cv--sm">
                                        Profile <i class="bi bi-arrow-up-right ms-1"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div id="noResults" class="text-center py-5 d-none">
                <div class="cv-card p-5" style="display: inline-block; min-width: 300px;">
                    <i class="bi bi-search text-muted-cv" style="font-size: 2.5rem;"></i>
                    <h3 class="mt-3" style="font-weight: 700;">No one found</h3>
                    <p class="text-muted-cv small font-mono">Try adjusting your search terms</p>
                </div>
            </div>
        </main>
    </div>

    <%@ include file="../components/Footer.jsp" %>
    <%@ include file="../components/Scripts.jsp" %>

    <script>
        document.getElementById('participantSearch').addEventListener('input', function(e) {
            const term = e.target.value.toLowerCase().trim();
            const rows = document.querySelectorAll('.discovery-row');
            let visibleCount = 0;

            rows.forEach(row => {
                const searchContent = row.getAttribute('data-search');
                if (searchContent.includes(term)) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('noResults').classList.toggle('d-none', visibleCount > 0);
            document.getElementById('discoveryTable').classList.toggle('d-none', visibleCount === 0);
        });
    </script>
</body>
</html>
