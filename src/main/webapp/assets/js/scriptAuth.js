document.addEventListener("DOMContentLoaded", function () {

    // Xử lí quên pass(gửi mail)
    const forgotForm = document.getElementById('forgotPasswordForm');
    if (forgotForm) {
        forgotForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const btn = document.getElementById('btnSubmitForgot');
            const errSpan = document.getElementById('err-forgot-msg');
            const successSpan = document.getElementById('success-forgot-msg');

            btn.textContent = "Đang gửi mail...";
            btn.disabled = true;
            errSpan.textContent = "";
            successSpan.textContent = "";

            const formData = new URLSearchParams(new FormData(this));

            fetch('forgot-password', {
                method: 'POST',
                body: formData
            })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        successSpan.textContent = data.message;
                        document.getElementById('emailInput').value = "";
                    } else {
                        errSpan.textContent = data.error;
                    }
                })
                .catch(err => {
                    errSpan.textContent = "Có lỗi xảy ra, vui lòng thử lại.";
                })
                .finally(() => {
                    btn.textContent = "Gửi Liên Kết Xác Nhận";
                    btn.disabled = false;
                });
        });
    }

    // Validate pass & form resetpass
    const resetForm = document.getElementById('resetPasswordForm');
    const newPassword = document.getElementById('newPassword');
    const btnReset = document.getElementById('btnSubmitReset');

    if (resetForm && newPassword) {
        const reqs = {
            length: document.getElementById('length'),
            uppercase: document.getElementById('uppercase'),
            lowercase: document.getElementById('lowercase'),
            number: document.getElementById('number'),
            special: document.getElementById('special')
        };

        // Logic check mật khẩu dùng lại từ Register
        newPassword.addEventListener('input', function () {
            const val = this.value;
            validate(reqs.length, val.length >= 8);
            validate(reqs.uppercase, /[A-Z]/.test(val));
            validate(reqs.lowercase, /[a-z]/.test(val));
            validate(reqs.number, /[0-9]/.test(val));
            validate(reqs.special, /[@$!%*?&]/.test(val));

            const allValid = Object.values(reqs).every(li => li.classList.contains('valid'));
            btnReset.disabled = !allValid;
        });

        // Submit Form Đổi Mật Khẩu
        resetForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const repass = document.getElementById('reNewPassword').value;
            const errSpan = document.getElementById('err-reset-msg');
            const successSpan = document.getElementById('success-reset-msg');

            errSpan.textContent = "";
            successSpan.textContent = "";

            if (newPassword.value !== repass) {
                errSpan.textContent = "Mật khẩu nhập lại không trùng khớp!";
                return;
            }

            btnReset.textContent = "Đang xử lý...";
            btnReset.disabled = true;

            fetch('reset-password', {
                method: 'POST',
                body: new URLSearchParams(new FormData(this))
            })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        successSpan.textContent = "Đổi mật khẩu thành công! Chuyển hướng sau 3 giây...";
                        setTimeout(() => {
                            window.location.href = "login";
                        }, 3000);
                    } else {
                        errSpan.textContent = data.error;
                        btnReset.disabled = false;
                        btnReset.textContent = "Cập Nhật Mật Khẩu";
                    }
                })
                .catch(err => {
                    errSpan.textContent = "Lỗi hệ thống!";
                    btnReset.disabled = false;
                    btnReset.textContent = "Cập Nhật Mật Khẩu";
                });
        });
    }

    function validate(element, isValid) {
        if (!element) return;
        if (isValid) {
            element.classList.remove('invalid', 'text-danger');
            element.classList.add('valid', 'text-success');
        } else {
            element.classList.remove('valid', 'text-success');
            element.classList.add('invalid', 'text-danger');
        }
    }
});