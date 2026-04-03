let filterState = {
    pageCurrent: 1,
    selectedBrands: [],
    selectedCates: [],
    selectedSort: 'default'
};


document.addEventListener("DOMContentLoaded", function () {
    renderPagination(parseInt(document.getElementById("numPage").value) || 1, 1);
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

    filterState.pageCurrent = 1; // Reset về trang 1 khi lọc mới
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
