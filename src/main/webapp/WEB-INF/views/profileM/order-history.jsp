<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.Order" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Lịch sử mua hàng - AuraSound");
    request.setAttribute("activePage", "order-history");
%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lịch sử mua hàng - AuraSound</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
</head>

<body>

<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<main class="profile-page-main">
    <div class="profile-container">
        <c:set var="userObj" value="${not empty userDetail ? userDetail : sessionScope.auth}" />
        <div class="profile-sidebar" id="profileSidebar">
            <div class="user-info">
                <img class="img-profile"
                     src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}"
                     alt="Avatar">
                <h5 class="user-name">Chào, ${sessionScope.auth.fullName}</h5>
                <p class="user-email">${sessionScope.auth.email}</p>
            </div>

            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link ${activePage == 'profile' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/profile"><i
                            class="fa-solid fa-user icon"></i> Thông tin tài khoản</a>
                    </li>
                    <li><a class="nav-link ${activePage == 'address' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/address"><i
                            class="fa-solid fa-map-location-dot icon"></i> Địa Chỉ</a>
                    </li>
                    <li><a class="nav-link ${activePage == 'favorites' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/favorites"><i
                            class="fa-solid fa-heart icon"></i> Sản phẩm yêu thích</a>
                    </li>
                    <li><a class="nav-link ${activePage == 'order-shipping' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/order-shipping"><i
                            class="fa-solid fa-truck icon"></i> Đang vận chuyển</a></li>
                    <li><a class="nav-link ${activePage == 'order-pending' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/order-pending"><i
                            class="fa-solid fa-clock icon"></i> Đang chờ duyệt</a></li>
                    <li><a class="nav-link ${activePage == 'order-cancelled' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/order-cancelled"><i
                            class="fa-solid fa-ban icon"></i> Đã hủy</a></li>
                    <li><a class="nav-link ${activePage == 'order-history' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/order-history"><i
                            class="fa-solid fa-history icon"></i> Lịch sử mua hàng</a>
                    </li>
                </ul>
            </div>
        </div>

        <section class="profile-content">
            <h3 class="title">Lịch sử đơn hàng</h3>

            <%
                List<Order> historyOrders = (List<Order>) request.getAttribute("historyOrders");
                if (historyOrders != null && !historyOrders.isEmpty()) {
                    // Sửa lỗi: Chuỗi định dạng đã được gom gọn trên 1 dòng
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    for (Order order : historyOrders) {

                        String cssClass = "pending";
                        int statusValue = order.getStatus();
                        if (statusValue == 1) cssClass = "shipping";
                        else if (statusValue == 2) cssClass = "history";
                        else if (statusValue == 3) cssClass = "cancelled";

                        String formattedDate = "";
                        if (order.getOrderDate() != null) {
                            formattedDate = order.getOrderDate().format(formatter);
                        }

                        String amountStr = "0 VNĐ";
                        if (order.getFinalAmount() != null) {
                            amountStr = String.format("%,.0f", order.getFinalAmount()) + " VNĐ";
                        }

                        String statusDesc = "Đang xử lý";
                        if (order.getEOrderStatus() != null) {
                            statusDesc = order.getEOrderStatus().name();
                        }
            %>
            <a class="a-nodecor" href="${pageContext.request.contextPath}/order-detail?id=<%= order.getId() %>">
                <div class="list-item">
                    <div class="item-order <%= cssClass %>">
                        Mã đơn: <%= order.getOrderCode() %> - Người nhận: <%= order.getRecipientName() != null ? order.getRecipientName() : "Trống tên" %>
                        | Tổng tiền: <%= amountStr %>
                        | Trạng thái: <span style="font-weight: 600;"><%= statusDesc %></span>
                        <br>
                        <small>Ngày đặt: <%= formattedDate %></small>
                    </div>
                </div>
            </a>
            <%
                }
            } else {
            %>
            <div class="alert alert-info">
                Bạn chưa có đơn hàng nào trong lịch sử.
            </div>
            <%
                }
            %>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>
</body>

</html>