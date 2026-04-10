<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="FAQ" scope="request" />
<c:set var="activePage" value="faq" scope="request" />

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="components/Head.jsp" %>
    <style>
        .cv-faq-item {
            margin-bottom: 1rem;
            cursor: pointer;
        }
        .cv-faq-question {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--border-color);
            padding: 1rem 1.5rem;
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: .3s;
        }
        .cv-faq-question:hover {
            border-color: var(--primary-color);
            background: rgba(0, 255, 224, 0.05);
        }
        .cv-faq-answer {
            padding: 1.5rem;
            color: var(--text-muted);
            line-height: 1.6;
            display: none;
        }
        .cv-faq-item.active .cv-faq-question {
            border-color: var(--primary-color);
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
        }
        .cv-faq-item.active .cv-faq-answer {
            display: block;
            border: 1px solid var(--primary-color);
            border-top: none;
            border-bottom-left-radius: 12px;
            border-bottom-right-radius: 12px;
            background: rgba(255, 255, 255, 0.01);
        }
    </style>
</head>
<body>
    <%@ include file="components/navbar.jsp" %>

    <div class="cv-shell">
        <%@ include file="components/Sidebar.jsp" %>

        <main class="cv-content">
            <div class="cv-hero mb-4">
                <div class="cv-hero__title">Frequently Asked <span>Questions</span></div>
                <p class="cv-hero__subtitle">Find answers to common questions about CodeVerse hackathons.</p>
            </div>

            <div class="row">
                <div class="col-lg-8 mx-auto">
                    
                    <div class="cv-section-title">General Questions</div>
                    
                    <div class="cv-faq-item">
                        <div class="cv-faq-question">
                            <span>How do I form a team?</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="cv-faq-answer">
                            You can create a team from the "Hackathons" page after registering. Once a team is created, use the "Invite Members" option in your Team Details to add other registered participants.
                        </div>
                    </div>

                    <div class="cv-faq-item">
                        <div class="cv-faq-question">
                            <span>How do I submit my project?</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="cv-faq-answer">
                            Navigate to the "Submissions" page from your sidebar. You can upload periodic work as you go, and when ready, the Team Leader can perform the "Final Submission" which includes code, files, and a demo video.
                        </div>
                    </div>

                    <div class="cv-faq-item">
                        <div class="cv-faq-question">
                            <span>Is there a registration fee?</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="cv-faq-answer">
                            Each hackathon has its own details. Some are free, while others may have a small registration fee noted on the Hackathon Details page. Payments are handled securely within the platform.
                        </div>
                    </div>

                    <div class="cv-section-title mt-5">Technical Questions</div>

                    <div class="cv-faq-item">
                        <div class="cv-faq-question">
                            <span>What are the file size limits for uploads?</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="cv-faq-answer">
                            Projects files (ZIP) are limited to 10MB per upload. Demo videos are limited to 50MB. All videos are automatically optimized to 720p resolution.
                        </div>
                    </div>

                    <div class="cv-faq-item">
                        <div class="cv-faq-question">
                            <span>Can I update my final submission?</span>
                            <i class="bi bi-chevron-down"></i>
                        </div>
                        <div class="cv-faq-answer">
                            Yes, as long as the submission deadline for that specific hackathon hasn't passed, the Team Leader can resubmit the final project details.
                        </div>
                    </div>

                </div>
            </div>
        </main>
    </div>

    <%@ include file="components/Footer.jsp" %>
    <%@ include file="components/Scripts.jsp" %>

    <script>
        document.querySelectorAll('.cv-faq-question').forEach(q => {
            q.addEventListener('click', () => {
                const item = q.parentElement;
                const wasActive = item.classList.contains('active');
                
                // Close all
                document.querySelectorAll('.cv-faq-item').forEach(i => i.classList.remove('active'));
                
                // Open clicked
                if (!wasActive) {
                    item.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
