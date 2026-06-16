(function () {
    if (!document.getElementById('product-grid')) return;

    let filterState = {
        pageCurrent: 1,
        selectedBrands: [],
        selectedCates: [],
        selectedSort: 'default',
        minPrice: null,
        maxPrice: null
    };

    document.addEventListener("DOMContentLoaded", function () {
        const numPageEl = document.getElementById("numPage");
        if (numPageEl) {
            renderPagination(parseInt(numPageEl.value) || 1, 1);
            updateSlider();
        }
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
                selectedSort: filterState.selectedSort,
                minPrice: filterState.minPrice,
                maxPrice: filterState.maxPrice
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
        filterState.minPrice = 0;
        filterState.maxPrice = 20000000;

        $('.filter-option').removeClass('active');
        $('.sort-btn').removeClass('active');
        $('[data-sort="default"]').addClass('active');
        updateParentButtonStatus('brand');
        updateParentButtonStatus('category');
        if (minSlider && maxSlider) {
            minSlider.value = 0;
            maxSlider.value = 20000000;
            updateSlider();
        }
        loadAjaxProducts();
    }

    function filter(element) {
        const group = $(element).closest('.filter-options').data('filter-group');
        const value = $(element).data('filter');
        const isActivating = !$(element).hasClass('active');

        $(`.filter-options[data-filter-group="${group}"] .filter-option[data-filter="${value}"]`)
            .toggleClass('active', isActivating);

        if (group === 'brand') {
            updateFilterArray(filterState.selectedBrands, value);
        } else if (group === 'category') {
            updateFilterArray(filterState.selectedCates, value);
        }
        updateParentButtonStatus(group);
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

    function updateParentButtonStatus(group) {
        const currentArray = (group === 'brand') ? filterState.selectedBrands : filterState.selectedCates;
        const parentBtns = $(`.filter-options[data-filter-group="${group}"]`).closest('.filter-item').find('> .btn-filter');

        if (currentArray.length > 0) {
            parentBtns.addClass('active');
        } else {
            parentBtns.removeClass('active');
        }

        const isAnyFilter = filterState.selectedBrands.length > 0 || filterState.selectedCates.length > 0;
        $('.master-filter-container').closest('.filter-item').find('> .btn-filter').toggleClass('active', isAnyFilter);
    }

    function updateFilterArray(array, value) {
        const stringValue = value.toString();
        const index = array.indexOf(stringValue);
        if (index > -1) {
            array.splice(index, 1);
        } else {
            array.push(stringValue);
        }
    }

    function renderPagination(totalPage, current) {
        let total = parseInt(totalPage) || 1;
        let cur = parseInt(current) || 1;
        let html = '';

        if (cur > 1) {
            html += `<button class="page-btn" onclick="changePage(1)">Đầu</button>`;
        }

        let start = Math.max(1, cur - 2);
        let end = Math.min(total, cur + 2);

        if (start > 1) {
            html += `<span class="page-dots">...</span>`;
        }
        for (let i = start; i <= end; i++) {
            html += `<button class="page-btn ${i === cur ? 'active' : ''}" onclick="changePage(${i})">${i}</button>`;
        }

        if (end < total) {
            html += `<span class="page-dots">...</span>`;
        }
        if (cur < total) {
            html += `<button class="page-btn" onclick="changePage(${total})">Cuối</button>`;
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
        if (!minSlider || !maxSlider) return;
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

    if (minSlider) minSlider.addEventListener('input', updateSlider);
    if (maxSlider) maxSlider.addEventListener('input', updateSlider);

    const btnApplyPrice = document.getElementById('btn-apply-price');
    if (btnApplyPrice) {
        btnApplyPrice.addEventListener('click', function () {
            loadAjaxProducts();
            $('.filter-dropdown').removeClass('active');
        });
    }

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

    const minPriceInput = document.getElementById('min-price-input');
    const maxPriceInput = document.getElementById('max-price-input');
    if (minPriceInput) minPriceInput.addEventListener('input', (e) => handleInput(e, 'min'));
    if (maxPriceInput) maxPriceInput.addEventListener('input', (e) => handleInput(e, 'max'));

    function updateFromSlider() {
        let minVal = Math.floor(minSlider.value / 1000);
        let maxVal = Math.floor(maxSlider.value / 1000);

        document.getElementById('min-price-input').value = formatNumber(minVal.toString());
        document.getElementById('max-price-input').value = formatNumber(maxVal.toString());

        updateTrack();
    }

    if (minSlider) minSlider.addEventListener('input', updateFromSlider);
    if (maxSlider) maxSlider.addEventListener('input', updateFromSlider);
})();