<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/tag/_taglibs.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${pageTitle}</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAdmin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleHome.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAdmin.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/styleOrder.css">
</head>

<body>
<div id="realtimeToastContainer"></div>

<div class="container-fluid">
  <div class="row">
    <jsp:include page="/WEB-INF/tag/_adminMenu.jsp"/>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-3">
      <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
        <h2 class="section-title text-primary" style="margin-top: 0; margin-bottom: .5rem; font-weight: 500; line-height: 1.2;">Quản lý Đơn hàng</h2>
      </div>

      <c:set var="totalOrders" value="0"/>
      <c:set var="pendingOrders" value="0"/>
      <c:forEach items="${orderList}" var="o">
        <c:set var="totalOrders" value="${totalOrders + 1}"/>
        <c:if test="${o.status == 0}">
          <c:set var="pendingOrders" value="${pendingOrders + 1}"/>
        </c:if>
      </c:forEach>

      <div class="d-flex gap-3 mb-4 flex-wrap">
        <div class="stat-pill">
          <div class="stat-icon icon-total"><i class="bi bi-box-seam"></i></div>
          <div>
            <p class="stat-label">Tổng Đơn Hàng</p>
            <p class="stat-value" id="totalOrderCountDisplay">${totalOrders}</p>
          </div>
        </div>
        <div class="stat-pill">
          <div class="stat-icon icon-pending"><i class="bi bi-hourglass-split"></i></div>
          <div>
            <p class="stat-label">Chờ Xác Nhận</p>
            <p class="stat-value text-warning">${pendingOrders}</p>
          </div>
        </div>
      </div>

      <div class="user-table-wrap">
        <div class="table-responsive">
          <table class="table table-hover align-middle" id="orderManagementTable">
            <thead>
            <tr>
              <th>Mã Đơn</th>
              <th>Khách Hàng</th>
              <th>Ngày Đặt</th>
              <th>Tổng Tiền</th>
              <th>Trạng Thái Đơn</th>
              <th>Thao Tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orderList}" var="o">
              <tr>
                <td><span class="code-badge">${o.orderCode}</span></td>
                <td><strong>${o.recipientName}</strong></td>
                <td class="text-muted" style="font-size: .85rem;">${o.orderDate}</td>
                <td class="text-danger fw-bold">
                  <fmt:formatNumber value="${o.finalAmount}" pattern="#,###"/> đ
                </td>
                <td>
                    <span class="badge bg-${o.statusClass}">
                        ${o.EOrderStatus != null ? o.EOrderStatus.name() : "PENDING"}
                    </span>
                </td>
                <td>
                  <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/admin/order-detail?id=${o.id}" class="btn btn-sm btn-outline-primary">
                      <i class="bi bi-eye"></i> Xem
                    </a>
                    <button class="btn btn-sm btn-outline-success update-status-btn"
                            data-id="${o.id}"
                            data-code="${o.orderCode}"
                            data-status="${o.status}"
                            data-bs-toggle="modal"
                            data-bs-target="#statusModal">
                      <i class="bi bi-pencil-square"></i> Cập nhật
                    </button>
                  </div>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>
</div>

<div class="modal fade" id="statusModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content">
      <div class="modal-header py-2 bg-light">
        <h6 class="modal-title fw-bold text-primary">Cập nhật đơn <span id="lblOrderCode"></span></h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body py-3">
        <input type="hidden" id="hidOrderId">
        <label class="form-label fw-bold small mb-1">Chọn trạng thái mới</label>
        <select id="selOrderStatus" class="form-select form-select-sm">
          <option value="0">PENDING (Chờ xử lý)</option>
          <option value="1">SHIPPING (Đang giao)</option>
          <option value="2">COMPLETED (Hoàn thành)</option>
          <option value="3">CANCELLED (Đã hủy đơn)</option>
        </select>
      </div>
      <div class="modal-footer py-1 bg-light">
        <button type="button" class="btn btn-sm btn-light" data-bs-dismiss="modal">Đóng</button>
        <button type="button" id="btnSubmitStatus" class="btn btn-sm btn-primary px-3">Lưu dữ liệu</button>
      </div>
    </div>
  </div>
</div>

<script>
  window.APP_CONTEXT = '${pageContext.request.contextPath}';
</script>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scriptAdmin.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin/scriptOrder.js"></script>
</body>
</html>