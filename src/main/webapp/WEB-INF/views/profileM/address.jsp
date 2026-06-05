<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<%
    request.setAttribute("activePage", "address");
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa Chỉ - AuraSound</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHeadphones.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAddress.css">

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

        <div class="profile-content">
            <div id="address-section" class="tab-content active">
                <h3 class="title">Quản Lý Địa Chỉ</h3>

                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="bi bi-check-circle"></i> ${message}
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-error">
                        <i class="bi bi-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <button type="button" id="btnAddAddress" class="add-address-btn">
                    <i class="bi bi-plus-circle"></i> Thêm Địa Chỉ Mới (${addressCount}/5)
                </button>

                <div class="address-list">
                    <c:choose>
                        <c:when test="${empty addresses}">
                            <div class="address-empty">
                                <i class="bi bi-geo-alt"></i>
                                <p>Bạn chưa có địa chỉ nào</p>
                                <small>Thêm địa chỉ giao hàng để tiện cho việc mua sắm</small>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${addresses}" var="addr">

                                <div class="address-item ${addr.isDefault ? 'default' : ''}"  data-id="${addr.id}">
                                    <c:if test="${addr.isDefault}">
                                        <div class="address-default-badge">
                                            <i class="bi bi-star-fill"></i> Địa Chỉ Mặc Định
                                        </div>
                                    </c:if>
                                    <input class="address-default" style="display:none"  />

                                    <div class="address-info">
                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Người Nhận</div>
                                                <div class="address-info-value-name">${addr.recipientName}</div>
                                            </div>
                                            <div class="address-info-col">
                                                <div class="address-info-label">Số Điện Thoại</div>
                                                <div class="address-info-value-phone">${addr.phone}</div>
                                            </div>
                                        </div>

                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Tỉnh/Thành Phố</div>
                                                <div class="address-info-value-city">${addr.city}</div>
                                            </div>
                                        </div>

                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Địa Chỉ Chi Tiết</div>
                                                <div class="address-info-value-address">${addr.address}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="address-actions">
                                        <button type="button" class="btn btn-edit" onclick="editAddress(${addr.id})">
                                            <i class="bi bi-pencil"></i> Chỉnh Sửa
                                        </button>
                                        <button type="button" class="btn btn-delete" onclick="deleteAddress(${addr.id})">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                        <c:if test="${!addr.isDefault}">
                                            <button type="button" class="btn btn-default" onclick="setDefault(${addr.id})">
                                                <i class="bi bi-star"></i> Đặt Mặc Định
                                            </button>
                                        </c:if>
                                        <c:if test="${addr.isDefault}">
                                            <button type="button" class="btn btn-default active" disabled>
                                                <i class="bi bi-star-fill"></i> Đã Là Mặc Định
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</main>


