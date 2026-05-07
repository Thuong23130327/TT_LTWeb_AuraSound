<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<%
    request.setAttribute("pageTitle", "Chi tiết đơn hàng - AuraSound");
    request.setAttribute("activePage", "profile");
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
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleCheckout.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>


<main class="profile-page-main">
    <div class="profile-container">


        <div class="profile-sidebar" id="profileSidebar">
            <div class="user-info">
                <img class="img-profile" src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}" alt="Avatar">
                <h5 class="user-name">Chào, ${userDetail.fullName}</h5>
                <p class="user-email">${userDetail.fullName}</p>
            </div>

            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user icon"></i> Thông
                        tin tài khoản</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-shipping"><i
                            class="fa-solid fa-truck icon"></i> Đang
                        vận chuyển</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-pending"><i
                            class="fa-solid fa-clock icon"></i> Đang
                        chờ duyệt</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-cancelled"><i
                            class="fa-solid fa-ban icon"></i> Đã
                        hủy</a></li>
                    <li><a class="nav-link active" href="${pageContext.request.contextPath}/order-history"><i
                            class="fa-solid fa-history icon"></i> Lịch
                        sử mua hàng</a></li>
                </ul>
            </div>
        </div>

        <div class="profile-content">
            <a href="profileM/order-history.jsp" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> TRỞ LẠI
            </a>

            <div class="order-detail-header">
                <h3 class="title" style="margin-bottom: 0; border-bottom: none;">Chi tiết đơn hàng #AS0891</h3>
                <span class="order-status cancelled">
                        <i class="fa-solid fa-ban"></i> Đã hủy
                    </span>
            </div>

            <div class="order-detail-block">
                <h4>Sản phẩm</h4>
                <div class="block-content">
                    <c:forEach var="item" items="${orderItems}">
                    <div class="product-item">
                        <img src="${item.productVariant.mainImageUrl}" alt="${item.name}" style="width: 70px; margin-right: 15px;">
                        <div class="product-info">
                            <h6>${item.name}</h6>
                            <p>Màu: ${item.productVariant.colorName} | SL: ${item.quantity}</p>
                            </div>
                            <div class="product-price"><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VNĐ"/></div>
                        </div>
                        <hr>
                        </c:forEach>

                        <div class="order-total">
                            <span>Thành tiền:</span>
                            <span class="total-price">13.850.000₫</span>
                        </div>
                    </div>
                </div>

                <div class="order-detail-block">
                    <h4>Thông tin đơn hàng</h4>
                    <div class="block-content">
                        <ul class="order-info-list">
                            <li>
                                <strong>Mã đơn hàng:</strong>
                                <span>#${orderDetail.orderCode}</span>
                            </li>
                            <li>
                                <strong>Ngày đặt:</strong>
                                <span><fmt:formatDate value="${orderDetail.orderDate}" pattern="dd-MM-yyyy HH:mm"/></span>
                            </li>
                            <li>
                                <strong>Ngày hủy:</strong>
                                <span>11-11-2025 08:34</span>
                            </li>
                            <li>
                                <strong>Yêu cầu bởi:</strong>
                                <span>Người mua</span>
                            </li>
                            <li>
                                <strong>Lý do hủy:</strong>
                                <span>Thay đổi đơn hàng (màu sắc, kích thước, thêm mã giảm giá,...)</span>
                            </li>
                            <li>
                                <strong>Phương thức thanh toán:</strong>
                                <span>COD</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="order-detail-block">
                    <h4>Địa chỉ nhận hàng</h4>
                    <div class="block-content address-info">
                        <strong>Nguyễn Hoài Thương</strong>
                        <p>0708870329</p>
                        <p>10 Đường số 5, Phường Linh Xuân, TP.HCM</p>
                    </div>
                </div>
            </div>
        </div>
</main>


<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
</body>
</html>