<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - AuraSound</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styleAuth.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="auth-container">
    <h2>Đặt Lại Mật Khẩu</h2>
    <p>Vui lòng nhập mật khẩu mới cho tài khoản của bạn.</p>

    <form id="resetPasswordForm">
        <input type="hidden" name="token" value="${param.token}" />

        <input type="password" name="password" id="newPassword" placeholder="Mật khẩu mới" required />

        <ul id="password-requirements" class="requirement-list text-start" style="list-style: none; padding-left: 0; font-size: 0.85rem; margin-top: 5px; margin-bottom: 15px;">
            <li id="length" class="text-danger">Ít nhất 8 ký tự</li>
            <li id="uppercase" class="text-danger">Có ít nhất 1 chữ hoa</li>
            <li id="lowercase" class="text-danger">Có ít nhất 1 chữ thường</li>
            <li id="number" class="text-danger">Có ít nhất 1 chữ số</li>
            <li id="special" class="text-danger">Có ít nhất 1 ký tự đặc biệt (@$!%*?&...)</li>
        </ul>

        <input type="password" name="repassword" id="reNewPassword" placeholder="Nhập lại mật khẩu mới" required />

        <span class="text-danger d-block text-start mb-2" id="err-reset-msg" style="font-size: 0.85rem;"></span>
        <span class="text-success d-block text-start mb-2" id="success-reset-msg" style="font-size: 0.85rem;"></span>

        <button type="submit" class="auth-btn" id="btnSubmitReset" disabled>Cập Nhật Mật Khẩu</button>
    </form>
</div>

<script src="${pageContext.request.contextPath}/assets/js/scriptAuth.js"></script>
</body>
</html>