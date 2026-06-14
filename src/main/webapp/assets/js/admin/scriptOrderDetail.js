$(document).ready(function() {
    const contextPath = window.APP_CONTEXT || '';

    console.log("[Hệ thống] Đã nạp thành công Module điều khiển giao diện Chi tiết đơn hàng (Admin).");

    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

});