<div id="modal-address" class="modal-container">
    <div class="modal-header">
        <h3 id="modalTitle">Thêm Địa Chỉ</h3>
        <i class="bi bi-x-lg close-modal" id="closeAddressModal"></i>
    </div>

    <div class="modal-body">
        <form id="addressForm" action="${pageContext.request.contextPath}/address" method="post">
            <input type="hidden" id="action" name="action" value="create">
            <input type="hidden" id="addressId" name="addressId" value="">

            <div class="form-group">
                <label for="recipientName">Tên Người Nhận *</label>
                <input type="text" id="recipientName" name="recipientName" placeholder="Nhập tên người nhận" required>
            </div>

            <div class="form-group">
                <label for="phone">Số Điện Thoại *</label>
                <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
            </div>

            <div class="form-group">
                <label for="city">Tỉnh/Thành Phố *</label>
                <select id="city" name="city" required>
                    <option value="">-- Chọn Tỉnh/Thành Phố --</option>
                    <option value="An Giang">An Giang</option>
                    <option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu</option>
                    <option value="Bạc Liêu">Bạc Liêu</option>
                    <option value="Bắc Giang">Bắc Giang</option>
                    <option value="Bắc Kạn">Bắc Kạn</option>
                    <option value="Bắc Ninh">Bắc Ninh</option>
                    <option value="Bến Tre">Bến Tre</option>
                    <option value="Bình Dương">Bình Dương</option>
                    <option value="Bình Phước">Bình Phước</option>
                    <option value="Bình Thuận">Bình Thuận</option>
                    <option value="Cà Mau">Cà Mau</option>
                    <option value="Cao Bằng">Cao Bằng</option>
                    <option value="Cần Thơ">Cần Thơ</option>
                    <option value="Đà Nẵng">Đà Nẵng</option>
                    <option value="Đắk Lắk">Đắk Lắk</option>
                    <option value="Đắk Nông">Đắk Nông</option>
                    <option value="Điện Biên">Điện Biên</option>
                    <option value="Đồng Nai">Đồng Nai</option>
                    <option value="Đồng Tháp">Đồng Tháp</option>
                    <option value="Gia Lai">Gia Lai</option>
                    <option value="Hà Giang">Hà Giang</option>
                    <option value="Hà Nam">Hà Nam</option>
                    <option value="Hà Nội">Hà Nội</option>
                    <option value="Hà Tĩnh">Hà Tĩnh</option>
                    <option value="Hải Dương">Hải Dương</option>
                    <option value="Hải Phòng">Hải Phòng</option>
                    <option value="Hậu Giang">Hậu Giang</option>
                    <option value="Hòa Bình">Hòa Bình</option>
                    <option value="Hưng Yên">Hưng Yên</option>
                    <option value="Khánh Hòa">Khánh Hòa</option>
                    <option value="Kiên Giang">Kiên Giang</option>
                    <option value="Kon Tum">Kon Tum</option>
                    <option value="Lai Châu">Lai Châu</option>
                    <option value="Lâm Đồng">Lâm Đồng</option>
                    <option value="Lạng Sơn">Lạng Sơn</option>
                    <option value="Lào Cai">Lào Cai</option>
                    <option value="Long An">Long An</option>
                    <option value="Nam Định">Nam Định</option>
                    <option value="Nghệ An">Nghệ An</option>
                    <option value="Ninh Bình">Ninh Bình</option>
                    <option value="Ninh Thuận">Ninh Thuận</option>
                    <option value="Phú Thọ">Phú Thọ</option>
                    <option value="Phú Yên">Phú Yên</option>
                    <option value="Quảng Bình">Quảng Bình</option>
                    <option value="Quảng Nam">Quảng Nam</option>
                    <option value="Quảng Ngãi">Quảng Ngãi</option>
                    <option value="Quảng Ninh">Quảng Ninh</option>
                    <option value="Quảng Trị">Quảng Trị</option>
                    <option value="Sóc Trăng">Sóc Trăng</option>
                    <option value="Sơn La">Sơn La</option>
                    <option value="Tây Ninh">Tây Ninh</option>
                    <option value="Thái Bình">Thái Bình</option>
                    <option value="Thái Nguyên">Thái Nguyên</option>
                    <option value="Thanh Hóa">Thanh Hóa</option>
                    <option value="Thừa Thiên Huế">Thừa Thiên Huế</option>
                    <option value="Tiền Giang">Tiền Giang</option>
                    <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                    <option value="Trà Vinh">Trà Vinh</option>
                    <option value="Tuyên Quang">Tuyên Quang</option>
                    <option value="Vĩnh Long">Vĩnh Long</option>
                    <option value="Vĩnh Phúc">Vĩnh Phúc</option>
                    <option value="Yên Bái">Yên Bái</option>
                </select>
            </div>

            <div class="form-group">
                <label for="address">Địa Chỉ Chi Tiết *</label>
                <input type="text" id="address" name="address" placeholder="Nhập địa chỉ chi tiết (Số nhà, Đường, ...)" required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox" id="isDefault" name="isDefault" value="true">
                <label for="isDefault" style="margin: 0;">Đặt làm địa chỉ mặc định</label>
            </div>
        </form>
    </div>

    <div class="modal-footer">
        <button id="btnCancelAddress" class="btn-secondary">Hủy</button>
        <button id="btnSaveAddress" class="btn-primary">Lưu Địa Chỉ</button>
    </div>
</div>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptAddress.js"></script>
</body>
</html>
