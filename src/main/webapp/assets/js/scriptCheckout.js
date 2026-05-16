

const SHIPPING_FEE = 30_000;
let currentDiscount = 0;


function formatVND(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
}

function updateTotalDisplay(discountAmount) {
    const originalTotal = parseFloat(
        document.getElementById('final-total').getAttribute('data-original')
    );
    currentDiscount = discountAmount;

    document.getElementById('final-total').innerText      = formatVND(originalTotal - discountAmount);
    document.getElementById('discount-amount').innerText  = '-' + formatVND(discountAmount);
    document.getElementById('discount-row').style.display = discountAmount > 0 ? 'flex' : 'none';
}

function validateForm() {
    const required = [
        { id: 'fullname', label: 'Họ và tên'        },
        { id: 'phone',    label: 'Số điện thoại'     },
        { id: 'city',     label: 'Tỉnh / Thành phố'  },
        { id: 'ward',     label: 'Phường / Xã'        },
        { id: 'address',  label: 'Địa chỉ cụ thể'    }
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

//Sài voucher
document.getElementById('btn-apply-voucher').addEventListener('click', function () {
    const code  = document.getElementById('voucher-input').value.trim();
    const msgEl = document.getElementById('voucher-msg');

    if (!code) {
        msgEl.className = 'error-msg';
        msgEl.innerText = 'Vui lòng nhập mã giảm giá.';
        return;
    }

    // sài khi có vouchers
    msgEl.className = 'error-msg';
    msgEl.innerText = 'Mã giảm giá không hợp lệ.';
});

//Nút đặt hàng
document.getElementById('btn-dat-hang').addEventListener('click', function () {
    if (!validateForm()) return;

    const btn = this;
    btn.disabled  = true;
    btn.innerText = 'Đang xử lý...';
    btn.classList.add('loading');

    const params = new URLSearchParams({
        fullName:    document.getElementById('fullname').value.trim(),
        phone:       document.getElementById('phone').value.trim(),
        city:        document.getElementById('city').value.trim(),
        ward:        document.getElementById('ward').value.trim(),
        address:     document.getElementById('address').value.trim(),
        notes:       document.getElementById('notes').value.trim(),
        voucherCode: document.getElementById('voucher-input').value.trim()
    });

    fetch('order', {
        method:  'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body:    params.toString()
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {

                const popup = document.getElementById('success-popup');
                popup.style.display = 'flex';
                setTimeout(() => popup.classList.add('show'), 10);

                setTimeout(() => {
                    window.location.href = 'order-detail-success?id=' + data.orderId;
                }, 2000);

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

// Đóng Pop-up
document.getElementById('popup-close').addEventListener('click', function () {
    window.location.href = 'home';
});