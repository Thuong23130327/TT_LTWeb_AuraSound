function updateHeaderBadge(quantity) {
    const cartBadge = document.getElementById('cart-badge');
    if (!cartBadge) return;
    cartBadge.innerText = quantity;
    cartBadge.style.display = quantity > 0 ? 'inline-block' : 'none';
}

function formatVND(amount) {
    return Number(amount).toLocaleString('vi-VN') + ' đ';
}

function recalculateCart() {
    let totalQty = 0;
    let totalPrice = 0;
    document.querySelectorAll('.cart-item').forEach(function(item) {
        const checkbox = item.querySelector('.item-check');
        if (!checkbox || !checkbox.checked) return;
        const variantId = item.id.replace('item-row-', '');
        const qtyInput = document.getElementById('qty-' + variantId);
        const qty = qtyInput ? parseInt(qtyInput.value) : 0;
        const price = parseFloat(item.getAttribute('data-price')) || 0;
        totalQty += qty;
        totalPrice += qty * price;
    });
    const qtyDisplay = document.getElementById('total-qty-display');
    const priceDisplay = document.getElementById('total-price-display');
    if (qtyDisplay) qtyDisplay.innerText = totalQty;
    if (priceDisplay) priceDisplay.innerText = formatVND(totalPrice);
}

function updateQuantityAJAX(variantId, changeAmount) {
    const qtyInput = document.getElementById('qty-' + variantId);
    if (!qtyInput) return;
    const newQty = parseInt(qtyInput.value) + changeAmount;
    if (newQty <= 0) { deleteItemAJAX(variantId); return; }
    fetch(ctxPath + '/cart?action=add&id=' + variantId + '&q=' + changeAmount + '&type=ajax')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.status === 'success') {
                qtyInput.value = newQty;
                recalculateCart();
                updateHeaderBadge(data.cartQty);
            }
        })
        .catch(function(err) { console.error('Loi:', err); });
}

function deleteItemAJAX(variantId) {
    if (!confirm('Xóa sản phẩm này khỏi giỏ hàng?')) return;
    fetch(ctxPath + '/cart?action=delete&id=' + variantId + '&type=ajax')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.status !== 'success') return;
            const row = document.getElementById('item-row-' + variantId);
            if (row) row.remove();
            recalculateCart();
            updateHeaderBadge(data.cartQty);
            if (document.querySelectorAll('.cart-item').length === 0) {
                const wrapper = document.getElementById('cart-items-wrapper');
                if (wrapper) wrapper.innerHTML = '<div style="text-align:center;padding:50px;"><p>Giỏ hàng trống.</p><a href="product" style="color:blue;">Tiếp tục mua sắm</a></div>';
            }
        })
        .catch(function(err) { console.error('Loi:', err); });
}

function toggleVariantDropdown(variantId, event) {
    event.stopPropagation();
    const dropdown = document.getElementById('dropdown-' + variantId);
    if (!dropdown) return;
    const isOpen = dropdown.classList.contains('show');
    document.querySelectorAll('.variant-dropdown.show').forEach(function(el) { el.classList.remove('show'); });
    if (!isOpen) dropdown.classList.add('show');
}

document.addEventListener('click', function(e) {
    if (!e.target.closest('.variant-selector-wrapper')) {
        document.querySelectorAll('.variant-dropdown.show').forEach(function(el) { el.classList.remove('show'); });
    }
});

function selectVariant(oldVariantId, newVariantId, colorName, event) {
    event.stopPropagation();
    const dropdown = document.getElementById('dropdown-' + oldVariantId);
    if (dropdown) dropdown.classList.remove('show');
    if (oldVariantId === newVariantId) return;
    fetch(ctxPath + '/cart?action=updateVariant&id=' + oldVariantId + '&newVariantId=' + newVariantId + '&type=ajax')
        .then(function(r) { return r.json(); })
        .then(function(data) {
            if (data.status !== 'success') { alert('Đổi màu thất bại.'); return; }
            const row = document.getElementById('item-row-' + oldVariantId);
            if (!row) return;
            row.id = 'item-row-' + data.newId;
            row.dataset.price = data.price;
            row.dataset.variantId = data.newId;
            const img = document.getElementById('img-' + oldVariantId);
            if (img) { img.src = data.img; img.id = 'img-' + data.newId; }
            const priceEl = document.getElementById('price-label-' + oldVariantId);
            if (priceEl) {
                priceEl.innerText = formatVND(data.price);
                priceEl.id = 'price-label-' + data.newId;
            }
            const colorLabel = document.getElementById('color-label-' + oldVariantId);
            if (colorLabel) {
                colorLabel.innerText = colorName;
                colorLabel.id = 'color-label-' + data.newId;
            }
            if (dropdown) {
                dropdown.id = 'dropdown-' + data.newId;
                dropdown.querySelectorAll('.variant-option').forEach(function(opt) {
                    opt.classList.toggle('active-variant',
                        parseInt(opt.getAttribute('data-id')) === data.newId);

                    const optId = parseInt(opt.getAttribute('data-id'));
                    opt.classList.toggle('active-variant', optId === data.newId);

                    opt.setAttribute('onclick',
                        'selectVariant(' + data.newId + ',' + optId + ',\'' +
                        opt.getAttribute('data-color') + '\',event)');
                });
            }
            const wrapper = document.getElementById('wrapper-' + oldVariantId);
            if (wrapper) wrapper.id = 'wrapper-' + data.newId;

            const triggerBtn = document.querySelector(
                '#wrapper-' + data.newId + ' .item-variant-btn');
            if (triggerBtn) {
                triggerBtn.setAttribute('onclick',
                    'toggleVariantDropdown(' + data.newId + ',event)');
            }

            const qtyInput = document.getElementById('qty-' + oldVariantId);
            if (qtyInput) qtyInput.id = 'qty-' + data.newId;
            const qtyMinus = document.getElementById('qty-minus-' + oldVariantId);
            if (qtyMinus) { qtyMinus.id = 'qty-minus-' + data.newId; qtyMinus.setAttribute('onclick', 'updateQuantityAJAX(' + data.newId + ', -1)'); }
            const qtyPlus = document.getElementById('qty-plus-' + oldVariantId);
            if (qtyPlus) { qtyPlus.id = 'qty-plus-' + data.newId; qtyPlus.setAttribute('onclick', 'updateQuantityAJAX(' + data.newId + ', 1)'); }
            const deleteBtn = document.getElementById('delete-btn-' + oldVariantId);
            if (deleteBtn) { deleteBtn.id = 'delete-btn-' + data.newId; deleteBtn.setAttribute('onclick', 'deleteItemAJAX(' + data.newId + ')'); }
            recalculateCart();
        })
        .catch(function(err) { console.error('Loi:', err); });
}

function goToCheckout() {
    const checkedBoxes = document.querySelectorAll('.item-check:checked');
    if (checkedBoxes.length === 0) { alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán.'); return; }
    const form = document.createElement('form');
    form.method = 'GET';
    form.action = ctxPath + '/checkout';
    checkedBoxes.forEach(function(checkbox) {
        const variantId = checkbox.closest('.cart-item').id.replace('item-row-', '');
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'selectedIds';
        input.value = variantId;
        form.appendChild(input);
    });
    document.body.appendChild(form);
    form.submit();
}