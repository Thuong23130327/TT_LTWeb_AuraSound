<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

<%
    request.setAttribute("pageTitle", "QUẢN LÝ SẢN PHẨM - AuraSound");
    request.setAttribute("activePage", "product");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHeadphones.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/order_detail.css">
</head>

<body>

<button onclick="backTop()" id="back-top-btn" title="Lên đầu trang">
    <i class="bi bi-caret-up-fill"></i>
</button>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

            <nav>
                <div class="nav-container content">
                    <div class="nav-left">
                        <a class="a-nodecor" href="#">
                            <div class="contact">Sửa Sản Phẩm</div>
                        </a>

                        <a class="a-nodecor" href="#product-detail">
                            <div class="contact">${p.name}</div>
                        </a>

                        <a class="a-nodecor" href="#var-detail">
                            <div class="contact">Sửa Biến Thể</div>
                        </a>

                        <a class="a-nodecor" href="#spec-detail">
                            <div class="contact">Sửa Thông Số</div>
                        </a>

                        <a class="a-nodecor" href="#">
                            <div class="contact">Sửa Ảnh SP</div>
                        </a>
                    </div>

                    <div id="hamburger-icon"><i class="bi bi-list"></i></div>
                </div>

            </nav>

            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 mb-2 border-bottom">
                <h2 class="h2 section-title text-primary">
                    Chi tiết SP # ${p.id}
                </h2>

                <div class="btn-toolbar">
                    <a class="a-nodecor" href="${AuraSound}/admin/product-manager">
                        <button type="button" class="btn btn-sm btn-primary btn-update-status">
                            Trở lại
                        </button>
                    </a>
                </div>
            </div>

            <div id="order-detail-content" class="content-section active">
                <div class="col-lg-12 mb-2 ">
                    <div class="card h-100">
                        <form action="${AuraSound}/admin/upd-product?action=updateProduct" method="post">
                            <c:if test="${p != null}">
                                <input name="inputPid" type="hidden" value="${p.id}">
                            </c:if>
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <span><i class="fas fa-user-circle me-2"></i>Thông tin chung</span>
                                </div>

                                <div class="d-flex align-items-center gap-4">
                                    <div class="form-check form-switch mb-0 d-flex align-items-center gap-2">
                                        <label for="isActiveToggle">
                                            Hiển thị sản phẩm
                                        </label>
                                        <input
                                                type="checkbox"
                                                id="isActiveToggle"
                                                name="isActive"
                                                value="true"
                                        ${p.isActive ? 'checked' : ''}>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-gradient">
                                        Lưu Thay Đổi
                                    </button>
                                </div>
                            </div>

                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-3 mb-2 ">

                                        <span><strong>Thương hiệu: </strong></span>
                                        <select name="inputBrand" id="product-brand"
                                                class="form-select mb-3">
                                            <c:forEach items="${brandList}" var="brand">
                                                <option value="${brand.id}" ${brand.id == p.brandId ? 'selected' : ''}>${brand.name}</option>
                                            </c:forEach>
                                        </select>


                                        <span><strong>Danh mục: </strong></span>
                                        <select name="inputCate" id="product-category" class="form-select">
                                            class="form-select mb-3">
                                            <c:forEach items="${childList}" var="cate">
                                                <option value="${cate.id}" ${cate.id == p.categoriesId ? 'selected' : ''} >${cate.name}</option>
                                            </c:forEach>
                                        </select>


                                        <span><strong>Tên SP: </strong></span>
                                        <input name="inputNameProduct" type="text" id="product-name"
                                               value="${p.name}"
                                               class="form-control mb-3"
                                               placeholder="Tên SP">

                                        <span><strong>SKU: </strong></span>
                                        <input name="inputSku" type="text" id="product-sku" value="${p.sku}"
                                               class="form-control mb-3"
                                               placeholder="Nhập mã SKU sản phẩm">

                                    </div>

                                    <div class="col-lg-5 mb-2 ">


                                        <span><strong>Mô tả: </strong></span>
                                        <textarea name="inputDiscrip" id="product-short-desc"
                                                  class="form-control"
                                                  rows="10">${p.description}</textarea>
                                    </div>

                                    <div class="col-lg-4 mb-2 ">
                                        <span class="mb-4"><strong>Chọn biến thể làm đại diện: </strong></span>
                                        <div class="row">
                                            <div class="col-lg-4 mb-2">
                                                <c:forEach items="${variants}" var="v" varStatus="status">
                                                    <div class="form-check mb-2">
                                                        <input type="radio"
                                                               name="variantSelect"
                                                               id="var-${status.index}"
                                                               value="${v.id}"
                                                               class="form-check-input"
                                                               onchange="showSample(this)"
                                                               data-img="${v.mainImageUrl}"
                                                               data-price="${v.sellPrice}"
                                                               data-oldprice="${v.marketPrice}"
                                                               data-discount="${v.discountPercent}"
                                                            ${v. mainImageUrl == p.img ? 'checked' : ''}
                                                        >
                                                        <span>${v.colorName}</span>
                                                    </div>
                                                </c:forEach>

                                            </div>

                                            <div class="col-lg-6 showVar mt-3">
                                                <a href="detail?pid=${p.id}" class="product-card">
                                                    <div id="sampleBadge" class="product-badge discount"
                                                         style="${p.discountPercent > 0 ? '' : 'display:none'}">
                                                        Giảm <span id="sampleDiscountText">${p.discountPercent}</span> %
                                                    </div>

                                                    <img id="sampleImg" src="${p.img}" alt="${p.name}"
                                                         onerror="this.src='https://placehold.co/300x300?text=No+Image'">

                                                    <div class="product-card-info">
                                                        <h4>${p.name}</h4>
                                                        <div class="price-block">
                                                            <div id="sampleNewPrice" class="new-price">
                                                                <fmt:formatNumber value="${p.sellPrice}"
                                                                                  pattern="#,###"/> đ
                                                            </div>

                                                            <div id="sampleOldPriceBlock"
                                                                 style="${p.discountPercent > 0 ? '' : 'display:none'}">
                                                                <div id="sampleOldPrice" class="old-price">
                                                                    <fmt:formatNumber value="${p.oldPrice}"
                                                                                      pattern="#,###"/> đ
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </form>
                    </div>

                </div>

                <div class="col-lg-12 mb-2 ">
                    <div class="card h-100">
                        <form action="${AuraSound}/admin/upd-product?action=updateVariantSelect" method="post"
                              enctype="multipart/form-data">

                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <div class="icon-shape bg-primary-light text-primary rounded me-3">
                                        <i class="fas fa-info-circle fs-5"></i>
                                    </div>
                                    <span><i class="bi bi-airplane-fill"></i>
