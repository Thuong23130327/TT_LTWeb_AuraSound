<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Sản phẩm đã yêu thích - AuraSound");
    request.setAttribute("activePage", "profile");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<!-- section -->

<main class="profile-page-main">
    <div class="profile-container">
        <div class="profile-sidebar">
            <div class="user-info">
                <img class="img-profile"
                     src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : '../assets/img/avatar/default.png'}"
                     alt="Avatar">
                <h5 class="user-name">Chào, ${userDetail.fullName}</h5>
                <p class="user-email">${userDetail.email}</p>
            </div>
            <div class="side-menu mobile-hidden" id="sideMenuContent">
                <ul class="nav-list">
                    <li><a class="nav-link " href="${pageContext.request.contextPath}/profile"><i
                            class="fa-solid fa-user icon"></i> Thông
                        tin tài khoản</a></li>
                    <li><a class="nav-link active" href="favorites.jsp"><i class="fa-solid fa-heart icon"></i> Sản
                        phẩm yêu thích</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-shipping"><i
                            class="fa-solid fa-truck icon"></i> Đang
                        vận chuyển</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-pending"><i
                            class="fa-solid fa-clock icon"></i> Đang
                        chờ duyệt</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-cancelled"><i
                            class="fa-solid fa-ban icon"></i> Đã
                        hủy</a></li>
                    <li><a class="nav-link" href="${pageContext.request.contextPath}/order-history"><i
                            class="fa-solid fa-history icon"></i> Lịch
                        sử mua hàng</a></li>
                </ul>
            </div>
        </div>

        <section class="profile-content">
            <h3 class="title">Sản phẩm yêu thích</h3>

            <div class="product-grid" id="product-grid">
                <c:forEach items="${wishlistProducts}" var="p">
                    <div class="product-card-wrapper" data-product-id="${p.id}">
                        <a href="${pageContext.request.contextPath}/detail?pid=${p.id}" class="product-card">
                            <img src="${p.img}" alt="${p.name}"
                                 onerror="this.src='https://placehold.co/300x300?text=No+Image'">
                            <div class="product-card-info">
                                <h4>${p.name}</h4>
                                <div class="price-block">
                                    <div class="new-price">
                                        <fmt:formatNumber value="${p.sellPrice}" pattern="#,###"/> đ
                                    </div>
                                </div>
                                <div class="product-bottom-row">
                                    <div class="favorite active">
                                        <span class="btn-wishlist" data-id="${p.id}" data-favorites-card="true"
                                              style="cursor:pointer;"
                                              onclick="event.preventDefault();">
            <i class="bi bi-heart-fill" style="color:red;"></i>
        </span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>

            </div>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>
<script src="${AuraSound}/assets/js/script.js"></script>

<script src="${AuraSound}/assets/js/scriptProduct.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
</body>
</html>