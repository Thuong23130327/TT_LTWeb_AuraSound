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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    <%--    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">--%>
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <%--    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">--%>
    <%--    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHeadphones.css">--%>

    <link rel="stylesheet" href="${AuraSound}/assets/css/product-page.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<main class="store-container content headphones-page-container">


    <div class="product-grid-container">
        <form action="product" class="nav-product-sticky-wrapper" method="get" id="filterForm">
            <%--            <button class="filter-toggle-btn" id="filter-toggle">--%>
            <%--                <i class="bi bi-funnel-fill"></i> Bộ lọc--%>
            <%--            </button>--%>
            <div class="filter-wrapper nav-product-container">
                <div class="d-flex align-items-center nav-product">

                    <div class="nav-group-left">
                        <button class="btn-filter">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </button>

                    </div>
                    <div class="nav-group-center">
                        <button class="btn-filter">
                            <i class="bi bi-funnel-fill"></i> Bộ lọc
                        </button>
                        <div class="filter-item">
                            <button type="button" class="btn-filter">
                                Hãng <i class="bi bi-chevron-down ms-2"></i>
                            </button>
                            <div class="filter-dropdown-content" style="    backdrop-filter: blur(12px) !important;">
                                <div class="filter-options" data-filter-group="brand">
                                    <c:forEach items="${applicationScope.brandList}" var="brand">
                                        <button onclick="filter(this)" type="button" class="filter-option"
                                                data-filter="${brand.id}">
                                                ${brand.name}
                                        </button>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="filter-item">
                            <button type="button" class="btn-filter">
                                Giá <i class="bi bi-chevron-down ms-2"></i>
                            </button>
                            <div class="filter-dropdown-content" style="min-width: 280px;     backdrop-filter: blur(12px) !important;">
                                <div class="price-inputs">
                                    <div class="price-field">
                                        <input type="text" id="min-price-input" value="0" maxlength="7">
                                        <span class="fixed-zeros">.000đ</span>
                                    </div>
                                    <span class="separator">-</span>
                                    <div class="price-field">
                                        <input type="text" id="max-price-input" value="20.000" maxlength="7">
                                        <span class="fixed-zeros">.000đ</span>
                                    </div>
                                </div>
                                <div class="price-slider-container">
                                    <div class="slider-track"></div>
                                    <input type="range" min="0" max="20000000" step="100000" value="0"
                                           id="min-range-slider">
                                    <input type="range" min="0" max="20000000" step="100000" value="20000000"
                                           id="max-range-slider">
                                </div>
                                <button type="button" id="btn-apply-price" class="btn-apply-price-inline">Xem kết
                                    quả
                                </button>
                            </div>
                        </div>
                        <div class="filter-item">
                            <button type="button" class="btn-filter">
                                Phân loại <i class="bi bi-chevron-down ms-2"></i>
                            </button>
                            <div class="filter-dropdown-content">
                                <div class="filter-options" data-filter-group="category">
                                    <c:forEach items="${applicationScope.MENU_TREE}" var="cate">
                                        <div class="filter-group-inner">
                                            <button onclick="filter(this)" type="button"
                                                    class="filter-option parent-cate" data-filter="${cate.id}">
                                                    ${cate.name}
                                            </button>
                                            <c:if test="${not empty cate.children}">
                                                <div class="child-group">
                                                    <c:forEach items="${cate.children}" var="child">
                                                        <button onclick="filter(this)" type="button"
                                                                class="filter-option" data-filter="${child.id}">
                                                                ${child.name}
                                                        </button>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="nav-group-right">
                        <div class="sort-options" id="sort-options">
                            <span>Sắp xếp theo:</span>
                            <button type="button" class="sort-btn active" onclick="sortOption(this)" data-sort="default">Nổi bật
                            </button>
                            <button type="button" class="sort-btn" onclick="sortOption(this)" data-sort="price-asc">Giá tăng dần
                            </button>
                            <button type="button" class="sort-btn" onclick="sortOption(this)" data-sort="price-desc">Giá giảm
                                dần
                            </button>
                        </div>

                    </div>

                    <%--                            <button class="btn-filter" onclick="clearFilter(this)" id="filter-reset">--%>
                    <%--                                Xóa tất cả bộ lọc--%>
                    <%--                            </button>--%>

                </div>
            </div>
        </form>
        <h1 id="namePage">${cateName != null ? cateName : 'Sản phẩm'}</h1>
        <div class="product-grid" id="product-grid">
            <c:forEach items="${productList}" var="p">
                <a href="detail?pid=${p.id}" class="product-card">
                    <c:if test="${p.discountPercent > 0}">
                        <div class="product-badge discount">Giảm ${p.discountPercent} %</div>
                    </c:if>

                    <img src="${p.img}" alt="${p.name}"
                         onerror="this.src='https://placehold.co/300x300?text=No+Image'">

                    <div class="product-card-info">
                        <h4>${p.name}</h4>

                        <div class="price-block">
                            <div class="new-price"><fmt:formatNumber value="${p.sellPrice}" pattern="#,###"/> đ
                            </div>

                            <c:if test="${p.discountPercent > 0}">
                                <div class="old-price"><fmt:formatNumber value="${p.oldPrice}" pattern="#,###"/> đ
                                </div>
                            </c:if>

                        </div>

                        <div class="product-bottom-row">
                            <div class="rating">
                                <i class="bi bi-star-fill"></i>
                                <span>${p.avgRating}</span>
                            </div>
                            <div class="favorite">
                                <i class="bi bi-heart"></i>
                                <span>Yêu thích</span>
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>

        </div>


        <div class="pagination" id="pagination-buttons">

        </div>
    </div>

    <input type="hidden" id="numPage" name="totalPageNeed" value="${totalPage}">
    <input type="hidden" id="cur-keyword" value="${search}">


</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script>
    let cateId = "${cateId != null ? cateId : 0}";
</script>

<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
</body>
</html>