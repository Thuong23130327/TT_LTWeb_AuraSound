<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<%
    request.setAttribute("pageTitle", "Đơn hàng chờ xử lý - AuraSound");
    request.setAttribute("activePage", "order-pending");
%>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đơn hàng đang chờ duyệt - AuraSound</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHeadphones.css">
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>
<main class="profile-page-main">
    <div class="profile-container">
        <c:set var="userObj" value="${not empty userDetail ? userDetail : sessionScope.auth}" />
        <div class="profile-sidebar" id="profileSidebar">
            <div class="user-info">
                <img class="img-profile" src="${not empty userObj.avatarUrl ? (fn:startsWith(userObj.avatarUrl, 'http') ? userObj.avatarUrl : pageContext.request.contextPath.concat('/').concat(userObj.avatarUrl)) : pageContext.request.contextPath.concat('/assets/img/avatar/default.png')}" alt="Avatar">
                <h5 class="user-name">Chào, ${userObj.fullName}</h5>
                <p class="user-email">${userObj.email}</p>
            </div>
            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link ${activePage == 'profile' ? 'active' : ''}" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user icon"></i> Thông tin tài khoản</a></li>
                    <li><a class="nav-link ${activePage == 'address' ? 'active' : ''}" href="${pageContext.request.contextPath}/address"><i class="fa-solid fa-map-location-dot icon"></i> Địa Chỉ</a></li>
                    <li><a class="nav-link ${activePage == 'favorites' ? 'active' : ''}" href="${pageContext.request.contextPath}/favorites"><i class="fa-solid fa-heart icon"></i> Sản phẩm yêu thích</a></li>
                    <li><a class="nav-link ${activePage == 'order-shipping' ? 'active' : ''}" href="${pageContext.request.contextPath}/order-shipping"><i class="fa-solid fa-truck icon"></i> Đang vận chuyển</a></li>
                    <li><a class="nav-link ${activePage == 'order-pending' ? 'active' : ''}" href="${pageContext.request.contextPath}/order-pending"><i class="fa-solid fa-clock icon"></i> Đang chờ duyệt</a></li>
                    <li><a class="nav-link ${activePage == 'order-cancelled' ? 'active' : ''}" href="${pageContext.request.contextPath}/order-cancelled"><i class="fa-solid fa-ban icon"></i> Đã hủy</a></li>
                    <li><a class="nav-link ${activePage == 'order-history' ? 'active' : ''}" href="${pageContext.request.contextPath}/order-history"><i class="fa-solid fa-history icon"></i> Lịch sử mua hàng</a></li>
                </ul>
            </div>
        </div>
        <section class="profile-content">
            <h3 class="title">Đơn hàng đang chờ duyệt</h3>
            <c:choose>
                <c:when test="${not empty pendingOrders}">
                    <c:forEach var="order" items="${pendingOrders}">
                        <div class="modern-order-card">
                            <div class="modern-order-header">
                                <span class="modern-order-code">Mã đơn: ${order.orderCode} <span style="font-weight: normal; color: #888; font-size: 13px;">(${fn:replace(order.orderDate, 'T', ' ')})</span></span>
                                <span class="order-status pending">Đang chờ duyệt</span>
                            </div>
                            <div class="modern-order-body">
                                <c:forEach var="item" items="${order.items}">
                                    <div class="modern-order-item">
                                        <img src="${not empty item.productVariant.mainImageUrl ? item.productVariant.mainImageUrl : '../assets/img/default-product.png'}" alt="Product Image">
                                        <div class="modern-order-item-info">
                                            <h4 class="modern-order-item-name">${not empty item.productName ? item.productName : 'Sản phẩm'}</h4>
                                            <p class="modern-order-item-meta">Phân loại: ${not empty item.productVariant.colorName ? item.productVariant.colorName : ''} | Số lượng: x${item.quantity}</p>
                                        </div>
                                        <div class="modern-order-item-price"><fmt:formatNumber value="${item.price_at_purchase}" type="currency" pattern="#,###"/> đ</div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="modern-order-footer">
                                <div class="modern-order-total">
                                    Tổng tiền: <strong><fmt:formatNumber value="${order.finalAmount}" type="currency" pattern="#,###"/> đ</strong>
                                </div>
                                <div class="modern-order-actions">
                                    <a href="${pageContext.request.contextPath}/order-detail?id=${order.id}" class="btn-outline">Xem chi tiết</a>
                                    <button class="btn-outline btn-danger btn-cancel-order" data-id="${order.id}">Hủy đơn</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">Bạn hiện không có đơn hàng nào đang chờ duyệt.</div>
                </c:otherwise>
            </c:choose>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<!-- ===== MODAL XÁC NHẬN HỦY ĐƠN ===== -->
<div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-labelledby="cancelOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold text-danger" id="cancelOrderModalLabel">Xác nhận hủy đơn hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn hủy đơn hàng này không?<br>
                Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không hủy</button>
                <button type="button" class="btn btn-danger" id="btnConfirmCancel">Hủy đơn hàng</button>
            </div>
        </div>
    </div>
</div>

<script>
    window.ctxPath = '${pageContext.request.contextPath}';
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptStore.js"></script>
</body>
</html>