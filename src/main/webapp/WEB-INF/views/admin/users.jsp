<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/styleUser.css">
</head>

<body>
<div id="realtimeToastContainer"></div>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-3">

            <h2 class="section-title text-primary" style="margin-top: 0; margin-bottom: .5rem; font-weight: 500; line-height: 1.2;">Quản lý Tài khoản</h2>

            <c:set var="totalUsers" value="0"/>
            <c:set var="activeUsers" value="0"/>
            <c:set var="lockedUsers" value="0"/>
            <c:forEach items="${userList}" var="u">
                <c:set var="totalUsers" value="${totalUsers + 1}"/>
                <c:choose>
                    <c:when test="${u.isLocked()}"><c:set var="lockedUsers" value="${lockedUsers + 1}"/></c:when>
                    <c:otherwise><c:set var="activeUsers" value="${activeUsers + 1}"/></c:otherwise>
                </c:choose>
            </c:forEach>

            <div class="d-flex gap-3 mb-4 flex-wrap">
                <div class="stat-pill">
                    <div class="stat-icon icon-total"><i class="bi bi-people"></i></div>
                    <div>
                        <p class="stat-label">Tổng người dùng</p>
                        <p class="stat-value" id="totalUserCountDisplay">${totalUsers}</p>
                    </div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon icon-active"><i class="bi bi-shield-check"></i></div>
                    <div>
                        <p class="stat-label">Đang hoạt động</p>
                        <p class="stat-value">${activeUsers}</p>
                    </div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon icon-locked"><i class="bi bi-shield-slash"></i></div>
                    <div>
                        <p class="stat-label">Bị khóa</p>
                        <p class="stat-value">${lockedUsers}</p>
                    </div>
                </div>
            </div>

            <div class="user-table-wrap">
                <div class="table-toolbar">
                    <i class="bi bi-search text-muted"></i>
                    <input type="text" id="customSearchInput" placeholder="Tìm người dùng theo tên hoặc email...">
                    <span class="ms-auto text-muted" style="font-size:.82rem">
                        Hiển thị <strong id="rowCountDisplay">${totalUsers}</strong> người dùng
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle" id="userManagementTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Người Dùng</th>
                            <th>Email</th>
                            <th>Vai Trò</th>
                            <th>Trạng Thái</th>
                            <th>Ngày Tạo</th>
                            <th>Thao Tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty userList}">
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">Hệ thống chưa ghi nhận tài khoản nào.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${userList}" var="u">
                                    <c:set var="hasAdminRole" value="false"/>
                                    <c:forEach items="${u.roles}" var="role">
                                        <c:if test="${role.roleName == 'ADMIN'}"><c:set var="hasAdminRole" value="true"/></c:if>
                                    </c:forEach>
                                    <tr>
                                        <td class="text-muted">#${u.id}</td>
                                        <td><strong>${u.fullName}</strong></td>
                                        <td><span class="code-badge" style="cursor:default; border:none; background:#f4f5f7;">${u.email}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <c:choose>
                                                    <c:when test="${hasAdminRole}"><span class="badge bg-danger">Quản trị viên</span></c:when>
                                                    <c:otherwise><span class="badge bg-primary">Người dùng</span></c:otherwise>
                                                </c:choose>
                                                <i class="bi bi-pencil-square text-muted edit-role-trigger" style="cursor:pointer;"
                                                   data-id="${u.id}" data-name="${u.fullName}" data-roleid="${hasAdminRole ? 1 : 2}"
                                                   data-bs-toggle="modal" data-bs-target="#roleModificationModal"></i>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.isLocked()}"><span class="status-locked"><i class="bi bi-lock-fill me-1"></i>Đã khóa</span></c:when>
                                                <c:otherwise><span class="status-active"><i class="bi bi-check-circle-fill me-1"></i>Hoạt động</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-muted" style="font-size: .83rem; font-weight: 500;">
                                            <c:if test="${not empty u.createdAt}">
                                                <c:set var="dateStr" value="${u.createdAt.toString()}" />
                                                ${fn:substring(dateStr, 8, 10)}/${fn:substring(dateStr, 5, 7)}/${fn:substring(dateStr, 0, 4)} ${fn:substring(dateStr, 11, 19)}
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <a href="${AuraSound}/admin/user-detail?id=${u.id}" class="btn-tbl-action btn-tbl-view">
                                                    <i class="bi bi-eye-fill me-1"></i>Xem
                                                </a>
                                                <button class="btn-tbl-action ${u.isLocked() ? 'btn-tbl-unlock' : 'btn-tbl-lock'} toggle-lock-trigger"
                                                        data-email="${u.email}" data-locked="${u.isLocked()}">
                                                    <i class="bi ${u.isLocked() ? 'bi-unlock-fill' : 'bi-lock-fill'} me-1"></i>
                                                        ${u.isLocked() ? 'Mở khóa' : 'Khóa lại'}
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<div class="modal fade" id="roleModificationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content" style="border-radius:12px;">
            <div class="modal-header py-2 bg-light">
                <h6 class="modal-title fw-bold text-primary"><i class="bi bi-shield-lock-fill me-2"></i>Thay đổi vai trò</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body py-3">
                <p class="mb-2 text-muted small">Tài khoản: <strong id="lblTargetUser" class="text-dark">—</strong></p>
                <input type="hidden" id="hidUserId">

                <label class="form-label fw-bold small mb-1">Chọn phân quyền mới <span class="text-danger">*</span></label>
                <select id="selUserRole" class="form-select form-select-sm" style="border-radius: 8px;">
                    <option value="2">Người dùng (USER)</option>
                    <option value="1">Quản trị viên (ADMIN)</option>
                </select>
            </div>
            <div class="modal-footer py-1 justify-content-end gap-2 bg-light border-top-0">
                <button type="button" class="btn btn-sm btn-light border" data-bs-dismiss="modal">Hủy</button>
                <button type="button" id="btnSubmitChangeRole" class="btn btn-sm btn-primary px-3" style="border-radius: 8px;">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<script>
    const APP_CONTEXT = '${pageContext.request.contextPath}';
</script>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptAdmin.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin/scriptUser.js"></script>

</body>
</html>