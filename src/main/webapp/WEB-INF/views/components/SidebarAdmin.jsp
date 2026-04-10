<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<aside class="cv-sidebar" id="cvSidebar">

	<%-- ─── PROFILE STRIP ─── --%>
	<div class="cv-sidebar-profile">
		<div class="cv-sidebar-avatar">
			<c:choose>
				<c:when test="${not empty sessionScope.user.profilePicURL}">
					<img src="${sessionScope.user.profilePicURL}"
						alt="${sessionScope.user.firstName}'s Profile Picture" />
				</c:when>
				<c:otherwise>
					<img
						src="https://api.dicebear.com/7.x/initials/svg?seed=${sessionScope.user.firstName}&backgroundColor=0b0f1a&textColor=00ffe0"
						alt="${sessionScope.user.firstName}'s Initials" />
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<div class="cv-sidebar-name">
				<c:out value="${sessionScope.user.firstName}" />
			</div>
			<div class="cv-sidebar-role">
				<c:out value="${sessionScope.user.role}" />
			</div>
		</div>
	</div>

	<%-- ─── MAIN SECTION ─── --%>
	<nav class="cv-nav-section">
		<div class="cv-nav-section-label">Main</div>

		<a href="/admin-dashboard"
			class="cv-nav-item ${activePage == 'dashboard' ? 'active' : ''}">
			<i class="bi bi-speedometer2"></i> <span class="cv-nav-label">Dashboard</span>
		</a>
	</nav>

	<%-- ─── USER MANAGEMENT ─── --%> 
	<nav class="cv-nav-section">
		<div class="cv-nav-section-label">User Management</div>

		<a href="/newUserType"
			class="cv-nav-item ${activePage == 'addUserType' ? 'active' : ''}">
			<i class="bi bi-person-plus"></i> <span class="cv-nav-label">Add
				User Type</span>
		</a> <a href="/listUser"
			class="cv-nav-item ${activePage == 'userList' ? 'active' : ''}">
			<i class="bi bi-people"></i> <span class="cv-nav-label">User
				List</span>
		</a> <a href="/listUserType"
			class="cv-nav-item ${activePage == 'userTypeList' ? 'active' : ''}">
			<i class="bi bi-card-list"></i> <span class="cv-nav-label">User
				Types</span>
		</a> <a href="/admin/invite-judge"
			class="cv-nav-item ${activePage == 'inviteJudge' ? 'active' : ''}">
			<i class="bi bi-person-badge"></i> <span class="cv-nav-label">Invite
				Judge</span>
		</a> <a href="/admin/judge-management"
			class="cv-nav-item ${activePage == 'assignJudge' ? 'active' : ''}">
			<i class="bi bi-diagram-3"></i> <span class="cv-nav-label">Assign
				Judge</span>
		</a>
	</nav>

	<%-- ─── CATEGORY ─── --%>
	<nav class="cv-nav-section">
		<div class="cv-nav-section-label">Category</div>

		<a href="newCategory"
			class="cv-nav-item ${activePage == 'newCategory' ? 'active' : ''}">
			<i class="bi bi-plus-circle"></i> <span class="cv-nav-label">New
				Category</span>
		</a> <a href="listCategory"
			class="cv-nav-item ${activePage == 'listCategory' ? 'active' : ''}">
			<i class="bi bi-list-ul"></i> <span class="cv-nav-label">List
				Category</span>
		</a>
	</nav>

	<%-- ─── HACKATHON ─── --%>
	<nav class="cv-nav-section">
		<div class="cv-nav-section-label">Hackathon</div>

		<a href="newHackathon"
			class="cv-nav-item ${activePage == 'newHackathon' ? 'active' : ''}">
			<i class="bi bi-lightning-charge"></i> <span class="cv-nav-label">New
				Hackathon</span>
		</a> <a href="addHackathonDescription"
			class="cv-nav-item ${activePage == 'hackathonDesc' ? 'active' : ''}">
			<i class="bi bi-file-earmark-text"></i> <span class="cv-nav-label">Add
				Description</span>
		</a> <a href="listHackathon"
			class="cv-nav-item ${activePage == 'listHackathon' ? 'active' : ''}">
			<i class="bi bi-list-check"></i> <span class="cv-nav-label">List
				Hackathons</span>
		</a>
	</nav>

	<%-- ─── OTHER ─── --%>
	<nav class="cv-nav-section">
		<div class="cv-nav-section-label">Other</div>

		<a href="#" class="cv-nav-item"> <i class="bi bi-table"></i> <span
			class="cv-nav-label">Tables</span>
		</a> <a href="#" class="cv-nav-item"> <i class="bi bi-icons"></i> <span
			class="cv-nav-label">Icons</span>
		</a>
	</nav>

	<%-- ─── ACCOUNT ─── --%>
	<nav class="cv-nav-section">
		<div class="cv-nav-section-label">Account</div>

		<a href="/profile"
			class="cv-nav-item ${activePage == 'profile' ? 'active' : ''}"> <i
			class="bi bi-person-circle"></i> <span class="cv-nav-label">Profile</span>
		</a> <a href="/settings"
			class="cv-nav-item ${activePage == 'settings' ? 'active' : ''}">
			<i class="bi bi-gear"></i> <span class="cv-nav-label">Settings</span>
		</a>
	</nav>

	<%-- ─── FOOTER ─── --%>
	<div class="cv-sidebar-footer">
		<a href="/logout" class="cv-nav-item" style="color: var(--danger)">
			<i class="bi bi-box-arrow-right"></i> <span class="cv-nav-label">Logout</span>
		</a>
	</div>

</aside>