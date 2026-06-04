<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<%
    request.setAttribute("pageTitle", "Sản phẩm đã yêu thích - AuraSound");
    request.setAttribute("activePage", "favorites");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleProfile.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<!-- section -->

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

        <section class="profile-content">
            <h3 class="title">Sản phẩm yêu thích</h3>

            <div class="product-grid" id="product-grid">
                <a href="../sproduct.jsp" class="product-card" data-brand="sony" data-type="chup-tai"
                   data-feature="bluetooth chong-on" data-price="7990000">
                    <div class="product-badge discount">
                        Giảm 18%
                    </div>
                    <img src="https://salt.tikicdn.com/cache/750x750/ts/product/ac/cf/71/908237eb3f6dfd93ee494866616de085.jpg.webp"
                         alt="Sony WH-1000XM5">

                    <!-- Thông tin sản phẩm -->
                    <div class="product-card-info">
                        <h4>Sony WH-1000XM5</h4>

                        <div class="price-block">
                            <span class="new-price">7.990.000đ</span>
                            <span class="old-price">9.690.000đ</span>
                        </div>

                        <div class="product-bottom-row">
                            <div class="rating">
                                <i class="bi bi-star-fill"></i>
                                <span>4.7</span>
                            </div>
                            <div class="favorite">
                                <i style="display: block;" class="bi bi-heart-fill"></i>
                                <span>Yêu thích</span>
                            </div>
                        </div>
                    </div>
                </a>

                <a href="../sproduct.jsp" class="product-card" data-brand="ava" data-type="truewireless"
                   data-feature="bluetooth" data-price="200000">

                    <!-- Tag giảm giá -->
                    <div class="product-badge discount">
                        Giảm 20%
                    </div>
                    <img src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/330709/tai-nghe-bluetooth-true-wireless-ava-go-p310-trang-1-638642413611048035-750x500.jpg"
                         alt="Sony WH-1000XM5">

                    <!-- Thông tin sản phẩm -->
                    <div class="product-card-info">
                        <h4>Tai nghe Bluetooth True Wireless AVA+ Go P310 </h4>

                        <div class="price-block">
                            <span class="new-price">200.000đ</span>
                            <span class="old-price">250.000đ</span>
                        </div>

                        <div class="product-bottom-row">
                            <div class="rating">
                                <i class="bi bi-star-fill"></i>
                                <span>4.7</span>
                            </div>
                            <div class="favorite">
                                <i style="display: block;" class="bi bi-heart-fill"></i>

                                <span>Yêu thích</span>
                            </div>
                        </div>
                    </div>
                </a>
                <a href="../sproduct.jsp" class="product-card" data-brand="ava" data-type="truewireless"
                   data-feature="bluetooth" data-price="200000">

                    <img src="https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/54/332455/tai-nghe-tws-jbl-wave-beam-2-den-3-638682176208572620-750x500.jpg"
                         alt="Tai nghe Bluetooth True Wireless JBL Wave Beam 2 ">

                    <!-- Thông tin sản phẩm -->
                    <div class="product-card-info">
                        <h4>Tai nghe Bluetooth True Wireless JBL Wave Beam 2 </h4>

                        <div class="price-block">
                            <span class="new-price">1.390.000đ</span>
                        </div>

                        <div class="product-bottom-row">
                            <div class="rating">
                                <i class="bi bi-star-fill"></i>
                                <span>4.2</span>
                            </div>
                            <div class="favorite">
                                <i style="display: block;" class="bi bi-heart-fill"></i>

                                <span>Yêu thích</span>
                            </div>
                        </div>
                    </div>
                </a>


                <a href="../sproduct.jsp" class="product-card" data-brand="sony" data-type="truewireless"
                   data-feature="bluetooth" data-price="1390000">

                    <img
                            src="https://cdn.tgdd.vn/Products/Images/54/313694/tai-nghe-bluetooth-chup-tai-sony-wh-ch520-kem-1-750x500.jpg">

                    <!-- Thông tin sản phẩm -->
                    <div class="product-card-info">
                        <h4>Tai nghe Bluetooth Chụp Tai Sony WH-CH520 </h4>

                        <div class="price-block">
                            <span class="new-price">990.000đ</span>
                        </div>

                        <div class="product-bottom-row">
                            <div class="rating">
                                <i class="bi bi-star-fill"></i>
                                <span>4.5</span>
                            </div>
                            <div class="favorite">
                                <i style="display: block;" class="bi bi-heart-fill"></i>

                                <span>Yêu thích</span>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </section>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptProfile.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptStore.js"></script>
</body>
</html>