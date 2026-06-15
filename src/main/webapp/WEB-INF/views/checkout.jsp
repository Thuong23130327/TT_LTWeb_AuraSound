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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleCheckout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAddress.css">
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<%-- Overlay backdrop (giống address.jsp) --%>
<div id="menu-overlay" class="overlay"></div>

<main class="content">
    <div class="checkout-container">

        <!-- Khối thông tin khách hàng và địa chỉ -->
        <div class="customer-details">
            <h2>Thông tin giao hàng</h2>
            <c:if test="${sessionScope.auth == null}">
                <p>Bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để điền nhanh thông tin.</p>
            </c:if>

            <div class="form-group">
                <label for="fullname">Họ và tên *</label>
                <input type="text" id="fullname" value="${sessionScope.auth.fullName}" placeholder="Nhập họ và tên của bạn" required disabled class="input-disabled">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" value="${sessionScope.auth.email}" placeholder="Nhập địa chỉ email" disabled class="input-disabled">
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại *</label>
                    <input type="tel" id="phone" value="${sessionScope.auth.phone}" placeholder="Nhập số điện thoại" required disabled class="input-disabled">
                </div>
            </div>

            <h2>Địa chỉ nhận hàng</h2>

            <div class="form-group">
                <label for="city">Tỉnh / Thành phố *</label>
                <input type="text" id="city" placeholder="Tỉnh / Thành phố" disabled class="input-disabled">
            </div>

            <div class="form-group">
                <label for="district_main">Quận / Huyện *</label>
                <input type="text" id="district_main" placeholder="Quận / Huyện" disabled class="input-disabled">
            </div>

            <div class="form-group">
                <label for="wardDisplay">Phường / Xã *</label>
                <input type="text" id="wardDisplay" placeholder="Phường / Xã" disabled class="input-disabled">
            </div>

            <div class="form-group">
                <label for="addressDisplay">Địa chỉ cụ thể *</label>
                <input type="text" id="addressDisplay" placeholder="Số nhà, tên đường..." disabled class="input-disabled">
            </div>

            <input type="hidden" id="mainProvinceId" value="">
            <input type="hidden" id="mainDistrictId" value="">
            <input type="hidden" id="mainWardCode" value="">
            <input type="hidden" id="mainAddressId" value="">

            <div class="form-group">
                <label for="notes">Ghi chú (tùy chọn)</label>
                <textarea id="notes" rows="3" placeholder="Ghi chú về đơn hàng..."></textarea>
            </div>

            <!-- Sổ địa chỉ -->
            <div class="address-book-section mt-4 pt-3 border-top">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0"><i class="bi bi-journal-bookmark"></i> Sổ địa chỉ của bạn</h4>
                    <button type="button" id="btnAddAddress"
                            class="add-address-btn co-add-btn ${addressCount >= 5 ? 'btn-address-disabled' : ''}"
                            ${addressCount >= 5 ? 'disabled' : ''}>
                        <i class="bi bi-plus-circle"></i> Thêm mới (${addressCount}/5)
                    </button>
                </div>

                <div class="address-list">
                    <c:choose>
                        <c:when test="${empty addresses}">
                            <div class="address-empty">
                                <i class="bi bi-geo-alt"></i>
                                <p>Bạn chưa có địa chỉ nào</p>
                                <small>Vui lòng thêm địa chỉ nhận hàng mới.</small>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${addresses}" var="addr">
                                <div class="address-item co-address-item ${addr.isDefault ? 'default' : ''}"
                                     data-id="${addr.id}"
                                     data-province-id="${addr.provinceId}"
                                     data-district-id="${addr.districtId}"
                                     data-ward-code="${addr.wardCode}">

                                    <%-- Radio chọn địa chỉ giao hàng --%>
                                    <label class="co-select-label">
                                        <input type="radio" name="selectedShippingAddress"
                                               value="${addr.id}"
                                               ${addr.isDefault ? 'checked' : ''}
                                               class="co-radio">
                                        <span>Dùng địa chỉ này để giao hàng</span>
                                    </label>

                                    <c:if test="${addr.isDefault}">
                                        <div class="address-default-badge">
                                            <i class="bi bi-star-fill"></i> Địa Chỉ Mặc Định
                                        </div>
                                    </c:if>

                                    <div class="address-info">
                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Người Nhận</div>
                                                <div class="address-info-value-name">${addr.recipientName}</div>
                                            </div>
                                            <div class="address-info-col">
                                                <div class="address-info-label">Số Điện Thoại</div>
                                                <div class="address-info-value-phone">${addr.phone}</div>
                                            </div>
                                        </div>

                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Khu vực (Phường/Xã, Quận/Huyện, Tỉnh/Thành)</div>
                                                <div class="address-info-value-city">${addr.city}</div>
                                            </div>
                                        </div>

                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Địa Chỉ Chi Tiết (Số nhà, Tên đường)</div>
                                                <div class="address-info-value-address">${addr.address}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="address-actions">
                                        <button type="button" class="btn btn-edit"
                                                onclick="event.stopPropagation(); editAddress(${addr.id})">
                                            <i class="bi bi-pencil"></i> Chỉnh Sửa
                                        </button>
                                        <button type="button" class="btn btn-delete"
                                                onclick="event.stopPropagation(); deleteAddress(${addr.id})">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                        <c:if test="${!addr.isDefault}">
                                            <button type="button" class="btn btn-default"
                                                    onclick="event.stopPropagation(); setDefault(${addr.id})">
                                                <i class="bi bi-star"></i> Đặt Mặc Định
                                            </button>
                                        </c:if>
                                        <c:if test="${addr.isDefault}">
                                            <button type="button" class="btn btn-default active" disabled>
                                                <i class="bi bi-star-fill"></i> Đã Là Mặc Định
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Khối tóm tắt đơn hàng (Sidebar) -->
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
                                    <p class="product-variant">${item.colorName}</p>
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
                <button type="button" id="btn-open-wallet" class="btn-wallet" title="Kho Voucher"><i class="bi bi-ticket-perforated"></i> Kho</button>
            </div>

            <span id="voucher-msg"></span>

            <div class="totals">
                <div class="totals-item">
                    <p>Tạm tính:</p>
                    <p id="subtotal-amount" data-value="${totalPrice}"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>đ</p>
                </div>
                <div class="totals-item">
                    <p>Phí vận chuyển:</p>
                    <p id="shipping-fee-display"><fmt:formatNumber value="${shippingFee}" pattern="#,###"/>đ</p>
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
                    <input type="radio" id="payment-vnpay" name="payment" value="vnpay">
                    <label for="payment-vnpay"><i class="bi bi-credit-card"></i> Thanh toán qua VNPAY</label>
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

