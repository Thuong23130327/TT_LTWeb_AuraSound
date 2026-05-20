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

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>


<main class="profile-page-main">
    <div class="profile-container">

        <div class="profile-sidebar" id="profileSidebar">
            <div class="user-info">
                <img class="img-profile" src="assets/img/avatar/HoaiThuong.png" alt="Avatar">
                <h5 class="user-name">Chào, ${userDetail.fullName}</h5>
                <p class="user-email">${userDetail.fullName}</p>
            </div>

            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user icon"></i> Thông
                        tin tài khoản</a></li>
                    <li><a class="nav-link" href="favorites.jsp"><i class="fa-solid fa-heart icon"></i> Sản
                        phẩm yêu thích</a></li>
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
        <section class="profile-content">
            <h3 class="title">Đơn hàng đang chờ duyệt</h3>
            <c:choose>
                <c:when test="${not empty succOrders}">
<%--                    <c:if test="${not empty succOrders}">--%>
<%--                        <p>Mã đơn: #${succOrders.orderCode}</p>--%>
<%--                        <p>Tổng tiền: <fmt:formatNumber value="${succOrders.finalAmount}" type="currency" currencySymbol="VNĐ"/></p>--%>
<%--                        <p>Ngày đặt: <c:out value="${fn:replace(succOrders.orderDate.toString(), 'T', ' ')}"/></p>--%>
<%--                    </c:if>--%>
                    <c:forEach var="order" items="${pendingOrders}">
                        <a class="a-nodecor" href="${pageContext.request.contextPath}/order-detail?id=${order.id}">
                            <div class="list-item">
                                <div class="item-order history">
                                    #${order.orderCode} - Người nhận: ${not empty order.recipientName ? order.recipientName : 'Trống tên'}
                                    | Tổng tiền:
                                    <c:choose>
                                        <c:when test="${not empty order.finalAmount}">
                                            <fmt:formatNumber value="${order.finalAmount}" type="currency" currencySymbol="VNĐ"/>
                                        </c:when>
                                        <c:otherwise>0 VNĐ</c:otherwise>
                                    </c:choose>
                                    <br>
                                    <small>Ngày đặt: <c:out value="${fn:replace(order.orderDate, 'T', ' ')}"/></small>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">Bạn hiện không có đơn hàng đã hoàn thành nào.</div>
                </c:otherwise>
            </c:choose>
        </section>

    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
</body>
</html>