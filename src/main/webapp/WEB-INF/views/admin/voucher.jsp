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
    <link rel="stylesheet" href="${AuraSound}/assets/css/admin/styleVoucher.css">
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

            <div >
                <div class="d-flex justify-content-between align-items-center gap-3 flex-wrap">
                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                        <h2 class="section-title text-primary" style="margin-top: 0; margin-bottom: .5rem; font-weight: 500; line-height: 1.2;">Quản lý Voucher</h2>
                    </div>
                    <button class="btn-add-voucher" data-bs-toggle="modal" data-bs-target="#addVoucherModal">
                        <i class="bi bi-plus-circle me-1"></i> Tạo Voucher
                    </button>
                </div>
            </div>

            <c:set var="cntTotal"   value="0"/>
            <c:set var="cntActive"  value="0"/>
            <c:set var="cntExpired" value="0"/>
            <c:forEach items="${vouchers}" var="v">
                <c:set var="cntTotal" value="${cntTotal + 1}"/>
                <c:choose>
                    <c:when test="${v.endDate != null and v.endDate.isBefore(now)}">
                        <c:set var="cntExpired" value="${cntExpired + 1}"/>
                    </c:when>
                    <c:when test="${v.usageLimit > 0}">
                        <c:set var="cntActive" value="${cntActive + 1}"/>
                    </c:when>
                </c:choose>
            </c:forEach>

            <div class="d-flex gap-3 mb-4 flex-wrap">
                <div class="stat-pill">
                    <div class="stat-icon icon-total"><i class="bi bi-ticket-perforated"></i></div>
                    <div>
                        <p class="stat-label">Tổng voucher</p>
                        <p class="stat-value">${cntTotal}</p>
                    </div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon icon-active"><i class="bi bi-check-circle"></i></div>
                    <div>
                        <p class="stat-label">Đang hoạt động</p>
                        <p class="stat-value">${cntActive}</p>
                    </div>
                </div>
                <div class="stat-pill">
                    <div class="stat-icon icon-expired"><i class="bi bi-x-circle"></i></div>
                    <div>
                        <p class="stat-label">Đã hết hạn</p>
                        <p class="stat-value">${cntExpired}</p>
                    </div>
                </div>
            </div>

            <%-- Table --%>
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
                            <c:when test="${empty vouchers}">
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
                                <c:forEach items="${vouchers}" var="v" varStatus="st">
                                    <c:set var="expired" value="${v.endDate != null and v.endDate.isBefore(now)}"/>
                                    <c:set var="usedUp"  value="${v.usageLimit <= 0}"/>
                                    <tr>
                                        <td class="text-muted">${st.index + 1}</td>
                                        <td>
                                            <span class="code-badge" onclick="copyCode('${v.code}', this)" title="Nhấn để sao chép">
                                                <i class="bi bi-clipboard"></i>${v.code}
                                            </span>
                                        </td>
                                        <td>
                                            <strong class="discount-price">
                                                <fmt:formatNumber value="${v.discountAmount}" pattern="#,###"/>đ
                                            </strong>
                                        </td>
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
                                                <c:when test="${not empty v.endDateFormatted}">
                                                    ${v.endDateFormatted}
                                                </c:when>
                                                <c:otherwise><span class="text-muted">Không giới hạn</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-muted" style="font-size:.82rem">
                                                ${v.createdAtFormatted}
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

<%-- Modal thêm voucher --%>
<div class="modal fade" id="addVoucherModal" tabindex="-1"
     data-bs-backdrop="static" data-bs-keyboard="false"
     data-should-open="${not empty showModal or not empty errorMsg}">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Tạo Voucher Mới</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/voucher" method="post"
                  id="addVoucherForm" novalidate>
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
                                       style="border-radius:0 9px 9px 0"
                                       maxlength="30" required>
                            </div>
                            <small class="form-text">Chỉ dùng chữ IN HOA, số, dấu _ hoặc - (3–30 ký tự)</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số tiền giảm (đ) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="number" class="form-control" name="discountAmount"
                                       value="${formDiscount}" placeholder="50000" min="1000" step="1000"
                                       style="border-radius:9px 0 0 9px" required>
                                <span class="input-group-text" style="border-radius:0 9px 9px 0;border-color:#ddd">đ</span>
                            </div>
                        </div>
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
                        <div class="col-md-6">
                            <label class="form-label">Ngày hết hạn</label>
                            <input type="datetime-local" class="form-control" name="endDate"
                                   value="${formEndDate}" id="endDateInput">
                            <small class="form-text">Để trống = không giới hạn thời gian</small>
                        </div>
                        <div class="col-12">
                            <div class="voucher-preview-box">
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
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal"
                            style="border-radius:9px;font-size:.9rem">Hủy</button>
                    <button type="submit" class="btn-submit-voucher">
                        <i class="bi bi-check-circle me-1"></i>Tạo Voucher
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- Modal xác nhận xóa --%>
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
                <button type="button" class="btn btn-light" data-bs-dismiss="modal"
                        style="border-radius:8px">Hủy</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/voucher" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="deleteId">
                    <button type="submit" class="btn-confirm-delete">
                        <i class="bi bi-trash me-1"></i>Xóa ngay
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${AuraSound}/assets/js/script.js"></script>
<script src="${AuraSound}/assets/js/scriptAdmin.js"></script>
<script src="${AuraSound}/assets/js/admin/scriptVoucher.js"></script>
</body>
</html>