<!-- Success Popup -->
<div id="success-popup" class="popup-content-wrap popup-hidden">
    <div class="popup-content">
        <button class="popup-close-btn" id="popup-close"><i class="bi bi-x-lg"></i></button>
        <div class="icon-box"><i class="bi bi-check-lg"></i></div>
        <h3>Đặt hàng thành công!</h3>
        <p>Cảm ơn bạn đã mua sắm tại AuraSound.</p>
    </div>
</div>

<!-- Fail Popup -->
<div id="fail-popup" class="popup-content-wrap popup-hidden">
    <div class="popup-content">
        <button class="popup-close-btn" id="popup-fail-close"><i class="bi bi-x-lg"></i></button>
        <div class="icon-box icon-box-fail">
            <i class="bi bi-x-lg"></i>
        </div>
        <h3 class="text-fail">Thanh toán thất bại!</h3>
        <p>Bạn đã hủy giao dịch hoặc có lỗi xảy ra. Vui lòng thử lại.</p>
    </div>
</div>

<!-- Modal Thêm/Sửa Địa Chỉ (dùng id giống address.jsp để tương thích) -->
<div id="modal-address" class="modal-container">
    <div class="modal-header">
        <h3 id="modalTitle">Thêm Địa Chỉ</h3>
        <i class="bi bi-x-lg close-modal" id="closeAddressModal"></i>
    </div>

    <div class="modal-body">
        <form id="addressForm" action="${pageContext.request.contextPath}/address" method="post">
            <input type="hidden" id="action" name="action" value="create">
            <input type="hidden" id="addressId" name="addressId" value="">
            <input type="hidden" name="redirect" value="checkout">

            <div class="form-group">
                <label for="recipientName">Tên Người Nhận *</label>
                <input type="text" id="recipientName" name="recipientName" placeholder="Nhập tên người nhận" required>
            </div>

            <div class="form-group">
                <label for="phoneModal">Số Điện Thoại *</label>
                <input type="tel" id="phoneModal" name="phone" placeholder="Nhập số điện thoại" required>
            </div>

            <div class="form-group">
                <label for="province">Tỉnh / Thành Phố *</label>
                <select id="province" required>
                    <option value="">-- Chọn Tỉnh / Thành Phố --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="district">Quận / Huyện *</label>
                <select id="district" required disabled>
                    <option value="">-- Chọn Quận / Huyện --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="ward">Phường / Xã *</label>
                <select id="ward" required disabled>
                    <option value="">-- Chọn Phường / Xã --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="addressDetail">Địa Chỉ Chi Tiết (Số nhà, Tên đường...) *</label>
                <input type="text" id="addressDetail" name="address" placeholder="Nhập địa chỉ chi tiết (Số nhà, Đường, ...)" required>
            </div>

            <input type="hidden" id="provinceId" name="provinceId">
            <input type="hidden" id="districtId" name="districtId">
            <input type="hidden" id="wardCode" name="wardCode">
            <input type="hidden" id="cityText" name="cityText">

            <div class="checkbox-group">
                <input type="checkbox" id="isDefault" name="isDefault" value="true">
                <label for="isDefault" style="margin: 0;">Đặt làm địa chỉ mặc định</label>
            </div>
        </form>
    </div>

    <div class="modal-footer">
        <button id="btnCancelAddress" class="btn-secondary">Hủy</button>
        <button id="btnSaveAddress" class="btn-primary">Lưu Địa Chỉ</button>
    </div>
</div>

<!-- Popup Kho Voucher -->
<div id="wallet-popup" class="popup-content-wrap popup-hidden">
    <div class="popup-content wallet-popup-box">
        <button class="popup-close-btn" id="wallet-close"><i class="bi bi-x-lg"></i></button>
        <h3 class="wallet-title"><i class="bi bi-wallet2"></i> Kho Voucher Của Bạn</h3>

        <div class="voucher-list">
            <c:choose>
                <c:when test="${not empty walletVouchers}">
                    <c:forEach items="${walletVouchers}" var="v">
                        <div class="voucher-card">
                            <div class="voucher-info">
                                <strong class="voucher-code">${v.code}</strong>
                                <p class="voucher-discount">Giảm: <fmt:formatNumber value="${v.discountAmount}" pattern="#,###"/>đ</p>
                                <p class="voucher-min-order">Đơn tối thiểu: <fmt:formatNumber value="${v.minimumOrderAmount}" pattern="#,###"/>đ</p>
                                <p class="voucher-expiry">HSD: ${v.endDateFormatted}</p>
                            </div>
                            <button type="button" class="btn-select-voucher" data-code="${v.code}">Dùng ngay</button>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="voucher-empty-text">Hiện tại bạn chưa có voucher nào khả dụng.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptCheckout.js"></script>
</body>
</html>