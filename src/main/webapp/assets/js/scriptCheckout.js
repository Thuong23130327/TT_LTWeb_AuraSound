document.addEventListener("DOMContentLoaded", function () {
    let currentShippingFee = 0;
    let appliedVoucherCode = '';
    let appliedDiscountAmount = 0;

    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
    }

    function updateTotalDisplay(discountAmount) {
        appliedDiscountAmount = discountAmount || 0;

        const subtotalEl = document.getElementById('subtotal-amount');
        const subtotal = subtotalEl ? (parseFloat(subtotalEl.getAttribute('data-value')) || 0) : 0;

        const discountRow = document.getElementById('discount-row');
        const discountAmountEl = document.getElementById('discount-amount');
        const finalTotalEl = document.getElementById('final-total');
        const shippingFeeDisplay = document.getElementById('shipping-fee-display');

        const calculatedFinalTotal = subtotal + currentShippingFee - appliedDiscountAmount;

        if (shippingFeeDisplay) {
            shippingFeeDisplay.innerText = formatVND(currentShippingFee);
        }

        if (discountRow && discountAmountEl) {
            if (appliedDiscountAmount > 0) {
                discountAmountEl.innerText = '-' + formatVND(appliedDiscountAmount);
                discountRow.style.display = 'flex';
            } else {
                discountRow.style.display = 'none';
            }
        }

        if (finalTotalEl) {
            finalTotalEl.innerText = formatVND(calculatedFinalTotal);
            finalTotalEl.setAttribute('data-original', (subtotal + currentShippingFee));
        }
    }

    function callShippingFeeApi(districtId, wardCode) {
        if (!districtId || !wardCode) return;

        const summaryContainer = document.querySelector('.order-summary');
        if (summaryContainer) summaryContainer.classList.add('loading');

        const params = new URLSearchParams({ districtId: districtId, wardCode: wardCode });

        fetch('api/calculate-shipping', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
        })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    currentShippingFee = parseFloat(data.fee);
                    updateTotalDisplay(appliedDiscountAmount);
                }
            })
            .catch(err => console.error("Lỗi Servlet phí ship: ", err))
            .finally(() => {
                if (summaryContainer) summaryContainer.classList.remove('loading');
            });
    }

    function selectShippingAddress(cardEl) {
        if (!cardEl) return;

        document.querySelectorAll('.address-item-card').forEach(card => {
            card.classList.remove('border-warning', 'bg-light-subtle');
            const radio = card.querySelector('input[type="radio"]');
            if (radio) radio.checked = false;
        });

        cardEl.classList.add('border-warning', 'bg-light-subtle');
        const radio = cardEl.querySelector('input[type="radio"]');
        if (radio) radio.checked = true;

        const recipientName = cardEl.getAttribute('data-recipient-name') || '';
        const phone = cardEl.getAttribute('data-phone') || '';
        const cityStr = cardEl.getAttribute('data-city') || '';
        const addressVal = cardEl.getAttribute('data-address') || '';
        const provinceId = cardEl.getAttribute('data-province-id') || '';
        const districtId = cardEl.getAttribute('data-district-id') || '';
        const wardCode = cardEl.getAttribute('data-ward-code') || '';

        const parts = cityStr.split(',').map(s => s.trim());
        let wardText = parts[0] || '';
        let districtText = parts[1] || '';
        let provinceText = parts[2] || cityStr;

        document.getElementById('fullname').value = recipientName;
        document.getElementById('phone').value = phone;
        document.getElementById('city').value = provinceText;
        document.getElementById('district_main').value = districtText;
        document.getElementById('ward').value = wardText;
        document.getElementById('address').value = addressVal;

        document.getElementById('mainProvinceId').value = provinceId;
        document.getElementById('mainDistrictId').value = districtId;
        document.getElementById('mainWardCode').value = wardCode;
        document.getElementById('mainAddressId').value = cardEl.getAttribute('data-id') || '';

        callShippingFeeApi(districtId, wardCode);
    }

    document.querySelectorAll('.address-item-card').forEach(card => {
        card.addEventListener('click', function(e) {
            if (e.target.closest('button') || e.target.closest('a') || e.target.closest('input[type="radio"]')) {
                if (e.target.closest('input[type="radio"]')) selectShippingAddress(this);
                return;
            }
            selectShippingAddress(this);
        });
    });

    const checkedRadio = document.querySelector('input[name="selectedShippingAddress"]:checked');
    if (checkedRadio) {
        selectShippingAddress(checkedRadio.closest('.address-item-card'));
    } else {
        const firstCard = document.querySelector('.address-item-card');
        if (firstCard) selectShippingAddress(firstCard);
    }

    const applyVoucherBtn = document.getElementById('btn-apply-voucher');
    if (applyVoucherBtn) {
        applyVoucherBtn.addEventListener('click', function () {
            const btn = this;
            const code = document.getElementById('voucher-input').value.trim().toUpperCase();
            const msgEl = document.getElementById('voucher-msg');

            if (!code) {
                msgEl.className = 'error-msg';
                msgEl.innerText = 'Vui lòng nhập mã giảm giá.';
                return;
            }

            const orderTotal = parseFloat(document.getElementById('final-total').getAttribute('data-original'));
            btn.disabled = true;
            btn.innerText = 'Đang kiểm tra...';

            const params = new URLSearchParams({ code, orderTotal });
            fetch('api/voucher/validate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'ok') {
                        appliedVoucherCode = data.voucherCode;
                        updateTotalDisplay(data.discountAmount);
                        msgEl.className = 'success-msg';
                        msgEl.innerHTML = data.message;
                    } else {
                        msgEl.className = 'error-msg';
                        msgEl.innerHTML = data.message;
                    }
                })
                .catch(() => {
                    msgEl.className = 'error-msg';
                    msgEl.innerText = 'Lỗi kết nối voucher.';
                })
                .finally(() => {
                    btn.disabled = false;
                    btn.innerText = 'Áp dụng';
                });
        });
    }

    const orderBtn = document.getElementById('btn-dat-hang');
    if (orderBtn) {
        orderBtn.addEventListener('click', function () {
            if (!validateForm()) return;

            const btn = this;
            btn.disabled = true;
            btn.innerText = 'Đang xử lý...';

            const params = new URLSearchParams({
                fullName:    document.getElementById('fullname').value.trim(),
                phone:       document.getElementById('phone').value.trim(),
                city:        document.getElementById('district_main').value.trim() + ", " + document.getElementById('city').value.trim(),
                ward:        document.getElementById('ward').value.trim(),
                address:     document.getElementById('address').value.trim(),
                notes:       document.getElementById('notes').value.trim(),
                voucherCode: appliedVoucherCode,
                paymentMethod: document.querySelector('input[name="payment"]:checked').value,
                provinceId:  document.getElementById('mainProvinceId').value.trim(),
                districtId:  document.getElementById('mainDistrictId').value.trim(),
                wardCode:    document.getElementById('mainWardCode').value.trim(),
                addressId:   document.getElementById('mainAddressId').value.trim(),
                shippingFee: currentShippingFee
            });

            fetch('order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'redirect') { window.location.href = data.url; return; }
                    if (data.status === 'success') {
                        window.location.href = 'order-detail-success?id=' + data.orderId;
                    } else {
                        alert('Lỗi: ' + data.message);
                        btn.disabled = false;
                        btn.innerText = 'ĐẶT HÀNG';
                    }
                })
                .catch(err => {
                    alert('Lỗi kết nối server.');
                    btn.disabled = false;
                    btn.innerText = 'ĐẶT HÀNG';
                });
        });
    }

    function validateForm() {
        const required = [
            { id: 'fullname', label: 'Họ và tên' },
            { id: 'phone',    label: 'Số điện thoại' },
            { id: 'city',     label: 'Tỉnh / Thành phố' },
            { id: 'district_main', label: 'Quận / Huyện' },
            { id: 'ward',     label: 'Phường / Xã' },
            { id: 'address',  label: 'Địa chỉ cụ thể' }
        ];
        for (const f of required) {
            const el = document.getElementById(f.id);
            if (!el || el.value.trim() === '') {
                alert('Vui lòng chọn địa chỉ giao hàng hợp lệ!');
                return false;
            }
        }
        if (!/^[0-9]{10}$/.test(document.getElementById('phone').value.trim())) {
            alert('Số điện thoại không hợp lệ.');
            return false;
        }
        return true;
    }
});