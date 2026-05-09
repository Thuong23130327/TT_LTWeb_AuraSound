<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Thanh toán - AuraSound");
    request.setAttribute("activePage", "cart");
%>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleCheckout.css">

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
            <c:if test="${sessionScope.user == null}">
                <p>Bạn đã có tài khoản? <a href="login.jsp">Đăng nhập</a> để điền nhanh thông tin.</p>
            </c:if>

            <div class="form-group">
                <label for="fullname">Họ và tên *</label>
                <input type="text" id="fullname" value="${sessionScope.user.fullName}" placeholder="Nhập họ và tên của bạn" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" value="${sessionScope.user.email}" placeholder="Nhập địa chỉ email">
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại *</label>
                    <input type="tel" id="phone" value="${sessionScope.user.phoneNumber}" placeholder="Nhập số điện thoại" required>
                </div>
            </div>

            <h2>Địa chỉ nhận hàng</h2>

            <div class="form-group">
                <label for="city">Tỉnh / Thành phố *</label>
                <input type="text" id="city" value="${sessionScope.user.address}" required placeholder="Nhập Tỉnh/ Thành phố">
            </div>

            <div class="form-group">
                <label for="ward">Phường / Xã *</label>
                <input type="text" id="ward" required placeholder="Phường / Xã">
            </div>

            <div class="form-group">
                <label for="address">Địa chỉ cụ thể *</label>
                <input type="text" id="address" placeholder="Số nhà, tên đường..." required>
            </div>

            <div class="form-group">
                <label for="notes">Ghi chú (tùy chọn)</label>
                <textarea id="notes" rows="3" placeholder="Ghi chú về đơn hàng, ví dụ: thời gian giao hàng..."></textarea>
            </div>
        </div>

        <div class="order-summary">
            <h2>Đơn hàng của bạn</h2>

            <ul class="product-list">
                <c:choose>
                    <c:when test="${not empty sessionScope.cart.listItems}">

                        <c:forEach items="${sessionScope.cart.listItems}" var="item">

                            <li class="product-item">
                                <div class="product-image">
                                    <img src="${item.productVariant.mainImageUrl}" alt="Ảnh sản phẩm">
                                    <span class="product-quantity">${item.quantity}</span>
                                </div>

                                <div class="product-info">
                                    <p class="product-name" style="font-weight: bold;">
                                            ${item.productVariant.variantSku}
                                    </p>

                                    <p class="product-variant" style="color: #666; font-size: 0.9em;">
                                        Màu: ${item.productVariant.colorName}
                                    </p>
                                </div>

                                <p class="product-price">
                                    <fmt:formatNumber value="${item.productVariant.sellPrice * item.quantity}" type="currency" currencySymbol=""/>đ
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
                    <p>
                        <fmt:formatNumber value="${sessionScope.cart.totalPrice}" type="currency" currencySymbol=""/>đ
                    </p>
                </div>
                <div class="totals-item">
                    <p>Phí vận chuyển:</p>
                    <p>30.000đ</p> </div>

                <div class="totals-item" id="discount-row">
                    <p>Giảm giá:</p>
                    <p id="discount-amount">-0đ</p>
                </div>

                <div class="totals-item total">
                    <p>Tổng cộng:</p>
                    <p id="final-total" data-original="${sessionScope.cart.totalPrice + 30000}">
                        <fmt:formatNumber value="${sessionScope.cart.totalPrice + 30000}" type="currency" currencySymbol=""/>đ
                    </p>
                </div>
            </div>

            <div class="payment-methods">
                <h4>Phương thức thanh toán</h4>
                <div class="payment-option">
                    <input type="radio" id="payment-cod" name="payment" value="cod" checked>
                    <label for="payment-cod">
                        <i class="bi bi-truck"></i> Thanh toán khi nhận hàng (COD)
                    </label>
                </div>
                <div class="payment-option">
                    <input type="radio" id="payment-bank" name="payment" value="bank">
                    <label for="payment-bank">
                        <i class="bi bi-credit-card"></i> Chuyển khoản ngân hàng
                    </label>
                </div>
                <div class="payment-option">
                    <input type="radio" id="payment-momo" name="payment" value="momo">
                    <label for="payment-momo">
                        <i class="bi bi-qr-code"></i> Ví Momo (QR Code)
                    </label>
                </div>
            </div>

            <button class="checkout-btn" id="btn-dat-hang">ĐẶT HÀNG</button>
        </div>
    </div>
</main>


<!-- footer -->
<jsp:include page="/tag/_footer.jsp"></jsp:include>

<div id="success-popup" class="popup-content-wrap" style="display: none;">
    <div class="popup-content">
        <button class="popup-close-btn" id="popup-close">
            <i class="bi bi-x-lg"></i>
        </button>
        <div class="icon-box">
            <i class="bi bi-check-lg"></i>
        </div>
        <h3>Đặt hàng thành công!</h3>
        <p>Cảm ơn bạn đã mua sắm tại AuraSound.</p>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/checkout.js"></script>

</body>
</html>