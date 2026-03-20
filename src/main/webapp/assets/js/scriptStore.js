let total = parseInt(document.getElementById("numPage").value) || 1;
let selectedBrands = [];
let selectedCates = [];
let selectedSort =  "default";

document.addEventListener("DOMContentLoaded", function () {

    renderPagination(1, total);
    activeFilter();

});

function activeFilter() {

    var options = document.querySelectorAll('div[data-filter-group="category"] .filter-option');

    options.forEach(function (element) {
        // Lấy giá trị data-filter
        var value = element.getAttribute('data-filter');
        if (cateId == value) {
            selectedCates.push(cateId);
            element.classList.add("active");
        }
    });
}

function renderPagination(current, total) {
    let html = '';
    let divPageButton = document.getElementById("pagination-buttons");
    if (total <= 1) {
        divPageButton.innerHTML = html;
        return;
    }
    total = parseInt(total);
    current = parseInt(current);
    if (current == 1) {
        html += `<button class="page-btn active" onclick="loadPage(this)" data-page="${current}">${current}</button>`;
        html += `<button class="page-btn " onclick="loadPage(this)" data-page="${current + 1}">${current + 1}</button>`;
        html += `<button class="page-btn " onclick="loadPage(this)" data-page="${current + 2}">${current + 2}</button>`;
        html += `<button title="Đến trang cuối" class="page-btn " onclick="loadPage(this)" data-page="${total}">>></button>`;
        divPageButton.innerHTML = html;
        return;
    }
    if (current == total) {
        html += `<button title="Về Trang đầu" class="page-btn " onclick="loadPage(this)" data-page="1"><<</button>`;
        html += `<button class="page-btn " onclick="loadPage(this)" data-page="${current - 2}">${current - 2}</button>`;
        html += `<button class="page-btn " onclick="loadPage(this)" data-page="${current - 1}">${current - 1}</button>`;
        html += `<button class="page-btn active" onclick="loadPage(this)" data-page="${current}">${current}</button>`;
        divPageButton.innerHTML = html;
        return;
    }

    html += `<button title="Về Trang đầu" class="page-btn " onclick="loadPage(this)" data-page="1"><<</button>`;
    html += `<button class="page-btn " onclick="loadPage(this)" data-page="${current - 1}">${current - 1}</button>`;
    html += `<button class="page-btn active" onclick="loadPage(this)" data-page="${current}">${current}</button>`;
    html += `<button class="page-btn " onclick="loadPage(this)" data-page="${current + 1}">${current + 1}</button>`;
    html += `<button title="Đến trang cuối" class="page-btn " onclick="loadPage(this)" data-page="${total}">>></button>`;
    divPageButton.innerHTML = html;
    return;
}

function loadPage(e) {

    console.log("Đang gửi AJAX tới: " + path + "/loadAjax" );
    let page = parseInt(e.getAttribute("data-page"));
    console.log("page: " + page);
    $.ajax({
        type: "GET",
        url: path + "/loadAjax",
        data: {
            selectedBrands: selectedBrands,
            selectedCates: selectedCates,
            selectedSort: selectedSort != null ? selectedSort : "default",
            pageCurrent: page,
            cateId: typeof cateId !== 'undefined' ? cateId : null
        },
        traditional:
            true,
        dataType:
            "html",

        success:
            function (data) {
            var html = data.split("||||")[1];
                var row = document.getElementById("product-grid");
                if (row)
                    row.innerHTML = html;
                else
                    console.log("Không tìm thấy thẻ div chứa sản phẩm!");

            }

        ,
        error: function (xhr, status, error) {
            console.log("Lỗi: " + error);
            console.log("Trạng thái: " + status);
        }
    })
    ;
    let listButonPage = document.getElementsByClassName("page-btn");
    let tittleEle = document.getElementById("namePage");

    tittleEle.scrollIntoView({behavior: "smooth", block: "start"});

    for (const listButonPageElement of listButonPage) {
        listButonPageElement.classList.remove("active");
    }
    renderPagination(page, total);
    setTitle();
}

function clearFilter(e) {
    selectedBrands = [];
    selectedCates = [];
    loadData(e);
    let listSort = document.getElementsByClassName("filter-option");
    for (let EachElement of listSort) {
        EachElement.classList.remove("active");
    }
    setTitle();
}
var allPage = 0;

function loadData() {
    $.ajax({
        type: "GET",
        url: path + "/loadAjax",
        traditional: true,
        data: {
            pageCurrent: 1,
            selectedBrands: selectedBrands,
            selectedCates: selectedCates,
            selectedSort: selectedSort == null ? "default" : selectedSort,
            cateId: typeof cateId !== 'undefined' ? cateId : null
        },
        dataType: "html",

        success: function (data) {
            allPage = parseInt(data.split("||||")[0]);
            var html = data.split("||||")[1];
            console.log(total);
            var row = document.getElementById("product-grid");

            if (row)
                row.innerHTML = html;
            else
                console.log("Không tìm thấy thẻ div chứa sản phẩm!");
        },
        error: function (xhr, status, error) {
            console.log("Lỗi: " + error);
            console.log("Trạng thái: " + status);
        }
    });
    setTitle();
}

function setTitle() {
    if ((selectedCates == null && selectedBrands == null) || (selectedBrands.length == 0 && selectedCates == 0)) {
        document.getElementById("namePage").innerText = "Sản phẩm";
    } else
        document.getElementById("namePage").innerText = "Kết quả lọc";
}

function sort(e) {
    e.classList.toggle("active");
    let parDiv = e.closest(".filter-options");
    let sortFiter = parDiv.getAttribute("data-filter-group");
    let index = -1;

    let datafilter = e.getAttribute("data-filter");
    if (e.classList.contains("active")) {
        if (sortFiter == "brand") selectedBrands.push(datafilter);
        if (sortFiter == "category") selectedCates.push(datafilter);
    } else {
        if (sortFiter == "brand") {
            index = selectedBrands.indexOf(datafilter);
            selectedBrands.splice(index, 1);
        }
        if (sortFiter == "category") {
            index = selectedCates.indexOf(datafilter);
            selectedCates.splice(index, 1);
        }
    }
    renderPagination(1, total);
    loadData(e);
    setTitle();
}

function sortOption(e) {
    selectedSort = e.getAttribute("data-sort");
    loadData(e);
    activeSort();
}

function activeSort() {
    var options = document.querySelectorAll(".sort-btn");

    options.forEach(function (element) {
        var value = element.getAttribute('data-sort');
        if (selectedSort === value)
            element.classList.add("active");
        else element.classList.remove("active");
    });
}
