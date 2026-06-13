document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById('modal-address');
    const overlay = document.getElementById('menu-overlay');
    const btnAddAddress = document.getElementById('btnAddAddress');
    const closeAddressModal = document.getElementById('closeAddressModal');
    const btnCancelAddress = document.getElementById('btnCancelAddress');
    const btnSaveAddress = document.getElementById('btnSaveAddress');
    const addressForm = document.getElementById('addressForm');
    const modalTitle = document.getElementById('modalTitle');
    const action = document.getElementById('action');
    const addressId = document.getElementById('addressId');

    // --- CẤU HÌNH API GIAO HÀNG NHANH (GHN) ---
    const GHN_TOKEN = 'dffec2e1-6725-11f1-a973-aee5264794df';
    const BASE_URL = 'https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/';
    const path = window.location.pathname.includes('/address') ? window.location.pathname.replace(/\/address.*$/, '') : '';

    const headers = {
        'Content-Type': 'application/json',
        'Token': GHN_TOKEN
    };

    // Khai báo các thành phần DOM địa chỉ mới
    const provinceSelect = document.getElementById('province');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');

    const provinceIdInput = document.getElementById('provinceId');
    const districtIdInput = document.getElementById('districtId');
    const wardCodeInput = document.getElementById('wardCode');
    const cityTextInput = document.getElementById('cityText');

    // --- HÀM BỔ TRỢ GỌI API GHN (Hỗ trợ Async/Await) ---

    // 1. Tải danh sách Tỉnh/Thành phố
    async function fetchProvinces(selectedId = null) {
        try {
            const response = await fetch(`${BASE_URL}province`, { method: 'GET', headers: headers });
            const resData = await response.json();
            if (resData.code === 200) {
                provinceSelect.innerHTML = '<option value="">-- Chọn Tỉnh / Thành Phố --</option>';
                // Sắp xếp theo bảng chữ cái mới nhất
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
                // Lọc bỏ các dữ liệu thử nghiệm rác (nếu có) trên hệ thống dev
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

    // 3. Tải danh sách Phường/Xã dựa trên DistrictID (Luôn lấy địa giới cập nhật sau sáp nhập 2025)
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

    fetchProvinces();

    if (btnAddAddress) {
        btnAddAddress.addEventListener('click', function () {
            resetForm();
            action.value = 'create';
            modalTitle.textContent = 'Thêm Địa Chỉ Mới';
            openModal();
        });
    }

    // sửa địa chỉ
    window.editAddress = async function (addrId) {
        const addressItem = document.querySelector(`.address-item[data-id="${addrId}"]`);
        if (!addressItem) {
            window.location.href = `${path}/address?action=edit&id=${addrId}`;
            return;
        }

        const recipientName = addressItem.querySelector('.address-info-value-name')?.textContent.trim() || '';
        const phone = addressItem.querySelector('.address-info-value-phone')?.textContent.trim() || '';
        const addressValue = addressItem.querySelector('.address-info-value-address')?.textContent.trim() || '';
        const isDefaultBadge = addressItem.querySelector('.address-default');

        const pId = addressItem.getAttribute('data-province-id');
        const dId = addressItem.getAttribute('data-district-id');
        const wCode = addressItem.getAttribute('data-ward-code');

        document.getElementById('recipientName').value = recipientName;
        document.getElementById('phone').value = phone;
        document.getElementById('address').value = addressValue;
        document.getElementById('isDefault').checked = !!isDefaultBadge;

        action.value = 'edit';
        addressId.value = addrId;
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

    // xóa / mặc định
    window.deleteAddress = function (addrId) {
        if (confirm('Bạn chắc chắn muốn xóa địa chỉ này?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = `${path}/address`;

            form.innerHTML = `
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="addressId" value="${addrId}">
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
        `;

        document.body.appendChild(form);
        form.submit();
    };

    //
    function openModal() {
        modal.classList.add('active');
        overlay.classList.add('active');
    }

    function closeModal() {
        modal.classList.remove('active');
        overlay.classList.remove('active');
        resetForm();
    }

    function resetForm() {
        addressForm.reset();
        districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
        districtSelect.disabled = true;
        wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
        wardSelect.disabled = true;
        action.value = 'create';
        addressId.value = '';
    }

    if (closeAddressModal) closeAddressModal.addEventListener('click', closeModal);
    if (btnCancelAddress) btnCancelAddress.addEventListener('click', closeModal);
    if (overlay) overlay.addEventListener('click', closeModal);

    //
    if (btnSaveAddress) {
        btnSaveAddress.addEventListener('click', function () {
            const recipientName = document.getElementById('recipientName').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const address = document.getElementById('address').value.trim();

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

    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transition = 'opacity 0.3s ease';
            setTimeout(() => {
                alert.style.display = 'none';
            }, 300);
        }, 5000);
    });
});