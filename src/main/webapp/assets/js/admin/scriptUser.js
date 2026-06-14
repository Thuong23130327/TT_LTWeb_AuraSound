$(document).ready(function () {
    let cachedUserCount = parseInt($('#totalUserCountDisplay').text()) || 0;

    var userTable = $('#userManagementTable').DataTable({
        "paging": true,
        "lengthChange": false,
        "searching": true,
        "ordering": true,
        "info": false,
        "autoWidth": false,
        "dom": "rtip",
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json"
        }
    });

    $('#customSearchInput').on('keyup input', function () {
        userTable.search(this.value).draw();
        $('#rowCountDisplay').text(userTable.page.info().recordsDisplay);
    });

    function performUserPolling() {
        $.ajax({
            url: APP_CONTEXT + '/admin/user-manager',
            type: 'GET',
            data: { action: 'checkCount' },
            dataType: 'json',
            success: function (data) {
                if (data.totalCount > cachedUserCount) {
                    triggerRealtimeAlert("Đăng ký mới!", "Hệ thống vừa ghi nhận có tài khoản người dùng mới tạo thành công.");
                    cachedUserCount = data.totalCount;

                    setTimeout(function () {
                        location.reload();
                    }, 2500);
                }
            },
            error: function () {
                console.log("Hệ thống Polling kiểm tra tài khoản tạm thời gián đoạn.");
            }
        });
    }
    setInterval(performUserPolling, 7000);

    function triggerRealtimeAlert(title, content) {
        let alertTemplate = `
            <div class="flash-toast">
                <i class="bi bi-person-plus-fill" style="color:var(--theme-color-primary); font-size:1.4rem;"></i>
                <div>
                    <strong style="font-size:0.9rem; display:block; color:#222;">${title}</strong>
                    <span style="font-size:0.83rem; color:#666;">${content}</span>
                </div>
                <i class="bi bi-x text-muted" style="cursor:pointer; margin-left:10px;" onclick="$(this).closest('.flash-toast').remove()"></i>
            </div>
        `;
        $('#realtimeToastContainer').html(alertTemplate);
    }

    $(document).on('click', '.toggle-lock-trigger', function () {
        let button = $(this);
        let email = button.data('email');
        let isLocked = button.data('locked');
        let confirmMsg = isLocked ? "Bạn muốn MỞ KHÓA tài khoản [" + email + "]?" : "Bạn muốn KHÓA tài khoản [" + email + "]?";

        if (confirm(confirmMsg)) {
            $.ajax({
                url: APP_CONTEXT + '/admin/user-manager', // Đã sửa
                type: 'POST',
                data: { action: 'toggleLock', email: email, isLocked: isLocked },
                success: function (response) {
                    if (response.status === 'success') {
                        location.reload();
                    } else {
                        alert("Thao tác thất bại: " + (response.message || "Lỗi quyền thực thi."));
                    }
                }
            });
        }
    });

    $(document).on('click', '.edit-role-trigger', function () {
        $('#hidUserId').val($(this).data('id'));
        $('#lblTargetUser').text($(this).data('name'));
        $('#selUserRole').val($(this).data('roleid'));
    });

    $('#btnSubmitChangeRole').on('click', function () {
        let userId = $('#hidUserId').val();
        let roleId = $('#selUserRole').val();

        $.ajax({
            url: APP_CONTEXT + '/admin/user-manager', // Đã sửa
            type: 'POST',
            data: { action: 'changeRole', userId: userId, roleId: roleId },
            success: function (response) {
                if (response.status === 'success') {
                    location.reload();
                } else {
                    alert("Cập nhật phân quyền không thành công.");
                }
            }
        });
    });
});