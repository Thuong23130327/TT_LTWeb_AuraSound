document.querySelectorAll('.btn-wishlist').forEach(button => {
    button.addEventListener('click', function(e) {
        e.preventDefault();

        const productId = this.getAttribute('data-id');
        const icon = this.querySelector('i');

        fetch('/wishlist-ajax', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                'productId': productId
            })
        })
            .then(response => {
                if (response.status === 401) {
                    Swal.fire('Lỗi', 'Vui lòng đăng nhập để thêm vào danh sách yêu thích!', 'warning');
                    throw new Error("Unauthorized");
                }
                return response.json();
            })
            .then(data => {
                if (data && data.status === "success") {
                    if (data.isWished) {
                        icon.style.color = "red";
                    } else {
                        icon.style.color = "";
                    }
                }
            })
            .catch(error => console.error("Error wishlist:", error));
    });
});

// active ảnh nhỏ của minh họa sp
function activeSmall(targetSrc) {
    const thumbnails = document.querySelectorAll(".small-img")
    for (const smallImg of thumbnails) {
        smallImg.classList.remove("active");
        if (smallImg.src == targetSrc) {
            smallImg.classList.add("active");
            smallImg.scrollIntoView({
                behavior: 'smooth',
                block: 'nearest',
                inline: 'center'
            });
        }
    }
}

// Đổi ảnh chính đang đc hiển thị
function changeMainImg(targetSrc) {
    const mainImg = document.getElementById("MainImg")
    mainImg.classList.add("hiding");
    mainImg.src = targetSrc;
    mainImg.classList.remove("hiding");
    activeSmall(targetSrc);
}

//Hàm xử lý next ảnh hay prev ảnh
function scrollImg(direction) {
    const thumbnails = Array.from(document.querySelectorAll(".small-img"))

    const activeThumb = document.querySelector(".small-img.active")
    let curIndex = activeThumb ? thumbnails.indexOf(activeThumb) : 0;
    let newIndex;

    if (direction == 'next') {
        newIndex = curIndex + 1;
        if (newIndex >= thumbnails.length) newIndex = 0;
    } else {
        newIndex = curIndex - 1;
        if (newIndex < 0) newIndex = thumbnails.length - 1;
    }
    const tarImg = thumbnails[newIndex].src;
    changeMainImg(tarImg);


}

function nextImage() {
    scrollImg('next');
}

function prevImage() {
    scrollImg('pre');
}

function selectVariant(e) {
    const id = e.getAttribute("data-id");
    const marketPrice = e.getAttribute("data-marketPrice");
    const stock = e.getAttribute("data-stock");
    const sellPrice = e.getAttribute("data-sellPrice");
    const targetImg = e.getAttribute("data-img");

    changeMainImg(targetImg);
    const formatter = new Intl.NumberFormat('vi-VN');
    const newPriceElem = document.getElementById("new-price");
    const oldPriceElem = document.getElementById("old-price");
    if (newPriceElem) {
        newPriceElem.innerText = formatter.format(sellPrice) + " đ";
    }

    if (oldPriceElem) {
        oldPriceElem.innerText = formatter.format(marketPrice) + " đ";
    }
    document.getElementById("stock").innerText = stock;
    let stockElement = document.getElementById("stock");
    stockElement.setAttribute("data-stock", stock);

    document.getElementById("selectedVariantId").value = id;

    const input = document.getElementById("quanProduct")
    input.value = 1;

    const listVar = document.querySelectorAll(".color-item")
    listVar.forEach(item => item.classList.remove("active"));
    e.classList.add("active");
}

function updateQuan(change) {
    let input = document.getElementById("quanProduct");
    let quanOld = parseInt(input.value);
    let quanNew = quanOld + change;
    checkValidAndSetQuan(input, quanNew);
}

function checkInput() {
    let input = document.getElementById("quanProduct");
    let quanNew = parseInt(input.value) || 1;
    checkValidAndSetQuan(input, quanNew);
}


function checkValidAndSetQuan(input, quanNew) {
    let stockElement = document.getElementById("stock");
    let stock = parseInt(stockElement.getAttribute("data-stock"));
    console.log("Giá trị nhập vào:", quanNew);
    console.log("Tồn kho lấy từ HTML:", stockElement);
    console.log("Tồn kho sau khi ép kiểu số:", stock);

    if (isNaN(stock)) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: 'Không lấy được số lượng tồn kho!',
            confirmButtonColor: '#e74c3c'
        });

        return;
    }
    if (quanNew > stock) {
        quanNew = stock;
        Swal.fire({
            icon: 'warning',
            title: 'Vượt quá số lượng',
            html: 'Bạn chỉ có thể mua tối đa <b>' + stock + '</b> sản phẩm!',
            confirmButtonColor: '#f39c12',
            timer: 2500,
            timerProgressBar: true
        });
    }

    if (quanNew < 1) quanNew = 1;
    input.value = quanNew;
}

function addToCartAjax(e) {
    e.preventDefault();

    const variantId = document.getElementById("selectedVariantId").value;
    const quantity = document.getElementById("quanProduct").value;

    let stockElement = document.getElementById("stock");
    let stock = parseInt(stockElement.getAttribute("data-stock"));
    if (stock <= 0) {
        Swal.fire({
            icon: 'error',
            title: 'Hết hàng',
            text: 'Sản phẩm hiện đã hết hàng!',
            confirmButtonColor: '#e74c3c'
        });
        return;
    }

    Swal.fire({
        title: 'Đang thêm vào giỏ hàng...',
        allowOutsideClick: false,
        didOpen: () => { Swal.showLoading(); }
    });

    $.ajax({
        type: "POST",
        url: path + "/cart",
        data: {
            variantId: variantId,
            quantity: quantity,
            ajax: "true"
        },
        dataType: "json",
        success: function (res) {
            if (res.cartQty !== undefined) {
                const badge = document.getElementById("cart-badge");
                if (badge) {
                    badge.textContent = res.cartQty;
                    badge.style.display = res.cartQty > 0 ? "inline-block" : "none";
                }
            }

            Swal.fire({
                icon: 'success',
                title: 'Thêm thành công!',
                html: 'Sản phẩm đã được thêm vào giỏ hàng 🛒',
                showCancelButton: true,
                confirmButtonText: '<i class="bi bi-cart-check"></i> Xem giỏ hàng',
                cancelButtonText: 'Tiếp tục mua sắm',
                confirmButtonColor: '#2ecc71',
                cancelButtonColor: '#6c757d',
                reverseButtons: true,
                timer: 3000,
                timerProgressBar: true
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = path + "/cart";
                }
            });
        },
        error: function (xhr) {
            Swal.fire({
                icon: 'error',
                title: 'Thất bại!',
                text: 'Không thể thêm vào giỏ hàng. Vui lòng thử lại!',
                confirmButtonColor: '#e74c3c'
            });
        }
    });
}




