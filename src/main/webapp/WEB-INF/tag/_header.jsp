<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="_taglibs.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-bootstrap-4/bootstrap-4.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    const path = "${pageContext.request.contextPath}";
</script>
<button onclick="backTop()" id="back-top-btn" title="Lên đầu trang">
    <i class="bi bi-caret-up-fill"></i>
</button>

<header>
    <div class="header-container content">
        <div class="head-left">
            <div class="head-scroll">
                <div class="text-item">AuraSound - Âm thanh định hình phong cách</div>
                <div class="text-item">Chuyên các loại Loa, Tai nghe chính hãng</div>
                <div class="text-item">AuraSound - Âm thanh định hình phong cách</div>
                <div class="text-item">Bảo hành 1 đổi 1 trong 1 tháng</div>
            </div>
        </div>
        <div class="head-right">
            <div class="info-item"><a href="${AuraSound}/contact">Liên hệ chi tiết</a></div>
            <div class="info-item"><a href="${AuraSound}/profileM/order-history">Tra cứu đơn hàng</a></div>
            <div class="info-item"><a href="tel:19001919">1900 1919</a></div>
        </div>
    </div>
</header>

<nav>
    <div class="nav-container content">
        <div class="nav-left">
            <a class="a-nodecor logo-container" href="${AuraSound}/home">
                <div class="logo-wave">
                    <div class="sound-wave wave1"></div>
                    <div class="sound-wave wave2"></div>
                    <div class="sound-wave wave3"></div>
                </div>
                <span class="logo-text">AuraSound</span>
            </a>
        </div>
        <div class="nav-right">
            <div class="nav-right">
                <form class="formSearch" action="${AuraSound}/search" method="get" style="position: relative;">
                    <div class="searchBar">
                        <input id="search-input"
                               oninput="searchAjax(this)"
                               autocomplete="off"
                               name="search"
                               type="text"
                               placeholder="Tìm kiếm"
                               value="${not empty search ? search : param.search}">

                        <button type="submit">
                            <i class="bi bi-search"></i>
                        </button>

                    </div>
                    <div id="result-search" class="result-search">
                        <span>Ket qua tim kiem</span>

                    </div>
                </form>


                <a class="a-nodecor " href="${AuraSound}/home">
                    <div class="home ${activePage =='home'?'active':''}">Trang chủ</div>
                </a>
                <a class="a-nodecor" href="${AuraSound}/contact">
                    <div class="contact  ${activePage =='contact'?'active':''}">Liên hệ</div>
                </a>

                <%--Menu dropdown--%>
                <div class="nav-item-dropdown aura-dropdown-container">
                    <a class="a-nodecor" href="${applicationScope.AuraSound}/product">
                        <div class="store ${activePage == 'product' ? 'active' : ''} ">
                            Sản phẩm <i class="bi bi-chevron-compact-down"></i>
                        </div>
                    </a>

                    <ul class="aura-menu-parent">
                        <c:forEach items="${applicationScope.MENU_TREE}" var="par">
                            <li class="aura-menu-item has-child">
                                <a href="${applicationScope.AuraSound}/product?cateId=${par.id}" class="parent-link">
                                        ${par.name}

                                    <c:if test="${not empty par.children}">
                                        <i class="bi bi-chevron-right ms-auto"></i>
                                    </c:if>
                                </a>

                                <c:if test="${not empty par.children}">
                                    <ul class="aura-menu-child">
                                        <c:forEach items="${par.children}" var="child">
                                            <li>
                                                <a href="${applicationScope.AuraSound}/product?cateId=${child.id}">${child.name}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>

                            </li>
                        </c:forEach>
                    </ul>
                </div>


                <a class="a-nodecor " href="${AuraSound}/cart">
                    <div class="cart ${activePage =='cart'?'active':''}">
                        <i class="bi bi-cart"></i> Giỏ hàng
                        <span id="cart-badge" class="badge bg-danger rounded-pill"
                              style="font-size: 0.7rem; vertical-align: top; ${sessionScope.cartQty == null || sessionScope.cartQty == 0 ? 'display:none' : 'display:inline-block'}">
                            ${sessionScope.cartQty != null ? sessionScope.cartQty : 0}
                        </span>
                    </div>
                </a>

                <div class="nav-account">

                    <c:if test="${sessionScope.auth != null}">
                        <div class="account-avatar">
                            <a href="${AuraSound}/profile" class="avatar-link">
                                <img src="${not empty sessionScope.loggedInUser ? sessionScope.loggedInUser.avatarUrl : '/assets/img/default.png'}"
                                     alt="Avatar">
                            </a>
                            <div class="account-menu">
                                <a class="account-menu-item" href="${AuraSound}/profile">Xin
                                    chào ${sessionScope.auth.fullName}</a>
                                <a class="account-menu-item" href="${AuraSound}/profile">Thông tin tài
                                    khoản</a>
                                <a class="account-menu-item" href="${AuraSound}/logout" id="navLogout">Đăng xuất</a>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.auth == null}">
                        <a class="a-nodecor login-link" href="${AuraSound}/login">
                            <div class="login">Đăng nhập</div>
                        </a>
                    </c:if>

                    <c:if test="${sessionScope.author != null}">
                        <a class="a-nodecor login-link" href="${AuraSound}/admin/dashboard">
                            <div class="login">Admin - Quản Lý</div>
                        </a>
                    </c:if>


                </div>

                <div id="hamburger-icon"><i class="bi bi-list"></i></div>
            </div>
        </div>
    </div>
