
function showNotify(title, text, icon) {
    Swal.fire({
        title: title,
        text: text,
        icon: icon,
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'Đồng ý',
        timer: 3000,
        timerProgressBar: true
    });
}

document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector('form');
    const email = document.getElementById('ContactEmail');
    const phone = document.getElementById('ContactPhone');
    const message = document.getElementById('c-message');

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const phoneRegex = /^0[35789]\d{8}$/;

    function showError(input, isError) {
        const group = input.parentElement;
        if (isError) {
            group.classList.add('error');
        } else {
            group.classList.remove('error');
        }
    }
    email.addEventListener('blur', () => showError(email, !emailRegex.test(email.value)));
    phone.addEventListener('blur', () => showError(phone, !phoneRegex.test(phone.value)));
    message.addEventListener('blur', () => showError(message, message.value.trim() === ""));

    window.validateFinal = function () {
        let isEmailValid = emailRegex.test(email.value);
        let isPhoneValid = phoneRegex.test(phone.value);
        let isMessageValid = message.value.trim() !== "";

        showError(email, !isEmailValid);
        showError(phone, !isPhoneValid);
        showError(message, !isMessageValid);

        if (isEmailValid && isPhoneValid && isMessageValid) {
            return true;
        }
        return false;
    };

});