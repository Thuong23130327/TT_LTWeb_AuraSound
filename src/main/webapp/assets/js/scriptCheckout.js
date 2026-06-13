const SHIPPING_FEE = 30_000;
let appliedVoucherCode   = '';
let appliedDiscountAmount = 0;

function formatVND(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
}

function updateTotalDisplay(discountAmount) {
    const originalTotal = parseFloat(
        document.getElementById('final-total').getAttribute('data-original')
    );
    appliedDiscountAmount = discountAmount;
    const discountRow   = document.getElementById('discount-row');
    const discountAmountEl = document.getElementById('discount-amount');
    const finalTotalEl  = document.getElementById('final-total');
    if (discountAmount > 0) {
        discountAmountEl.innerText   = '-' + formatVND(discountAmount);
        discountRow.style.display    = 'flex';
        finalTotalEl.innerText       = formatVND(originalTotal - discountAmount);
    } else {
        discountRow.style.display    = 'none';
        finalTotalEl.innerText       = formatVND(originalTotal);
    }
}

function validateForm() {
    const required = [
        { id: 'fullname', label: 'Họ và tên' },
        { id: 'phone',    label: 'Số điện thoại' },
        { id: 'city',     label: 'Tỉnh / Thành phố' },
        { id: 'ward',     label: 'Phường / Xã' },
        { id: 'address',  label: 'Địa chỉ cụ thể' }
    ];
    for (const f of required) {
        const el = document.getElementById(f.id);
        if (!el || el.value.trim() === '') {
            alert('Vui lòng điền: ' + f.label);
            el && el.focus();
            return false;
        }
    }
    if (!/^[0-9]{10}$/.test(document.getElementById('phone').value.trim())) {
        alert('Số điện thoại phải gồm đúng 10 chữ số.');
        document.getElementById('phone').focus();
        return false;
    }
    return true;
}
document.getElementById('btn-apply-voucher').addEventListener('click', function () {
    const btn     = this;
    const code    = document.getElementById('voucher-input').value.trim().toUpperCase();
    const msgEl   = document.getElementById('voucher-msg');
    appliedVoucherCode    = '';
    appliedDiscountAmount = 0;
    updateTotalDisplay(0);
    msgEl.className = '';
    msgEl.innerHTML = '';
    if (!code) {
        msgEl.className = 'error-msg';
        msgEl.innerText = 'Vui lòng nhập mã giảm giá.';
        return;
    }
    const orderTotal = parseFloat(
        document.getElementById('final-total').getAttribute('data-original')
    );
    btn.disabled  = true;
    btn.innerText = 'Đang kiểm tra...';
    const params = new URLSearchParams({ code, orderTotal });
    fetch('api/voucher/validate', {
        method:  'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body:    params.toString()
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'ok') {
                appliedVoucherCode    = data.voucherCode;
                appliedDiscountAmount = data.discountAmount;
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
            msgEl.innerText = 'Không thể kết nối server, vui lòng thử lại.';
        })
        .finally(() => {
            btn.disabled  = false;
            btn.innerText = 'Áp dụng';
        });
});
document.getElementById('voucher-input').addEventListener('input', function () {
    if (appliedVoucherCode) {
        appliedVoucherCode    = '';
        appliedDiscountAmount = 0;
        updateTotalDisplay(0);
        const msgEl = document.getElementById('voucher-msg');
        msgEl.className = '';
        msgEl.innerHTML = '';
    }
});
document.getElementById('btn-dat-hang').addEventListener('click', function () {
    if (!validateForm()) return;
    const btn = this;
    btn.disabled  = true;
    btn.innerText = 'Đang xử lý...';
    btn.classList.add('loading');

    const selectedPaymentMethod = document.querySelector('input[name="payment"]:checked').value;

    const params = new URLSearchParams({
        fullName:    document.getElementById('fullname').value.trim(),
        phone:       document.getElementById('phone').value.trim(),
        city:        document.getElementById('city').value.trim(),
        ward:        document.getElementById('ward').value.trim(),
        address:     document.getElementById('address').value.trim(),
        notes:       document.getElementById('notes').value.trim(),
        voucherCode: appliedVoucherCode,
        paymentMethod: selectedPaymentMethod
    });
    fetch('order', {
        method:  'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body:    params.toString()
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'redirect') {
                window.location.href = data.url;
                return;
            }
            if (data.status === 'success') {
                const popup = document.getElementById('success-popup');
                popup.style.display    = 'flex';
                popup.style.opacity    = '1';
                popup.style.visibility = 'visible';
                setTimeout(() => popup.classList.add('show'), 10);
                setTimeout(() => {
                    window.location.href = 'order-detail-success?id=' + data.orderId;
                }, 2500);
            } else {
                alert('Lỗi: ' + (data.message || 'Đặt hàng thất bại'));
                btn.disabled  = false;
                btn.innerText = 'ĐẶT HÀNG';
                btn.classList.remove('loading');
            }
        })
        .catch(err => {
            console.error('Lỗi kết nối:', err);
            alert('Không thể kết nối server, vui lòng thử lại.');
            btn.disabled  = false;
            btn.innerText = 'ĐẶT HÀNG';
            btn.classList.remove('loading');
        });
});
document.getElementById('popup-close').addEventListener('click', function () {
    window.location.href = 'home';
});

window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const vnpayStatus = urlParams.get('vnpay');
    const orderId = urlParams.get('orderId');

    if (vnpayStatus === 'success') {
        const popup = document.getElementById('success-popup');
        if (popup) {
            popup.style.display = 'flex';
            setTimeout(() => popup.classList.add('show'), 10);
            setTimeout(() => {
                window.location.href = 'order-detail-success?id=' + orderId;
            }, 2500);
        }
    } else if (vnpayStatus === 'cancel') {
        const popup = document.getElementById('fail-popup');
        if (popup) {
            popup.style.display = 'flex';
            setTimeout(() => popup.classList.add('show'), 10);
            setTimeout(() => {
                window.location.href = 'home';
            }, 3500);
        }
    }
});

document.getElementById('popup-fail-close')?.addEventListener('click', function () {
    window.location.href = 'home';
});
//Xử lí kho Voucher
const walletPopup = document.getElementById('wallet-popup');
const btnOpenWallet = document.getElementById('btn-open-wallet');
const btnCloseWallet = document.getElementById('wallet-close');

if(btnOpenWallet) {
    btnOpenWallet.addEventListener('click', () => {
        walletPopup.style.display = 'flex';
        setTimeout(() => walletPopup.classList.add('show'), 10);
    });
}

if(btnCloseWallet) {
    btnCloseWallet.addEventListener('click', () => {
        walletPopup.classList.remove('show');
        setTimeout(() => walletPopup.style.display = 'none', 300);
    });
}
const btnSelectVouchers = document.querySelectorAll('.btn-select-voucher');
btnSelectVouchers.forEach(btn => {
    btn.addEventListener('click', function() {
        const code = this.getAttribute('data-code');
        document.getElementById('voucher-input').value = code;
        walletPopup.classList.remove('show');
        setTimeout(() => walletPopup.style.display = 'none', 300);
        document.getElementById('btn-apply-voucher').click();
    });
});