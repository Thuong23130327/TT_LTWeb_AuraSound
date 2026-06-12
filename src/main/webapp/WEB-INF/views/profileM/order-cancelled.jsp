<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Đơn hàng đã hủy - AuraSound");
    request.setAttribute("activePage", "order-cancelled");
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
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
          crossorigin="anonymous">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<!-- secion -->

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
            <h3 class="title">Đơn hàng đã hủy</h3>
            <c:choose>
                <c:when test="${not empty cancelledOrders}">
                    <c:forEach var="order" items="${cancelledOrders}">
                        <a class="a-nodecor" href="${pageContext.request.contextPath}/order-detail?id=${order.id}">
                            <div class="list-item">
                                <div class="item-order cancelled">
                                    #${order.orderCode} - Đã hủy: <c:out value="${fn:replace(order.orderDate, 'T', ' ')}"/>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">Bạn hiện không có đơn hàng nào bị hủy.</div>
                </c:otherwise>
            </c:choose>

        </section>
    </div>
</main>


<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptStore.js"></script>
</body>
</html>