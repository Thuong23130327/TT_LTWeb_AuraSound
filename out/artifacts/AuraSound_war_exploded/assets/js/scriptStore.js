let filterState = {
    pageCurrent: 1,
    selectedBrands: [],
    selectedCates: [],
    selectedSort: 'default',
    minPrice: null,
    maxPrice: null
};


document.addEventListener("DOMContentLoaded", function () {
    renderPagination(parseInt(document.getElementById("numPage").value) || 1, 1);
    updateSlider();

});

function loadAjaxProducts() {
    console.log(">>> Đang gửi Ajax với dữ liệu: ", filterState);
    $.ajax({
        type: "POST",
        url: path + "/product",
        data: {
            pageCurrent: filterState.pageCurrent,
            selectedBrands: filterState.selectedBrands,
            selectedCates: filterState.selectedCates,
            selectedSort: filterState.selectedSort
        },
        dataType: "json",
        traditional: true,

        success: function (res) {
            $("#product-grid").html(res.html);
            renderPagination(res.totalPage, filterState.pageCurrent);
            let tittleEle = document.getElementById("namePage");
            tittleEle.scrollIntoView({behavior: "smooth", block: "start"});
            updateTittle();
        },
        error: function (e) {
            console.error("Load sp ajax fail ", e);
        }
    });
}

function updateTittle() {
    if ((filterState.selectedCates == null && filterState.selectedBrands == null) || (filterState.selectedBrands.length == 0 && filterState.selectedCates == 0)) {
        document.getElementById("namePage").innerText = "Sản phẩm";
    } else
        document.getElementById("namePage").innerText = "Kết quả lọc";
}

function clearFilter() {
    filterState.pageCurrent = 1;
    filterState.selectedBrands = [];
    filterState.selectedCates = [];
    filterState.selectedSort = 'default';

    $('.filter-option').removeClass('active');
    $('.sort-btn').removeClass('active');
    $('[data-sort="default"]').addClass('active');
    loadAjaxProducts();
}


function filter(element) {
    // Lọc brand hay cate
    const group = $(element).parent().data('filter-group');
    const value = $(element).data('filter');

    $(element).toggleClass('active');

    if (group === 'brand') {
        updateFilterArray(filterState.selectedBrands, value);
    } else {
        updateFilterArray(filterState.selectedCates, value);
    }
    const parentBtn = $(element).closest('.filter-item').find('> .btn-filter');
    const currentArray = (group === 'brand') ? filterState.selectedBrands : filterState.selectedCates;

    if (currentArray.length > 0) {
        parentBtn.addClass('active');
    } else {
        parentBtn.removeClass('active');
    }
    filterState.pageCurrent = 1;
    loadAjaxProducts();
}

function sortOption(element) {
    $('.sort-btn').removeClass('active');
    $(element).addClass('active');

    filterState.selectedSort = $(element).data('sort');
    filterState.pageCurrent = 1;
    loadAjaxProducts();
}


function updateFilterArray(array, value) {
    const index = array.indexOf(value);
    if (index > -1) array.splice(index, 1); // co roi thi xoa di
    else array.push(value); // chua co them vao
}

function renderPagination(totalPage, current) {
    let total = parseInt(totalPage) || 1;
    let cur = parseInt(current) || 1;

    let html = '';
    for (let i = 1; i <= total; i++) {
        html += `<button class="page-btn ${i === cur ? 'active' : ''}"
                 onclick="changePage(${i})">${i}</button>`;
    }
    $("#pagination-buttons").html(html);
}

function changePage(page) {
    filterState.pageCurrent = page;
    loadAjaxProducts();
}
const minSlider = document.getElementById('min-range-slider');
const maxSlider = document.getElementById('max-range-slider');
const minInput = document.getElementById('min-price-input');
const maxInput = document.getElementById('max-price-input');
const track = document.querySelector('.slider-track');

const priceGap = 1000000;

function formatCurrency(value) {
    return new Intl.NumberFormat('vi-VN').format(value);
}

function updateSlider() {
    let minVal = parseInt(minSlider.value);
    let maxVal = parseInt(maxSlider.value);

    if (maxVal - minVal < priceGap) {
        if (this === minSlider) {
            minSlider.value = maxVal - priceGap;
        } else {
            maxSlider.value = minVal + priceGap;
        }
    }

    minInput.value = formatCurrency(minSlider.value);
    maxInput.value = formatCurrency(maxSlider.value);

    const percentLeft = (minSlider.value / minSlider.max) * 100;
    const percentRight = 100 - (maxSlider.value / maxSlider.max) * 100;

    track.style.left = percentLeft + "%";
    track.style.right = percentRight + "%";
    filterState.minPrice = minSlider.value;
    filterState.maxPrice = maxSlider.value;
}

minSlider.addEventListener('input', updateSlider);
maxSlider.addEventListener('input', updateSlider);

document.getElementById('btn-apply-price').addEventListener('click', function() {
    loadAjaxProducts();
    $('.filter-dropdown').removeClass('active');
});


function formatNumber(n) {
    return n.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

function handleInput(e, type) {
    let input = e.target;
    let value = input.value.replace(/\D/g, "");
    if (parseInt(value) > 20000) value = "20000";
    input.value = formatNumber(value);
    let realValue = parseInt(value) * 1000 || 0;
    if (type === 'min') {
        minSlider.value = realValue;
        filterState.minPrice = realValue;
    } else {
        maxSlider.value = realValue;
        filterState.maxPrice = realValue;
    }

    updateTrack();
}

document.getElementById('min-price-input').addEventListener('input', (e) => handleInput(e, 'min'));
document.getElementById('max-price-input').addEventListener('input', (e) => handleInput(e, 'max'));

function updateFromSlider() {
    let minVal = Math.floor(minSlider.value / 1000);
    let maxVal = Math.floor(maxSlider.value / 1000);

    document.getElementById('min-price-input').value = formatNumber(minVal.toString());
    document.getElementById('max-price-input').value = formatNumber(maxVal.toString());

    updateTrack();
}

minSlider.addEventListener('input', updateFromSlider);
maxSlider.addEventListener('input', updateFromSlider);