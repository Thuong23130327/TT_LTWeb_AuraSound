<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


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
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

</head>

<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2"><i class="fas fa-home me-2"></i> Admin </h1>
            <div class="btn-toolbar mb-2 mb-md-0">
                <div class="btn-mail-container me-3">
                    <button class="btn btn-primary btn-sm rounded-3">
                        <i class="fas fa-envelope"></i>
                        <span class="badge rounded-pill bg-danger badge-counter">3</span>
                    </button>
                </div>
                <button type="button" class="btn btn-sm btn-primary rounded-3">
                    <i class="fas fa-sync-alt me-1"></i> Cập nhật Dữ liệu
                </button>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-lg-3 col-md-6 mb-3">
                <div class="card stat-card">
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
                <div class="card stat-card">
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
                <div class="card stat-card">
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
                <div class="card stat-card">
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
                <div class="card shadow-sm h-100">
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
                                            <p class="h3 fw-bold"><fmt:formatNumber value="${stats.totalRevenue}" type="number" maxFractionDigits="0" /> VNĐ</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-3">
                                <div class="card stat-card bg-success text-white">
                                    <div class="card-body d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="card-title">Năm ${currentYear}</h5>
                                            <p class="h3 fw-bold"><fmt:formatNumber value="${stats.yearRevenue}" type="number" maxFractionDigits="0" /> VNĐ</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-3">
                                <div class="card stat-card bg-info text-white">
                                    <div class="card-body d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="card-title">T${currentMonth}/${currentYear}</h5>
                                            <p class="h3 fw-bold"><fmt:formatNumber value="${stats.monthRevenue}" type="number" maxFractionDigits="0" /> VNĐ</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6 mb-3">
                                <div class="card stat-card bg-danger text-white">
                                    <div class="card-body d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="card-title">Hôm nay</h5>
                                            <p class="h3 fw-bold"><fmt:formatNumber value="${stats.dayRevenue}" type="number" maxFractionDigits="0" /> VNĐ</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="chart-container">
                            <div class="card-header bg-white py-3">
                                <h2 class="mb-0 fw-bold text-dark">Doanh thu 7 ngày gần đây</h2>
                            </div>
                            <div class="bar-chart" style="height: 320px;">
                                <canvas id="revenueBarChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</div>

<%@ include file="/WEB-INF/tag/_footerAdmin.jsp" %>
</body>
</html>
