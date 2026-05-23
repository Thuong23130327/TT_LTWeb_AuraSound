

function updateHeaderBadge(quantity) {
    const cartBadge = document.getElementById('cart-badge');
    if (cartBadge) {
        cartBadge.innerText = quantity;

        // Nếu có sản phẩm thì hiện thẻ span lên, nếu = 0 thì ẩn đi
        if (quantity > 0) {
            cartBadge.style.display = 'inline-block';
        } else {
            cartBadge.style.display = 'none';
        }
    }
}

$(document).ready(function () {
    function formatVND(value) {
        return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
    }

    function updateCart(id, change, action) {
        $.ajax({
            url: 'cart',
            type: 'GET',
            data: {
                action: action,
                id: id,
                q: change
            },
            success: function (res) {
                if (res.status === 'success') {
                    $('#total-price').text(formatVND(res.totalPrice));
                    $('#total-qty').text(res.totalQty);
                }
            }
        });
    }

    $('.qty-btn').click(function () {
        let btn = $(this);
        let id = btn.data('id');
        let change = btn.data('change');
        let input = btn.siblings('.qty-input');
        let newQty = parseInt(input.val()) + change;

        if (newQty >= 1) {
            input.val(newQty);
            updateCart(id, change, 'updateQty');
        }
    });
    $(document).on('click', '.ajax-qty', function () {
        let id = $(this).data('id');
        let q = $(this).data('qty');

        $.ajax({
            url: 'cart',
            type: 'GET',
            data: { action: 'updateQty', id: id, q: q },
            success: function (res) {
                if (res.status === 'success') {
                    // Đè toàn bộ HTML mới vào grid
                    $('.cart-items-list').html(res.html);

                    // Cập nhật tổng tiền bên dưới
                    $('.subtotal-price').text(new Intl.NumberFormat('vi-VN').format(res.totalPrice) + ' đ');
                    $('.total-qty-text').text(res.totalQty);
                }
            }
        });
    });
    $('.delete-btn').click(function () {
        if (confirm('Bạn muốn xóa sản phẩm này?')) {
            let id = $(this).data('id');
            let row = $(this).closest('.cart-item');

            $.ajax({
                url: 'cart',
                type: 'GET',
                data: { action: 'delete', id: id },
                success: function (res) {
                    row.remove();
                    $('#total-price').text(formatVND(res.totalPrice));
                    $('#total-qty').text(res.totalQty);
                    if ($('.cart-item').length === 0) location.reload();
                }
            });
        }
    });
});
function formatVND(amount) {
    return amount.toLocaleString('vi-VN') + ' đ';
}

function recalculateCart() {
    let totalQty = 0;
    let totalPrice = 0;

    const items = document.querySelectorAll('.cart-item');
    items.forEach(item => {
        const checkbox = item.querySelector('.item-check');
        // Tính tiền cho sp đc chọn
        if (checkbox && checkbox.checked) {
            const variantId = item.id.replace('item-row-', '');
            const qty = parseInt(document.getElementById(`qty-` + variantId).value);
            const price = parseFloat(item.getAttribute('data-price'));

            totalQty += qty;
            totalPrice += (qty * price);
        }
    });

    document.getElementById('total-qty-display').innerText = totalQty;
    document.getElementById('total-price-display').innerText = formatVND(totalPrice);
}

// Tăng giảm sp
function updateQuantityAJAX(variantId, changeAmount) {
    const qtyInput = document.getElementById(`qty-` + variantId);
    let currentQty = parseInt(qtyInput.value);
    let newQty = currentQty + changeAmount;

    if (newQty <= 0) {
        deleteItemAJAX(variantId);
        return;
    }

    fetch(`cart?action=add&id=` + variantId + `&q=` + changeAmount + `&type=ajax`)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                qtyInput.value = newQty;
                recalculateCart();
                updateHeaderBadge(data.cartQty);


            }
        })
        .catch(error => console.error('Lỗi AJAX:', error));
}

// Xóa sp
function deleteItemAJAX(variantId) {
    if (!confirm('Xóa sản phẩm này khỏi giỏ hàng?')) return;

    fetch(`cart?action=delete&id=` + variantId + `&type=ajax`)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                const itemRow = document.getElementById(`item-row-` + variantId);
                if (itemRow) itemRow.remove();

                recalculateCart();
                updateHeaderBadge(data.cartQty);

                // Cập nhật giao diện
                const remainingItems = document.querySelectorAll('.cart-item');
                if (remainingItems.length === 0) {
                    document.getElementById('cart-items-wrapper').innerHTML = `
                            <div style="text-align: center; padding: 50px;">
                                <p>Giỏ hàng của bạn đang trống.</p>
                                <a href="product" style="color: blue;">Tiếp tục mua sắm</a>
                            </div>`;
                }
            }
        })
        .catch(error => console.error('Lỗi AJAX:', error));
}