</nav>

<div class="mobile-menu" id="mobile-menu-container">
    <div class="mobile-menu-header">
        <div class="logo-container">
            <span class="logo-text">AuraSound</span>
        </div>
        <i class="bi bi-x-lg" id="mobile-menu-close"></i>
    </div>
    <div class="mobile-menu-item">
        <form action="${AuraSound}/search" method="post">
            <div class="searchBar">
                <input name="search" type="text" placeholder="Tìm kiếm" value="${search}">
                <button type="submit">
                    <i class="bi bi-search"></i>
                </button>
            </div>
        </form>
    </div>


    <c:if test="${sessionScope.auth != null}">
        <div class="mobile-menu-item"><a href="${AuraSound}/profileM/profile">Thông tin tài khoản</a></div>
        <div class="mobile-menu-item"><a href="${AuraSound}/logout">Đăng xuất</a></div>
    </c:if>

    <c:if test="${sessionScope.auth == null}">
        <div class="mobile-menu-item"><a href="${AuraSound}/login" class="nav-login-btn">Đăng nhập</a></div>
    </c:if>

    <div class="mobile-menu-item ${activePage =='cart'?'active':''}"><a href="${AuraSound}/cart">Giỏ hàng</a></div>
    <div class="mobile-menu-item ${activePage =='contact'?'active':''}"><a href="${AuraSound}/contact">Liên hệ</a></div>
    <div class="mobile-menu-item ${activePage =='product'?'active':''}"><a href="${AuraSound}/product">Sản phẩm</a>
    </div>
</div>
<div class="overlay" id="menu-overlay"></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let searchTimer;

    function searchAjax(input) {
        clearTimeout(searchTimer);
        const keyword = input.value.trim();
        const resultDiv = document.getElementById("result-search");

        if (keyword.length < 2) {
            resultDiv.style.display = "none";
            resultDiv.innerHTML = "";
            return;
        }

        searchTimer = setTimeout(function() {
            $.ajax({
                type: "GET",
                url: path + "/search",
                data: { search: keyword, ajax: "true" },
                dataType: "json",
                success: function(res) {
                    let html = "";

                    if (res.products && res.products.length > 0) {
                        res.products.forEach(function(p) {
                            html += '<a href="' + path + '/detail?pid=' + p.id + '" class="search-result-item">';
                            html += '  <img src="' + (p.img || '') + '" alt="" style="width:40px;height:40px;object-fit:cover;margin-right:8px;">';
                            html += '  <div>';
                            html += '    <div class="search-item-name">' + p.name + '</div>';
                            html += '    <div class="search-item-price">' + new Intl.NumberFormat('vi-VN').format(p.sellPrice) + ' đ</div>';
                            html += '  </div>';
                            html += '</a>';
                        });

                        html += '<a href="' + path + '/search?search=' + encodeURIComponent(keyword) + '" class="search-view-all">';
                        html += '  Xem tất cả kết quả cho "' + keyword + '"';
                        html += '</a>';
                    } else {
                        html = '<div class="search-no-result">Không tìm thấy sản phẩm</div>';
                    }

                    resultDiv.innerHTML = html;
                    resultDiv.style.display = "block";
                },
                error: function(e) {
                    console.error("Search error: ", e);
                }
            });
        }, 300);
    }

    // Ẩn dropdown
    document.addEventListener("click", function(e) {
        const searchForm = document.querySelector(".formSearch");
        const resultDiv = document.getElementById("result-search");
        if (searchForm && !searchForm.contains(e.target)) {
            resultDiv.style.display = "none";
        }
    });
</script>
