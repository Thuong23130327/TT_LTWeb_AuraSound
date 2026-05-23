<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>


<%
    request.setAttribute("pageTitle", "Giỏ hàng - AuraSound");
    request.setAttribute("activePage", "cart");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

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

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleCart.css">

</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<main class="cart-container">
    <div class="cart-items-list" id="cart-items-wrapper">
        <c:choose>
            <c:when test="${not empty cartItems}">
                <c:forEach var="item" items="${cartItems}">
                    <div class="cart-item" id="item-row-${item.productVariantId}" data-price="${item.price}" style="display: flex; align-items: center; gap: 15px;">

                        <div class="item-checkbox">
                            <input type="checkbox" class="item-check" ${item.checked ? 'checked' : ''}
                                   onchange="recalculateCart()">
                        </div>

                        <div class="item-main">
                            <img class="item-img" src="${item.img}" alt="${item.name}">
                            <div class="item-details">
                                <h4>${item.name}</h4>
                            </div>
                            <div class="item-price-col">
                                <span class="item-price"><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</span>
                            </div>
                        </div>

                        <div class="item-actions">
                            <span class="item-delete" style="cursor: pointer; color: red;"
                                  onclick="deleteItemAJAX(${item.productVariantId})">
                                Xoá
                            </span>

                            <div class="quantity-control">
                                <button type="button" class="quantity-btn"
                                        onclick="updateQuantityAJAX(${item.productVariantId}, -1)">-</button>

                                <input class="quantity-input" id="qty-${item.productVariantId}" type="text" value="${item.quantity}" readonly>

                                <button type="button" class="quantity-btn"
                                        onclick="updateQuantityAJAX(${item.productVariantId}, 1)">+</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 50px;">
                    <p>Giỏ hàng của bạn đang trống.</p>
                    <a href="product" style="color: blue;">Tiếp tục mua sắm</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="cart-subtotal">
        <span>Tạm tính (<span id="total-qty-display">${totalQuantity}</span> sản phẩm):</span>
        <span class="subtotal-price" id="total-price-display">
            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/> đ
        </span>
    </div>

    <div class="checkout-button-container">
        <a href="${AuraSound}/checkout">
            <button type="button" class="checkout-button-tgdd" onclick="goToCheckout()">
                THANH TOÁN
            </button>
        </a>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script>
    const ctxPath = '${pageContext.request.contextPath}';
</script>
<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
<script src="${AuraSound}/assets/js/scriptCart.js"></script>
</body>
</html>