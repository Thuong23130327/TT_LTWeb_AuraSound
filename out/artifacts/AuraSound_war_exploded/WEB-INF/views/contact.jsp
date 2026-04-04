<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../tag/_taglibs.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.7.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>

<%--css--%>
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleStore.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleHome.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleProfile.css">
    <link rel="stylesheet" href="${AuraSound}/assets/css/styleContact.css">
</head>

<body>
<jsp:include page="/WEB-INF/tag/_header.jsp"></jsp:include>

<main>
    <div class="contact-header">
        <h2>Liên hệ AuraSound</h2>
        <p>Bạn muốn để lại lời nhắn hay hợp tác công việc? Đừng ngần ngại điền form nhé!</p>
    </div>

    <section id="form-details">
        <form action="${pageContext.request.contextPath}/contact" method="post" onsubmit="return validateFinal()">

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <div class="input-group">
                <input type="text" id="ContactName" name="name"
                       value="${not empty name ? name : auth.fullName}"
                       placeholder="Họ tên" autocomplete="off">
            </div>

            <div class="input-group">
                <input type="email" id="ContactEmail" name="email"
                       value="${not empty email ? email : auth.email}"
                       placeholder="E-mail" autocomplete="off">
                <small class="error-msg">Email không đúng định dạng</small>
            </div>

            <div class="input-group">
                <input type="tel" id="ContactPhone" name="phone"
                       value="${not empty phone ? phone : auth.phone}"
                       placeholder="Số điện thoại" autocomplete="off">
                <small class="error-msg">Số điện thoại sai</small>
            </div>

            <div class="input-group">
                <textarea id="c-message" name="message" cols="30" rows="10" placeholder="Lời nhắn">${message}</textarea>
                <small class="error-msg">Vui lòng nhập lời nhắn</small>
            </div>

            <button type="submit" class="send-btn">Gửi</button>
        </form>
    </section>

    <section id="contact-details" class="section-p1">
        <div class="details">
            <h3>LIÊN HỆ</h3>
            <h2>AuraSound có mặt chính hãng duy nhất tại</h2>
            <div class="info-list">
                <li><i class="fal fa-map"></i> <p>Nong Lam University, Thủ Đức, TP. Hồ Chí Minh</p></li>
                <li><i class="fal fa-envelope"></i> <p>Aurasound.work@gmail.com</p></li>
                <li><i class="fal fa-phone-alt"></i> <p>1900 1919</p></li>
                <li><i class="fal fa-clock"></i> <p>9:00 - 22:00 (Thứ 2 - Chủ Nhật)</p></li>
            </div>
        </div>

        <div class="map">
            <iframe
                    src="https://maps.google.com/maps?q=Trường%20Đại%20học%20Nông%20Lâm%20TP.HCM,%20Thủ%20Đức,%20Hồ%20Chí%20Minh&t=&z=16&ie=UTF8&iwloc=&output=embed"
                    width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>

<%--js--%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const emailEl = document.getElementById('ContactEmail');
        const messageEl = document.getElementById('c-message');

        const showResult = (el, isValid) => {
            const parent = el.parentElement;
            if (isValid) {
                parent.classList.add('success');
                parent.classList.remove('error');
            } else {
                parent.classList.add('error');
                parent.classList.remove('success');
            }
        };

        emailEl.addEventListener('input', () => {
            const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            showResult(emailEl, regex.test(emailEl.value));
        });

        messageEl.addEventListener('input', () => {
            showResult(messageEl, messageEl.value.trim() !== '');
        });
    });

    function validateFinal() {
        const emailEl = document.getElementById('ContactEmail');
        const messageEl = document.getElementById('c-message');

        const isEmailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailEl.value);
        const isMsgValid = messageEl.value.trim() !== '';

        if (!isEmailValid || !isMsgValid) {
            alert("Vui lòng điền đúng định dạng Email và Lời nhắn!");
            return false;
        }
        return true;
    }
</script>
</body>
</html>