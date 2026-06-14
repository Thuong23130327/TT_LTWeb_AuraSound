<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/styleOrderDetail.css">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-3">

            <a href="${pageContext.request.contextPath}/admin/manage-order" class="btn-return">
                <i class="bi bi-arrow-left"></i> Quay lại danh sách đơn hàng
            </a>

            <div class="d-flex justify-content-between align-items-sm-center flex-column flex-sm-row pb-3 mb-4 gap-2" style="border-bottom: 1px solid var(--profile-border-light);">
                <div>
                    <h2 class="section-title gradient-text-title" style="margin: 0; padding-left: 15px;">
                        Đơn hàng #${order.orderCode}
                    </h2>
                    <small style="color: var(--gray-text);" class="ms-3">Ngày đặt: ${order.formattedOrderDate}</small>
                </div>
                <div>
                    <span class="badge bg-${order.statusClass} fs-6 px-3 py-2 fw-medium">
                        ${order.EOrderStatus != null ? order.EOrderStatus.getDescription() : "Chờ duyệt"}
                    </span>
                </div>
            </div>

            <div class="row order-container">
                <div class="col-lg-8">

                    <div class="detail-card">
                        <div class="card-header-title">
                            <span>Sản phẩm trong đơn</span>
                            <span class="badge ${order.paymentStatus == 1 ? 'bg-success' : 'bg-warning'} px-2 py-1" style="font-weight: 500;">
                                ${order.paymentStatus == 1 ? 'Đã thanh toán' : 'Chưa thanh toán'}
                            </span>
                        </div>

                        <c:forEach items="${orderItems}" var="item">
                            <div class="cart-style-item">
                                <img src="${item.productVariant.mainImageUrl}" class="item-preview-img" alt="Product">
                                <div class="item-details">
                                    <h6 class="item-title">${item.productName}</h6>
                                    <p class="item-meta">Màu sắc: <span class="badge text-dark" style="background-color: var(--profile-border-light);">${item.productVariant.colorName}</span></p>
                                    <p class="item-meta">SKU: ${item.productVariant.variantSku}</p>
                                </div>
                                <div class="item-pricing">
                                    <div class="fw-medium" style="color: var(--black);">
                                        <fmt:formatNumber value="${item.price_at_purchase}" pattern="#,###"/> đ
                                    </div>
                                    <small style="color: var(--gray-text);">Số lượng: ${item.quantity}</small>
                                    <div class="price-color mt-1" style="font-size: 0.95rem;">
                                        Thành tiền: <fmt:formatNumber value="${item.price_at_purchase * item.quantity}" pattern="#,###"/> đ
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${not empty order.shippingNote}">
                            <div class="mt-4 p-3 rounded-3 shipping-note-box">
                                <span class="fw-semibold d-block mb-1" style="font-size: 0.85rem; color: var(--profile-shipping-border);">
                                    <i class="bi bi-chat-left-text-fill me-1"></i> Ghi chú giao hàng:
                                </span>
                                <p class="mb-0" style="color: var(--profile-text-dark); font-size: 0.9rem; font-style: italic;">${order.shippingNote}</p>
                            </div>
                        </c:if>
                    </div>

                    <div class="detail-card">
                        <div class="card-header-title" style="margin-bottom: 12px;">Tóm tắt đơn hàng</div>

                        <div class="calc-row">
                            <span>Tạm tính tiền hàng</span>
                            <span class="fw-medium"><fmt:formatNumber value="${order.totalProductsPrice}" pattern="#,###"/> đ</span>
                        </div>
                        <div class="calc-row">
                            <span>Phí vận chuyển</span>
                            <span class="fw-medium"><fmt:formatNumber value="${order.shippingFee}" pattern="#,###"/> đ</span>
                        </div>
                        <div class="calc-row fw-medium" style="color: var(--profile-history-border);">
                            <span>Mã giảm giá</span>
                            <span>- <fmt:formatNumber value="${order.discountAmount}" pattern="#,###"/> đ</span>
                        </div>

                        <div class="calc-row calc-total">
                            <span>Tổng thanh toán</span>
                            <span class="price-color fs-5"><fmt:formatNumber value="${order.finalAmount}" pattern="#,###"/> đ</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="detail-card">
                        <div class="card-header-title pb-2" style="border-bottom: 1px solid var(--profile-border-light);">Thông tin nhận hàng</div>

                        <div class="customer-info-section mt-3">
                            <h6><i class="bi bi-envelope-fill me-1 gradient-icon"></i> Tài khoản liên hệ</h6>
                            <p class="fw-medium">${order.customerEmail}</p>
                        </div>

                        <hr style="border-color: var(--profile-border-light); margin: 15px 0;">

                        <div class="customer-info-section">
                            <h6><i class="bi bi-geo-alt-fill me-1 gradient-icon"></i> Địa chỉ giao hàng</h6>
                            <p class="fw-bold mb-1" style="color: var(--black);">${order.recipientName}</p>
                            <p class="mb-1"><i class="bi bi-telephone me-1" style="color: var(--theme-color-primary);"></i> ${order.shippingPhone}</p>
                            <p>
                                <i class="bi bi-map me-1" style="color: var(--theme-color-primary);"></i> ${order.shippingAddress}, ${order.shippingCity}
                            </p>
                        </div>

                        <c:if test="${not empty order.adminNote}">
                            <hr style="border-color: var(--profile-border-light); margin: 15px 0;">
                            <div class="customer-info-section">
                                <h6><i class="bi bi-bookmark-star-fill me-1" style="color: var(--theme-color-secondary);"></i> Ghi chú nội bộ</h6>
                                <p style="font-size: 0.85rem; font-style: italic; color: var(--gray-text);">${order.adminNote}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<script>window.APP_CONTEXT = '${pageContext.request.contextPath}';</script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin/scriptOrderDetail.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptAdmin.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin/scriptOrder.js"></script>
</body>
</html>