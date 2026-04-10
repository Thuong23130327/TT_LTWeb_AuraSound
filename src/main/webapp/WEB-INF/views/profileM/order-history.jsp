<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Lịch sử mua hàng - AuraSound");
    request.setAttribute("activePage", "profile");
%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
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
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>
<!-- section -->

<main class="profile-page-main">
    <div class="profile-container">
        <div class="profile-sidebar">
            <div class="user-info">
                <img class="img-profile" src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}" alt="Avatar">
                <h5 class="user-name">Chào, ${userDetail.fullName}</h5>
                <p class="user-email">${userDetail.email}</p>
            </div>
            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user icon"></i> Thông
                        tin tài khoản</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-shipping"><i class="fa-solid fa-truck icon"></i> Đang
                        vận chuyển</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-pending"><i class="fa-solid fa-clock icon"></i> Đang
                        chờ duyệt</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-cancelled"><i class="fa-solid fa-ban icon"></i> Đã
                        hủy</a></li>
                    <li><a class="nav-link active" href="${pageContext.request.contextPath}/order-history"><i
                            class="fa-solid fa-history icon"></i> Lịch sử mua hàng</a></li>
                </ul>
            </div>
        </div>
        <section class="profile-content">
            <h3 class="title">Lịch sử mua hàng</h3>

            <c:choose>
                <c:when test="${not empty historyOrders}">
                    <c:forEach var="order" items="${historyOrders}">

                        <c:set var="statusClass" value="history" />
                        <c:if test="${order.status == 'Cancelled'}">
                            <c:set var="statusClass" value="cancelled" />
                        </c:if>
                        <c:if test="${order.status == 'Pending'}">
                            <c:set var="statusClass" value="pending" />
                        </c:if>
                        <c:if test="${order.status == 'Shipping'}">
                            <c:set var="statusClass" value="shipping" />
                        </c:if>

                        <a class="a-nodecor" href="${pageContext.request.contextPath}/order-detail?id=${order.id}">
                            <div class="list-item">
                                <div class="item-order ${statusClass}">
                                    #${order.orderCode} -
                                    <c:choose>
                                        <c:when test="${order.status == 'Canceled'}">Đã hủy: </c:when>
                                        <c:otherwise>Trạng thái: ${order.status} - </c:otherwise>
                                    </c:choose>
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <div class="alert alert-info">Bạn chưa có đơn hàng nào trong lịch sử.</div>
                </c:otherwise>
            </c:choose>
        </section>
    </div>
</main>
<!-- footer -->
<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>
</body>

</html>