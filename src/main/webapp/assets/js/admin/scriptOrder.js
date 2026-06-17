$(document).ready(function() {
    if ($('#orderManagementTable').length) {
        $('#orderManagementTable').DataTable({
            language: { url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json' },
            order: [[2, 'desc']]
        });
    }

    let currentOrderCount = parseInt($('#totalOrderCountDisplay').text().trim()) || 0;
    const contextPath = window.APP_CONTEXT || '';
    setInterval(function() {
        $.ajax({
            url: contextPath + '/admin/manage-order',
            type: 'GET',
            data: { action: 'checkCount' },
            success: function(response) {
                if (response && response.totalCount > currentOrderCount) {
                    currentOrderCount = response.totalCount;

                    showRealtimeNotification(
                        "🔔 HỆ THỐNG CÓ ĐƠN HÀNG MỚI!",
                        "Một đơn đặt hàng vừa được phát sinh. Đang tự động cập nhật danh sách..."
                    );

                    setTimeout(function() {
                        location.reload();
                    }, 2500);
                }
            },
            error: function() {
                console.warn("Không thể kết nối kiểm tra đồng bộ đơn hàng.");
            }
        });
    }, 7000);

    function showRealtimeNotification(title, msg) {
        let toastHtml = `
            <div class="flash-toast">
                <i class="bi bi-bell-fill text-primary" style="font-size: 1.5rem;"></i>
                <div>
                    <h6 class="mb-0 fw-bold text-dark">${title}</h6>
                    <small class="text-muted" style="font-size: 0.8rem;">${msg}</small>
                </div>
            </div>`;
        let $toast = $(toastHtml).appendTo('#realtimeToastContainer');

        setTimeout(() => {
            $toast.fadeOut(400, function(){
                $(this).remove();
            });
        }, 2500);
    }

    $(document).on('click', '.update-status-btn', function() {
        let orderId = $(this).data('id');
        let orderCode = $(this).data('code');
        let currentStatus = $(this).data('status');

        $('#hidOrderId').val(orderId);
        $('#lblOrderCode').text(orderCode);
        $('#selOrderStatus').val(currentStatus);

        // Logic chống nhảy cóc bước
        let $select = $('#selOrderStatus');
        let $helper = $('#statusHelper');
        $select.find('option').prop('disabled', false); // Reset
        $helper.hide();

        currentStatus = parseInt(currentStatus);
        if (currentStatus === 0) { // Pending
            $select.find('option[value="2"]').prop('disabled', true); // Cannot go straight to Completed
            $helper.text('* Đơn chờ xử lý không thể chuyển thẳng sang Hoàn thành.').show();
        } else if (currentStatus === 1) { // Shipping
            $select.find('option[value="0"]').prop('disabled', true); // Cannot go back to Pending
            $helper.text('* Đơn đang giao không thể quay lại Chờ xử lý.').show();
        } else if (currentStatus === 2 || currentStatus === 3) { // Completed or Cancelled
            $select.find('option').prop('disabled', true);
            $select.find(`option[value="${currentStatus}"]`).prop('disabled', false);
            $helper.text('* Đơn hàng đã kết thúc, không thể thay đổi trạng thái.').show();
        }
    });

    $('#btnSubmitStatus').click(function() {
        let orderId = $('#hidOrderId').val();
        let newStatus = $('#selOrderStatus').val();

        $.ajax({
            url: contextPath + '/admin/manage-order',
            type: 'POST',
            data: {
                action: 'updateStatus',
                orderId: orderId,
                status: newStatus
            },
            success: function(res) {
                if (res && res.status === 'success') {
                    location.reload();
                } else {
                    alert("Cảnh báo lỗi: " + (res.message || "Không rõ nguyên nhân."));
                }
            },
            error: function() {
                alert("Lỗi kết nối hệ thống máy chủ xử lý trạng thái đơn.");
            }
        });
    });
});