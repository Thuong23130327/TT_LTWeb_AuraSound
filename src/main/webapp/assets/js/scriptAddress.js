
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

    if (btnAddAddress) {
        btnAddAddress.addEventListener('click', function () {
            resetForm();
            action.value = 'create';
            modalTitle.textContent = 'Thêm Địa Chỉ Mới';
            openModal();
        });
    }

    window.editAddress = function (addrId) {
        const addressItem = document.querySelector(`.address-item[data-id="${addrId}"]`);
        console.log("test", addressItem);
        if (!addressItem) {

            window.location.href = `${path}/address?action=edit&id=${addrId}`;
            console.warn(`Không tìm thấy phần tử địa chỉ với id ${addrId}, đang chuyển hướng để chỉnh sửa.`);
            return;
        }
        console.log("Đã tìm thấy phần tử địa chỉ:", addressItem);
        const recipientName = addressItem.querySelector('.address-info-value-name')?.textContent || '';
        const phone = addressItem.querySelector('.address-info-value-phone')?.textContent || '';
        const city = addressItem.querySelector('.address-info-value-city')?.textContent || '';
        const addressValue = addressItem.querySelector('.address-info-value-addr')?.textContent || '';
        const isDefaultBadge = addressItem.querySelector('.address-default');

        document.getElementById('recipientName').value = recipientName;
        document.getElementById('phone').value = phone;
        document.getElementById('city').value = city;
        document.getElementById('address').value = addressValue;
        document.getElementById('isDefault').checked = !!isDefaultBadge;

        action.value = 'edit';
        addressId.value = addrId;
        modalTitle.textContent = 'Chỉnh Sửa Địa Chỉ';

        openModal();
    };

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
        action.value = 'create';
        addressId.value = '';
    }

    if (closeAddressModal) {
        closeAddressModal.addEventListener('click', closeModal);
    }

    if (btnCancelAddress) {
        btnCancelAddress.addEventListener('click', closeModal);
    }

    if (overlay) {
        overlay.addEventListener('click', closeModal);
    }

    if (btnSaveAddress) {
        btnSaveAddress.addEventListener('click', function () {

            const recipientName = document.getElementById('recipientName').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const address = document.getElementById('address').value.trim();
            const city = document.getElementById('city').value.trim();

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

            if (!city) {
                alert('Vui lòng chọn tỉnh/thành phố!');
                return;
            }

            if (!address) {
                alert('Vui lòng nhập địa chỉ chi tiết!');
                return;
            }

            if (address.length < 5) {
                alert('Địa chỉ phải có ít nhất 5 ký tự!');
                return;
            }


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
