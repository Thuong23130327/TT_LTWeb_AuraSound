<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - AuraSound</title>

    <link rel="stylesheet" href="assets/css/styleHome.css">
    <link rel="stylesheet" href="assets/css/styleLogin.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.0.0/css/all.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
            rel="stylesheet">
</head>

<body>

<div class="container" id="container">
    <div class="form-container sign-up">
        <form action="register" method="post">
            <h1>Đăng ký</h1>
            <input type="text" name="fullname" value="${fullname}" placeholder=" Họ và tên" required/>
            <input type="email" name="email" value="${regEmail}" placeholder=" Email" required/>
            <input type="password" name="password" id="regPassword" placeholder="Password" required/>

            <ul id="password-requirements" class="requirement-list">
                <li id="length" class="invalid">Ít nhất 8 ký tự</li>
                <li id="uppercase" class="invalid">Có ít nhất 1 chữ hoa</li>
                <li id="lowercase" class="invalid">Có ít nhất 1 chữ thường</li>
                <li id="number" class="invalid">Có ít nhất 1 chữ số</li>
                <li id="special" class="invalid">Có ít nhất 1 ký tự đặc biệt (@$!%*?&...)</li>
            </ul>

            <input type="password" name="repassword" id="rePassword" placeholder="Nhập lại password" required/>
            <span class="text-danger">${registerError}</span>
            <ul id="password-requirements" class="requirement-list">
                <li id="match" class="invalid">Mật khẩu nhập lại phải trùng khớp</li>
            </ul>

            <button type="submit" id="signUp">Đăng Ký</button>
        </form>
    </div>

    <div class="form-container sign-in">
        <form action="login" method="post">
            <h1>Đăng Nhập</h1>
            <div class="social-icons">
                <a href="https://accounts.google.com/o/oauth2/auth?scope=email+profile+openid&redirect_uri=http://localhost:8080/AuraSound_war/login&response_type=code&client_id=462941574651-08lfhtvomnhq4qhotkei01r5eu6uougj.apps.googleusercontent.com&approval_prompt=force"
                   class="icon">
                    <i class="fa-brands fa-google-plus-g"></i>
                </a>
                <a href="#" class="icon">
                    <i class="fa-brands fa-facebook-f"></i>
                </a>
                <a href="admin/admin.jsp" class="icon">
                    <i class="fa-brands fa-github"></i>
                </a>
                <a href="#" class="icon">
                    <i class="fa-brands fa-linkedin-in"></i>
                </a>
            </div>
            <input type="email" name="email" value="${loginEmail}" placeholder="Nhập Email"/>
            <input type="password" name="password" placeholder="Password"/>
            <p class="text-danger">${error}
            </p>
            <a href="#">Quên mật khẩu?</a>
            <span class="text-success">${registerMessage}</span>
            <button type="submit" id="signIn">Đăng Nhập</button>
            </a>
        </form>
    </div>

    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-left">
                <h1>Xin Chào!</h1>
                <p>
                    Đăng ký thông tin cá nhân của bạn để để nhận nhiều ưu đãi nhé! <br> Nhấn nút Đăng Nhập nếu bạn đã có
                    tài khoản
                </p>
                <button class="hidden" id="login">Đăng Nhập</button>
            </div>
            <div class="toggle-panel toggle-right">
                <h1>Chào Mừng Quay Lại!</h1>
                <p>
                    Nhập thông tin cá nhân của bạn để sử dụng trang web <br> Nếu chưa có tài khoản, Nhấn nút Đăng Kí để
                    nhận nhiều ưu đãi nhé!
                </p>
                <button class="hidden" id="register">Đăng Ký</button>

            </div>
        </div>
    </div>
</div>
<script src="assets/js/scriptLogin.js"></script>
<%
    if (request.getAttribute("registerError") != null) {
%>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const container = document.getElementById('container');
        if (container) {
            container.classList.add("active");
        }
    });
</script>
<% } %>

</body>
</html>