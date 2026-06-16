<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<%
    request.setAttribute("pageTitle", "Quản lý Tổng quát - AuraSound");
    request.setAttribute("activePage", "admin");
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
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3">
                <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                    <h2 class="section-title text-primary"
                        style="margin-top: 0; margin-bottom: .5rem; font-weight: 500; line-height: 1.2;">Admin Dashboard
                    </h2>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card"
                         onclick="window.location.href='${pageContext.request.contextPath}/admin/product-manager'"
                         style="cursor: pointer;" title="Đi đến Quản lý Sản phẩm">
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title">Tổng sản phẩm</h5>
                                <p class="h3 fw-bold">${stats.totalProducts}</p>
                            </div>
                            <i class="fas fa-box fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card"
                         onclick="window.location.href='${pageContext.request.contextPath}/admin/manage-order'"
                         style="cursor: pointer;" title="Đi đến Quản lý Đơn hàng">
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title">Tổng đơn hàng</h5>
                                <p class="h3 fw-bold">${stats.totalOrders}</p>
                            </div>
                            <i class="fas fa-shopping-cart fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card"
                         onclick="window.location.href='${pageContext.request.contextPath}/admin/manage-order'"
                         style="cursor: pointer;" title="Xử lý đơn hàng">
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title">Đơn chờ xử lý</h5>
                                <p class="h3 fw-bold">${stats.ordersPending}</p>
                            </div>
                            <i class="fas fa-exclamation-triangle fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stat-card"
                         onclick="window.location.href='${pageContext.request.contextPath}/admin/user-manager'"
                         style="cursor: pointer;" title="Đi đến Quản lý Khách hàng">
                        <div class="card-body d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title">Khách hàng</h5>
                                <p class="h3 fw-bold">${stats.totalCustomer}</p>
                            </div>
                            <i class="fas fa-users fa-3x opacity-50"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark">Thống kê doanh thu</h5>
                        </div>
                        <div class="card-body">

                            <div class="row mb-4">
                                <div class="col-lg-3 col-md-6 mb-3">
                                    <div class="card stat-card bg-primary text-white">
                                        <div class="card-body d-flex justify-content-between align-items-center">
                                            <div>
                                                <h5 class="card-title">Tổng doanh thu</h5>
                                                <p class="h3 fw-bold"><fmt:formatNumber value="${stats.totalRevenue}"
                                                                                        type="number"
                                                                                        maxFractionDigits="0"/> VNĐ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 mb-3">
                                    <div class="card stat-card bg-success text-white">
                                        <div class="card-body d-flex justify-content-between align-items-center">
                                            <div>
                                                <h5 class="card-title">Năm ${currentYear}</h5>
                                                <p class="h3 fw-bold"><fmt:formatNumber value="${stats.yearRevenue}"
                                                                                        type="number"
                                                                                        maxFractionDigits="0"
                                                                                        pattern="#,###"/> đ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 mb-3">
                                    <div class="card stat-card bg-info text-white">
                                        <div class="card-body d-flex justify-content-between align-items-center">
                                            <div>
                                                <h5 class="card-title">T${currentMonth}/${currentYear}</h5>
                                                <p class="h3 fw-bold"><fmt:formatNumber value="${stats.monthRevenue}"
                                                                                        type="number"
                                                                                        maxFractionDigits="0"
                                                                                        pattern="#,###"/> đ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 mb-3">
                                    <div class="card stat-card bg-danger text-white">
                                        <div class="card-body d-flex justify-content-between align-items-center">
                                            <div>
                                                <h5 class="card-title">Hôm nay</h5>
                                                <p class="h3 fw-bold"><fmt:formatNumber value="${stats.dayRevenue}"
                                                                                        type="number"
                                                                                        maxFractionDigits="0"
                                                                                        pattern="#,###"/> đ</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="chart-wrapper  mt-4">
                                <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                                    <h5 class="mb-0 fw-bold text-dark" id="chartTitle">Doanh thu 7 ngày gần đây</h5>
                                    <select id="chartFilter" class="form-select w-auto fw-bold text-primary"
                                            onchange="loadChartData()">
                                        <option value="7days">7 ngày qua</option>
                                        <option value="thisMonth">Tháng này</option>
                                        <option value="thisYear">Năm nay</option>
                                    </select>
                                </div>

                                <div class="bar-chart">
                                    <canvas id="revenueBarChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold text-dark"><i class="fas fa-bell text-warning"></i> Thông báo mới
                            </h5>
                        </div>
                        <div class="card-body p-0" style="max-height: 400px; overflow-y: auto;">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="n" items="${recentNotis}">
                                    <li class="list-group-item d-flex align-items-center p-3 border-bottom">

                                        <c:choose>
                                            <c:when test="${n.type == 'ORDER'}">
                                                <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3"
                                                     style="width: 40px; height: 40px;">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-success bg-opacity-10 text-success rounded-circle d-flex align-items-center justify-content-center me-3"
                                                     style="width: 40px; height: 40px;">
                                                    <i class="fas fa-envelope"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div>
                                            <h6 class="mb-1 text-dark" style="font-size: 14px;">${n.message}</h6>
                                            <small class="text-muted"><i class="far fa-clock"></i> ${n.created_at}
                                            </small>
                                        </div>
                                    </li>
                                </c:forEach>

                                <c:if test="${empty recentNotis}">
                                    <li class="list-group-item text-center text-muted p-4">
                                        <i class="fas fa-inbox fa-3x mb-3 text-light"></i><br>
                                        Chưa có thông báo nào.
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/tag/_footerAdmin.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    let revenueChart = null;

    function loadChartData() {
        let filter = document.getElementById('chartFilter').value;
        let titleEl = document.getElementById('chartTitle');

        if (filter === '7days') titleEl.innerText = 'Doanh thu 7 ngày gần đây';
        else if (filter === 'thisMonth') titleEl.innerText = 'Doanh thu Tháng này';
        else if (filter === 'thisYear') titleEl.innerText = 'Doanh thu Năm nay';

        fetch('${pageContext.request.contextPath}/admin/api/chart?filter=' + filter)
            .then(response => response.json())
            .then(data => {
                renderChart(data.labels, data.data);
            });
    }

    function renderChart(labels, data) {
        const ctx = document.getElementById('revenueBarChart').getContext('2d');

        if (revenueChart != null) {
            revenueChart.destroy();
        }

        revenueChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: data,
                    backgroundColor: 'rgba(13, 110, 253, 0.8)',
                    borderColor: 'rgba(13, 110, 253, 1)',
                    borderWidth: 1,
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {beginAtZero: true}
                }
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        loadChartData();
    });
</script>
</body>
</html>
