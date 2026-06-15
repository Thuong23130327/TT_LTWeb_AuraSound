<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<% request.setAttribute("activePage", "address" ); %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa Chỉ - AuraSound</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
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
                <img class="img-profile"
                     src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}"
                     alt="Avatar">
                <h5 class="user-name">Chào, ${sessionScope.auth.fullName}</h5>
                <p class="user-email">${sessionScope.auth.email}</p>
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
                                <div class="address-item ${addr.isDefault ? 'default' : ''}"
                                     data-id="${addr.id}"
                                     data-province-id="${addr.provinceId}"
                                     data-district-id="${addr.districtId}"
                                     data-ward-code="${addr.wardCode}">

                                    <c:if test="${addr.isDefault}">
                                        <div class="address-default-badge">
                                            <i class="bi bi-star-fill"></i> Địa Chỉ Mặc Định
                                        </div>
                                    </c:if>
                                    <input class="address-default" style="display:none" />

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
                                                <div class="address-info-label">Khu vực (Phường/Xã, Quận/Huyện, Tỉnh/Thành)</div>
                                                <div class="address-info-value-city">${addr.city}</div>
                                            </div>
                                        </div>

                                        <div class="address-info-row">
                                            <div class="address-info-col">
                                                <div class="address-info-label">Địa Chỉ Chi Tiết (Số nhà, Tên đường)</div>
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
                <label for="province">Tỉnh / Thành Phố *</label>
                <select id="province" required>
                    <option value="">-- Chọn Tỉnh / Thành Phố --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="district">Quận / Huyện *</label>
                <select id="district" required disabled>
                    <option value="">-- Chọn Quận / Huyện --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="ward">Phường / Xã *</label>
                <select id="ward" required disabled>
                    <option value="">-- Chọn Phường / Xã --</option>
                </select>
            </div>

            <div class="form-group">
                <label for="address">Địa Chỉ Chi Tiết (Số nhà, Tên đường...) *</label>
                <input type="text" id="address" name="address" placeholder="Nhập địa chỉ chi tiết (Số nhà, Đường, ...)" required>
            </div>

            <input type="hidden" id="provinceId" name="provinceId">
            <input type="hidden" id="districtId" name="districtId">
            <input type="hidden" id="wardCode" name="wardCode">
            <input type="hidden" id="cityText" name="cityText">

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