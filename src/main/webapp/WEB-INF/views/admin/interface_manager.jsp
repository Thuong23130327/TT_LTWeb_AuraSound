<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>

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

    <link rel="stylesheet" href="${AuraSound}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">

</head>
<body>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-3 px-md-4">
            <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                <h2 class="section-title text-primary"
                    style="margin-top: 0; margin-bottom: .5rem; font-weight: 500; line-height: 1.2;">Quản Lý Giao
                    Diện</h2>
            </div>
            <p class="text-muted">Chỉnh sửa Banner, Menu Footer, Thương hiệu và Danh mục.</p>

            <div class="card shadow-sm mt-3">
                <div class="card-body">
                    <ul class="nav nav-tabs">
                        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab"
                                                href="#bannerTab">Banners</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#footerTab">Footer Nổi
                            Bật</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#brandTab">Thương Hiệu</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#cateTab">Danh Mục</a></li>
                    </ul>

                    <div class="tab-content mt-3">

                        <div class="tab-pane fade show active" id="bannerTab">
                            <form action="${pageContext.request.contextPath}/admin/upd-interface?action=addBanner"
                                  method="post" enctype="multipart/form-data"
                                  class="mb-3 d-flex flex-wrap gap-2 align-items-start">

                                <div class="d-flex flex-column gap-2">
                                    <input type="file" name="imageFile" class="form-control" accept="image/*" required>
                                    <input type="text" name="title" class="form-control" placeholder="Tiêu đề Banner"
                                           required>
                                </div>
                                <div class="d-flex flex-column gap-2">
                                    <input type="text" name="targetUrl" class="form-control"
                                           placeholder="Trang đích (/product...)" required>
                                    <input type="number" name="sortOrder" class="form-control"
                                           placeholder="Thứ tự (1, 2...)" style="max-width: 150px;" required>
                                </div>
                                <textarea name="description" class="form-control" placeholder="Mô tả ngắn gọn..."
                                          rows="3" style="max-width: 300px;"></textarea>

                                <button class="btn btn-primary h-100" type="submit"><i class="bi bi-plus-circle"></i>
                                    Thêm Banner
                                </button>
                            </form>

                            <table class="table table-striped table-sm text-center align-middle">
                                <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Hình Ảnh</th>
                                    <th>Tiêu đề / Mô tả</th>
                                    <th>Thứ tự</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th>Hành Động</th>
                                </tr>
                                </thead>
                                <tbody id="bannerSortable">
                                <c:forEach var="b" items="${banners}">
                                    <tr data-id="${b.id}" style="cursor: grab;">
                                        <td>${b.id}</td>
                                        <td><img src="${b.imageUrl}" width="150" class="rounded shadow-sm"></td>
                                        <td class="text-start">
                                            <strong>${b.title}</strong><br/>
                                            <small class="text-muted">${b.description}</small>
                                        </td>
                                        <td>${b.sortOrder}</td>
                                        <td>
                                            <div class="form-check form-switch d-flex justify-content-center">
                                                <input class="form-check-input" type="checkbox" role="switch"
                                                       style="cursor: pointer; transform: scale(1.3);"
                                                       onchange="toggleBannerAjax(${b.id}, this)"
                                                    ${b.active ? 'checked' : ''}>
                                            </div>
                                        </td>
                                        <td><fmt:formatDate value="${b.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-sm text-white mb-1"
                                                    data-bs-toggle="modal" data-bs-target="#editBannerModal${b.id}">
                                                <i class="bi bi-pencil-square"></i> Sửa
                                            </button>
                                            <br/>
                                            <button type="button" class="btn btn-danger btn-sm"
                                                    onclick="deleteBannerAjax(${b.id}, this)">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                            <div class="modal fade text-start" id="editBannerModal${b.id}" tabindex="-1"
                                                 aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <form action="${pageContext.request.contextPath}/admin/upd-interface?action=updateBanner"
                                                          onsubmit="updateBannerAjax(event, this)"
                                                          method="post" class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Sửa Banner ID: ${b.id}</h5>
                                                            <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <input type="hidden" name="id" value="${b.id}">
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Tiêu đề</label>
                                                                <input type="text" name="title" class="form-control"
                                                                       value="${b.title}" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Trang đích (Link
                                                                    URL)</label>
                                                                <input type="text" name="targetUrl" class="form-control"
                                                                       value="${b.targetUrl}" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Thứ tự hiển thị (1, 2,
                                                                    3...)</label>
                                                                <input type="number" name="sortOrder"
                                                                       class="form-control" value="${b.sortOrder}"
                                                                       required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Mô tả</label>
                                                                <textarea name="description" class="form-control"
                                                                          rows="3">${b.description}</textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary"
                                                                    data-bs-dismiss="modal">Đóng
                                                            </button>
                                                            <button type="submit" class="btn btn-primary">Lưu Thay Đổi
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="tab-pane fade" id="footerTab">
                            <form action="${pageContext.request.contextPath}/admin/upd-interface?action=addFooter"
                                  method="post" class="mb-3 d-flex gap-2">
                                <input type="text" name="title" class="form-control"
                                       placeholder="Tên (VD: Tai nghe VIP)" required>
                                <input type="text" name="targetUrl" class="form-control"
                                       placeholder="Link đích (VD: /product)" required>
                                <input type="number" name="sortOrder" class="form-control" placeholder="Thứ tự (1,2,3)"
                                       required>
                                <button class="btn btn-success" type="submit">Thêm Footer</button>
                            </form>
                            <table class="table table-bordered text-center align-middle">
                                <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Tiêu đề</th>
                                    <th>Link</th>
                                    <th>Thứ tự</th>
                                    <th>Hành Động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="f" items="${footers}">


                                    <tr>
                                        <td>${f.id}</td>
                                        <td>${f.title}</td>
                                        <td>${f.targetUrl}</td>
                                        <td>${f.sortOrder}</td>
                                        <td>

                                            <button class="btn btn-sm btn-info" data-bs-toggle="modal"
                                                    data-bs-target="#editFooterModal${f.id}">Sửa
                                            </button>

                                            <div class="modal fade" id="editFooterModal${f.id}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <form action="${pageContext.request.contextPath}/admin/upd-interface"
                                                              method="post">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Cập nhật Footer Link</h5>
                                                                <button type="button" class="btn-close"
                                                                        data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <input type="hidden" name="action" value="updateFooter">
                                                                <input type="hidden" name="id" value="${f.id}">

                                                                <div class="mb-3">
                                                                    <label>Tiêu đề hiển thị</label>
                                                                    <input type="text" name="title" class="form-control"
                                                                           value="${f.title}" required>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label>Đường dẫn đích (Target URL)</label>
                                                                    <input type="text" name="targetUrl"
                                                                           class="form-control" value="${f.targetUrl}"
                                                                           required>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label>Thứ tự hiển thị (Sort Order)</label>
                                                                    <input type="number" name="sortOrder"
                                                                           class="form-control" value="${f.sortOrder}"
                                                                           required>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" class="btn btn-primary">Lưu thay
                                                                    đổi
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <a href="${pageContext.request.contextPath}/admin/upd-interface?action=deleteFooter&id=${f.id}"
                                               class="btn btn-danger btn-sm">Xóa</a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="tab-pane fade" id="brandTab">
                            <form action="${pageContext.request.contextPath}/admin/upd-interface?action=addBrand"
                                  method="post" enctype="multipart/form-data" class="mb-3 d-flex gap-2">
                                <input type="text" name="name" class="form-control w-25"
                                       placeholder="Tên Hãng (VD: Sony)" required>
                                <input type="file" name="imageFile" class="form-control w-25" accept="image/*" required>
                                <button class="btn btn-info text-white" type="submit">Thêm Hãng</button>
                            </form>
                            <table class="table table-bordered text-center align-middle">
                                <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Hãng</th>
                                    <th>Logo</th>
                                    <th>Hành Động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="br" items="${brands}">
                                    <tr>
                                        <td>${br.id}</td>
                                        <td>${br.name}</td>
                                        <td><img src="${br.logoUrl}" width="80" alt="logo" class="bg-light p-1 border">
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/upd-interface?action=deleteBrand&id=${br.id}"
                                               class="btn btn-danger btn-sm">Xóa</a>
                                            <button type="button" class="btn btn-warning btn-sm"
                                                    onclick="openEditBrand('${br.id}', '${br.name}')">Sửa
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="tab-pane fade" id="cateTab">
                            <form action="${pageContext.request.contextPath}/admin/upd-interface?action=addCategory"
                                  method="post" class="mb-3 d-flex gap-2">
                                <input type="text" name="name" class="form-control w-25" placeholder="Tên Danh mục"
                                       required>
                                <select name="parentId" class="form-select w-25">
                                    <option value="0">Là danh mục gốc</option>
                                    <c:forEach var="pc" items="${categories}">
                                        <option value="${pc.id}">${pc.name}</option>
                                    </c:forEach>
                                </select>
                                <button class="btn btn-warning" type="submit">Thêm Danh Mục</button>
                            </form>
                            <table class="table table-bordered text-center align-middle">
                                <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Danh Mục</th>
                                    <th>Trạng thái Cấp bậc</th>
                                    <th>Hành Động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="c" items="${categories}">
                                    <tr>
                                        <td>${c.id}</td>
                                        <td class="fw-bold">${c.name}</td>
                                        <td>
                                            <c:if test="${c.parentId == 0}">
                                                <span class="badge bg-primary">Danh mục Gốc</span>
                                            </c:if>
                                            <c:if test="${c.parentId != 0}">
                                                <span class="badge bg-secondary">Danh mục con (Của ID: ${c.parentId})</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/upd-interface?action=deleteCategory&id=${c.id}"
                                               class="btn btn-danger btn-sm">Xóa</a>

                                            <button type="button" class="btn btn-warning btn-sm"
                                                    onclick="openEditCategory('${c.id}', '${c.name}', '${c.parentId}')">
                                                Sửa
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<div class="modal fade" id="editBrandModal" tabindex="-1">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/upd-interface?action=updateBrand" method="post"
              enctype="multipart/form-data" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sửa Thương Hiệu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="id" id="editBrandId">
                <div class="mb-3">
                    <label>Tên Hãng</label>
                    <input type="text" name="name" id="editBrandName" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Logo mới (Bỏ trống nếu muốn giữ logo cũ)</label>
                    <input type="file" name="imageFile" class="form-control" accept="image/*">
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<div class="modal fade" id="editCategoryModal" tabindex="-1">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/admin/upd-interface?action=updateCategory" method="post"
              class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sửa Danh Mục</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="id" id="editCateId">
                <div class="mb-3">
                    <label>Tên Danh Mục</label>
                    <input type="text" name="name" id="editCateName" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Danh mục cha (Để trống nếu là mục Gốc)</label>
                    <select name="parentId" id="editCateParent" class="form-select">
                        <option value="">--- Trống (Là danh mục gốc) ---</option>
                        <c:forEach var="pc" items="${categories}">
                            <option value="${pc.id}">${pc.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-warning">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>

<script>
    function toggleBannerAjax(id, checkboxElem) {
        let currentStatus = !checkboxElem.checked;

        let url = '${pageContext.request.contextPath}/admin/upd-interface?action=toggleBanner&id=' + id + '&status=' + currentStatus;

        fetch(url, {method: 'POST'})
            .then(res => res.json())
            .then(success => {
                if (!success) {
                    alert("Lỗi! Không thể đổi trạng thái.");
                    checkboxElem.checked = currentStatus;
                }
            });
    }

    function deleteBannerAjax(id, btnElem) {
        if (!confirm("Bạn chắc chắn muốn xóa Banner này chứu ?")) return;

        let url = '${pageContext.request.contextPath}/admin/upd-interface?action=deleteBanner&id=' + id;

        fetch(url, {method: 'POST'})
            .then(res => res.json())
            .then(success => {
                if (success) {
                    btnElem.closest('tr').remove();
                } else {
                    alert("Lỗi khi xóa!");
                }
            });
    }

    function updateBannerAjax(event, formElem) {
        event.preventDefault();
        let formData = new URLSearchParams(new FormData(formElem));

        fetch(formElem.action, {
            method: 'POST',
            body: formData
        })
            .then(res => res.json())
            .then(success => {
                if (success) {
                    alert("Cập nhật thành công!");
                    location.reload();
                } else {
                    alert("Cập nhật thất bại!");
                }
            });
    }

    let bannerTbody = document.getElementById('bannerSortable');
    if (bannerTbody) {
        new Sortable(bannerTbody, {
            animation: 150,
            ghostClass: 'bg-light',
            onEnd: function (evt) {
                let rows = bannerTbody.querySelectorAll("tr");
                let ids = [];

                rows.forEach(row => {
                    ids.push(row.getAttribute("data-id"));
                });

                let formData = new URLSearchParams();
                ids.forEach(id => formData.append("ids[]", id));
                fetch('${pageContext.request.contextPath}/admin/upd-interface?action=reorderBanners', {
                    method: 'POST',
                    body: formData
                })
                    .then(res => res.json())
                    .then(success => {
                        if (success) {
                            location.reload();
                        }
                    });
            }
        });
    }

    document.addEventListener("DOMContentLoaded", function () {
        let activeTab = localStorage.getItem('activeInterfaceTab');
        if (activeTab) {
            let triggerEl = document.querySelector('a[href="' + activeTab + '"]');
            if (triggerEl) {
                new bootstrap.Tab(triggerEl).show();
            }
        }

        let tabLinks = document.querySelectorAll('a[data-bs-toggle="tab"]');
        tabLinks.forEach(function (link) {
            link.addEventListener('shown.bs.tab', function (e) {
                localStorage.setItem('activeInterfaceTab', e.target.getAttribute('href'));
            });
        });
    });

    function openEditBrand(id, name) {
        document.getElementById('editBrandId').value = id;
        document.getElementById('editBrandName').value = name;
        new bootstrap.Modal(document.getElementById('editBrandModal')).show();
    }

    function openEditCategory(id, name, parentId) {
        document.getElementById('editCateId').value = id;
        document.getElementById('editCateName').value = name;
        document.getElementById('editCateParent').value = parentId || "";
        new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
    }


</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>