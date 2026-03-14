<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
<link rel="stylesheet" href="assets/css/styleHome.css">
<link rel="stylesheet" href="assets/css/styleProfile.css">
<link rel="stylesheet" href="assets/css/styleStore.css">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    request.setAttribute("pageTitle", "Sản phẩm - AuraSound");
    request.setAttribute("activePage", "product");
    request.setAttribute("keepDefaultCss", true);
%>
<c:set var="customCss">
    <link rel="stylesheet" href="../assets/css/styleProduct.css">
    <link rel="stylesheet" href="assets/css/styleCheckout.css">
</c:set>
<%@ include file="../tag/_header.jsp" %>

<main class="store-container content">
    <h1>Sản Phẩm</h1>

    <div class="store-controls" id="filter-buttons">
        <a href="products">
            <button class="filter-btn active">Tất cả</button>
        </a>

        <a href="products?category=headphones.jsp">
            <button class="filter-btn">Tai Nghe</button>
        </a>

        <a href="products?category=speakers">
            <button class="filter-btn">Loa</button>
        </a>
    </div>


    <div class="product-grid" id="product-grid">

        <c:forEach items="${products}" var="p">
            <a href="sproduct.jsp" class="product-card">
                <div class="product-badge discount">
                    Giảm 50%
                </div>
                <img src="${p.image}"
                     alt="${p.name}">
                <div class="product-card-info">
                    <h4>"${p.name}"</h4>
                    <div class="price-block">
                               <span class="new-price">"${p.price}<"/span>
                    </div>
                    <div class="product-bottom-row">
                        <div class="rating">
                            <i class="bi bi-star-fill"></i>
                            <span>"${p.avgRating}"</span>
                        </div>
                        <div class="favorite">
                            <i class="bi bi-heart"></i> <i class="bi bi-heart-fill"></i>
                            <span>Yêu thích</span>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</main>

<%@ include file="../tag/_footer.jsp" %>

</body>

</html>