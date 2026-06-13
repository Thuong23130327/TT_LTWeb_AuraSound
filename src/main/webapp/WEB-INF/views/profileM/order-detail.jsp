<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
        <% request.setAttribute("pageTitle", "Chi tiết đơn hàng - AuraSound" );
            request.setAttribute("activePage", "order-history" ); %>
            <!DOCTYPE html>
            <html lang="vi">

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
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleCheckout.css">
            </head>

            <body>
                <jsp:include page="/WEB-INF/tag/_header.jsp" />

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

                            <%-- ===== KHỐI VẬN CHUYỂN + ĐỊA CHỈ (GỘP CHUNG) ===== --%>
                            <div class="order-detail-block">
                                <h4>Thông tin vận chuyển &amp; địa chỉ nhận hàng</h4>
                                <div class="block-content">
                                    <div style="display:flex; gap:40px; flex-wrap:wrap;">
                                        <%-- Cột trái: thông tin vận chuyển --%>
                                        <div style="flex:1; min-width:220px;">
                                            <p><strong>Mã vận đơn:</strong> <span style="color: #4a6fff;">AS-${order.orderCode}VN</span></p>
                                            <p><strong>Đơn vị vận chuyển:</strong> Giao hàng nhanh (GHN)</p>
                                            <p><strong>Tiến độ:</strong>
                                                <c:choose>
                                                    <c:when test="${order.status == 0}">Đơn hàng đang chờ xác nhận</c:when>
                                                    <c:when test="${order.status == 1}">Đang giao đến bạn</c:when>
                                                    <c:when test="${order.status == 2}">Giao hàng thành công</c:when>
                                                    <c:when test="${order.status == 3}">Đã hủy</c:when>
                                                </c:choose>
                                            </p>
                                        </div>
                                        <%-- Cột phải: địa chỉ nhận hàng --%>
                                        <div style="flex:1; min-width:220px; border-left:1px dashed #ddd; padding-left:24px;">
                                            <p style="font-weight:600; margin-bottom:4px;"><i class="fa-solid fa-location-dot" style="color:#4a6fff;"></i> Địa chỉ nhận hàng</p>
                                            <c:choose>
                                                <c:when test="${not empty orderShipping and not empty orderShipping.userAddress}">
                                                    <strong>${orderShipping.userAddress.recipientName}</strong>
                                                    <p style="margin:2px 0;">${orderShipping.userAddress.phone}</p>
                                                    <p style="margin:2px 0;">${orderShipping.userAddress.address}</p>
                                                    <p style="margin:2px 0;">${orderShipping.userAddress.city}</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-muted">Không có thông tin địa chỉ.</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- ===== KHỐI SẢN PHẨM ===== --%>
                            <div class="order-detail-block">
                                <h4>Sản phẩm</h4>
                                <div class="block-content">
                                    <c:choose>
                                        <c:when test="${not empty orderItems}">
                                            <c:forEach var="item" items="${orderItems}">
                                                <div class="product-item-detail" style="display:flex; align-items:center; gap:15px; margin-bottom:15px; border-bottom:1px dashed #eee; padding-bottom:15px; flex-wrap:wrap;">
                                                    <img src="${not empty item.productVariant.mainImageUrl
                                                            ? item.productVariant.mainImageUrl
                                                            : pageContext.request.contextPath.concat('/assets/img/default-product.png')}"
                                                        alt="${item.productName}"
                                                        style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px; border: 1px solid #eee;">
                                                    <div class="product-info" style="flex-grow:1;">
                                                        <h6 style="margin: 0 0 5px 0; font-weight: 600;">${item.productName}</h6>
                                                        <p style="margin: 0; font-size: 14px; color: #666;">Phân loại: ${item.productVariant.colorName} | SL: x${item.quantity}</p>
                                                    </div>
                                                    <div class="product-price" style="font-weight: 600; color: #e53935; min-width: 100px; text-align: right;">
                                                        <fmt:formatNumber value="${item.price_at_purchase}" type="currency" pattern="#,###"/> đ
                                                    </div>
                                                    <%-- Nút đánh giá từng sản phẩm (chỉ hiện khi đã hoàn thành) --%>
                                                    <c:if test="${order.status == 2}">
                                                        <button class="btn btn-sm btn-open-review"
                                                                data-product-id="${item.productVariant.id}"
                                                                data-product-name="${item.productName}"
                                                                data-order-id="${order.id}"
                                                                style="border:1px solid #667eea; color:#667eea; background:#fff; border-radius:8px; padding:5px 12px; white-space:nowrap; cursor:pointer;">
                                                            <i class="bi bi-star-fill" style="color:#f5a623;"></i> Đánh giá
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted">Không có sản phẩm nào.</p>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="order-total">
                                        <span>Tạm tính:</span>
                                        <span>
                                            <fmt:formatNumber value="${order.totalProductsPrice}" type="number" groupingUsed="true" /> đ
                                        </span>
                                    </div>
                                    <div class="order-total">
                                        <span>Phí vận chuyển:</span>
                                        <span>
                                            <fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true" /> đ
                                        </span>
                                    </div>
                                    <c:if test="${order.discountAmount > 0}">
                                        <div class="order-total">
                                            <span>Giảm giá:</span>
                                            <span>-
                                                <fmt:formatNumber value="${order.discountAmount}" type="number" groupingUsed="true" /> đ
                                            </span>
                                        </div>
                                    </c:if>
                                    <div class="order-total" style="font-weight: bold; font-size: 1.1em;">
                                        <span>Thành tiền:</span>
                                        <span class="total-price" style="color: #e53935; font-size: 1.2em;">
                                            <fmt:formatNumber value="${order.finalAmount}" type="number" groupingUsed="true" /> đ
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <%-- ===== KHỐI THÔNG TIN ĐƠN HÀNG ===== --%>
                            <div class="order-detail-block">
                                <h4>Thông tin đơn hàng</h4>
                                <div class="block-content">
                                    <ul class="order-info-list">
                                        <li>
                                            <strong>Mã đơn hàng:</strong>
                                            <span>#${order.orderCode}</span>
                                        </li>
                                        <li>
                                            <strong>Phương thức thanh toán:</strong>
                                            <span>
                                                <c:choose>
                                                    <c:when test="${order.paymentStatus == 1}">Thanh toán VNPay</c:when>
                                                    <c:otherwise>Thanh toán khi nhận hàng (COD)</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </li>
                                        <li>
                                            <strong>Ngày đặt hàng:</strong>
                                            <span>${fn:replace(order.orderDate, 'T', ' ')}</span>
                                        </li>
                                        <c:if test="${not empty order.finishedAt}">
                                            <li>
                                                <strong>Ngày hoàn thành:</strong>
                                                <span>${fn:replace(order.finishedAt, 'T', ' ')}</span>
                                            </li>
                                        </c:if>
                                        <li>
                                            <strong>Ghi chú của khách hàng:</strong>
                                            <span>${not empty orderShipping.note ? orderShipping.note : 'Không có'}</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <%-- ===== NÚT HÀNH ĐỘNG ===== --%>
                            <div class="order-detail-block" style="border:none; padding-top:0;">
                                <div class="block-content" style="display:flex; gap:12px; flex-wrap:wrap; justify-content:flex-end;">
                                    <%-- Hủy đơn: chỉ hiện với đơn chờ duyệt (status=0) --%>
                                    <c:if test="${order.status == 0}">
                                        <button class="btn btn-outline-danger btn-cancel-order"
                                                data-id="${order.id}"
                                                style="border-radius:10px; padding:10px 24px; font-weight:600;">
                                            <i class="fa-solid fa-ban"></i> Hủy đơn hàng
                                        </button>
                                    </c:if>
                                    <%-- Mua lại: hiện với đơn hoàn thành hoặc đã hủy --%>
                                    <c:if test="${order.status == 2 || order.status == 3}">
                                        <button class="btn btn-outline-primary btn-buy-again"
                                                data-id="${order.id}"
                                                style="border-radius:10px; padding:10px 24px; font-weight:600;">
                                            <i class="fa-solid fa-cart-plus"></i> Mua lại
                                        </button>
                                    </c:if>
                                </div>
                            </div>

                            <div class="order-detail-block">
                                <h4>Liên hệ AuraSound</h4>
                                <div class="block-content">
                                    <p>Trường hợp có thắc mắc hoặc khiếu nại về đơn hàng, vui lòng liên hệ trực tiếp với chúng tôi qua:</p>
                                    <p><i class="fa-solid fa-phone" style="width: 20px;"></i> Hotline: <strong>1900 1234</strong></p>
                                    <p><i class="fa-solid fa-envelope" style="width: 20px;"></i> Email: <strong>support@aurasound.vn</strong></p>
                                    <p><em>Lưu ý: Thời gian tiếp nhận hỗ trợ từ 8:00 đến 17:30 các ngày trong tuần.</em></p>
                                </div>
                            </div>

                        </div>
                    </div>
                </main>

                <!-- ===== MODAL XÁC NHẬN HỦY ĐƠN ===== -->
                <div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-labelledby="cancelOrderModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title fw-bold text-danger" id="cancelOrderModalLabel">Xác nhận hủy đơn hàng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Bạn có chắc chắn muốn hủy đơn hàng <strong>#${order.orderCode}</strong> không?<br>
                                Hành động này không thể hoàn tác.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không hủy</button>
                                <button type="button" class="btn btn-danger" id="btnConfirmCancel">Hủy đơn hàng</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ===== MODAL ĐÁNH GIÁ SẢN PHẨM ===== -->
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
                                            <input type="radio" name="rating" id="det-rate-1" value="1"/>
                                            <label for="det-rate-1" class="rate-btn btn-very-bad">Cực tệ</label>
                                            <input type="radio" name="rating" id="det-rate-2" value="2"/>
                                            <label for="det-rate-2" class="rate-btn btn-bad">Chưa ổn</label>
                                            <input type="radio" name="rating" id="det-rate-3" value="3"/>
                                            <label for="det-rate-3" class="rate-btn btn-neutral">Trung bình</label>
                                            <input type="radio" name="rating" id="det-rate-4" value="4"/>
                                            <label for="det-rate-4" class="rate-btn btn-good">Tuyệt</label>
                                            <input type="radio" name="rating" id="det-rate-5" value="5" required/>
                                            <label for="det-rate-5" class="rate-btn btn-very-good">Rất hài lòng</label>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="detailComment" class="form-label">Cảm nhận về sản phẩm:</label>
                                        <textarea name="comment" id="detailComment" class="form-control" rows="3"
                                                  placeholder="Chia sẻ trải nghiệm của bạn về âm thanh, thiết kế..."></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Thêm hình ảnh thực tế (nếu có):</label>
                                        <input type="file" name="reviewFiles" class="form-control" accept="image/*" multiple>
                                        <div id="detail-review-preview" class="d-flex gap-2 mt-2"></div>
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

                <jsp:include page="/WEB-INF/tag/_footer.jsp" />

                <script>
                    window.ctxPath = '${pageContext.request.contextPath}';
                </script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
                <script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
            </body>

            </html>