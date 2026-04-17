<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script>
    const path = "${pageContext.request.contextPath}";
</script>

<nav id="sidebar" class="col-md-3 col-lg-2 d-md-block sidebar shadow-sm">
    <a class="a-nodecor logo-container" href="${AuraSound}/home">
        <div class="logo-wave">
            <div class="sound-wave wave1"></div>
            <div class="sound-wave wave2"></div>
            <div class="sound-wave wave3"></div>

        </div>
        <span class="logo-text">AuraSound Admin</span>
    </a>

    <ul class="nav flex-column">

        <li class="nav-item">
            <a href="${AuraSound}/admin/dashboard" class="nav-link ${activePage == "admin"? "active" : ""}">
                <i class="fas fa-home me-2"></i>
                Tổng quan
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/admin/mail" class="nav-link ${activePage == "contact"? "active" : ""}">
                <i class="fas fa-envelope me-2"></i>
                Liên hệ
            </a>
        </li>
        <li class="nav-item">
            <a href="${AuraSound}/admin/product-manager" class="nav-link ${activePage == "product"? "active" : ""}">
                <i class="fas fa-box me-2"></i>
                Quản lý Sản phẩm
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/admin/manage-order" class="nav-link ${activePage == "order"? "active" : ""}">
                <i class="fas fa-shopping-cart me-2"></i>
                Quản lý Đơn hàng
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/admin/user-manager" class="nav-link ${activePage == "acc"? "active" : ""}">
                <i class="fas fa-users me-2"></i>
                Quản lý Tài Khoản
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/admin/voucher.jsp" class="nav-link ${activePage == "vou"? "active" : ""}">
                <i class="fa-solid fa-comment-dots me-2"></i>
                Quản lý Voucher
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/admin/my-web" class="nav-link ${activePage == "custom"? "active" : ""}">
                <i class="fa-solid fa-list me-2"></i>
                Quản lý Giao diện
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/home" class="nav-link ">
                <i class="fa-solid fa-earth-asia me-2"></i>
                Xem website
            </a>
        </li>

        <li class="nav-item">
            <a href="${AuraSound}/logout" class="nav-link text-danger">
                <i class="fa-solid fa-right-from-bracket me-2"></i>
                Đăng xuất
            </a>
        </li>
    </ul>

</nav>
