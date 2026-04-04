

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
    document.getElementById("new-price").innerText = formatter.format(sellPrice) + " đ";
    document.getElementById("old-price").innerText = formatter.format(marketPrice) + " đ";
    document.getElementById("stock").innerText = stock;

    document.getElementById("selectedVariantId").value = id;

    const input = document.getElementById("quanProduct")

    let stockElement = document.getElementById("stock");
    input.value = 1;
    stockElement.setAttribute("data-stock", stock);

    const listVar = document.querySelectorAll(".color-item")
    for (const eachVar of listVar) {
        eachVar.classList.remove("active");
    }

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
        alert("Lỗi: Không lấy được số lượng tồn kho!");
        return;
    }
    if (quanNew > stock) {
        quanNew = stock;
        alert("Bạn chỉ có thể mua tối đa " + stock + " sản phẩm!");
    }

    if (quanNew < 1) quanNew = 1;
    input.value = quanNew;
}




