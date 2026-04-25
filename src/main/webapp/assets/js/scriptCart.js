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