// profile.js

function showTab(tabId) {
    // 1. Ẩn tất cả nội dung tab
    const contents = document.querySelectorAll('.tab-content');
    contents.forEach(content => {
        content.classList.remove('active');
    });

    // 2. Bỏ trạng thái 'active' khỏi tất cả menu links
    const navLinks = document.querySelectorAll('.side-menu .nav-list a');
    navLinks.forEach(link => {
        link.classList.remove('active');
    });

    // 3. Hiển thị tab nội dung được chọn
    const activeContent = document.getElementById(tabId);
    if (activeContent) {
        activeContent.classList.add('active');
    }

    // 4. Đặt trạng thái 'active' cho menu item được click
    const clickedLink = event.target.closest('.nav-link');
    if (clickedLink) {
        clickedLink.classList.add('active');
    }

}

// HÀM MỚI ĐỂ CHUYỂN ĐỔI MENU MOBILE
function toggleMobileMenu() {
    const sideMenu = document.getElementById('sideMenuContent');
    if (sideMenu.classList.contains('mobile-hidden')) {
        sideMenu.classList.remove('mobile-hidden');
        sideMenu.classList.add('mobile-visible');
    } else {
        sideMenu.classList.remove('mobile-visible');
        sideMenu.classList.add('mobile-hidden');
    }
}

document.addEventListener("DOMContentLoaded", function () {
    // --- KHAI BÁO BIẾN ---
    const btnOpenEdit = document.getElementById('btnOpenEdit');
    const modal = document.getElementById('modal-edit-profile');
    const overlay = document.getElementById('menu-overlay'); // Dùng lại overlay cũ
    const btnCloseIcon = document.getElementById('closeIcon');
    const btnCancel = document.getElementById('btnCancel');
    const btnSave = document.getElementById('btnSave');

    // Biến cho phần Upload ảnh
    const imageUpload = document.getElementById('imageUpload');
    const avatarPreview = document.getElementById('avatarPreview');
    const mainAvatar = document.querySelector('.img-profile'); // Ảnh ở sidebar

    // --- HÀM XỬ LÝ ---

    // 1. Mở Modal
    function openModal() {
        modal.classList.add('active');
        overlay.classList.add('active'); // Hiện overlay nền tối
    }

    // 2. Đóng Modal
    function closeModal() {
        modal.classList.remove('active');
        overlay.classList.remove('active'); // Ẩn overlay
    }

    // --- GÁN SỰ KIỆN ---

    if (btnOpenEdit) btnOpenEdit.addEventListener('click', openModal);
    if (btnCloseIcon) btnCloseIcon.addEventListener('click', closeModal);
    if (btnCancel) btnCancel.addEventListener('click', closeModal);

    // Đóng khi click ra ngoài (click vào overlay)
    if (overlay) overlay.addEventListener('click', closeModal);

    // 3. Xử lý xem trước ảnh (Preview Image)
    if (imageUpload) {
        imageUpload.addEventListener('change', function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    // Gán ảnh mới vào thẻ img trong modal
                    avatarPreview.src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        });
    }

    // 4. Xử lý nút Lưu (Giả lập)
    if (btnSave) {
        btnSave.addEventListener('click', function () {
            // Lấy giá trị từ input
            const newName = document.getElementById('editName').value;
            const newPhone = document.getElementById('editPhone').value;

            // Cập nhật ra ngoài giao diện chính (Demo)
            document.querySelector('.user-name').innerText = "Chào, " + newName;
            document.getElementById('fullName').value = newName;
            document.getElementById('phone').value = newPhone;

            // Cập nhật avatar chính nếu có thay đổi
            if (avatarPreview.src !== mainAvatar.src) {
                mainAvatar.src = avatarPreview.src;
            }

            alert("Đã lưu thông tin thành công!");
            closeModal();
        });
    }
});

document.addEventListener('DOMContentLoaded', () => {


    const hamburgerIcon = document.getElementById('hamburger-icon');
    const closeButton = document.getElementById('mobile-menu-close');
    const mobileMenu = document.getElementById('mobile-menu-container');
    const overlay = document.getElementById('menu-overlay');

    // Hàm mở menu
    function openMenu() {
        mobileMenu.classList.add('open');
        overlay.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    // Hàm đóng menu
    function closeMenu() {
        mobileMenu.classList.remove('open');
        overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    // Gán sự kiện
    if (hamburgerIcon) {
        hamburgerIcon.addEventListener('click', openMenu);
    }
    if (closeButton) {
        closeButton.addEventListener('click', closeMenu);
    }
    if (overlay) {
        overlay.addEventListener('click', closeMenu);
    }

    // Tự động đóng menu khi resize lên desktop
    window.addEventListener('resize', () => {
        if (window.innerWidth > 991 && mobileMenu.classList.contains('open')) {
            closeMenu();
        }
    });
    // XỬ LÝ ĐĂNG XUẤT
    function performLogout() {
        try {

            localStorage.removeItem('authToken');
            sessionStorage.removeItem('authToken');
        } catch (e) { }

        window.location.href = '/login.jsp';
    }

    const logoutTop = document.getElementById('logoutTop');
    const logoutBtn = document.getElementById('logoutBtn');
    if (logoutTop) {
        logoutTop.addEventListener('click', (e) => {
            e.preventDefault();
            performLogout();
        });
    }
    if (logoutBtn) {
        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            performLogout();
        });
    }
    // top-nav logout links (multiple pages)
    const navLogoutLinks = document.querySelectorAll('.nav-logout-link');
    if (navLogoutLinks.length) {
        navLogoutLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                performLogout();
            });
        });
    }
});

document.addEventListener('DOMContentLoaded', function() {
    const btnSave = document.getElementById('btnSave');
    const editForm = document.getElementById('editForm');

    if (btnSave && editForm) {
        btnSave.addEventListener('click', function(e) {
            e.preventDefault();
            console.log("Nút Lưu đã được nhấn, đang submit form...");
            editForm.submit();
        });
    } else {
        console.error("Không tìm thấy nút btnSave hoặc form editForm trong trang này!");
    }
});

