<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
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