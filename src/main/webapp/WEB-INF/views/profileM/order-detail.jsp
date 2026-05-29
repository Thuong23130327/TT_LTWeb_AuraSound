<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Chi tiết đơn hàng - AuraSound");
    request.setAttribute("activePage", "profile");
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleCheckout.css">
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"/>

<main class="profile-page-main">
    <div class="profile-container">

        <div class="profile-sidebar" id="profileSidebar">
            <div class="user-info">
                <img class="img-profile"
                     src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : pageContext.request.contextPath.concat('/assets/img/avatar/default.png')}"
                     alt="Avatar">
                <h5 class="user-name">Chào, ${userDetail.fullName}</h5>
                <p class="user-email">${userDetail.email}</p>
            </div>
            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/profile">
                        <i class="fa-solid fa-user icon"></i> Thông tin tài khoản</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-shipping">
                        <i class="fa-solid fa-truck icon"></i> Đang vận chuyển</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-pending">
                        <i class="fa-solid fa-clock icon"></i> Đang chờ duyệt</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-cancelled">
                        <i class="fa-solid fa-ban icon"></i> Đã hủy</a></li>
                    <li><a class="nav-link active" href="${pageContext.request.contextPath}/order-history">
                        <i class="fa-solid fa-history icon"></i> Lịch sử mua hàng</a></li>
                </ul>
            </div>
        </div>

        <div class="profile-content">

            <a href="${pageContext.request.contextPath}/order-history" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> TRỞ LẠI
            </a>

            <div class="order-detail-header">
                <h3 class="title" style="margin-bottom: 0; border-bottom: none;">
                    Chi tiết đơn hàng #${order.orderCode}
                </h3>

                <c:choose>
                    <c:when test="${order.status == 0}">
                        <span class="order-status pending">
                            <i class="fa-solid fa-clock"></i> Chờ duyệt
                        </span>
                    </c:when>
                    <c:when test="${order.status == 1}">
                        <span class="order-status shipping">
                            <i class="fa-solid fa-truck"></i> Đang giao
                        </span>
                    </c:when>
                    <c:when test="${order.status == 2}">
                        <span class="order-status success">
                            <i class="fa-solid fa-check-circle"></i> Hoàn thành
                        </span>
                    </c:when>
                    <c:when test="${order.status == 3}">
                        <span class="order-status cancelled">
                            <i class="fa-solid fa-ban"></i> Đã hủy
                        </span>
                    </c:when>
                </c:choose>
            </div>

            <div class="order-detail-block">
                <h4>Sản phẩm</h4>
                <div class="block-content">
                    <c:choose>
                        <c:when test="${not empty orderItems}">
                            <c:forEach var="item" items="${orderItems}">
                                <div class="product-item">
                                    <img src="${not empty item.productVariant.mainImageUrl
                                                ? item.productVariant.mainImageUrl
                                                : pageContext.request.contextPath.concat('/assets/img/no-image.png')}"
                                         alt="${item.productName}"
                                         style="width: 70px; margin-right: 15px;">
                                    <div class="product-info">
                                        <h6>${item.productName}</h6>
                                        <p>Màu: ${item.productVariant.colorName} | SL: ${item.quantity}</p>
                                    </div>
                                    <div class="product-price">
                                        <fmt:formatNumber value="${item.price_at_purchase}" type="currency" />
                                    </div>
                                </div>
                                <hr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Không có sản phẩm nào.</p>
                        </c:otherwise>
                    </c:choose>

                    <div class="order-total">
                        <span>Tạm tính:</span>
                        <span><fmt:formatNumber value="${order.totalProductsPrice}" type="number" groupingUsed="true"/> VNĐ</span>
                    </div>
                    <div class="order-total">
                        <span>Phí vận chuyển:</span>
                        <span><fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true"/> VNĐ</span>
                    </div>
                    <c:if test="${order.discountAmount > 0}">
                        <div class="order-total">
                            <span>Giảm giá:</span>
                            <span>- <fmt:formatNumber value="${order.discountAmount}" type="number" groupingUsed="true"/> VNĐ</span>
                        </div>
                    </c:if>
                    <div class="order-total" style="font-weight: bold; font-size: 1.1em;">
                        <span>Thành tiền:</span>
                        <span class="total-price">
                            <fmt:formatNumber value="${order.finalAmount}" type="number" groupingUsed="true"/> VNĐ
                        </span>
                    </div>
                </div>
            </div>

            <div class="order-detail-block">
                <h4>Thông tin đơn hàng</h4>
                <div class="block-content">
                    <ul class="order-info-list">
                        <li>
                            <strong>Mã đơn hàng:</strong>
                            <span>#${order.orderCode}</span>
                        </li>
                        <li>
                            <strong>Ngày đặt:</strong>
                            <span>${order.orderDate}</span>
                        </li>
                        <c:if test="${not empty order.finishedAt}">
                            <li>
                                <strong>Ngày hoàn thành:</strong>
                                <span>${order.finishedAt}</span>
                            </li>
                        </c:if>
                        <li>
                            <strong>Trạng thái:</strong>
                            <span>
                                <c:choose>
                                    <c:when test="${order.status == 0}">Chờ duyệt</c:when>
                                    <c:when test="${order.status == 1}">Đang giao</c:when>
                                    <c:when test="${order.status == 2}">Hoàn thành</c:when>
                                    <c:when test="${order.status == 3}">Đã hủy</c:when>
                                    <c:otherwise>Không rõ</c:otherwise>
                                </c:choose>
                            </span>
                        </li>
                        <li>
                            <strong>Ghi chú của admin:</strong>
                            <span>${not empty order.adminNote ? order.adminNote : 'Không có'}</span>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="order-detail-block">
                <h4>Địa chỉ nhận hàng</h4>
                <div class="block-content address-info">
                    <c:choose>
                        <c:when test="${not empty orderShipping and not empty orderShipping.userAddress}">
                            <strong>${orderShipping.userAddress.recipientName}</strong>
                            <p>${orderShipping.userAddress.phone}</p>
                            <p>${orderShipping.userAddress.address}</p>
                            <p>${orderShipping.userAddress.city}</p>
                            <c:if test="${not empty orderShipping.note}">
                                <p><em>Ghi chú: ${orderShipping.note}</em></p>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Không có thông tin địa chỉ.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"/>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
</body>
</html>
