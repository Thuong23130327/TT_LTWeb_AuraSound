document.addEventListener("DOMContentLoaded", function () {

    let currentShippingFee = 0;
    let appliedVoucherCode = '';
    let appliedDiscountAmount = 0;


    const GHN_TOKEN = 'dffec2e1-6725-11f1-a973-aee5264794df';
    const BASE_URL = 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/';
    const GHN_HEADERS = { 'Content-Type': 'application/json', 'Token': GHN_TOKEN };

    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    const provinceIdInput = document.getElementById('provinceId');
    const districtIdInput = document.getElementById('districtId');
    const wardCodeInput = document.getElementById('wardCode');
    const cityTextInput = document.getElementById('cityText');

    async function fetchProvinces(selectedId = null) {
        try {
            const res = await fetch(`${BASE_URL}province`, { method: 'GET', headers: GHN_HEADERS });
            const data = await res.json();
            if (data.code === 200) {
                provinceSelect.innerHTML = '<option value="">-- Chọn Tỉnh / Thành Phố --</option>';
                const sorted = data.data.sort((a, b) => a.ProvinceName.localeCompare(b.ProvinceName));
                sorted.forEach(p => {
                    const opt = new Option(p.ProvinceName, p.ProvinceID);
                    if (selectedId && p.ProvinceID == selectedId) opt.selected = true;
                    provinceSelect.appendChild(opt);
                });
            }
        } catch (e) { console.error('Lỗi tải tỉnh:', e); }
    }

    async function fetchDistricts(provinceId, selectedId = null) {
        if (!provinceId) return;
        try {
            const res = await fetch(`${BASE_URL}district`, {
                method: 'POST', headers: GHN_HEADERS,
                body: JSON.stringify({ province_id: parseInt(provinceId) })
            });
            const data = await res.json();
            if (data.code === 200) {
                districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
                const filtered = data.data.filter(d => !d.DistrictName.includes('Thử nghiệm'));
                filtered.forEach(d => {
                    const opt = new Option(d.DistrictName, d.DistrictID);
                    if (selectedId && d.DistrictID == selectedId) opt.selected = true;
                    districtSelect.appendChild(opt);
                });
                districtSelect.disabled = false;
            }
        } catch (e) { console.error('Lỗi tải quận:', e); }
    }

    async function fetchWards(districtId, selectedCode = null) {
        if (!districtId) return;
        try {
            const res = await fetch(`${BASE_URL}ward?district_id=${districtId}`, { method: 'GET', headers: GHN_HEADERS });
            const data = await res.json();
            if (data.code === 200) {
                wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
                data.data.forEach(w => {
                    const opt = new Option(w.WardName, w.WardCode);
                    if (selectedCode && w.WardCode == selectedCode) opt.selected = true;
                    wardSelect.appendChild(opt);
                });
                wardSelect.disabled = false;
            }
        } catch (e) { console.error('Lỗi tải phường:', e); }
    }

    if (provinceSelect) {
        provinceSelect.addEventListener('change', async function () {
            districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
            districtSelect.disabled = true;
            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            wardSelect.disabled = true;
            if (this.value) await fetchDistricts(this.value);
        });
    }

    if (districtSelect) {
        districtSelect.addEventListener('change', async function () {
            wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
            wardSelect.disabled = true;
            if (this.value) await fetchWards(this.value);
        });
    }

    fetchProvinces();

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

        if (shippingFeeDisplay) shippingFeeDisplay.innerText = formatVND(currentShippingFee);
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

    async function callShippingFeeApi(districtId, wardCode) {
        if (!districtId || !wardCode) return;
        const summaryContainer = document.querySelector('.order-summary');
        if (summaryContainer) summaryContainer.classList.add('loading');
        try {
            const params = new URLSearchParams({ districtId, wardCode });
            const res = await fetch('api/calculate-shipping', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            });
            const data = await res.json();
            if (data.status === 'success') {
                currentShippingFee = parseFloat(data.fee);
                updateTotalDisplay(appliedDiscountAmount);
                
                const expectedDateEl = document.getElementById('expected-delivery-date');
                if (expectedDateEl) {
                    if (data.leadtime && data.leadtime > 0) {
                        const date = new Date(data.leadtime * 1000);
                        const day = ("0" + date.getDate()).slice(-2);
                        const month = ("0" + (date.getMonth() + 1)).slice(-2);
                        const year = date.getFullYear();
                        expectedDateEl.innerText = `${day}/${month}/${year}`;
                    } else {
                        expectedDateEl.innerText = 'Không xác định';
                    }
                }
            }
        } catch (e) {
            console.error('Lỗi tính phí ship:', e);
        } finally {
            if (summaryContainer) summaryContainer.classList.remove('loading');
        }
    }

    function selectShippingAddress(card) {
        if (!card) return;

        document.querySelectorAll('.co-address-item').forEach(c => {
            c.classList.remove('co-selected');
            const radio = c.querySelector('.co-radio');
            if (radio) radio.checked = false;
        });

        card.classList.add('co-selected');
        const radio = card.querySelector('.co-radio');
        if (radio) radio.checked = true;

        const recipientName = card.querySelector('.address-info-value-name')?.textContent.trim() || '';
        const phone         = card.querySelector('.address-info-value-phone')?.textContent.trim() || '';
        const city          = card.querySelector('.address-info-value-city')?.textContent.trim() || '';
        const address       = card.querySelector('.address-info-value-address')?.textContent.trim() || '';
        const districtId    = card.getAttribute('data-district-id') || '';
        const wardCode      = card.getAttribute('data-ward-code') || '';
        const provinceId    = card.getAttribute('data-province-id') || '';
        const addressId     = card.getAttribute('data-id') || '';

        const parts = city.split(',').map(s => s.trim());
        const wardText     = parts[0] || '';
        const districtText = parts[1] || '';
        const provinceText = parts[2] || city;

        const el = id => document.getElementById(id);
        if (el('fullname')) el('fullname').value = recipientName;
        if (el('phone'))    el('phone').value    = phone;
        if (el('city'))     el('city').value     = provinceText;
        if (el('district_main')) el('district_main').value = districtText;
        if (el('wardDisplay'))     el('wardDisplay').value     = wardText;
        if (el('addressDisplay'))  el('addressDisplay').value  = address;

        if (el('mainProvinceId')) el('mainProvinceId').value = provinceId;
        if (el('mainDistrictId')) el('mainDistrictId').value = districtId;
        if (el('mainWardCode'))   el('mainWardCode').value   = wardCode;
        if (el('mainAddressId'))  el('mainAddressId').value  = addressId;

        callShippingFeeApi(districtId, wardCode);
    }

    document.querySelectorAll('.co-address-item').forEach(card => {
        card.addEventListener('click', function (e) {
            if (e.target.closest('button')) return;
            selectShippingAddress(this);
        });

        const radio = card.querySelector('.co-radio');
        if (radio) {
            radio.addEventListener('change', function () {
                selectShippingAddress(card);
            });
        }
    });

    const defaultCard = document.querySelector('.co-address-item.default');
    const firstCard   = document.querySelector('.co-address-item');
    selectShippingAddress(defaultCard || firstCard);

    const modal          = document.getElementById('modal-address');
    const overlay        = document.getElementById('menu-overlay');
    const btnAddAddress  = document.getElementById('btnAddAddress');
    const closeBtn       = document.getElementById('closeAddressModal');
    const btnCancel      = document.getElementById('btnCancelAddress');
    const btnSave        = document.getElementById('btnSaveAddress');
    const addressForm    = document.getElementById('addressForm');
    const modalTitle     = document.getElementById('modalTitle');
    const actionInput    = document.getElementById('action');
    const addressIdInput = document.getElementById('addressId');

    function openModal() {
        if (modal) modal.classList.add('active');
        if (overlay) overlay.classList.add('active');
    }

    function closeModal() {
        if (modal) modal.classList.remove('active');
        if (overlay) overlay.classList.remove('active');
        resetModalForm();
    }

    function resetModalForm() {
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

    if (btnAddAddress) {
        btnAddAddress.addEventListener('click', function () {
            resetModalForm();
            modalTitle.textContent = 'Thêm Địa Chỉ Mới';
            actionInput.value = 'create';
            openModal();
        });
    }

    if (closeBtn) closeBtn.addEventListener('click', closeModal);
    if (btnCancel) btnCancel.addEventListener('click', closeModal);
    if (overlay)   overlay.addEventListener('click', closeModal);

    window.editAddress = async function (addrId) {
        const card = document.querySelector(`.co-address-item[data-id="${addrId}"]`);
        if (!card) return;

        const recipientName = card.querySelector('.address-info-value-name')?.textContent.trim() || '';
        const phone         = card.querySelector('.address-info-value-phone')?.textContent.trim() || '';
        const addressValue  = card.querySelector('.address-info-value-address')?.textContent.trim() || '';
        const isDefaultCard = card.classList.contains('default');

        const pId   = card.getAttribute('data-province-id');
        const dId   = card.getAttribute('data-district-id');
        const wCode = card.getAttribute('data-ward-code');

        const el = id => document.getElementById(id);
        if (el('recipientName')) el('recipientName').value = recipientName;
        if (el('phoneModal'))    el('phoneModal').value    = phone;
        if (el('addressDetail')) el('addressDetail').value = addressValue;
        if (el('isDefault'))     el('isDefault').checked  = isDefaultCard;

        actionInput.value    = 'edit';
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

    // Xóa địa chỉ
    window.deleteAddress = function (addrId) {
        if (confirm('Bạn chắc chắn muốn xóa địa chỉ này?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            const ctx = window.location.pathname.substring(0, window.location.pathname.indexOf('/checkout'));
            form.action = ctx + '/address';
            form.innerHTML = `
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="addressId" value="${addrId}">
                <input type="hidden" name="redirect" value="checkout">
            `;
            document.body.appendChild(form);
            form.submit();
        }
    };

    // Đặt mặc định
    window.setDefault = function (addrId) {
        const form = document.createElement('form');
        form.method = 'POST';
        const ctx = window.location.pathname.substring(0, window.location.pathname.indexOf('/checkout'));
        form.action = ctx + '/address';
        form.innerHTML = `
            <input type="hidden" name="action" value="setDefault">
            <input type="hidden" name="addressId" value="${addrId}">
            <input type="hidden" name="redirect" value="checkout">
        `;
        document.body.appendChild(form);
        form.submit();
    };

    if (btnSave) {
        btnSave.addEventListener('click', function () {
            const recipientName = document.getElementById('recipientName')?.value.trim();
            const phone         = document.getElementById('phoneModal')?.value.trim();
            const address       = document.getElementById('addressDetail')?.value.trim();

            if (!recipientName) { alert('Vui lòng nhập tên người nhận!'); return; }
            if (!phone)         { alert('Vui lòng nhập số điện thoại!'); return; }
            if (phone.length < 10 || phone.length > 20) {
                alert('Số điện thoại phải từ 10 đến 20 ký tự!'); return;
            }
            if (!provinceSelect?.value || !districtSelect?.value || !wardSelect?.value) {
                alert('Vui lòng chọn đầy đủ Tỉnh/Thành, Quận/Huyện, Phường/Xã!'); return;
            }
            if (!address)              { alert('Vui lòng nhập địa chỉ chi tiết!'); return; }
            if (address.length < 5)    { alert('Địa chỉ chi tiết phải có ít nhất 5 ký tự!'); return; }

            provinceIdInput.value = provinceSelect.value;
            districtIdInput.value = districtSelect.value;
            wardCodeInput.value   = wardSelect.value;

            const pText = provinceSelect.options[provinceSelect.selectedIndex].text;
            const dText = districtSelect.options[districtSelect.selectedIndex].text;
            const wText = wardSelect.options[wardSelect.selectedIndex].text;
            cityTextInput.value = `${wText}, ${dText}, ${pText}`;

            addressForm.submit();
        });
    }

    const walletPopup    = document.getElementById('wallet-popup');
    const btnOpenWallet  = document.getElementById('btn-open-wallet');
    const btnCloseWallet = document.getElementById('wallet-close');

    if (btnOpenWallet) {
        btnOpenWallet.addEventListener('click', () => {
            walletPopup.style.display = 'flex';
            setTimeout(() => walletPopup.classList.add('show'), 10);
        });
    }
    if (btnCloseWallet) {
        btnCloseWallet.addEventListener('click', () => {
            walletPopup.classList.remove('show');
            setTimeout(() => walletPopup.style.display = 'none', 300);
        });
    }

    document.querySelectorAll('.btn-select-voucher').forEach(btn => {
        btn.addEventListener('click', function () {
            document.getElementById('voucher-input').value = this.getAttribute('data-code');
            walletPopup.classList.remove('show');
            setTimeout(() => walletPopup.style.display = 'none', 300);
            document.getElementById('btn-apply-voucher').click();
        });
    });

    const applyVoucherBtn = document.getElementById('btn-apply-voucher');
    if (applyVoucherBtn) {
        applyVoucherBtn.addEventListener('click', async function () {
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
            try {
                const params = new URLSearchParams({ code, orderTotal });
                const res = await fetch('api/voucher/validate', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params.toString()
                });
                const data = await res.json();
                if (data.status === 'ok') {
                    appliedVoucherCode = data.voucherCode;
                    updateTotalDisplay(data.discountAmount);
                    msgEl.className = 'success-msg';
                    msgEl.innerHTML = data.message;
                } else {
                    msgEl.className = 'error-msg';
                    msgEl.innerHTML = data.message;
                }
            } catch (e) {
                msgEl.className = 'error-msg';
                msgEl.innerText = 'Lỗi kết nối voucher.';
            } finally {
                btn.disabled = false;
                btn.innerText = 'Áp dụng';
            }
        });
    }

    function validateOrderForm() {
        const fields = [
            { id: 'fullname',        label: 'Họ và tên' },
            { id: 'phone',           label: 'Số điện thoại' },
            { id: 'city',            label: 'Tỉnh / Thành phố' },
            { id: 'district_main',   label: 'Quận / Huyện' },
            { id: 'wardDisplay',     label: 'Phường / Xã' },
            { id: 'addressDisplay',  label: 'Địa chỉ cụ thể' }
        ];
        for (const f of fields) {
            const el = document.getElementById(f.id);
            if (!el || el.value.trim() === '') {
                alert('Vui lòng chọn địa chỉ giao hàng hợp lệ!');
                return false;
            }
        }
        const ph = document.getElementById('phone').value.trim();
        if (!/^[0-9]{10}$/.test(ph)) {
            alert('Số điện thoại không hợp lệ.');
            return false;
        }
        return true;
    }

    const orderBtn = document.getElementById('btn-dat-hang');
    if (orderBtn) {
        orderBtn.addEventListener('click', async function () {
            if (!validateOrderForm()) return;

            const btn = this;
            btn.disabled = true;
            btn.innerText = 'Đang xử lý...';

            const el = id => document.getElementById(id);
            const params = new URLSearchParams({
                fullName:      el('fullname').value.trim(),
                phone:         el('phone').value.trim(),
                city:          el('district_main').value.trim() + ', ' + el('city').value.trim(),
                ward:          el('wardDisplay').value.trim(),
                address:       el('addressDisplay').value.trim(),
                notes:         el('notes').value.trim(),
                voucherCode:   appliedVoucherCode,
                paymentMethod: document.querySelector('input[name="payment"]:checked').value,
                provinceId:    el('mainProvinceId').value.trim(),
                districtId:    el('mainDistrictId').value.trim(),
                wardCode:      el('mainWardCode').value.trim(),
                addressId:     el('mainAddressId').value.trim(),
                shippingFee:   currentShippingFee
            });

            try {
                const res = await fetch('order', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params.toString()
                });
                const data = await res.json();
                if (data.status === 'redirect') {
                    window.location.href = data.url;
                } else if (data.status === 'success') {
                    window.location.href = 'order-detail-success?id=' + data.orderId;
                } else {
                    alert('Lỗi: ' + data.message);
                    btn.disabled = false;
                    btn.innerText = 'ĐẶT HÀNG';
                }
            } catch (e) {
                alert('Lỗi kết nối server.');
                btn.disabled = false;
                btn.innerText = 'ĐẶT HÀNG';
            }
        });
    }

});