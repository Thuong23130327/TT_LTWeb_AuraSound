<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Lịch sử mua hàng - AuraSound");
    request.setAttribute("activePage", "profile");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v6.0.0-beta3/css/all.css">
</head>

<body>

<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<main style="margin-top: 100px;">
    <div class="container container-profile">
        <div class="profile-sidebar">
            <div class="profile-user">
                <img src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : 'https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg'}" alt="Avatar" class="profile-avatar">
                <div class="profile-info">
                    <p class="profile-username">${not empty userDetail.fullName ? userDetail.fullName : 'Người dùng AuraSound'}</p>
                    <p class="profile-email">${userDetail.email}</p>
                </div>
            </div>
            <div class="menu-profile">
                <ul>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user icon"></i> Tài khoản của tôi</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-pending"><i class="fa-solid fa-clock icon"></i> Chờ xử lý</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-shipping"><i class="fa-solid fa-truck icon"></i> Đang vận chuyển</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-cancelled"><i class="fa-solid fa-ban icon"></i> Đã hủy</a></li>
                    <li><a class="nav-link active" href="${pageContext.request.contextPath}/order-history"><i class="fa-solid fa-history icon"></i> Lịch sử mua hàng</a></li>
                </ul>
            </div>
        </div>

        <section class="profile-content">
            <h3 class="title">Lịch sử đơn hàng</h3>
            <c:choose>
                <c:when test="${not empty historyOrders}">
                    <c:forEach var="order" items="${historyOrders}">

                        <c:set var="statusClass" value="default" />
                        <c:set var="statusText" value="Không xác định" />

                        <c:choose>
                            <c:when test="${order.status.value == 0}">
                                <c:set var="statusClass" value="pending" />
                                <c:set var="statusText" value="Chờ duyệt" />
                            </c:when>
                            <c:when test="${order.status.value == 1}">
                                <c:set var="statusClass" value="shipping" />
                                <c:set var="statusText" value="Đang giao" />
                            </c:when>
                            <c:when test="${order.status.value == 2}">
                                <c:set var="statusClass" value="success" />
                                <c:set var="statusText" value="Thành công" />
                            </c:when>
                            <c:when test="${order.status.value == 3}">
                                <c:set var="statusClass" value="cancelled" />
                                <c:set var="statusText" value="Đã hủy" />
                            </c:when>
                        </c:choose>

                        <a class="a-nodecor" href="${pageContext.request.contextPath}/order-detail?id=${order.id}">
                            <div class="list-item">
                                <div class="item-order ${statusClass}">
                                    #${order.orderCode} - ${statusText} -

                                        <%-- Giải pháp an toàn ép kiểu LocalDateTime sang String hiển thị ngày --%>
                                    <c:choose>
                                        <c:when test="${not empty order.orderDate}">
                                            <c:out value="${fn:replace(order.orderDate.toString(), 'T', ' ')}"/>
                                        </c:when>
                                        <c:otherwise>
                                            Không rõ ngày đặt
                                        </c:otherwise>
                                    </c:choose>
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

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>
</body>
</html>