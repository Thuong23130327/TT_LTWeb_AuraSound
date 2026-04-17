<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - AuraSound</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAuth.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="auth-container">
    <h2>Quên Mật Khẩu?</h2>
    <p>Nhập email đăng ký của bạn. Chúng tôi sẽ gửi một liên kết để đặt lại mật khẩu.</p>

    <form id="forgotPasswordForm">
        <input type="email" name="email" id="emailInput" placeholder="Nhập địa chỉ Email" required />
        <span class="text-danger d-block text-start mb-2" id="err-forgot-msg" style="font-size: 0.85rem;"></span>
        <span class="text-success d-block text-start mb-2" id="success-forgot-msg" style="font-size: 0.85rem;"></span>

        <button type="submit" class="auth-btn" id="btnSubmitForgot">Gửi Liên Kết Xác Nhận</button>
    </form>

    <a href="${pageContext.request.contextPath}/login" class="back-link">Quay lại trang Đăng Nhập</a>
</div>

<script src="${pageContext.request.contextPath}/assets/js/scriptAuth.js"></script>
</body>
</html>