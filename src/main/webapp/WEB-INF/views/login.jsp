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

<div class="container ${not empty showRegisterPanel ? 'active' : ''}" id="container">
    <div class="form-container sign-up">
        <form id="registerForm" action="register" method="post">
            <h1>Đăng ký</h1>

            <div id="step-email">
                <input type="email" name="email" id="regEmail" value="${regEmail}" placeholder="Email" required />
                <span class="inline-error" id="emailError">${errorEmail}</span>

                <button type="button" id="btnSendMagicLink" class="mt-2">Gửi link xác thực qua Email</button>
                <div id="mailStatus" class="mt-2" style="font-size: 0.85rem;"></div>
            </div>

            <div id="step-info" style="display: none; width: 100%;">
                <input type="text" name="fullname" value="${fullname}" placeholder="Họ và tên" />
                <span class="inline-error">${errorFullname}</span>

                <input type="password" name="password" id="regPassword" placeholder="Password" />
                <input type="password" name="repassword" id="rePassword" placeholder="Nhập lại password" />

                <button type="submit" id="btnSubmitRegister">Hoàn tất Đăng Ký</button>
            </div>

            <span class="text-danger" style="font-weight: bold; margin-bottom: 10px;">${registerError}</span>
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
                <a href="${AuraSound}/login-facebook" class="icon">
                    <i class="fa-brands fa-facebook-f"></i>
                </a>
            </div>

            <input type="email" name="email" value="${loginEmail}" placeholder="Nhập Email"/>
            <input type="password" name="password" placeholder="Password"/>
            <p class="text-danger">${error}
            </p>
            <a href="<%= request.getContextPath() %>/forgot-password">Quên mật khẩu?</a>
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
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);

        if (urlParams.get('status') === 'verified') {
            const container = document.getElementById('container');
            if (container) container.classList.add('active');

            // Ẩn phần nhập email, hiện phần nhập password
            const stepEmail = document.getElementById('step-email');
            const stepInfo = document.getElementById('step-info');

            if (stepEmail) stepEmail.style.display = 'none';
            if (stepInfo) stepInfo.style.display = 'block';

            // Tự động điền lại email từ session
            const verifiedEmail = "${sessionScope.verified_email}";
            const regEmailInput = document.getElementById('regEmail');
            if(verifiedEmail && regEmailInput) {
                regEmailInput.value = verifiedEmail;
                regEmailInput.readOnly = true;
            }
        }

        // 2. XỬ LÝ GỬI LINK (AJAX)
        const btnSend = document.getElementById('btnSendMagicLink');
        if (btnSend) {
            btnSend.addEventListener('click', function() {
                const emailInput = document.getElementById('regEmail');
                const email = emailInput ? emailInput.value : '';
                const statusDiv = document.getElementById('mailStatus');
                const btn = this;

                if(!email || !email.includes('@')) {
                    alert("Vui lòng nhập email hợp lệ!");
                    return;
                }

                btn.disabled = true;
                btn.innerText = "Đang gửi...";
                statusDiv.innerHTML = "<i class='fas fa-spinner fa-spin'></i> Đang xử lý, vui lòng đợi...";
                statusDiv.style.color = "gray";

                // Sử dụng contextPath để tránh lỗi đường dẫn
                const contextPath = "<%= request.getContextPath() %>";

                fetch(contextPath + '/send-magic-link?email=' + encodeURIComponent(email), {
                    method: 'POST'
                })
                    .then(response => response.json())
                    .then(data => {
                        if(data.success) {
                            statusDiv.style.color = "green";
                            statusDiv.innerHTML = "<b>Thành công!</b> Link đã được gửi vào mail của bạn.";
                            btn.style.display = "none";
                        } else {
                            statusDiv.style.color = "red";
                            statusDiv.innerHTML = "Lỗi: " + data.message;
                            btn.disabled = false;
                            btn.innerText = "Gửi lại link xác thực";
                        }
                    })
                    .catch(err => {
                        console.error("Fetch error:", err);
                        statusDiv.style.color = "red";
                        statusDiv.innerHTML = "Không thể kết nối đến server.";
                        btn.disabled = false;
                        btn.innerText = "Thử lại";
                    });
            });
        }
    });

</script>

</body>
</html>