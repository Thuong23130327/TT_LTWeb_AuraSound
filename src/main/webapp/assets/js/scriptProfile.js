// profile.js


function showTab(tabId) {
    const contents = document.querySelectorAll('.tab-content');
    contents.forEach(content => content.classList.remove('active'));

    const navLinks = document.querySelectorAll('.side-menu .nav-list a');
    navLinks.forEach(link => link.classList.remove('active'));

    const activeContent = document.getElementById(tabId);
    if (activeContent) activeContent.classList.add('active');

    const clickedLink = event.target.closest('.nav-link');
    if (clickedLink) clickedLink.classList.add('active');
}

function toggleMobileMenu() {
    const sideMenu = document.getElementById('sideMenuContent');
    if (!sideMenu) return;
    if (sideMenu.classList.contains('mobile-hidden')) {
        sideMenu.classList.remove('mobile-hidden');
        sideMenu.classList.add('mobile-visible');
    } else {
        sideMenu.classList.remove('mobile-visible');
        sideMenu.classList.add('mobile-hidden');
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const btnOpenEdit = document.getElementById('btnOpenEdit');
    const modal       = document.getElementById('modal-edit-profile');
    const overlay     = document.getElementById('menu-overlay');
    const btnCloseIcon = document.getElementById('closeIcon');
    const btnCancel   = document.getElementById('btnCancel');
    const btnSave     = document.getElementById('btnSave');
    const imageUpload = document.getElementById('imageUpload');
    const avatarPreview = document.getElementById('avatarPreview');

    function openModal()  { if (modal) modal.classList.add('active');    if (overlay) overlay.classList.add('active'); }
    function closeModal() { if (modal) modal.classList.remove('active'); if (overlay) overlay.classList.remove('active'); }

    if (btnOpenEdit)  btnOpenEdit.addEventListener('click', openModal);
    if (btnCloseIcon) btnCloseIcon.addEventListener('click', closeModal);
    if (btnCancel)    btnCancel.addEventListener('click', closeModal);
    if (overlay)      overlay.addEventListener('click', closeModal);

    if (imageUpload) {
        imageUpload.addEventListener('change', function (event) {
            const file = event.target.files[0];
            if (file && avatarPreview) {
                const reader = new FileReader();
                reader.onload = function (e) { avatarPreview.src = e.target.result; };
                reader.readAsDataURL(file);
            }
        });
    }

    if (btnSave) {
        btnSave.addEventListener('click', function () {
            const newName  = document.getElementById('editName')  ? document.getElementById('editName').value  : '';
            const newPhone = document.getElementById('editPhone') ? document.getElementById('editPhone').value : '';

            if (!newName || newName.trim().length < 2) {
                alert("Họ tên phải có ít nhất 2 ký tự!"); return;
            }
            if (!newPhone || newPhone.trim().length < 10) {
                alert("Số điện thoại không hợp lệ!"); return;
            }

            const editForm = document.getElementById('editForm');
            if (editForm) editForm.submit();
        });
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const hamburgerIcon = document.getElementById('hamburger-icon');
    const closeButton   = document.getElementById('mobile-menu-close');
    const mobileMenu    = document.getElementById('mobile-menu-container');
    const overlay       = document.getElementById('menu-overlay');

    function openMenu() {
        if (mobileMenu) mobileMenu.classList.add('open');
        if (overlay)    overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeMenu() {
        if (mobileMenu) mobileMenu.classList.remove('open');
        if (overlay)    overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    if (hamburgerIcon) hamburgerIcon.addEventListener('click', openMenu);
    if (closeButton)   closeButton.addEventListener('click', closeMenu);
    if (overlay)       overlay.addEventListener('click', closeMenu);

    window.addEventListener('resize', () => {
        if (window.innerWidth > 991 && mobileMenu && mobileMenu.classList.contains('open')) {
            closeMenu();
        }
    });

    function performLogout() {
        try {
            localStorage.removeItem('authToken');
            sessionStorage.removeItem('authToken');
        } catch (e) {}
        window.location.href = '/login.jsp';
    }

    const logoutTop = document.getElementById('logoutTop');
    const logoutBtn = document.getElementById('logoutBtn');
    if (logoutTop) logoutTop.addEventListener('click', (e) => { e.preventDefault(); performLogout(); });
    if (logoutBtn) logoutBtn.addEventListener('click', (e) => { e.preventDefault(); performLogout(); });

    document.querySelectorAll('.nav-logout-link').forEach(link => {
        link.addEventListener('click', (e) => { e.preventDefault(); performLogout(); });
    });
});


document.addEventListener('DOMContentLoaded', function () {
    const ctxPath = (typeof window.ctxPath !== 'undefined') ? window.ctxPath : '';

    let pendingCancelOrderId = null;

    document.querySelectorAll('.btn-cancel-order').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            pendingCancelOrderId = this.getAttribute('data-id');

            const cancelModal = document.getElementById('cancelOrderModal');
            if (cancelModal && typeof bootstrap !== 'undefined') {
                const bsModal = new bootstrap.Modal(cancelModal);
                bsModal.show();
            } else {
                // Fallback
                if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?')) {
                    doConfirmCancel(pendingCancelOrderId);
                }
            }
        });
    });

    const btnConfirmCancel = document.getElementById('btnConfirmCancel');
    if (btnConfirmCancel) {
        btnConfirmCancel.addEventListener('click', function () {
            if (pendingCancelOrderId) doConfirmCancel(pendingCancelOrderId);
        });
    }

    function doConfirmCancel(orderId) {
        fetch(ctxPath + '/api/cancel-order', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'orderId=' + orderId
        })
        .then(res => res.json())
        .then(data => {
            const cancelModal = document.getElementById('cancelOrderModal');
            if (cancelModal && typeof bootstrap !== 'undefined') {
                const bsModal = bootstrap.Modal.getInstance(cancelModal);
                if (bsModal) bsModal.hide();
            }
            if (data.status === 'success') {
                showToast('Đơn hàng đã được hủy thành công!', 'success');
                setTimeout(() => window.location.reload(), 1200);
            } else {
                showToast(data.message || 'Hủy đơn hàng thất bại.', 'error');
            }
        })
        .catch(err => {
            console.error(err);
            showToast('Lỗi kết nối. Vui lòng thử lại.', 'error');
        });
    }

    document.querySelectorAll('.btn-buy-again').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const orderId      = this.getAttribute('data-id');
            const originalText = this.innerText;
            const self         = this;
            this.innerText  = 'Đang xử lý...';
            this.disabled   = true;

            fetch(ctxPath + '/api/buy-again', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'orderId=' + orderId
            })
            .then(res => res.json())
            .then(data => {
                if (data.status === 'success') {
                    // Chuyển sang cart, param buyAgain=true sẽ tick tất cả checkbox
                    window.location.href = ctxPath + '/cart?buyAgain=true';
                } else {
                    showToast(data.message || 'Thêm vào giỏ hàng thất bại.', 'error');
                    self.innerText = originalText;
                    self.disabled  = false;
                }
            })
            .catch(err => {
                console.error(err);
                showToast('Lỗi kết nối. Vui lòng thử lại.', 'error');
                self.innerText = originalText;
                self.disabled  = false;
            });
        });
    });

    document.querySelectorAll('.btn-open-review').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const productId   = this.getAttribute('data-product-id');
            const productName = this.getAttribute('data-product-name');
            const orderId     = this.getAttribute('data-order-id');

            const reviewProductIdInput = document.getElementById('reviewProductId');
            const reviewOrderIdInput   = document.getElementById('reviewOrderId');
            const reviewProductTitle   = document.getElementById('reviewProductTitle');

            if (reviewProductIdInput) reviewProductIdInput.value = productId || '';
            if (reviewOrderIdInput)   reviewOrderIdInput.value   = orderId   || '';
            if (reviewProductTitle)   reviewProductTitle.textContent = productName || 'Sản phẩm';

            // Reset form đánh giá khi mở lại
            const reviewForm = document.getElementById('reviewForm');
            if (reviewForm) reviewForm.reset();

            const reviewModal = document.getElementById('reviewModal');
            if (reviewModal && typeof bootstrap !== 'undefined') {
                const bsModal = new bootstrap.Modal(reviewModal);
                bsModal.show();
            }
        });
    });
});

