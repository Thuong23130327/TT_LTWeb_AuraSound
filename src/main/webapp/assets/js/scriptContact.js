document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector('form');
    const email = document.getElementById('ContactEmail');
    const phone = document.getElementById('ContactPhone');
    const message = document.getElementById('c-message');

    // Các biểu thức Regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^0[35789]\d{8}$/;

    // Hàm hiển thị lỗi
    function showError(input, isError) {
        const group = input.parentElement;
        if (isError) {
            group.classList.add('error');
        } else {
            group.classList.remove('error');
        }
    }

    // Kiểm tra trực tiếp khi người dùng rời khỏi ô nhập (Blur)
    email.addEventListener('blur', () => showError(email, !emailRegex.test(email.value)));
    phone.addEventListener('blur', () => showError(phone, !phoneRegex.test(phone.value)));
    message.addEventListener('blur', () => showError(message, message.value.trim() === ""));

    // Hàm validate cuối cùng khi submit
    window.validateFinal = function() {
        let isEmailValid = emailRegex.test(email.value);
        let isPhoneValid = phoneRegex.test(phone.value);
        let isMessageValid = message.value.trim() !== "";

        showError(email, !isEmailValid);
        showError(phone, !isPhoneValid);
        showError(message, !isMessageValid);

        if (isEmailValid && isPhoneValid && isMessageValid) {
            return true; // Cho phép submit
        }
        return false; // Chặn submit
    };
});