<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

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
