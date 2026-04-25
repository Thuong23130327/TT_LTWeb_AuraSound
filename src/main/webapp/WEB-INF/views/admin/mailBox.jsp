<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    request.setAttribute("pageTitle", "Quản lý Liên hệ - AuraSound");
    request.setAttribute("activePage", "contact");
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
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleAdmin.css">
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="mail-content-center-wrapper mx-auto">

                <div
                        class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 border-bottom">
                    <h2 class="h2 section-title text-primary">
                        Quản lý Liên hệ, Thư
                    </h2>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="table-scroll-wrapper">
                            <table id="contactTable" class="table table-striped table-sm">
                                <thead>
                                <tr>
                                    <th>Stt</th>
                                    <th>Người Gửi</th>
                                    <th>Nội dung</th>
                                    <th>Thời gian</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>

                                <tbody id="contact-content">
                                <c:forEach items="${allContacts}" var="eachMail" varStatus="i">
                                    <tr>
                                        <td>${i.count}</td>
                                        <td>${eachMail.senderName}</td>
                                        <td>${eachMail.mess}</td>
                                        <td>${eachMail.stringCreatedAt}</td>
                                        <td>
                                            <c:if test="${eachMail.stringStatus =='New'}">
                                                <a
                                                        href="${AuraSound}/admin/mail_detail?id=${eachMail.id}">
                                                    <button class="btn-new">${eachMail.stringStatus}</button>
                                                </a>
                                            </c:if>

                                            <c:if test="${eachMail.stringStatus =='Replied'}">
                                                <a href="${AuraSound}/admin/mail_detail?id=${eachMail.id}">

                                                    <button class="btn-replied">${eachMail.stringStatus}</button>

                                                </a>
                                            </c:if>
                                        </td>

                                        <td>
                                            <a href="${AuraSound}/admin/mail_detail?id=${eachMail.id}">
                                                <button class="btn-sm">${eachMail.stringStatus=='Replied'? "Chi tiết": "Phản hồi"}</button>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <%--Nếu danh sách trống--%>
                                <c:if test="${empty allContacts}">
                                    <tr>
                                        <td colspan="5" class="text-center">Không có Liên hệ nào trong hệ thống.</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>


        <script src="${AuraSound}/assets/js/scriptAdmin.js"></script>
        <script>
            $(document).ready(function () {
                var table = $('#contactTable').DataTable({
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

                $('#contactTable thead tr').clone(true).appendTo('#contactTable thead');
                $('#contactTable thead tr:eq(1) th').each(function (i) {
                    var title = $(this).text();
                    if (title !== 'Thao tác' && title !== 'Stt') { // Không thêm lọc cho cột thao tác/stt
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

<%
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
        if (msg.equals("success")) {
%>
<script>
    alert("Thành công! Email của bạn đã được gửi đi.");
</script>
<%
            session.removeAttribute("msg");
        }
    }
%>
</html>
