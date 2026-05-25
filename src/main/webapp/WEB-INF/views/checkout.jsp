<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Thanh toán - AuraSound");
    request.setAttribute("activePage", "cart");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleCheckout.css">

    <style>
        .error-msg { color: red; font-size: 0.85rem; margin-top: 5px; display: block; }
        .success-msg { color: green; font-size: 0.85rem; margin-top: 5px; display: block; }
        #discount-row { display: none; color: #28a745; }
        .loading { opacity: 0.6; pointer-events: none; }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<main class="content">
    <div class="checkout-container">

        <div class="customer-details">
            <h2>Thông tin giao hàng</h2>
            <c:if test="${sessionScope.auth == null}">
                <p>Bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để điền nhanh thông tin.</p>
            </c:if>

            <div class="form-group">
                <label for="fullname">Họ và tên *</label>
                <input type="text" id="fullname" value="${sessionScope.auth.fullName}" placeholder="Nhập họ và tên của bạn" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" value="${sessionScope.auth.email}" placeholder="Nhập địa chỉ email">
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại *</label>
                    <input type="tel" id="phone" value="${sessionScope.auth.phone}" placeholder="Nhập số điện thoại" required>
                </div>
            </div>

            <h2>Địa chỉ nhận hàng</h2>

            <div class="form-group">
                <label for="city">Tỉnh / Thành phố *</label>
                <input type="text" id="city" placeholder="Nhập Tỉnh / Thành phố">
            </div>

            <div class="form-group">
                <label for="ward">Phường / Xã *</label>
                <input type="text" id="ward" placeholder="Phường / Xã">
            </div>

            <div class="form-group">
                <label for="address">Địa chỉ cụ thể *</label>
                <input type="text" id="address" placeholder="Số nhà, tên đường...">
            </div>

            <div class="form-group">
                <label for="notes">Ghi chú (tùy chọn)</label>
                <textarea id="notes" rows="3" placeholder="Ghi chú về đơn hàng..."></textarea>
            </div>
        </div>

        <div class="order-summary">
            <h2>Đơn hàng của bạn</h2>

            <ul class="product-list">
                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach items="${cartItems}" var="item">
                            <li class="product-item">
                                <div class="product-image">
                                    <img src="${item.img}" alt="${item.name}">
                                    <span class="product-quantity">${item.quantity}</span>
                                </div>
                                <div class="product-info">
                                    <p class="product-name">${item.name}</p>
                                </div>
                                <p class="product-price">
                                    <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>đ
                                </p>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="product-item">
                            <p>Giỏ hàng đang trống.</p>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <div class="promo-code">
                <input type="text" id="voucher-input" placeholder="Nhập mã giảm giá">
                <button type="button" id="btn-apply-voucher">Áp dụng</button>
            </div>

            <span id="voucher-msg"></span>

            <div class="totals">
                <div class="totals-item">
                    <p>Tạm tính:</p>
                    <p><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>đ</p>
                </div>
                <div class="totals-item">
                    <p>Phí vận chuyển:</p>
                    <p><fmt:formatNumber value="${shippingFee}" pattern="#,###"/>đ</p>
                </div>
                <div class="totals-item" id="discount-row">
                    <p>Giảm giá:</p>
                    <p id="discount-amount">-0đ</p>
                </div>
                <div class="totals-item total">
                    <p>Tổng cộng:</p>
                    <p id="final-total" data-original="${finalTotal}">
                        <fmt:formatNumber value="${finalTotal}" pattern="#,###"/>đ
                    </p>
                </div>
            </div>

            <div class="payment-methods">
                <h4>Phương thức thanh toán</h4>
                <div class="payment-option">
                    <input type="radio" id="payment-cod" name="payment" value="cod" checked>
                    <label for="payment-cod"><i class="bi bi-truck"></i> Thanh toán khi nhận hàng (COD)</label>
                </div>
                <div class="payment-option">
                    <input type="radio" id="payment-bank" name="payment" value="bank">
                    <label for="payment-bank"><i class="bi bi-credit-card"></i> Chuyển khoản ngân hàng</label>
                </div>
                <div class="payment-option">
                    <input type="radio" id="payment-momo" name="payment" value="momo">
                    <label for="payment-momo"><i class="bi bi-qr-code"></i> Ví Momo</label>
                </div>
            </div>

            <button class="checkout-btn" id="btn-dat-hang">ĐẶT HÀNG</button>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<div id="success-popup" class="popup-content-wrap" style="display: none;">
    <div class="popup-content">
        <button class="popup-close-btn" id="popup-close"><i class="bi bi-x-lg"></i></button>
        <div class="icon-box"><i class="bi bi-check-lg"></i></div>
        <h3>Đặt hàng thành công!</h3>
        <p>Cảm ơn bạn đã mua sắm tại AuraSound.</p>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptCheckout.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/checkout.js"></script>

</body>
</html>