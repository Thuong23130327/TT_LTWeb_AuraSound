<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<%
    request.setAttribute("activePage", "product");
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${cateName != null ? cateName : 'Sản phẩm'} - AuraSound</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHeadphones.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>
<!-- section profile -->

<main class="profile-page-main">
    <div class="profile-container">

        <div class="profile-sidebar" id="profileSidebar">
            <div class="user-info">
                <img class="img-profile" src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}" alt="Avatar">
                <h5 class="user-name">Chào, ${userDetail.fullName}</h5>
                <p class="user-email">${userDetail.email}</p>
            </div>

            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link active" href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user icon"></i> Thông
                        tin tài khoản</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-shipping"><i class="fa-solid fa-truck icon"></i> Đang
                        vận chuyển</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-pending"><i class="fa-solid fa-clock icon"></i> Đang
                        chờ duyệt</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-cancelled"><i class="fa-solid fa-ban icon"></i> Đã
                        hủy</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-history"><i class="fa-solid fa-history icon"></i> Lịch
                        sử mua hàng</a></li>
                </ul>
            </div>
        </div>

        <div class="profile-content">

            <div id="account-info" class="tab-content active">
                <h3 class="title">Thông tin cá nhân</h3>

                <div class="form-group">
                    <label for="fullName">Họ và Tên</label>
                    <input type="text" id="fullName" value="${userDetail.fullName}" readonly>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" value="${userDetail.email}" disabled>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <input type="text" id="phone" value="${userDetail.phone}" readonly>
                </div>
                <button type="button" id="btnOpenEdit" class="btn-primary">Cập nhật thông tin</button>

                <form id="editForm" action="${pageContext.request.contextPath}/profile" method="post">
                    <div id="modal-edit-profile" class="modal-container">
                        <div class="modal-header">
                            <h3>Chỉnh sửa hồ sơ</h3>
                            <i class="bi bi-x-lg close-modal" id="closeIcon"></i>
                        </div>

                        <div class="modal-body">

                            <div class="avatar-upload-group">
                                <div class="avatar-preview-box">
                                    <img id="avatarPreview" src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}"
                                         alt="Avatar Preview">
                                    <input type="file" id="imageUpload" accept="image/*" hidden>
                                    <label for="imageUpload" class="camera-icon">
                                        <i class="bi bi-camera-fill"></i>
                                    </label>
                                </div>
                                <span class="hint-text">Nhấn vào icon camera để thay đổi ảnh</span>
                            </div>

                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" id="editName" name="fullName" value="${userDetail.fullName}">
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" id="editEmail" value="${userDetail.email}" disabled
                                       style="background: #eee;">
                            </div>

                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" id="editPhone" name="phone" value="${userDetail.phone}">
                            </div>

                        </div>

                        <div class="modal-footer">
                            <button id="btnCancel" class="btn-secondary">Thoát</button>
                            <button id="btnSave" class="btn-primary">Lưu thay đổi</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
</body>
</html>