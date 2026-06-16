<%@ page import="model.entity.Order" %>
<%@ page import="model.entity.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
        <% request.setAttribute("pageTitle", "Chi tiết đơn hàng - AuraSound" );
            request.setAttribute("activePage", "order-history" ); %>
        <% Order currentOrder = (Order) request.getAttribute("order"); %>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${pageTitle}</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
                    rel="stylesheet">
                <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
                <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
                    crossorigin="anonymous">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
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
                                                class="fa-solid fa-user icon"></i> Thông tin tài khoản</a></li>
                                    <li><a class="nav-link ${activePage == 'address' ? 'active' : ''}"
                                            href="${pageContext.request.contextPath}/address"><i
                                                class="fa-solid fa-map-location-dot icon"></i> Địa Chỉ</a></li>
                                    <li><a class="nav-link ${activePage == 'favorites' ? 'active' : ''}"
                                            href="${pageContext.request.contextPath}/favorites"><i
                                                class="fa-solid fa-heart icon"></i> Sản phẩm yêu thích</a></li>
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
                                                class="fa-solid fa-history icon"></i> Lịch sử mua hàng</a></li>
                                </ul>
                            </div>
                        </div>
                        <section class="profile-content">
                            <h3 class="title"><i class="fa-solid fa-file-invoice"></i> Chi tiết đơn hàng</h3>

                            <% if (currentOrder != null) {
                                String statusDesc = "Đang xử lý";
                                int statusValue = currentOrder.getStatus();
                                if(statusValue == 1) statusDesc = "Đang vận chuyển";
                                else if(statusValue == 2) statusDesc = "Hoàn thành";
                                else if(statusValue == 3) statusDesc = "Đã hủy";
                            %>
                            <div class="card mb-4 border-0 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                                        <div>
                                            <h5 class="fw-bold mb-1">Mã đơn hàng: <%= currentOrder.getOrderCode() %></h5>
                                            <p class="text-muted small mb-0">Trạng thái: <span class="badge bg-primary"><%= statusDesc %></span></p>
                                        </div>
                                        <div class="text-md-end">
                                            <p class="mb-0 text-muted small">Tổng thanh toán</p>
                                            <h4 class="text-danger fw-bold mb-0">
                                                <%= String.format("%,.0f", currentOrder.getFinalAmount()) %> đ
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h5 class="fw-bold mb-3">Sản phẩm đã mua</h5>
                            <div class="modern-order-card p-3 mb-4">
                                <div class="modern-order-body">
                                    <%
                                        if(currentOrder.getItems() != null) {
                                            for(OrderItem item : currentOrder.getItems()) {
                                                String priceStr = item.getPrice_at_purchase() != null ? String.format("%,.0f", item.getPrice_at_purchase()) + " đ" : "0 đ";
                                    %>
                                    <div class="modern-order-item d-flex align-items-center gap-3 py-2 border-bottom">
                                        <img src="<%= item.getProductVariant() != null ? item.getProductVariant().getMainImageUrl() : "../assets/img/default-product.png" %>"
                                             alt="Product" style="width: 70px; height: 70px; object-fit: cover; border-radius: 8px;">
                                        <div style="flex:1;">
                                            <h6 class="fw-bold mb-1"><%= item.getProductName() %></h6>
                                            <p class="text-muted small mb-0">
                                                Phân loại: <%= item.getProductVariant() != null ? item.getProductVariant().getColorName() : "Mặc định" %>
                                                | Số lượng: x<%= item.getQuantity() %>
                                            </p>
                                        </div>
                                        <div class="fw-bold text-dark"><%= priceStr %></div>
                                    </div>
                                    <%
                                            }
                                        }
                                    %>
                                </div>
                            </div>

                            <div class="d-flex justify-content-start">
                                <a href="${pageContext.request.contextPath}/order-history" class="btn btn-outline-dark">
                                    <i class="fa-solid fa-arrow-left"></i> Quay lại lịch sử mua hàng
                                </a>
                            </div>

                            <% } else { %>
                            <div class="alert alert-danger text-center my-4">
                                <i class="fa-solid fa-triangle-exclamation mb-2 fs-3"></i>
                                <p class="mb-0">Không tìm thấy thông tin chi tiết cho đơn hàng này hoặc mã đơn không hợp lệ.</p>
                                <a href="${pageContext.request.contextPath}/order-history" class="btn btn-sm btn-secondary mt-3">Quay lại danh sách</a>
                            </div>
                            <% } %>
                        </section>

                    </div>
                </main>

                <jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

                <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
                <script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
                <script src="${pageContext.request.contextPath}/assets/js/scriptStore.js"></script>
            </body>

            </html>