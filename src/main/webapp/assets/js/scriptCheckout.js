document.addEventListener("DOMContentLoaded", function () {

    // =====================================================================
    // BIẾN TRẠNG THÁI TOÀN CỤC
    // =====================================================================
    let currentShippingFee = parseFloat(
        document.getElementById('final-total')?.getAttribute('data-shipping') || '30000'
    );
    let appliedVoucherCode = '';
    let appliedDiscountAmount = 0;

    // =====================================================================
    // CẤU HÌNH GHN API
    // =====================================================================
    const GHN_TOKEN = 'dffec2e1-6725-11f1-a973-aee5264794df';
    const GHN_BASE  = 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/';
    const GHN_HEADERS = {
        'Content-Type': 'application/json',
        'Token': GHN_TOKEN
    };

    // Xác định base path của ứng dụng (context path)
    const path = window.location.pathname.replace(/\/checkout.*$/, '');

    // =====================================================================
    // TIỆN ÍCH
    // =====================================================================
    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN').format(amount) + 'đ';
    }

    function updateTotalDisplay(discountAmount) {
        const finalTotalEl   = document.getElementById('final-total');
        const originalTotal  = parseFloat(finalTotalEl?.getAttribute('data-original') || '0');
        const baseShipping   = parseFloat(finalTotalEl?.getAttribute('data-shipping')  || '30000');
        appliedDiscountAmount = discountAmount || 0;

        // Tách ra subtotal (giá sản phẩm thuần)
        const subtotal = originalTotal - baseShipping;

        // Cập nhật hiển thị phí ship
        const shippingEl = document.getElementById('shipping-fee-display');
        if (shippingEl) shippingEl.innerText = formatVND(currentShippingFee);

        const discountRow      = document.getElementById('discount-row');
        const discountAmountEl = document.getElementById('discount-amount');

        const newFinal = Math.max(0, subtotal + currentShippingFee - appliedDiscountAmount);

        if (appliedDiscountAmount > 0) {
            discountAmountEl.innerText = '-' + formatVND(appliedDiscountAmount);
            discountRow.style.display = 'flex';
        } else {
            discountRow.style.display = 'none';
        }

        finalTotalEl.innerText = formatVND(newFinal);
    }

    // =====================================================================
    // VALIDATE FORM TRƯỚC KHI ĐẶT HÀNG
    // =====================================================================
    function validateForm() {
        const required = [
            { id: 'fullname',      label: 'Họ và tên' },
            { id: 'phone',         label: 'Số điện thoại' },
            { id: 'city',          label: 'Tỉnh / Thành phố' },
            { id: 'district_main', label: 'Quận / Huyện' },
            { id: 'ward',          label: 'Phường / Xã' },
            { id: 'address',       label: 'Địa chỉ cụ thể' }
        ];
        for (const f of required) {
            const el = document.getElementById(f.id);
            if (!el || el.value.trim() === '') {
                alert('Vui lòng chọn địa chỉ giao hàng hợp lệ hoặc thêm địa chỉ mới!');
                return false;
            }
        }
        if (!/^[0-9]{10,11}$/.test(document.getElementById('phone').value.trim())) {
            alert('Số điện thoại phải gồm 10–11 chữ số.');
            return false;
        }
        return true;
    }

    // =====================================================================
    // GỌI API TÍNH PHÍ SHIP & THỜI GIAN DỰ KIẾN
    // =====================================================================
    async function callShippingFeeApi(districtId, wardCode) {
        if (!districtId || !wardCode) return;

        const summaryContainer = document.querySelector('.order-summary');
        if (summaryContainer) summaryContainer.classList.add('loading');

        const expectedDateEl = document.getElementById('expected-delivery-date');
        const shippingEl     = document.getElementById('shipping-fee-display');
        if (expectedDateEl) expectedDateEl.innerText = 'Đang tính...';
        if (shippingEl)     shippingEl.innerText = 'Đang tính...';

        try {
            const params = new URLSearchParams({ districtId, wardCode });
            const res  = await fetch('api/calculate-shipping', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            });
            const data = await res.json();

            // --- Phí vận chuyển ---
            // fee = -1 nghĩa là GHN trả lỗi thực sự (không hardcode fallback)
            if (data.fee !== undefined && data.fee >= 0) {
                currentShippingFee = data.fee;
                updateTotalDisplay(appliedDiscountAmount);
            } else {
                // GHN lỗi: hiển thị thông báo rõ ràng, KHÔNG dùng số giả
                currentShippingFee = 0;
                updateTotalDisplay(appliedDiscountAmount);
                if (shippingEl) shippingEl.innerHTML =
                    '<span style="color:#e74c3c;font-size:0.85em">⚠ Không lấy được phí ship, vui lòng thử lại</span>';
            }

            // --- Thời gian dự kiến ---
            // leadtime là Unix timestamp (giây); -1 = không xác định được từ GHN
            if (expectedDateEl) {
                if (data.leadtime && data.leadtime > 0) {
                    const date  = new Date(data.leadtime * 1000);
                    const day   = ('0' + date.getDate()).slice(-2);
                    const month = ('0' + (date.getMonth() + 1)).slice(-2);
                    const year  = date.getFullYear();
                    // Tên thứ trong tuần để dễ hình dung
                    const weekdays = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
                    const dow = weekdays[date.getDay()];
                    expectedDateEl.innerText = `${dow}, ${day}/${month}/${year}`;
                } else {
                    expectedDateEl.innerHTML =
                        '<span style="color:#e74c3c;font-size:0.85em">⚠ Không xác định được từ GHN</span>';
                }
            }

        } catch (err) {
            console.error('[ShippingFee] Lỗi kết nối:', err);
            if (shippingEl) shippingEl.innerHTML =
                '<span style="color:#e74c3c;font-size:0.85em">⚠ Lỗi kết nối, thử lại sau</span>';
            if (expectedDateEl) expectedDateEl.innerHTML =
                '<span style="color:#e74c3c;font-size:0.85em">⚠ Lỗi kết nối</span>';
        } finally {
            if (summaryContainer) summaryContainer.classList.remove('loading');
        }
    }

    // =====================================================================
    // CHỌN ĐỊA CHỈ GIAO HÀNG TỪ SỔ ĐỊA CHỈ
    // =====================================================================
    function selectShippingAddress(cardEl) {
        if (!cardEl) return;

        // Bỏ active tất cả card
        document.querySelectorAll('.address-item-card').forEach(card => {
            card.classList.remove('border-warning', 'bg-light-subtle');
            const radio = card.querySelector('input[type="radio"]');
            if (radio) radio.checked = false;
        });

        // Active card được chọn
        cardEl.classList.add('border-warning', 'bg-light-subtle');
        const radio = cardEl.querySelector('input[type="radio"]');
        if (radio) radio.checked = true;

        // Lấy dữ liệu từ data-attribute
        const recipientName = cardEl.getAttribute('data-recipient-name') || '';
        const phone         = cardEl.getAttribute('data-phone')          || '';
        const cityStr       = cardEl.getAttribute('data-city')           || '';
        const addressVal    = cardEl.getAttribute('data-address')        || '';
        const provinceId    = cardEl.getAttribute('data-province-id')    || '';
        const districtId    = cardEl.getAttribute('data-district-id')    || '';
        const wardCode      = cardEl.getAttribute('data-ward-code')      || '';

        // Phân tách chuỗi city ("Phường, Quận, Tỉnh")
        const parts = cityStr.split(',').map(s => s.trim());
        let wardText = '', districtText = '', provinceText = '';
        if (parts.length >= 3) {
            wardText     = parts[0];
            districtText = parts[1];
            provinceText = parts.slice(2).join(', ');
        } else if (parts.length === 2) {
            wardText     = parts[0];
            provinceText = parts[1];
        } else {
            provinceText = cityStr;
        }

        // Điền vào form hiển thị (readonly)
        document.getElementById('fullname').value      = recipientName;
        document.getElementById('phone').value         = phone;
        document.getElementById('city').value          = provinceText;
        document.getElementById('district_main').value = districtText;
        document.getElementById('ward').value          = wardText;
        document.getElementById('address').value       = addressVal;

        // Điền hidden inputs để gửi đơn
        document.getElementById('mainProvinceId').value = provinceId;
        document.getElementById('mainDistrictId').value  = districtId;
        document.getElementById('mainWardCode').value    = wardCode;
        document.getElementById('mainAddressId').value   = cardEl.getAttribute('data-id') || '';

        // Tính phí ship theo địa chỉ mới
        callShippingFeeApi(districtId, wardCode);
    }

    // Đăng ký click chọn địa chỉ
    document.querySelectorAll('.address-item-card').forEach(card => {
        card.addEventListener('click', function (e) {
            const isButton = e.target.closest('button');
            const isRadio  = e.target.closest('input[type="radio"]');
            if (isButton) return; // Để button tự xử lý
            if (isRadio) {
                selectShippingAddress(this);
                return;
            }
            selectShippingAddress(this);
        });
    });

    // Tự động fill địa chỉ mặc định (hoặc đầu tiên) khi load trang
    const checkedRadio = document.querySelector('input[name="selectedShippingAddress"]:checked');
    if (checkedRadio) {
        selectShippingAddress(checkedRadio.closest('.address-item-card'));
    } else {
        const firstCard = document.querySelector('.address-item-card');
        if (firstCard) selectShippingAddress(firstCard);
    }

    // =====================================================================
    // GHN API – CÁC HÀM TẢI DROPDOWN (DÙNG TRONG MODAL THÊM/SỬA ĐỊA CHỈ)
    // =====================================================================
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect     = document.getElementById('modalWard');

    const provinceIdInput = document.getElementById('modalProvinceId');
    const districtIdInput = document.getElementById('modalDistrictId');
    const wardCodeInput   = document.getElementById('modalWardCode');
    const cityTextInput   = document.getElementById('modalCityText');

    async function fetchProvinces(selectedId = null) {
        if (!provinceSelect) return;
        try {
            const res     = await fetch(`${GHN_BASE}province`, { method: 'GET', headers: GHN_HEADERS });
            const resData = await res.json();
            if (resData.code === 200) {
                provinceSelect.innerHTML = '<option value="">-- Chọn Tỉnh / Thành Phố --</option>';
                const provinces = resData.data.sort((a, b) => a.ProvinceName.localeCompare(b.ProvinceName, 'vi'));
                provinces.forEach(p => {
                    const opt = new Option(p.ProvinceName, p.ProvinceID);
                    if (selectedId && p.ProvinceID == selectedId) opt.selected = true;
                    provinceSelect.appendChild(opt);
                });
            }
        } catch (err) {
            console.error('Lỗi tải Tỉnh/Thành từ GHN:', err);
        }
    }

    async function fetchDistricts(provinceId, selectedId = null) {
        if (!provinceId || !districtSelect) return;
        try {
            const res     = await fetch(`${GHN_BASE}district`, {
                method: 'POST',
                headers: GHN_HEADERS,
                body: JSON.stringify({ province_id: parseInt(provinceId) })
            });
            const resData = await res.json();
            if (resData.code === 200) {
                districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
                const districts = resData.data.filter(d => !d.DistrictName.includes('Thử nghiệm'));
                districts.forEach(d => {
                    const opt = new Option(d.DistrictName, d.DistrictID);
                    if (selectedId && d.DistrictID == selectedId) opt.selected = true;
                    districtSelect.appendChild(opt);
                });
                districtSelect.disabled = false;
            }
        } catch (err) {
            console.error('Lỗi tải Quận/Huyện từ GHN:', err);
        }
    }

    async function fetchWards(districtId, selectedCode = null) {
        if (!districtId || !wardSelect) return;
        try {
            const res     = await fetch(`${GHN_BASE}ward?district_id=${districtId}`, { method: 'GET', headers: GHN_HEADERS });
            const resData = await res.json();
            if (resData.code === 200) {
                wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
                resData.data.forEach(w => {
                    const opt = new Option(w.WardName, w.WardCode);
                    if (selectedCode && w.WardCode == selectedCode) opt.selected = true;
                    wardSelect.appendChild(opt);
                });
                wardSelect.disabled = false;
            }
        } catch (err) {
            console.error('Lỗi tải Phường/Xã từ GHN:', err);
        }
    }

    // Cascade sự kiện dropdown tỉnh → huyện → xã trong modal
    if (provinceSelect) {
        provinceSelect.addEventListener('change', async function () {
            if (districtSelect) { districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>'; districtSelect.disabled = true; }
            if (wardSelect)     { wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';       wardSelect.disabled = true; }
            if (this.value) await fetchDistricts(this.value);
        });
    }

    if (districtSelect) {
        districtSelect.addEventListener('change', async function () {
            if (wardSelect) { wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>'; wardSelect.disabled = true; }
            if (this.value) await fetchWards(this.value);
        });
    }

    // Tải tỉnh thành lần đầu cho modal
    fetchProvinces();

    // =====================================================================
    // MODAL THÊM / SỬA ĐỊA CHỈ
    // =====================================================================
    const modal            = document.getElementById('modal-address');
    const overlay          = document.getElementById('menu-overlay');
    const btnAddAddress    = document.getElementById('btnAddAddress');
    const closeAddressModal= document.getElementById('closeAddressModal');
    const btnCancelAddress = document.getElementById('btnCancelAddress');
    const btnSaveAddress   = document.getElementById('btnSaveAddress');
    const addressForm      = document.getElementById('addressForm');
    const modalTitle       = document.getElementById('modalTitle');
    const actionInput      = document.getElementById('action');
    const addressIdInput   = document.getElementById('addressId');

    function openModal() {
        if (modal)   modal.classList.add('active');
        if (overlay) overlay.classList.add('active');
    }

    function closeModal() {
        if (modal)   modal.classList.remove('active');
        if (overlay) overlay.classList.remove('active');
        resetModalForm();
    }

    function resetModalForm() {
        if (addressForm) addressForm.reset();
        if (districtSelect) { districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>'; districtSelect.disabled = true; }
        if (wardSelect)     { wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';       wardSelect.disabled = true; }
        if (actionInput)    actionInput.value = 'create';
        if (addressIdInput) addressIdInput.value = '';
    }

    if (closeAddressModal) closeAddressModal.addEventListener('click', closeModal);
    if (btnCancelAddress)  btnCancelAddress.addEventListener('click', closeModal);
    if (overlay) overlay.addEventListener('click', function (e) {
        // Chỉ đóng khi click đúng overlay, không phải phần tử bên trong
        if (e.target === overlay) closeModal();
    });

    if (btnAddAddress) {
        btnAddAddress.addEventListener('click', function () {
            resetModalForm();
            if (actionInput)  actionInput.value = 'create';
            if (modalTitle)   modalTitle.textContent = 'Thêm Địa Chỉ Mới';
            openModal();
        });
    }

    // Hàm sửa địa chỉ (gọi từ nút Sửa trên mỗi card)
    window.editAddress = async function (addrId) {
        const cardEl = document.querySelector(`.address-item-card[data-id="${addrId}"]`);
        if (!cardEl) {
            window.location.href = `${path}/address?action=edit&id=${addrId}`;
            return;
        }

        const recipientName = cardEl.getAttribute('data-recipient-name') || '';
        const phone         = cardEl.getAttribute('data-phone')          || '';
        const addressValue  = cardEl.getAttribute('data-address')        || '';
        const isDefault     = cardEl.classList.contains('border-warning');
        const pId           = cardEl.getAttribute('data-province-id');
        const dId           = cardEl.getAttribute('data-district-id');
        const wCode         = cardEl.getAttribute('data-ward-code');

        const recipientEl = document.getElementById('recipientName');
        const phoneEl     = document.getElementById('phoneInput');
        const addressEl   = document.getElementById('addressInput');
        const defaultEl   = document.getElementById('isDefault');

        if (recipientEl) recipientEl.value = recipientName;
        if (phoneEl)     phoneEl.value     = phone;
        if (addressEl)   addressEl.value   = addressValue;
        if (defaultEl)   defaultEl.checked = isDefault;

        if (actionInput)    actionInput.value    = 'edit';
        if (addressIdInput) addressIdInput.value = addrId;
        if (modalTitle)     modalTitle.textContent = 'Chỉnh Sửa Địa Chỉ';

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

    // Hàm xóa địa chỉ
    window.deleteAddress = function (addrId) {
        if (!confirm('Bạn chắc chắn muốn xóa địa chỉ này?')) return;
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `${path}/address`;
        form.innerHTML = `
            <input type="hidden" name="action"    value="delete">
            <input type="hidden" name="addressId" value="${addrId}">
            <input type="hidden" name="redirect"  value="checkout">
        `;
        document.body.appendChild(form);
        form.submit();
    };

    // Hàm đặt địa chỉ mặc định
    window.setDefault = function (addrId) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `${path}/address`;
        form.innerHTML = `
            <input type="hidden" name="action"    value="setDefault">
            <input type="hidden" name="addressId" value="${addrId}">
            <input type="hidden" name="redirect"  value="checkout">
        `;
        document.body.appendChild(form);
        form.submit();
    };

    // Lưu địa chỉ (validate + submit form modal)
    if (btnSaveAddress) {
        btnSaveAddress.addEventListener('click', function () {
            const recipientName = (document.getElementById('recipientName')?.value || '').trim();
            const phone         = (document.getElementById('phoneInput')?.value    || '').trim();
            const address       = (document.getElementById('addressInput')?.value  || '').trim();

            if (!recipientName) { alert('Vui lòng nhập tên người nhận!'); return; }
            if (!phone)         { alert('Vui lòng nhập số điện thoại!'); return; }
            if (phone.length < 10 || phone.length > 20) { alert('Số điện thoại phải từ 10 đến 20 ký tự!'); return; }

            if (!provinceSelect?.value || !districtSelect?.value || !wardSelect?.value) {
                alert('Vui lòng chọn đầy đủ Tỉnh/Thành, Quận/Huyện, Phường/Xã!');
                return;
            }

            if (!address)          { alert('Vui lòng nhập địa chỉ chi tiết!'); return; }
            if (address.length < 5) { alert('Địa chỉ chi tiết phải có ít nhất 5 ký tự!'); return; }

            if (provinceIdInput) provinceIdInput.value = provinceSelect.value;
            if (districtIdInput) districtIdInput.value = districtSelect.value;
            if (wardCodeInput)   wardCodeInput.value   = wardSelect.value;

            const pText = provinceSelect.options[provinceSelect.selectedIndex].text;
            const dText = districtSelect.options[districtSelect.selectedIndex].text;
            const wText = wardSelect.options[wardSelect.selectedIndex].text;
            if (cityTextInput) cityTextInput.value = `${wText}, ${dText}, ${pText}`;

            addressForm.submit();
        });
    }

    const applyVoucherBtn = document.getElementById('btn-apply-voucher');
    if (applyVoucherBtn) {
        applyVoucherBtn.addEventListener('click', function () {
            const btn    = this;
            const code   = document.getElementById('voucher-input').value.trim().toUpperCase();
            const msgEl  = document.getElementById('voucher-msg');

            appliedVoucherCode   = '';
            appliedDiscountAmount = 0;
            updateTotalDisplay(0);
            msgEl.className = '';
            msgEl.innerHTML = '';

            if (!code) {
                msgEl.className = 'error-msg';
                msgEl.innerText = 'Vui lòng nhập mã giảm giá.';
                return;
            }

            const orderTotal = parseFloat(document.getElementById('final-total').getAttribute('data-original') || '0');
            btn.disabled   = true;
            btn.innerText  = 'Đang kiểm tra...';

            const params = new URLSearchParams({ code, orderTotal });
            fetch('api/voucher/validate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
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
    }

    const voucherInput = document.getElementById('voucher-input');
    if (voucherInput) {
        voucherInput.addEventListener('input', function () {
            if (appliedVoucherCode) {
                appliedVoucherCode    = '';
                appliedDiscountAmount = 0;
                updateTotalDisplay(0);
                const msgEl = document.getElementById('voucher-msg');
                msgEl.className = '';
                msgEl.innerHTML = '';
            }
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
            const code = this.getAttribute('data-code');
            if (voucherInput) voucherInput.value = code;
            walletPopup.classList.remove('show');
            setTimeout(() => walletPopup.style.display = 'none', 300);
            if (applyVoucherBtn) applyVoucherBtn.click();
        });
    });

    const orderBtn = document.getElementById('btn-dat-hang');
    if (orderBtn) {
        orderBtn.addEventListener('click', function () {
            if (!validateForm()) return;

            const btn = this;
            btn.disabled  = true;
            btn.innerText = 'Đang xử lý...';
            btn.classList.add('loading');

            const selectedPayment = document.querySelector('input[name="payment"]:checked').value;

            const params = new URLSearchParams({
                fullName:      document.getElementById('fullname').value.trim(),
                phone:         document.getElementById('phone').value.trim(),
                city:          document.getElementById('district_main').value.trim() + ', ' + document.getElementById('city').value.trim(),
                ward:          document.getElementById('ward').value.trim(),
                address:       document.getElementById('address').value.trim(),
                notes:         document.getElementById('notes').value.trim(),
                voucherCode:   appliedVoucherCode,
                paymentMethod: selectedPayment,
                provinceId:    document.getElementById('mainProvinceId').value.trim(),
                districtId:    document.getElementById('mainDistrictId').value.trim(),
                wardCode:      document.getElementById('mainWardCode').value.trim(),
                addressId:     document.getElementById('mainAddressId').value.trim()
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
                        popup.style.display   = 'flex';
                        popup.style.opacity   = '1';
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
    }

    const popupClose = document.getElementById('popup-close');
    if (popupClose) popupClose.addEventListener('click', () => { window.location.href = 'home'; });

    const popupFailClose = document.getElementById('popup-fail-close');
    if (popupFailClose) popupFailClose.addEventListener('click', () => { window.location.href = 'home'; });

    // =====================================================================
    // HẬU XỬ LÝ VNPAY (callback sau thanh toán)
    // =====================================================================
    const urlParams   = new URLSearchParams(window.location.search);
    const vnpayStatus = urlParams.get('vnpay');
    const orderId     = urlParams.get('orderId');

    if (vnpayStatus === 'success') {
        const popup = document.getElementById('success-popup');
        if (popup) {
            popup.style.display = 'flex';
            setTimeout(() => popup.classList.add('show'), 10);
            setTimeout(() => { window.location.href = 'order-detail-success?id=' + orderId; }, 2500);
        }
    } else if (vnpayStatus === 'cancel') {
        const popup = document.getElementById('fail-popup');
        if (popup) {
            popup.style.display = 'flex';
            setTimeout(() => popup.classList.add('show'), 10);
            setTimeout(() => { window.location.href = 'home'; }, 3500);
        }
    }

});
