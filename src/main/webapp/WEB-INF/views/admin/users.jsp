<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">

</head>

<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div
                    class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 border-bottom">
                <h2 class="h2 section-title text-primary">
                    Quản lý Tài Khoản
                </h2>
            </div>

            <p class="text-muted">Quản lý tài khoản, chỉnh sửa quyền, khóa hoặc xem chi tiết hoạt
                động tài khoản</p>
            <div class="card shadow-sm">
                <div class="card-body">
                    <table id="userTable" class="table table-striped table-sm">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${userList}" var="u">
                            <tr>
                                <td>${u.id}</td>
                                <td>${u.fullName}</td>
                                <td>${u.email}</td>
                                <td>
                                    <c:forEach items="${u.roles}" var="r">
                                        <c:choose>
                                            <c:when test="${r.roleName == 'ADMIN'}">
                                                <span class="badge bg-danger">Quản trị viên</span>
                                            </c:when>
                                            <c:when test="${r.roleName == 'CONTENT_STAFF' or r.roleName == 'SALES_STAFF'}">
                                                <span class="badge bg-info">Nhân viên</span>
                                            </c:when>
                                            <c:when test="${r.roleName == 'CUSTOMER'}">
                                                <span class="badge bg-primary">Khách hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${r.roleName}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.isLocked()}">
                                            <span class="badge rounded-pill bg-warning text-dark"><i
                                                    class="fas fa-lock"></i> Đã khóa</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill bg-success"><i
                                                    class="fas fa-check-circle"></i> Hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${u.createdAt}</td>
                                <td>
                                    <a href="${AuraSound}/admin/user-detail?id=${u.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>


<script src="/assets/js/script.js"></script>
<script src="/assets/js/scriptAdmin.js"></script>
<script src="/assets/js/scriptProfile.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

<script>
    $(document).ready(function () {
        // 1. Khởi tạo DataTables
        var table = $('#userTable').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json"
            }
        });

        $('#userTable thead tr').clone(true).appendTo('#userTable thead');
        $('#userTable thead tr:eq(1) th').each(function (i) {
            var title = $(this).text();
            if (title !== 'Thao tác' && title !== 'Stt') { // ko thêm lọc cho cột thao tác/stt
                $(this).html('<input type="text" class="form-control form-control-sm" placeholder="Lọc ' + title + '" />');

                $('input', this).on('keyup change', function () {
                    if (table.column(i).search() !== this.value) {
                        table.column(i).search(this.value).draw();
                    }
                });
            } else {
                $(this).html('');
            }
        });
    });
</script>
</body>

</html>
