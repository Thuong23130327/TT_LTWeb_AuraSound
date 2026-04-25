<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    request.setAttribute("pageTitle", "QUẢN LÝ VOUCHER - AuraSound");
    request.setAttribute("activePage", "vou");
%>

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
        <jsp:include page="/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div
                    class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 border-bottom">
                <h2 class="h2 section-title text-primary">
                    Quản lý Voucher
                </h2>
            </div>

            <div class="card shadow-sm">
                <div class="card-body">
                    <table class="table table-striped table-sm">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Code</th>
                            <th>Lượt dùng</th>
                            <th>Trạng thái</th>
                            <th>Thai tác chi tiết</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr>
                            <td>1</td>
                            <td>NEWYEAR2026</td>
                            <td>10</td>
                            <td>
                                <span class="badge bg-danger">Đang phát hành</span>
                            </td>
                            <td>
                                <a href="../../../profileM/profile.jsp">
                                    <button class="btn btn-sm btn-info">Xem</button>
                                </a>
                                <a href="../../../404.jsp">
                                    <button class="btn btn-sm btn-warning">Sửa</button>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../../../assets/js/script.js"></script>
<script src="../../../assets/js/scriptAdmin.js"></script>
<script src="../../../assets/js/scriptProfile.js"></script>
</body>

</html>
