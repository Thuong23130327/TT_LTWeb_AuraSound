<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleAdmin.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">

    <style>
        .voucher-header-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            padding: 28px 32px;
            color: #fff;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
        }
        .voucher-header-card::before {
            content: '\F1E4';
            font-family: 'bootstrap-icons';
            position: absolute;
            right: 24px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 90px;
            opacity: 0.12;
        }
        .voucher-header-card h2  { font-size: 1.6rem; font-weight: 700; margin: 0 0 4px; }
        .voucher-header-card p   { margin: 0; opacity: .85; font-size: .92rem; }

        .btn-add-voucher {
            background: #fff; color: #764ba2; border: none; border-radius: 10px;
            font-weight: 600; padding: 10px 22px; font-size: .92rem;
            transition: all .2s; white-space: nowrap; cursor: pointer;
        }
        .btn-add-voucher:hover {
            background: #f0e8ff; transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(118,75,162,.3);
        }

        /* ===== STATS PILLS ===== */
        .stat-pill {
            background: #fff; border: 1px solid #eee; border-radius: 12px;
            padding: 14px 22px; display: flex; align-items: center; gap: 12px;
            flex: 1; min-width: 140px; box-shadow: 0 2px 8px rgba(0,0,0,.04);
        }
        .stat-pill .icon {
            width: 42px; height: 42px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; flex-shrink: 0;
        }
        .stat-pill .label { font-size: .78rem; color: #888; margin: 0; }
        .stat-pill .value { font-size: 1.3rem; font-weight: 700; color: #222; margin: 0; line-height: 1; }

        /* ===== TABLE ===== */
        .voucher-table-wrap {
            background: #fff; border-radius: 16px; overflow: hidden;
            box-shadow: 0 2px 16px rgba(0,0,0,.06);
        }
        .table-toolbar {
            padding: 18px 22px; border-bottom: 1px solid #f0f0f0;
            display: flex; align-items: center; gap: 12px; flex-wrap: wrap;
        }
        .table-toolbar input {
            border: 1px solid #e8e8e8; border-radius: 8px;
            padding: 8px 14px; font-size: .88rem; outline: none;
            transition: border .2s; width: 220px;
        }
        .table-toolbar input:focus { border-color: #764ba2; }
        .voucher-table-wrap table  { margin: 0; }
        .voucher-table-wrap thead th {
            background: #fafafa; font-size: .8rem; font-weight: 600;
            text-transform: uppercase; letter-spacing: .5px; color: #666;
            border-bottom: 2px solid #f0f0f0; padding: 13px 16px; white-space: nowrap;
        }
        .voucher-table-wrap tbody td {
            padding: 14px 16px; font-size: .88rem; vertical-align: middle;
            border-bottom: 1px solid #f7f7f7;
        }
        .voucher-table-wrap tbody tr:hover td  { background: #fdf8ff; }
        .voucher-table-wrap tbody tr:last-child td { border-bottom: none; }

        /* Code badge */
        .code-badge {
            font-family: 'Courier New', monospace; font-size: .82rem; font-weight: 700;
            background: #f3eeff; color: #6a3db5; padding: 4px 10px; border-radius: 6px;
            letter-spacing: .5px; border: 1px dashed #c8aaed; cursor: pointer;
            transition: all .15s; display: inline-flex; align-items: center; gap: 5px;
        }
        .code-badge:hover { background: #ebe0ff; }

        /* Status badges */
        .status-active  { background: #e8f8f1; color: #1a9e5c; border: 1px solid #b2e8cf; border-radius: 20px; padding: 3px 10px; font-size: .78rem; font-weight: 600; white-space: nowrap; }
        .status-expired { background: #fff1f1; color: #c0392b; border: 1px solid #f5c6cb; border-radius: 20px; padding: 3px 10px; font-size: .78rem; font-weight: 600; white-space: nowrap; }
        .status-used-up { background: #fff8e1; color: #b8860b; border: 1px solid #ffe082; border-radius: 20px; padding: 3px 10px; font-size: .78rem; font-weight: 600; white-space: nowrap; }

        /* Action btn */
        .btn-tbl-delete {
            background: #fff1f1; color: #e74c3c; border: 1px solid #fce4e4;
            border-radius: 7px; padding: 5px 12px; font-size: .82rem;
            font-weight: 500; transition: all .2s; cursor: pointer;
        }
        .btn-tbl-delete:hover { background: #e74c3c; color: #fff; }

        /* Empty state */
        .empty-state { text-align: center; padding: 60px 20px; color: #aaa; }
        .empty-state i { font-size: 3rem; margin-bottom: 12px; display: block; }

        /* ===== MODAL ===== */
        .modal-content   { border-radius: 16px; border: none; overflow: hidden; }
        .modal-header    { background: linear-gradient(135deg, #667eea, #764ba2); color: #fff; border: none; padding: 20px 24px; }
        .modal-header .modal-title  { font-weight: 700; font-size: 1.1rem; }
        .modal-header .btn-close    { filter: invert(1); }
        .modal-body      { padding: 24px; }
        .modal-footer    { border-top: 1px solid #f0f0f0; padding: 16px 24px; }
        .form-label      { font-size: .85rem; font-weight: 600; color: #555; margin-bottom: 5px; }
        .form-control, .form-select { border-radius: 9px; border: 1px solid #ddd; font-size: .9rem; padding: 10px 14px; }
        .form-control:focus, .form-select:focus { border-color: #764ba2; box-shadow: 0 0 0 3px rgba(118,75,162,.15); }
        .form-text       { font-size: .78rem; color: #999; }
        .btn-submit-voucher {
            background: linear-gradient(135deg, #667eea, #764ba2); color: #fff; border: none;
            border-radius: 9px; padding: 10px 28px; font-weight: 600; font-size: .92rem;
            transition: all .2s; cursor: pointer;
        }
        .btn-submit-voucher:hover { opacity: .9; transform: translateY(-1px); box-shadow: 0 4px 14px rgba(118,75,162,.35); }

        /* ===== FLASH TOAST ===== */
        .flash-toast {
            position: fixed; top: 20px; right: 20px; z-index: 9999;
            min-width: 300px; border-radius: 12px; padding: 14px 18px;
            font-size: .9rem; font-weight: 500; display: flex; align-items: center;
            gap: 10px; box-shadow: 0 8px 24px rgba(0,0,0,.12);
            animation: slideIn .3s ease;
        }
        .flash-toast.success { background: #e8f8f1; color: #1a7a4a; border: 1px solid #a3e4c1; }
        .flash-toast.error   { background: #fff1f1; color: #c0392b; border: 1px solid #f5c6cb; }
        .flash-toast .close-toast { margin-left: auto; cursor: pointer; opacity: .6; }
        .flash-toast .close-toast:hover { opacity: 1; }
        @keyframes slideIn { from { opacity: 0; transform: translateX(30px); } to { opacity: 1; transform: translateX(0); } }

        /* Confirm delete modal override */
        #confirmDeleteModal .modal-header { background: #fff1f1; color: #c0392b; border-bottom: 1px solid #f5c6cb; }
        .btn-confirm-delete { background: #e74c3c; color: #fff; border: none; border-radius: 8px; padding: 9px 22px; font-weight: 600; cursor: pointer; }
        .btn-confirm-delete:hover { background: #c0392b; }
    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-3">

            <c:if test="${not empty flashMsg}">
                <div class="flash-toast ${flashType}" id="flashToast">
                    <i class="bi ${flashType eq 'success' ? 'bi-check-circle-fill' : 'bi-exclamation-circle-fill'}"></i>
                    <span>${flashMsg}</span>
                    <i class="bi bi-x close-toast" onclick="this.closest('.flash-toast').remove()"></i>
                </div>
            </c:if>

            <div class="voucher-header-card">
                <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                    <div>
                        <h2><i class="bi bi-ticket-perforated me-2"></i>Quản lý Voucher</h2>
                        <p>Tạo và quản lý mã giảm giá cho khách hàng AuraSound</p>
                    </div>
                    <button class="btn-add-voucher" data-bs-toggle="modal" data-bs-target="#addVoucherModal">
                        <i class="bi bi-plus-circle me-1"></i> Tạo Voucher
                    </button>
                </div>
            </div>

            <c:set var="cntTotal"   value="0" />
            <c:set var="cntActive"  value="0" />
            <c:set var="cntExpired" value="0" />
            <c:forEach items="${voucher}" var="v">
                <c:set var="cntTotal" value="${cntTotal + 1}" />
                <c:choose>
                    <c:when test="${v.endDate != null and v.endDate.isBefore(java.time.LocalDateTime.now())}">
                        <c:set var="cntExpired" value="${cntExpired + 1}" />
                    </c:when>
                    <c:when test="${v.usageLimit > 0}">
                        <c:set var="cntActive" value="${cntActive + 1}" />
                    </c:when>
                </c:choose>
            </c:forEach>

            <div class="d-flex gap-3 mb-4 flex-wrap">
                <div class="stat-pill">
                    <div class="icon" style="background:#eef0ff;color:#667eea"><i class="bi bi-ticket-perforated"></i></div>
                    <div><p class="label">Tổng voucher</p><p class="value">${cntTotal}</p></div>
                </div>
                <div class="stat-pill">
                    <div class="icon" style="background:#e8f8f1;color:#1a9e5c"><i class="bi bi-check-circle"></i></div>
                    <div><p class="label">Đang hoạt động</p><p class="value">${cntActive}</p></div>
                </div>
                <div class="stat-pill">
                    <div class="icon" style="background:#fff1f1;color:#e74c3c"><i class="bi bi-x-circle"></i></div>
                    <div><p class="label">Đã hết hạn</p><p class="value">${cntExpired}</p></div>
                </div>
            </div>

            <div class="voucher-table-wrap">
                <div class="table-toolbar">
                    <i class="bi bi-search text-muted"></i>
                    <input type="text" id="searchInput" placeholder="Tìm theo mã voucher...">
                    <span class="ms-auto text-muted" style="font-size:.82rem">
                        Hiển thị <strong id="rowCount">${cntTotal}</strong> voucher
                    </span>
                </div>

                <div class="table-responsive">
                    <table class="table" id="voucherTable">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Mã Voucher</th>
                            <th>Giảm (đ)</th>
                            <th>Đơn tối thiểu</th>
                            <th>Lượt còn lại</th>
                            <th>Ngày hết hạn</th>
                            <th>Ngày tạo</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty voucher}">
                                <tr>
                                    <td colspan="9">
                                        <div class="empty-state">
                                            <i class="bi bi-ticket-perforated"></i>
                                            <p>Chưa có voucher nào. Hãy tạo voucher đầu tiên!</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${voucher}" var="v" varStatus="st">
                                    <c:set var="expired" value="${v.endDate != null and v.endDate.isBefore(java.time.LocalDateTime.now())}" />
                                    <c:set var="usedUp"  value="${v.usageLimit <= 0}" />

                                    <tr>
                                        <td class="text-muted">${st.index + 1}</td>

                                        <td>
                                            <span class="code-badge" onclick="copyCode('${v.code}', this)" title="Nhấn để sao chép">
                                                <i class="bi bi-clipboard"></i>${v.code}
                                            </span>
                                        </td>

                                        <td><strong style="color:#764ba2"><fmt:formatNumber value="${v.discountAmount}" pattern="#,###"/>đ</strong></td>

                                        <td><fmt:formatNumber value="${v.minimumOrderAmount}" pattern="#,###"/>đ</td>

                                        <td>
                                            <span style="font-weight:600">${v.usageLimit}</span>
                                            <c:if test="${v.usageLimit <= 0}">
                                                <span class="text-danger ms-1" style="font-size:.78rem">(Hết)</span>
                                            </c:if>
                                            <c:if test="${v.usageLimit > 0 and v.usageLimit <= 5}">
                                                <span class="text-warning ms-1" style="font-size:.78rem">(Sắp hết)</span>
                                            </c:if>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${v.endDate != null}">
                                                    ${v.endDate.format(java.time.format.DateTimeFormatter.ofPattern('dd/MM/yyyy HH:mm'))}
                                                </c:when>
                                                <c:otherwise><span class="text-muted">Không giới hạn</span></c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td class="text-muted" style="font-size:.82rem">
                                            <c:choose>
                                                <c:when test="${v.createdAt != null}">
                                                    ${v.createdAt.format(java.time.format.DateTimeFormatter.ofPattern('dd/MM/yyyy HH:mm'))}
                                                </c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${expired}">
                                                    <span class="status-expired"><i class="bi bi-clock-history me-1"></i>Hết hạn</span>
                                                </c:when>
                                                <c:when test="${usedUp}">
                                                    <span class="status-used-up"><i class="bi bi-dash-circle me-1"></i>Hết lượt</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-active"><i class="bi bi-lightning-charge me-1"></i>Hoạt động</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <button class="btn-tbl-delete" onclick="confirmDelete(${v.id}, '${v.code}')">
                                                <i class="bi bi-trash me-1"></i>Xóa
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </main>
    </div>
</div>

<div class="modal fade" id="addVoucherModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Tạo Voucher Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="${pageContext.request.contextPath}/admin/voucher" method="post" id="addVoucherForm" novalidate>
                <input type="hidden" name="action" value="add">

                <div class="modal-body">
                    <c:if test="${not empty errorMsg}">
                        <div class="alert alert-danger py-2 px-3 mb-3" style="border-radius:9px;font-size:.88rem">
                            <i class="bi bi-exclamation-circle me-1"></i>${errorMsg}
                        </div>
                    </c:if>

                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Mã Voucher <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text" style="border-radius:9px 0 0 9px;border-color:#ddd">
                                    <i class="bi bi-ticket-perforated text-muted"></i>
                                </span>
                                <input type="text" class="form-control" name="code" id="voucherCode"
                                       value="${formCode}" placeholder="VD: SUMMER2026"
                                       style="text-transform:uppercase;border-radius:0 9px 9px 0"
                                       maxlength="30" required>
                            </div>
                            <small class="form-text">Chỉ dùng chữ IN HOA, số, dấu _ hoặc - (3–30 ký tự)</small>
                        </div>

                        <%-- Số tiền giảm --%>
                        <div class="col-md-6">
                            <label class="form-label">Số tiền giảm (đ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="discountAmount"
                                       value="${formDiscount}" placeholder="50000" min="1000" step="1000"
                                       style="border-radius:9px 0 0 9px" required>
                                <span class="input-group-text" style="border-radius:0 9px 9px 0;border-color:#ddd">đ</span>
                            </div>
                        </div>

                        <%-- Đơn tối thiểu --%>
                        <div class="col-md-6">
                            <label class="form-label">Đơn tối thiểu (đ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="minimumOrderAmount"
                                       value="${formMinOrder}" placeholder="200000" min="0" step="1000"
                                       style="border-radius:9px 0 0 9px" required>
                                <span class="input-group-text" style="border-radius:0 9px 9px 0;border-color:#ddd">đ</span>
                            </div>
                            <small class="form-text">Nhập 0 nếu không giới hạn</small>
                        </div>

                        <%-- Số lượt dùng --%>
                        <div class="col-md-6">
                            <label class="form-label">Số lượt dùng <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text" style="border-radius:9px 0 0 9px;border-color:#ddd">
                                    <i class="bi bi-people text-muted"></i>
                                </span>
                                <input type="number" class="form-control" name="usageLimit"
                                       value="${formUsageLimit}" placeholder="100" min="1"
                                       style="border-radius:0 9px 9px 0" required>
                            </div>
                        </div>

                        <%-- Ngày hết hạn --%>
                        <div class="col-md-6">
                            <label class="form-label">Ngày hết hạn</label>
                            <input type="datetime-local" class="form-control" name="endDate"
                                   value="${formEndDate}" id="endDateInput">
                            <small class="form-text">Để trống = không giới hạn thời gian</small>
                        </div>

                        <%-- Live preview --%>
                        <div class="col-12">
                            <div style="background:#fdf8ff;border:1px dashed #c8aaed;border-radius:10px;padding:12px 16px">
                                <small class="text-muted d-block mb-1" style="font-weight:600">Xem trước:</small>
                                <span class="code-badge" style="cursor:default">
                                    <i class="bi bi-ticket-perforated"></i>
                                    <span id="previewCode">VOUCHER</span>
                                </span>
                                <span class="ms-2" style="font-size:.85rem;color:#555" id="previewDiscount">
                                    Giảm <strong>0đ</strong>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal" style="border-radius:9px;font-size:.9rem">Hủy</button>
                    <button type="submit" class="btn-submit-voucher"><i class="bi bi-check-circle me-1"></i>Tạo Voucher</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="confirmDeleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title"><i class="bi bi-exclamation-triangle me-2"></i>Xác nhận xóa</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center py-4">
                <p class="mb-1">Bạn muốn xóa voucher</p>
                <span class="code-badge" style="cursor:default" id="deleteCodeDisplay">—</span>
                <p class="mt-2 mb-0 text-muted" style="font-size:.83rem">Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-footer justify-content-center gap-2">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal" style="border-radius:8px">Hủy</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/voucher" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="deleteId">
                    <button type="submit" class="btn-confirm-delete"><i class="bi bi-trash me-1"></i>Xóa ngay</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptAdmin.js"></script>

<script>
    //js
    (function () {
        const shouldOpen = ${ not empty showModal or not empty errorMsg };
        if (shouldOpen) {
            new bootstrap.Modal(document.getElementById('addVoucherModal')).show();
        }
    })();

    (function () {
        const toast = document.getElementById('flashToast');
        if (!toast) return;
        setTimeout(() => {
            toast.style.transition = 'opacity .4s';
            toast.style.opacity = '0';
            setTimeout(() => toast.remove(), 400);
        }, 4000);
    })();

    const codeInput     = document.getElementById('voucherCode');
    const discountInput = document.querySelector('input[name="discountAmount"]');

    function updatePreview() {
        const code   = (codeInput.value || 'VOUCHER').toUpperCase();
        const amount = parseInt(discountInput.value) || 0;
        codeInput.value = code; // force uppercase ngay khi nhập
        document.getElementById('previewCode').textContent = code;
        document.getElementById('previewDiscount').innerHTML =
            'Giảm <strong>' + amount.toLocaleString('vi-VN') + 'đ</strong>';
    }
    codeInput.addEventListener('input', updatePreview);
    discountInput.addEventListener('input', updatePreview);

    function confirmDelete(id, code) {
        document.getElementById('deleteId').value        = id;
        document.getElementById('deleteCodeDisplay').textContent = code;
        new bootstrap.Modal(document.getElementById('confirmDeleteModal')).show();
    }

    function copyCode(code, el) {
        navigator.clipboard.writeText(code).then(() => {
            const orig = el.innerHTML;
            el.innerHTML = '<i class="bi bi-check2"></i> Đã sao chép!';
            el.style.background = '#e8f8f1';
            el.style.color = '#1a9e5c';
            setTimeout(() => {
                el.innerHTML = orig;
                el.style.background = '';
                el.style.color = '';
            }, 1800);
        });
    }

    document.getElementById('searchInput').addEventListener('input', function () {
        const keyword = this.value.toLowerCase().trim();
        const rows    = document.querySelectorAll('#voucherTable tbody tr');
        let visible   = 0;
        rows.forEach(row => {
            const badge = row.querySelector('.code-badge');
            if (!badge) { row.style.display = ''; return; }
            const match = !keyword || badge.textContent.toLowerCase().includes(keyword);
            row.style.display = match ? '' : 'none';
            if (match) visible++;
        });
        document.getElementById('rowCount').textContent = visible;
    });

    (function () {
        const inp = document.getElementById('endDateInput');
        if (!inp) return;
        const now = new Date();
        now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
        inp.min = now.toISOString().slice(0, 16);
    })();
</script>
</body>
</html>
