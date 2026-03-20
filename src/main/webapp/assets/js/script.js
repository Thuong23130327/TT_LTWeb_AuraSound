document.addEventListener("DOMContentLoaded", function () {

    // --- KHAI BÁO CÁC PHẦN TỬ CHUNG ---
    const mybutton = document.getElementById("back-top-btn");
    const hamburgerIcon = document.getElementById('hamburger-icon');
    const mobileMenu = document.getElementById('mobile-menu-container');
    const overlay = document.getElementById('menu-overlay');
    const allCloseIcons = document.querySelectorAll('.bi-x-lg');

    // Các phần tử liên quan đến Popup
    const btnDatHang = document.getElementById('btn-dat-hang');
    const cartBtn = document.getElementById('cart-btn');
    const successPopup = document.getElementById('success-popup');

    // Thêm: Lấy phần tử nội dung popup để chặn propagation
    // Lưu ý: Chỉ cần nếu bạn muốn chặn click nội dung bên trong Popup
    const popupContent = document.querySelector('#success-popup .popup-content');


    // --- 1. CHỨC NĂNG BACK-TO-TOP ---

    window.onscroll = function () {
        scrollFunction();
    };

    function scrollFunction() {
        if (!mybutton) return;
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            mybutton.style.display = "block";
        } else {
            mybutton.style.display = "none";
        }
    }

    // --- 2. HÀM XỬ LÝ POPUP ĐẶT HÀNG ---

    function openPopup() {
        if (successPopup) {
            successPopup.classList.add('show');
            overlay.classList.add('active');
        }
    }

    function closePopup() {
        if (successPopup) {
            successPopup.classList.remove('show');
            if (!(mobileMenu && mobileMenu.classList.contains('active'))) {
                overlay.classList.remove('active');
            }
        }
    }

    // --- 3. HÀM XỬ LÝ MENU MOBILE ---

    function openMenu() {
        mobileMenu.classList.add('active');
        overlay.classList.add('active');
    }

    function closeMenu() {
        if (mobileMenu) {
            mobileMenu.classList.remove('active');
            if (!(successPopup && successPopup.classList.contains('show'))) {
                overlay.classList.remove('active');
            }
        }
    }


    // --- 4. GÁN SỰ KIỆN TƯƠNG TÁC (Listeners) ---

    // Mở Menu khi click Hamburger
    if (hamburgerIcon) {
        hamburgerIcon.addEventListener('click', openMenu);
    }

    // Nút Đặt hàng mở Popup (trang checkout.jsp)
    if (btnDatHang) {
        btnDatHang.addEventListener('click', openPopup);
    }

    // Nút Thêm vào giỏ hàng mở Popup (trang sproduct.jsp) <--- ĐÃ THÊM LISTENER
    if (cartBtn) {
        cartBtn.addEventListener('click', openPopup);
    }

    // Xử lý TẤT CẢ các icon đóng (class: .bi-x-lg)
    allCloseIcons.forEach(icon => {
        icon.addEventListener('click', function (event) {
            event.stopPropagation();
            const parentPopup = event.target.closest('#success-popup');
            const parentMenu = event.target.closest('#mobile-menu-container');

            if (parentPopup) {
                closePopup();
            }
            if (parentMenu) {
                closeMenu();
            }
        });
    });

    // A. Xử lý click vào nền xám của Popup (đóng Popup)
    if (successPopup) {
        successPopup.addEventListener('click', function (event) {
            // Kiểm tra: Nếu click đích danh vào container ngoài (tức là nền xám của Popup)
            if (event.target === successPopup || event.target === overlay) {
                if (successPopup.classList.contains('show')) {
                    closePopup();
                }
            }
        });
    }

    // B. Xử lý click vào Overlay (đóng Menu Mobile)
    if (overlay) {
        overlay.addEventListener('click', function (event) {
            // Nếu Popup không mở, và Menu đang mở -> Đóng Menu
            if (!(successPopup && successPopup.classList.contains('show')) && mobileMenu && mobileMenu.classList.contains('active')) {
                closeMenu();
            }
        });
    }

    // --- 6. LOGIC THANH SEARCH BAR ---
    const searchBar = document.querySelector('.searchBar');
    const searchIcon = document.querySelector('.searchBar i.bi-search');

    if (searchIcon) {
        searchIcon.addEventListener('click', () => {
            searchBar.classList.toggle('active');
        });
    }


    // --- LOGIC SLIDESHOW ---

    const slidesTrack = document.querySelector('.slideshow-container .slides-track');
    const slides = document.querySelectorAll('.slideshow-container .slide');
    const dots = document.querySelectorAll('.slideshow-container .dot');
    const container = document.querySelector('.slideshow-container');
    let current = 0;
    const total = slides.length;
    const intervalMs = 5000; // 5s
    let autoSlide;

    function goTo(idx) {
        if (!slidesTrack) return;
        idx = (idx + total) % total;
        slidesTrack.style.transform = `translateX(-${idx * 100}%)`;
        dots.forEach((d, i) => d.classList.toggle('active', i === idx));
        current = idx;
    }

    function next() {
        goTo(current + 1);
    }

    function prev() {
        goTo(current - 1);
    }


    const btns = document.querySelectorAll('.slideshow-container .slide-btn');
    btns.forEach(btn => {
        if (btn.classList.contains('next')) {
            btn.addEventListener('click', () => {
                next();
                resetTimer();
            });
        } else if (btn.classList.contains('prev')) {
            btn.addEventListener('click', () => {
                prev();
                resetTimer();
            });
        }
    });
    dots.forEach((dot, i) => dot.addEventListener('click', () => {
        goTo(i);
        resetTimer();
    }));

    function startTimer() {
        autoSlide = setInterval(next, intervalMs);
    }

    function stopTimer() {
        clearInterval(autoSlide);
    }

    function resetTimer() {
        stopTimer();
        startTimer();
    }

    if (container) {
        container.addEventListener('mouseenter', stopTimer);
        container.addEventListener('mouseleave', startTimer);
    }

    if (slides.length > 0) {
        goTo(0);
        startTimer();
    }
});
function backTop() {
    window.scrollTo({top: 0, behavior: 'smooth'});
}
//Luu thgian ngung go search
var searchTimeout = null;

function searchAjax(inputElement) {
    let keyword = inputElement.value.trim();
    let dropdown = document.getElementById("result-search");

    if (searchTimeout) clearTimeout(searchTimeout);
    console.log("Đang gửi AJAX tới: " + path + "/searchAjax?search=" + keyword);
    searchTimeout = setTimeout(function() {
        $.ajax({
            url: path + "/searchAjax", // Đường dẫn Servlet của bạn
            type: "GET",
            data: {
                search: keyword
            },
            success: function(data) {
                    dropdown.innerHTML = data; // Nhét HTML vào hộp
                    dropdown.style.display = "block"; // Hiện hộp lên

            },
            error: function() {
                console.log("Lỗi tìm kiếm");
            }
        });
    }, 300); // Đợi 300ms sau khi ngừng gõ mới tìm
}

// Ẩn hộp gợi ý khi click ra ngoài
document.addEventListener('click', function(e) {
    let dropdown = document.getElementById("result-search");
    let searchInput = document.getElementById("search-input");

    if (dropdown && !dropdown.contains(e.target) && e.target !== searchInput) {
        dropdown.style.display = 'none';
    }
});