Sửa Biến thể </span>
                                </div>

                                <div class="d-flex align-items-center gap-4">
                                    <div class="form-check form-switch mb-0 d-flex align-items-center gap-2">
                                        <span class="text-nowrap"><strong>Đã bán: </strong></span>
                                        <input type="number" id="var-sold" value="" class="form-control bg-light ms-2"
                                               placeholder="Số lượng" readonly>

                                        <select onchange="updateVariantInfo(this)" id="product-status"
                                                class="form-select">
                                            <c:forEach items="${variants}" var="v" varStatus="status">
                                                <div class="form-check mb-2">
                                                    <option
                                                            name="variantSelect"
                                                            id="showvar-${status.index}"
                                                            value="${v.id}"

                                                            data-img="${v.mainImageUrl}"
                                                            data-price="${v.sellPrice}"
                                                            data-oldprice="${v.marketPrice}"
                                                            data-stock="${v.stockQuantity}"
                                                            data-sold="${v.soldQuantity}"
                                                            data-clname="${v.colorName}"
                                                            data-skuvar="${v.variantSku}"
                                                        ${v. mainImageUrl == p.img ? 'selected' : ''}
                                                    >
                                                            ${v.colorName}
                                                </div>
                                            </c:forEach>

                                        </select>

                                    </div>
                                    <div class="form-check form-switch mb-0 d-flex align-items-center gap-2">

                                        <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal"
                                                data-bs-target="#addVariantModal">
                                            <i class="bi bi-plus-circle"></i> Thêm biến thể mới
                                        </button>
                                        <button onclick="confirmDelete('v', document.getElementById('current-variant-id').value)"
                                                type="button" class="btn btn-outline-danger btn-accent">
                                            Xóa Biến thể
                                        </button>
                                        <button type="submit" class="btn btn-primary btn-gradient">
                                            Lưu Thay Đổi
                                        </button>
                                    </div>


                                </div>
                            </div>


                            <div class="card-body">
                                <div class="row">
                                    <div class="col-lg-4 mb-2 ">
                                        <span><strong>Tên màu: </strong></span>
                                        <input name="inputClName" type="text" id="var-colorName" value=""
                                               class="form-control"
                                               placeholder="Màu của biến thể">

                                        <span><strong>SKU biến thể: </strong></span>
                                        <input readonly type="text" id="var-sku" value="" class="form-control"
                                               placeholder="Nhập mã SKU sản phẩm">

                                        <span><strong>Số lượng kho: </strong></span>
                                        <input name="inputStock" type="text" id="var-stock" value="${p.sku}"
                                               class="form-control mb-3"
                                               placeholder="Nhập mã SKU sản phẩm">

                                    </div>

                                    <div class="col-lg-4 mb-2 ">
                                        <span><strong>Giá Chưa Giảm </strong></span>
                                        <input name="inputOldP" type="number" id="var-oldP" value=""
                                               class="form-control"
                                               placeholder="Nhập mã SKU sản phẩm">

                                        <span><strong>Giá Đã Giảm </strong></span>
                                        <input name="inputNewP" type="number" id="var-newP" value=""
                                               class="form-control"
                                               placeholder="Nhập mã SKU sản phẩm">

                                        <span class="mb-4"><strong>Ảnh đại diện: </strong></span>
                                        <input type="file" name="productImage" class="form-control" accept="image/*">
                                        <input type="hidden" name="vid" id="current-variant-id" value="">
                                        <c:if test="${p != null}">
                                            <input name="inputPid" type="hidden" value="${p.id}">
                                        </c:if> <input type="hidden" name="currentImgUrl" id="current-img-url" value="">
                                    </div>

                                    <div class="col-lg-4 mb-2 ">
                                        <img id="showImgVar" style="height: 150px; width: 150px;" src="${p.img}"
                                             alt="${p.name}"
                                             onerror="this.src='https://placehold.co/300x300?text=No+Image'">
                                    </div>

                                </div>

                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-lg-12 mb-2 ">
                    <div class="card h-100">
                        <form action="${AuraSound}/admin/upd-product?action=updateSpec" method="post">

                            <input type="hidden" name="inputPid" value="${p.id}">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <span><i class="fas fa-user-circle me-2"></i>Chi tiết kỹ thuật </span>
                                </div>

                                <div class="d-flex align-items-center gap-4">

                                    <div class="form-check form-switch mb-0 d-flex align-items-center gap-2">

                                        <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal"
                                                data-bs-target="#addSpecModal">
                                            <i class="bi bi-plus-circle"></i> Thêm Thông số
                                        </button>
                                        <button onclick="confirmDelete('v', document.getElementById('current-variant-id').value)"
                                                type="button" class="btn btn-outline-danger btn-accent">
                                            Xóa Thông số
                                        </button>
                                        <button type="submit" class="btn btn-primary btn-gradient">
                                            Lưu Thay Đổi
                                        </button>
                                    </div>
                                </div>
                            </div>


                            <div class="card-body">
                                <div class="row g-3">
                                    <c:forEach items="${specs}" var="s">
                                        <div class="col-lg-3">
                                            <input type="hidden" name="inputSpecIds" value="${s.id}">
                                            <label for="product-power" class="form-label">${s.specName}</label>
                                            <textarea name="inputSpecValue"
                                                      class="form-control"
                                                      rows="3"
                                                      placeholder="Nhập nội dung chi tiết...">${s.specValue}</textarea>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between">
                        <h6><i class="bi bi-file-image"></i>Ảnh sản phẩm</h6>
                        <form action="${AuraSound}/admin/upd-product?action=addGalery" method="post"
                              enctype="multipart/form-data">
                            <c:if test="${p != null}">
                                <input name="inputPid" type="hidden" value="${p.id}">
                            </c:if>
                            <input type="file" name="galleryFiles" class="d-none" id="btn-upload"
                                   onchange="this.form.submit()">
                            <button type="button" class="btn btn-sm btn-success"
                                    onclick="document.getElementById('btn-upload').click()">
                                <i class="fas fa-plus"></i> Thêm ảnh mới
                            </button>
                        </form>
                    </div>

                    <div class="card-body">
                        <form action="${AuraSound}/admin/upd-product?action=updateOrder" method="post">
                            <c:if test="${p != null}">
                                <input name="inputPid" type="hidden" value="${p.id}">
                            </c:if>
                            <div class="row">
                                <c:forEach items="${images}" var="img">
                                    <div class="col-md-3 mb-3 text-center">
                                        <div class="border p-2 rounded">
                                            <img src="${img.imageUrl}" class="img-fluid rounded mb-2"
                                                 style="height: 120px; object-fit: cover;">

                                            <input type="hidden" name="imgIds" value="${img.id}">
                                            <div class="input-group input-group-sm mb-2">
                                                <span class="input-group-text">Thứ tự</span>
                                                <input type="number" name="orders" value="${img.sortOrder}"
                                                       class="form-control text-center">
                                            </div>

                                            <a href="${AuraSound}/admin/upd-product?action=delGalery&imgId=${img.id}&inputPid=${p.id}"
                                               class="btn btn-sm btn-outline-danger w-100"
                                               onclick="return confirm('Xóa ảnh này khỏi AuraSound?')">
                                                <i class="fas fa-trash"></i> Xóa ảnh
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <button type="submit" class="btn btn-primary mt-3">Lưu thứ tự hiển thị</button>
                        </form>
                    </div>
                </div>
                <%
                    String msg = (String) session.getAttribute("msg");
                    if (msg != null) {
                        if (msg.equals("success")) {
                %>
                <script>
                    alert("Cập nhật THÀNH CÔNG!!");
                </script>
                <%
                    }
                    if (msg.equals("fail")) {
                %>
                <script>
                    alert("Cập nhật THẤT BẠI!!");
                </script>
                <%
                        }
                        session.removeAttribute("msg");
                    }
                %>
            </div>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../../../assets/js/script.js"></script>
        <script src="../../../assets/js/scriptAdmin.js"></script>
        <script src="../../../assets/js/product_detail.js"></script>


        <div class="modal fade" id="addVariantModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${AuraSound}/admin/upd-product?action=addVariant" method="post"
                          enctype="multipart/form-data"><c:if test="${p != null}">
                        <input name="inputPid" type="hidden" value="${p.id}">
                    </c:if>

                        <div class="modal-header">
                            <h5 class="modal-title">Thêm màu mới cho ${p.name}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Tên màu</label>
                                <input type="text" name="inputClName" class="form-control" required
                                       placeholder="Ví dụ: Xanh Navy">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Số lượng kho</label>
                                <input type="number" name="inputStock" class="form-control" value="0">
                            </div>
                            <div class="row">
                                <div class="col-6 mb-3">
                                    <label class="form-label">Giá niêm yết</label>
                                    <input type="number" name="inputOldP" class="form-control" placeholder="đ">
                                </div>
                                <div class="col-6 mb-3">
                                    <label class="form-label">Giá bán</label>
                                    <input type="number" name="inputNewP" class="form-control" placeholder="đ">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Ảnh biến thể</label>
                                <input type="file" name="productImage" class="form-control" accept="image/*">
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Xác nhận thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addSpecModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${AuraSound}/admin/upd-product?action=addSpec" method="post">
                        <c:if test="${p != null}">
                            <input name="inputPid" type="hidden" value="${p.id}">
                        </c:if>

                        <div class="modal-header">
                            <h5 class="modal-title">Thêm Thông số mới cho ${p.name}</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Tên Thông số</label>
                                <input type="text" name="specName" class="form-control" required
                                       placeholder="Ví dụ: Công suất">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá trị Thông số</label>
                                <textarea name="specValue" class="form-control" rows="3" required
                                          placeholder="Nhập nội dung chi tiết..."></textarea>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Xác nhận thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
</body>

</html>