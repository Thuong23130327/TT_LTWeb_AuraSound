<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/tag/_taglibs.jsp" %>

<%
    request.setAttribute("pageTitle", "QUẢN LÝ SẢN PHẨM - AuraSound");
    request.setAttribute("activePage", "product");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleAdmin.css">
</head>

<body>

<button onclick="backTop()" id="back-top-btn" title="Lên đầu trang">
    <i class="bi bi-caret-up-fill"></i>
</button>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

            <nav>
                <div class="nav-container content">
                    <div class="nav-left">

                        <a class="a-nodecor " href="${AuraSound}/admin/product-manager">
                            <div class="contact active">Tât cả</div>
                        </a>
                        <c:forEach items="${categoryList}" var="cate">
                            <a class="a-nodecor " href="${AuraSound}/admin/product-manager?categoryId=${cate.id}">
                                <div class="contact ${activeId == cate.id ? 'active':''}">${cate.name}</div>
                            </a>
                        </c:forEach>
                    </div>
                    <div id="hamburger-icon"><i class="bi bi-list"></i></div>
                </div>
            </nav>

            <div
                    class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-4 pb-2 border-bottom">
                <h2 class="h2 section-title text-primary">
                    Quản lý Sản phẩm
                </h2>
            </div>

            <p class="text-muted">Sửa, xóa sản phẩm và quản lý xuất nhập hàng.</p>
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="table-scroll-wrapper">
                        <table id="productTable" class="table table-striped table-sm">
                            <thead>
                            <tr>
                                <th>Stt</th>
                                <th>Mã SKU</th>
                                <th>Tên sản phẩm</th>
                                <th>Tổng biến thể</th>
                                <th>Tồn kho</th>
                                <th>Giá gốc</th>
                                <th>Giá bán</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach items="${productList}" var="p" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td>${p.sku}</td>
                                    <td>${p.name}</td>
                                    <td>${varCountMap[p.id] > 0 ? varCountMap[p.id]:0}</td>
                                    <td>${totalStockMap[p.id] > 0 ? totalStockMap[p.id]:0}</td>

                                    <td data-order="${p.oldPrice}" class="old-price"><fmt:formatNumber
                                            value="${p.oldPrice > p.sellPrice ? p.oldPrice : 0}" pattern="#,###"/>
                                        đ
                                    </td>
                                    <td data-order="${p.sellPrice}" class="new-price"><fmt:formatNumber
                                            value="${p.sellPrice}" pattern="#,###"/> đ
                                    </td>
                                    <td>
                                        <a href="${AuraSound}/admin/product-detail-manager?pid=${p.id}">
                                            <button class="btn btn-sm btn-warning">Chi tiết</button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty productList}">
                                <tr>
                                    <td colspan="5" class="text-center">Không có sản phẩm nào trong hệ thống.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                    <a href="product_detail.jsp">
                        <button class="btn btn-primary mt-3"><i class="fas fa-plus"></i> Thêm Sản Phẩm Mới</button>
                    </a>
                </div>
            </div>
        </main>
    </div>
</div>

<script src="../../../assets/js/script.js"></script>
<script src="../../../assets/js/scriptAdmin.js"></script>
<script src="../../../assets/js/scriptProfile.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

<script>
    $(document).ready(function () {
        // 1. Khởi tạo DataTables
        var table = $('#productTable').DataTable({
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

        $('#productTable thead tr').clone(true).appendTo('#productTable thead');
        $('#productTable thead tr:eq(1) th').each(function (i) {
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

</html>