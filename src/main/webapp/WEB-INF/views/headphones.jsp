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
    <form action="product" method="get" id="filterForm">
        <aside class="filter-sidebar" id="filter-sidebar">
            <div class="pt-3 pb-2">
                <a href="store.jsp" class="btn btn-sm btn-primary" title="Quay lại">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>

            <button class="filter-toggle-btn" id="filter-toggle">
                <i class="bi bi-funnel-fill"></i> Bộ lọc
            </button>

            <div class="filter-wrapper">
                <div class="filter-header">
                    <h3>Bộ lọc</h3>
                    <button class="filter-close-btn" id="filter-close">&times;</button>
                </div>

                <div class="filter-group">
                    <h4>Hãng sản xuất</h4>
                    <div class="filter-options" data-filter-group="brand">
                        <c:forEach items="${applicationScope.brandList}" var="brand">
                            <button onclick="sort(this)" type="button" class="filter-option" data-filter="${brand.id}">
                                    ${brand.name}
                            </button>
                        </c:forEach>

                    </div>
                </div>

                <div class="filter-group">
                    <h4>Loại tai nghe</h4>
                    <div class="filter-options" data-filter-group="category">
                        <c:forEach items="${applicationScope.MENU_TREE}" var="cate">
                            <button onclick="sort(this)" type="button" class="filter-option" data-filter="${cate.id}">
                                    ${cate.name}
                            </button>

                            <c:if test="${not empty cate.children}">
                                <c:forEach items="${cate.children}" var="child">
                                    <button onclick="sort(this)" type="button" class="filter-option"
                                            data-filter="${child.id}">
                                            ${child.name}
                                    </button>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <button type="button" onclick="clearFilter(this)" class="filter-reset-btn" id="filter-reset">Xóa tất cả
                    bộ lọc
                </button>
            </div>
        </aside>
    </form>
    <div class="product-grid-container">
        <h1 id="namePage">${cateName != null ? cateName : 'Sản phẩm'}</h1>

        <div class="sort-options" id="sort-options">
            <span>Sắp xếp theo:</span>
            <button class="sort-btn active" onclick="sortOption(this)" data-sort="default">Nổi bật</button>
            <button class="sort-btn" onclick="sortOption(this)" data-sort="price-asc">Giá tăng dần</button>
            <button class="sort-btn" onclick="sortOption(this)" data-sort="price-desc">Giá giảm dần</button>
        </div>

        <div class="product-grid" id="product-grid">

            <c:forEach items="${productList}" var="p">
                <a href="detail?pid=${p.id}" class="product-card">
                    <c:if test="${p.discountPercent > 0}">
                        <div class="product-badge discount">Giảm ${p.discountPercent} %</div>
                    </c:if>

                    <img src="${p.img}" alt="${p.name}" onerror="this.src='https://placehold.co/300x300?text=No+Image'">

                    <div class="product-card-info">
                        <h4>${p.name}</h4>

                        <div class="price-block">
                            <div class="new-price"><fmt:formatNumber value="${p.sellPrice}" pattern="#,###"/> đ</div>

                            <c:if test="${p.discountPercent > 0}">
                                <div class="old-price"><fmt:formatNumber value="${p.oldPrice}" pattern="#,###"/> đ</div>
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

<jsp:include page="../tag/_footer.jsp"></jsp:include>

<script>
    let cateId = "${cateId != null ? cateId : 0}";
</script>

<script src="${AuraSound}/assets/js/script.js"></script>
<%--<script src="${AuraSound}/assets/js/scriptProfile.js"></script>--%>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
</body>
</html>