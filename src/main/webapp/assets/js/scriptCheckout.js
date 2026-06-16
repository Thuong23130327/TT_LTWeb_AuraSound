document.addEventListener("DOMContentLoaded", function () {
    const SHIPPING_FEE = 30000;
    let appliedVoucherCode = '';
    let appliedDiscountAmount = 0;

    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
    }

    function updateTotalDisplay(discountAmount) {
        const originalTotal = parseFloat(
            document.getElementById('final-total').getAttribute('data-original')
        );
        appliedDiscountAmount = discountAmount;
        const discountRow = document.getElementById('discount-row');
        const discountAmountEl = document.getElementById('discount-amount');
        const finalTotalEl = document.getElementById('final-total');
        if (discountAmount > 0) {
            discountAmountEl.innerText = '-' + formatVND(discountAmount);
            discountRow.style.display = 'flex';
            finalTotalEl.innerText = formatVND(originalTotal - discountAmount);
        } else {
            discountRow.style.display = 'none';
            finalTotalEl.innerText = formatVND(originalTotal);
        }
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
                alert('Vui lòng chọn địa chỉ giao hàng hợp lệ hoặc thêm địa chỉ mới!');
                return false;
            }
        }
        if (!/^[0-9]{10}$/.test(document.getElementById('phone').value.trim())) {
            alert('Số điện thoại phải gồm đúng 10 chữ số.');
            return false;
        }
        return true;
    }

    // --- CẤU HÌNH API GIAO HÀNG NHANH (GHN) ---
    const GHN_TOKEN = 'dffec2e1-6725-11f1-a973-aee5264794df';
    const BASE_URL = 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/';
    const path = window.location.pathname.includes('/checkout') ? window.location.pathname.replace(/\/checkout.*$/, '') : '';

    const headers = {
        'Content-Type': 'application/json',
        'Token': GHN_TOKEN
    };

    // Khai báo các thành phần DOM địa chỉ mới
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('modalWard');

    const provinceIdInput = document.getElementById('modalProvinceId');
    const districtIdInput = document.getElementById('modalDistrictId');
    const wardCodeInput = document.getElementById('modalWardCode');
    const cityTextInput = document.getElementById('modalCityText');

    // 1. Tải danh sách Tỉnh/Thành phố
    async function fetchProvinces(selectedId = null) {
        try {
            const response = await fetch(`${BASE_URL}province`, { method: 'GET', headers: headers });
            const resData = await response.json();
            if (resData.code === 200) {
                provinceSelect.innerHTML = '<option value="">-- Chọn Tỉnh / Thành Phố --</option>';
                const provinces = resData.data.sort((a, b) => a.ProvinceName.localeCompare(b.ProvinceName));
                provinces.forEach(p => {
                    let opt = new Option(p.ProvinceName, p.ProvinceID);
                    if (selectedId && p.ProvinceID == selectedId) opt.selected = true;
                    provinceSelect.appendChild(opt);
                });
            }
        } catch (err) {
            console.error("Lỗi tải danh sách Tỉnh từ GHN:", err);
        }
    }

    // 2. Tải danh sách Quận/Huyện dựa trên ProvinceID
    async function fetchDistricts(provinceId, selectedId = null) {
        if (!provinceId) return;
        try {
            const response = await fetch(`${BASE_URL}district`, {
                method: 'POST',
                headers: headers,
                body: JSON.stringify({ province_id: parseInt(provinceId) })
            });
            const resData = await response.json();
            if (resData.code === 200) {
                districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
                const districts = resData.data.filter(d => !d.DistrictName.includes("Thử nghiệm"));
                districts.forEach(d => {
                    let opt = new Option(d.DistrictName, d.DistrictID);
                    if (selectedId && d.DistrictID == selectedId) opt.selected = true;
                    districtSelect.appendChild(opt);
                });
                districtSelect.disabled = false;
            }
        } catch (err) {
            console.error("Lỗi tải danh sách Quận Huyện từ GHN:", err);
        }
    }

    // 3. Tải danh sách Phường/Xã dựa trên DistrictID
    async function fetchWards(districtId, selectedCode = null) {
        if (!districtId) return;
        try {
            const response = await fetch(`${BASE_URL}ward?district_id=${districtId}`, { method: 'GET', headers: headers });
            const resData = await response.json();
            if (resData.code === 200) {
                wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
                resData.data.forEach(w => {
                    let opt = new Option(w.WardName, w.WardCode);
                    if (selectedCode && w.WardCode == selectedCode) opt.selected = true;
                    wardSelect.appendChild(opt);
                });
                wardSelect.disabled = false;
            }
        } catch (err) {
            console.error("Lỗi tải danh sách Phường Xã từ GHN:", err);
        }
    }

    if (provinceSelect) {
        provinceSelect.addEventListener('change', async function () {
            districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
            districtSelect.disabled = true;
            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            wardSelect.disabled = true;

            if (this.value) {
                await fetchDistricts(this.value);
            }
        });
    }

    if (districtSelect) {
        districtSelect.addEventListener('change', async function () {
            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            wardSelect.disabled = true;

            if (this.value) {
                await fetchWards(this.value);
            }
        });
    }

    // Tải tỉnh thành ban đầu
    fetchProvinces();

    // --- XỬ LÝ MODAL THÊM / SỬA ĐỊA CHỈ ---
    const modal = document.getElementById('modal-address');
    const overlay = document.getElementById('menu-overlay');
    const btnAddAddress = document.getElementById('btnAddAddress');
    const closeAddressModal = document.getElementById('closeAddressModal');
    const btnCancelAddress = document.getElementById('btnCancelAddress');
    const btnSaveAddress = document.getElementById('btnSaveAddress');
    const addressForm = document.getElementById('addressForm');
    const modalTitle = document.getElementById('modalTitle');
    const actionInput = document.getElementById('action');
    const addressIdInput = document.getElementById('addressId');

    function openModal() {
        if (modal) modal.classList.add('active');
        if (overlay) overlay.classList.add('active');
    }

    function closeModal() {
        if (modal) modal.classList.remove('active');
        if (overlay) overlay.classList.remove('active');
        resetForm();
    }

    function resetForm() {
        if (addressForm) addressForm.reset();
        if (districtSelect) {
            districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
            districtSelect.disabled = true;
        }
        if (wardSelect) {
            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            wardSelect.disabled = true;
        }
        if (actionInput) actionInput.value = 'create';
        if (addressIdInput) addressIdInput.value = '';
    }

    if (closeAddressModal) closeAddressModal.addEventListener('click', closeModal);
    if (btnCancelAddress) btnCancelAddress.addEventListener('click', closeModal);
    if (overlay) overlay.addEventListener('click', closeModal);

    if (btnAddAddress) {
        btnAddAddress.addEventListener('click', function () {
            resetForm();
            if (actionInput) actionInput.value = 'create';
            if (modalTitle) modalTitle.textContent = 'Thêm Địa Chỉ Mới';
            openModal();
        });
    }

    window.editAddress = async function (addrId) {
        const addressItem = document.querySelector(`.address-item-card[data-id="${addrId}"]`);
        if (!addressItem) {
            window.location.href = `${path}/address?action=edit&id=${addrId}`;
            return;
        }

        const recipientName = addressItem.getAttribute('data-recipient-name') || '';
        const phone = addressItem.getAttribute('data-phone') || '';
        const addressValue = addressItem.getAttribute('data-address') || '';
        const isDefault = addressItem.classList.contains('border-warning');

        const pId = addressItem.getAttribute('data-province-id');
        const dId = addressItem.getAttribute('data-district-id');
        const wCode = addressItem.getAttribute('data-ward-code');

        document.getElementById('recipientName').value = recipientName;
        document.getElementById('phoneInput').value = phone;
        document.getElementById('addressInput').value = addressValue;
        document.getElementById('isDefault').checked = isDefault;

        actionInput.value = 'edit';
        addressIdInput.value = addrId;
        modalTitle.textContent = 'Chỉnh Sửa Địa Chỉ';

        openModal();

        if (pId) {
            await fetchProvinces(pId);
            if (dId) {
                await fetchDistricts(pId, dId);
                if (wCode) {
                    await fetchWards(dId, wCode);
                }
            }
        }
    };

    window.deleteAddress = function (addrId) {
        if (confirm('Bạn chắc chắn muốn xóa địa chỉ này?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = `${path}/address`;

            form.innerHTML = `
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="addressId" value="${addrId}">
                <input type="hidden" name="redirect" value="checkout">
            `;

            document.body.appendChild(form);
            form.submit();
        }
    };

    window.setDefault = function (addrId) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `${path}/address`;

        form.innerHTML = `
            <input type="hidden" name="action" value="setDefault">
            <input type="hidden" name="addressId" value="${addrId}">
            <input type="hidden" name="redirect" value="checkout">
        `;

        document.body.appendChild(form);
        form.submit();
    };

    if (btnSaveAddress) {
        btnSaveAddress.addEventListener('click', function () {
            const recipientName = document.getElementById('recipientName').value.trim();
            const phone = document.getElementById('phoneInput').value.trim();
            const address = document.getElementById('addressInput').value.trim();

            if (!recipientName) {
                alert('Vui lòng nhập tên người nhận!');
                return;
            }

            if (!phone) {
                alert('Vui lòng nhập số điện thoại!');
                return;
            }

            if (phone.length < 10 || phone.length > 20) {
                alert('Số điện thoại phải từ 10 đến 20 ký tự!');
                return;
            }

            if (!provinceSelect.value || !districtSelect.value || !wardSelect.value) {
                alert('Vui lòng chọn đầy đủ Tỉnh/Thành, Quận/Huyện, Phường/Xã!');
                return;
            }

            if (!address) {
                alert('Vui lòng nhập địa chỉ chi tiết (Số nhà, tên đường)!');
                return;
            }

            if (address.length < 5) {
                alert('Địa chỉ chi tiết phải có ít nhất 5 ký tự!');
                return;
            }

            provinceIdInput.value = provinceSelect.value;
            districtIdInput.value = districtSelect.value;
            wardCodeInput.value = wardSelect.value;

            const pText = provinceSelect.options[provinceSelect.selectedIndex].text;
            const dText = districtSelect.options[districtSelect.selectedIndex].text;
            const wText = wardSelect.options[wardSelect.selectedIndex].text;
            cityTextInput.value = `${wText}, ${dText}, ${pText}`;

            addressForm.submit();
        });
    }

    // --- LỰA CHỌN ĐỊA CHỈ TRÊN TRANG CHECKOUT ---
    function selectShippingAddress(cardEl) {
        if (!cardEl) return;

        // Bỏ active của tất cả card và bỏ check radio
        document.querySelectorAll('.address-item-card').forEach(card => {
            card.classList.remove('border-warning', 'bg-light-subtle');
            const radio = card.querySelector('input[type="radio"]');
            if (radio) radio.checked = false;
        });

        // Active card đã chọn
        cardEl.classList.add('border-warning', 'bg-light-subtle');
        const radio = cardEl.querySelector('input[type="radio"]');
        if (radio) radio.checked = true;

        // Lấy dữ liệu từ attribute
        const recipientName = cardEl.getAttribute('data-recipient-name') || '';
        const phone = cardEl.getAttribute('data-phone') || '';
        const cityStr = cardEl.getAttribute('data-city') || '';
        const addressVal = cardEl.getAttribute('data-address') || '';
        const provinceId = cardEl.getAttribute('data-province-id') || '';
        const districtId = cardEl.getAttribute('data-district-id') || '';
        const wardCode = cardEl.getAttribute('data-ward-code') || '';

        // Phân tách chuỗi city (thường là "Phường, Quận, Tỉnh") để điền vào các ô input
        const parts = cityStr.split(',').map(s => s.trim());
        let wardText = '';
        let districtText = '';
        let provinceText = '';
        if (parts.length >= 3) {
            wardText = parts[0];
            districtText = parts[1];
            provinceText = parts[2];
        } else if (parts.length === 2) {
            wardText = parts[0];
            provinceText = parts[1];
        } else {
            provinceText = cityStr;
        }

        // Điền vào các ô input giao diện
        document.getElementById('fullname').value = recipientName;
        document.getElementById('phone').value = phone;
        document.getElementById('city').value = provinceText;
        document.getElementById('district_main').value = districtText;
        document.getElementById('ward').value = wardText;
        document.getElementById('address').value = addressVal;

        // Điền vào các input ẩn phục vụ gửi đơn hàng
        document.getElementById('mainProvinceId').value = provinceId;
        document.getElementById('mainDistrictId').value = districtId;
        document.getElementById('mainWardCode').value = wardCode;
        document.getElementById('mainAddressId').value = cardEl.getAttribute('data-id') || '';
    }

    // Đăng ký sự kiện click chọn địa chỉ
    document.querySelectorAll('.address-item-card').forEach(card => {
        card.addEventListener('click', function(e) {
            if (e.target.closest('button') || e.target.closest('a') || e.target.closest('input[type="radio"]')) {
                // Để nút và radio tự xử lý
                if (e.target.closest('input[type="radio"]')) {
                    selectShippingAddress(this);
                }
                return;
            }
            selectShippingAddress(this);
        });
    });

    // Tự động chọn địa chỉ mặc định hoặc đầu tiên lúc ban đầu
    const checkedRadio = document.querySelector('input[name="selectedShippingAddress"]:checked');
    if (checkedRadio) {
        const card = checkedRadio.closest('.address-item-card');
        selectShippingAddress(card);
    } else {
        const firstCard = document.querySelector('.address-item-card');
        if (firstCard) {
            selectShippingAddress(firstCard);
        }
    }

    // --- VOUCHER ---
    const applyVoucherBtn = document.getElementById('btn-apply-voucher');
    if (applyVoucherBtn) {
        applyVoucherBtn.addEventListener('click', function () {
            const btn = this;
            const code = document.getElementById('voucher-input').value.trim().toUpperCase();
            const msgEl = document.getElementById('voucher-msg');
            appliedVoucherCode = '';
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
                    btn.disabled = false;
                    btn.innerText = 'Áp dụng';
                });
        });
    }

    const voucherInput = document.getElementById('voucher-input');
    if (voucherInput) {
        voucherInput.addEventListener('input', function () {
            if (appliedVoucherCode) {
                appliedVoucherCode = '';
                appliedDiscountAmount = 0;
                updateTotalDisplay(0);
                const msgEl = document.getElementById('voucher-msg');
                msgEl.className = '';
                msgEl.innerHTML = '';
            }
        });
    }

    // --- ĐẶT HÀNG ---
    const orderBtn = document.getElementById('btn-dat-hang');
    if (orderBtn) {
        orderBtn.addEventListener('click', function () {
            if (!validateForm()) return;
            const btn = this;
            btn.disabled = true;
            btn.innerText = 'Đang xử lý...';
            btn.classList.add('loading');

            const selectedPaymentMethod = document.querySelector('input[name="payment"]:checked').value;

            const params = new URLSearchParams({
                fullName:    document.getElementById('fullname').value.trim(),
                phone:       document.getElementById('phone').value.trim(),
                city:        document.getElementById('district_main').value.trim() + ", " + document.getElementById('city').value.trim(),
                ward:        document.getElementById('ward').value.trim(),
                address:     document.getElementById('address').value.trim(),
                notes:       document.getElementById('notes').value.trim(),
                voucherCode: appliedVoucherCode,
                paymentMethod: selectedPaymentMethod,
                provinceId:  document.getElementById('mainProvinceId').value.trim(),
                districtId:  document.getElementById('mainDistrictId').value.trim(),
                wardCode:    document.getElementById('mainWardCode').value.trim(),
                addressId:   document.getElementById('mainAddressId').value.trim()
            });
            fetch('order', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'redirect') {
                        window.location.href = data.url;
                        return;
                    }
                    if (data.status === 'success') {
                        const popup = document.getElementById('success-popup');
                        popup.style.display = 'flex';
                        popup.style.opacity = '1';
                        popup.style.visibility = 'visible';
                        setTimeout(() => popup.classList.add('show'), 10);
                        setTimeout(() => {
                            window.location.href = 'order-detail-success?id=' + data.orderId;
                        }, 2500);
                    } else {
                        alert('Lỗi: ' + (data.message || 'Đặt hàng thất bại'));
                        btn.disabled = false;
                        btn.innerText = 'ĐẶT HÀNG';
                        btn.classList.remove('loading');
                    }
                })
                .catch(err => {
                    console.error('Lỗi kết nối:', err);
                    alert('Không thể kết nối server, vui lòng thử lại.');
                    btn.disabled = false;
                    btn.innerText = 'ĐẶT HÀNG';
                    btn.classList.remove('loading');
                });
        });
    }

    const popupClose = document.getElementById('popup-close');
    if (popupClose) {
        popupClose.addEventListener('click', function () {
            window.location.href = 'home';
        });
    }

    const popupFailClose = document.getElementById('popup-fail-close');
    if (popupFailClose) {
        popupFailClose.addEventListener('click', function () {
            window.location.href = 'home';
        });
    }

    // --- HẬU XỬ LÝ VNPAY ---
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
});