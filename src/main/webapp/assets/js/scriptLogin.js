const container = document.getElementById("container");
const registerBtn = document.getElementById("register");
const loginBtn = document.getElementById("login");
const passwordInput = document.getElementById('regPassword');
const signUpBtn = document.getElementById('btnSubmitRegister');
// const matchRequirement = document.getElementById('match');
const rePasswordInput = document.querySelector('input[name="repassword"]');

// Xử lí hiệu ứng
registerBtn.addEventListener("click", () => {
    container.classList.add("active");
});

loginBtn.addEventListener("click", () => {
    container.classList.remove("active");
});
document.addEventListener("DOMContentLoaded", function () {

    const requirements = {
        length: document.getElementById('length'),
        uppercase: document.getElementById('uppercase'),
        lowercase: document.getElementById('lowercase'),
        number: document.getElementById('number'),
        special: document.getElementById('special')
    };

    passwordInput.addEventListener('input', function () {
        const value = passwordInput.value;

        // 8 ky tu
        validate(requirements.length, value.length >= 8);

        // Ky tu Hoa
        validate(requirements.uppercase, /[A-Z]/.test(value));

        // Ky tu thuong
        validate(requirements.lowercase, /[a-z]/.test(value));

        // so
        validate(requirements.number, /[0-9]/.test(value));

        // Ky tu DB
        validate(requirements.special, /[@$!%*?&]/.test(value));

        const allValid = Object.values(requirements).every(li => li.classList.contains('valid'));
        signUpBtn.disabled = !allValid;
        // checkMatch();
        updateButtonState();
    });


});

function validate(element, isValid) {
    if (!element) return;
    if (isValid) {
        element.classList.remove('invalid');
        element.classList.add('valid');
    } else {
        element.classList.remove('valid');
        element.classList.add('invalid');
    }
}

// function checkMatch() {
//     const pass = passwordInput.value;
//     const rePass = rePasswordInput.value;
//
//     if (rePass !== "" && pass === rePass) {
//         matchRequirement.classList.remove('invalid');
//         matchRequirement.classList.add('valid');
//         return true;
//     } else {
//         matchRequirement.classList.remove('valid');
//         matchRequirement.classList.add('invalid');
//         return false;
//     }
// }

function updateButtonState() {
    const allRequirements = document.querySelectorAll('#password-requirements li');
    const allValid = Array.from(allRequirements).every(li => li.classList.contains('valid'));
    signUpBtn.disabled = !allValid;
}

document.addEventListener("DOMContentLoaded", function () {

    var forceShowRegister = "${showRegisterPanel}" === "true";

    if (forceShowRegister) {
        const container = document.getElementById('container');
        if (container) {
            container.classList.add("active");

            const btnRegisterToggle = document.getElementById('register');
            if (btnRegisterToggle) {
                btnRegisterToggle.click();
            }
        }
    }
    const formInputs = document.querySelectorAll('.form-container input');
    formInputs.forEach(input => {
        input.addEventListener('input', function() {
            const errorSpan = this.nextElementSibling;
            if (errorSpan && errorSpan.classList.contains('inline-error')) {
                errorSpan.textContent = '';
            }
            const generalError = document.querySelector('.text-danger[style*="font-weight: bold"]');
            if (generalError) generalError.textContent = '';
        });
    });
});