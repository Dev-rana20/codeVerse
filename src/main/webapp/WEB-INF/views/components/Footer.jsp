<%--============================================================CODEVERSE — Footer Fragment Path:
	src/main/webapp/WEB-INF/views/components/footer.jsp Include at the very bottom of every view, AFTER closing </main>
	and BEFORE </body>:

	</main>
	<%@ include file="components/footer.jsp" %>
		<%@ include file="components/scripts.jsp" %>
			</body>

			The footer automatically shifts right to clear the sidebar
			via CSS: margin-left: var(--sidebar-w)
			============================================================ --%>

			<footer class="cv-footer">
				<span class="cv-footer__copy">
					&copy; 2026 <span>CodeVerse</span>. All rights reserved.
				</span>
				<div class="cv-footer__links">
					<a href="/privacy">Privacy</a>
					<a href="/terms">Terms</a>
					<a href="/contact">Contact</a>
					<a href="/faq">FAQ</a>
				</div>
			</footer>