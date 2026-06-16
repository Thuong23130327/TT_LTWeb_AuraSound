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
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
                    for (Order order : historyOrders) {

                        String statusClass = "pending";
                        int statusValue = order.getStatus();
                        if (statusValue == 1) statusClass = "shipping";
                        else if (statusValue == 2) statusClass = "completed";
                        else if (statusValue == 3) statusClass = "cancelled";

                        String formattedDate = "";
                        if (order.getOrderDate() != null) {
                            formattedDate = order.getOrderDate().format(formatter);
                        }

                        String amountStr = "0 VNĐ";
                        if (order.getFinalAmount() != null) {
                            amountStr = String.format("%,.0f", order.getFinalAmount()) + " đ";
                        }

                        String statusDesc = "Đang xử lý";
                        if (order.getEOrderStatus() != null) {
                            statusDesc = order.getEOrderStatus().name();
                        }
                        if("COMPLETED".equals(statusDesc)) statusDesc = "Hoàn thành";
                        else if("PENDING".equals(statusDesc)) statusDesc = "Đang chờ duyệt";
                        else if("SHIPPING".equals(statusDesc)) statusDesc = "Đang vận chuyển";
                        else if("CANCELLED".equals(statusDesc)) statusDesc = "Đã hủy";
            %>
            <div class="modern-order-card">
                <div class="modern-order-header">
                    <span class="modern-order-code">Mã đơn: <%= order.getOrderCode() %> <span style="font-weight: normal; color: #888; font-size: 13px;">(<%= formattedDate %>)</span></span>
                    <span class="order-status <%= statusClass %>"><%= statusDesc %></span>
                </div>
                <div class="modern-order-body">
                    <%
                        List<model.entity.OrderItem> items = order.getItems();
                        if(items != null) {
                            for(model.entity.OrderItem item : items) {
                                String priceStr = item.getPrice_at_purchase() != null ? String.format("%,.0f", item.getPrice_at_purchase()) + " đ" : "0 đ";
                                int pvId = (item.getProductVariant() != null) ? item.getProductVariant().getId() : 0;
                                String pName = item.getProductName() != null ? item.getProductName().replace("\"","&quot;") : "Sản phẩm";
                    %>
                    <div class="modern-order-item" style="display:flex; align-items:center; flex-wrap:wrap; gap:8px;">
                        <img src="<%= item.getProductVariant() != null ? item.getProductVariant().getMainImageUrl() : "../assets/img/default-product.png" %>" alt="Product Image">
                        <div class="modern-order-item-info" style="flex:1; min-width:120px;">
                            <h4 class="modern-order-item-name"><%= item.getProductName() != null ? item.getProductName() : "Sản phẩm" %></h4>
                            <p class="modern-order-item-meta">Phân loại: <%= item.getProductVariant() != null ? item.getProductVariant().getColorName() : "" %> | Số lượng: x<%= item.getQuantity() %></p>
                        </div>
                        <div class="modern-order-item-price"><%= priceStr %></div>
                        <% if (statusValue == 2) { %>
                        <button class="btn-outline btn-open-review"
                                data-product-id="<%= pvId %>"
                                data-product-name="<%= pName %>"
                                data-order-id="<%= order.getId() %>"
                                style="white-space:nowrap; font-size:13px; padding:5px 12px;">
                            <i class="fa-solid fa-star" style="color:#f5a623;"></i> Đánh giá
                        </button>
                        <% } %>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="modern-order-footer">
                    <div class="modern-order-total">
                        Tổng tiền: <strong><%= amountStr %></strong>
                    </div>
                    <div class="modern-order-actions">
                        <a href="${pageContext.request.contextPath}/order-detail-success?id=<%= order.getOrderCode() %>" class="btn">Xem chi tiết</a>
                        <% if (statusValue == 0) { %>
                            <button class="btn-outline btn-danger btn-cancel-order" data-id="<%= order.getId() %>">Hủy đơn</button>
                        <% } %>
                        <% if (statusValue == 2 || statusValue == 3) { %>
                            <button class="btn-outline btn-buy-again" data-id="<%= order.getId() %>">Mua lại</button>
                        <% } %>
                    </div>
                </div>
            </div>
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

<!--MODAL XÁC NHẬN HỦY ĐƠN-->
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

<!--MODAL ĐÁNH GIÁ SẢN PHẨM-->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/add-Review" method="post" enctype="multipart/form-data" id="reviewForm">
                <input type="hidden" name="inputPid" id="reviewProductId" value="">
                <input type="hidden" name="inputUid" value="${sessionScope.auth.id}">
                <input type="hidden" name="orderId"  id="reviewOrderId"   value="">

                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Đánh giá sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label d-block fw-bold">Mức độ hài lòng của bạn:</label>
                        <div class="sentiment-rating">
                            <input type="radio" name="rating" id="hist-rate-1" value="1"/>
                            <label for="hist-rate-1" class="rate-btn btn-very-bad">Cực tệ</label>
                            <input type="radio" name="rating" id="hist-rate-2" value="2"/>
                            <label for="hist-rate-2" class="rate-btn btn-bad">Chưa ổn</label>
                            <input type="radio" name="rating" id="hist-rate-3" value="3"/>
                            <label for="hist-rate-3" class="rate-btn btn-neutral">Trung bình</label>
                            <input type="radio" name="rating" id="hist-rate-4" value="4"/>
                            <label for="hist-rate-4" class="rate-btn btn-good">Tuyệt</label>
                            <input type="radio" name="rating" id="hist-rate-5" value="5" required/>
                            <label for="hist-rate-5" class="rate-btn btn-very-good">Rất hài lòng</label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="historyComment" class="form-label">Cảm nhận về sản phẩm:</label>
                        <textarea name="comment" id="historyComment" class="form-control" rows="3"
                                  placeholder="Chia sẻ trải nghiệm của bạn về âm thanh, thiết kế..."></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Thêm hình ảnh thực tế (nếu có):</label>
                        <input type="file" name="reviewFiles" class="form-control" accept="image/*" multiple>
                        <div id="history-review-preview" class="d-flex gap-2 mt-2"></div>
                    </div>
                </div>

                <div class="modal-footer d-flex justify-content-end">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Xác nhận</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>
<script>
    window.ctxPath = '${pageContext.request.contextPath}';
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptStore.js"></script>
</body>

</html>