function showToast(message, type) {
    let container = document.getElementById('profileToastContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'profileToastContainer';
        container.style.cssText = 'position:fixed;top:20px;right:20px;z-index:9999;display:flex;flex-direction:column;gap:8px;';
        document.body.appendChild(container);
    }

    const toast   = document.createElement('div');
    const bgColor = type === 'success' ? '#28a745' : '#dc3545';
    const icon    = type === 'success' ? '&#10003;' : '&#10007;';
    toast.style.cssText = `background:${bgColor};color:#fff;padding:12px 20px;border-radius:8px;font-size:14px;font-weight:500;box-shadow:0 4px 12px rgba(0,0,0,0.15);display:flex;align-items:center;gap:10px;min-width:260px;animation:slideInRight 0.3s ease;`;
    toast.innerHTML = `<span style="font-size:18px;">${icon}</span><span>${message}</span>`;
    container.appendChild(toast);

    setTimeout(() => {
        toast.style.animation = 'fadeOutRight 0.3s ease forwards';
        setTimeout(() => toast.remove(), 300);
    }, 2500);
}

(function () {
    if (document.getElementById('profileToastCSS')) return;
    const style = document.createElement('style');
    style.id = 'profileToastCSS';
    style.textContent = `
        @keyframes slideInRight  { from { transform:translateX(110%); opacity:0; } to { transform:translateX(0); opacity:1; } }
        @keyframes fadeOutRight  { from { opacity:1; transform:translateX(0); }     to { opacity:0; transform:translateX(110%); } }
    `;
    document.head.appendChild(style);
})();
