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
    <div class="cart-items-list">
        <c:choose>
            <c:when test="${not empty cartItems}">
                <c:forEach var="item" items="${cartItems}">
                    <div class="cart-item" style="display: flex; align-items: center; gap: 15px;">
                        <div class="item-checkbox">
                            <input type="checkbox" ${item.checked ? 'checked' : ''}
                                   onclick="location.href='cart?action=check&id=${item.productVariantId}'">
                        </div>
                        <div class="item-main">
                            <img class="item-img" src="${item.img}" alt="${item.name}">

                            <div class="item-details">
                                <h4>${item.name}</h4>
                            </div>

                            <div class="item-price-col">

                                <span class="item-price"><fmt:formatNumber value="${item.price}" pattern="#,###"/> đ
                                    </span>
                            </div>
                        </div>
                        <div class="item-actions">
                            <span class="item-delete"
                                  onclick="if(confirm('Xóa sản phẩm này?')) location.href='cart?action=delete&id=${item.productVariantId}'">
                                Xoá
                            </span>

                            <div class="quantity-control">
                                <button class="quantity-btn"
                                        onclick="location.href='cart?action=add&id=${item.productVariantId}&q=-1'">-
                                </button>
                                <input class="quantity-input" type="text" value="${item.quantity}" readonly>
                                <button class="quantity-btn"
                                        onclick="location.href='cart?action=add&id=${item.productVariantId}&q=1'">+
                                </button>
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
        <span>Tạm tính (${totalQuantity} sản phẩm):</span>

        <span class="subtotal-price">
            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/> đ</span>
    </div>

    <div class="checkout-button-container">
        <a href="checkout.jsp">
            <button class="checkout-button-tgdd">THANH TOÁN</button>
        </a>
    </div>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptProfile.js"></script>
<script src="${AuraSound}/assets/js/scriptStore.js"></script>
<script src="${AuraSound}/assets/js/scriptCart.js"></script>
</body>
</html>