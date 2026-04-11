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

            <div class="input-group ${not empty nameError ? 'error' : ''}">
                <input type="text" id="ContactName" name="name"
                       value="${not empty name ? name : auth.fullName}"
                       placeholder="Họ tên" autocomplete="off">
                <small class="error-msg">${not empty nameError ? nameError : 'Vui lòng nhập họ tên'}</small>
            </div>

            <div class="input-group ${not empty emailError ? 'error' : ''}">
                <input type="email" id="ContactEmail" name="email"
                       value="${not empty email ? email : auth.email}"
                       placeholder="E-mail" autocomplete="off">
                <small class="error-msg">${not empty emailError ? emailError : 'Email không đúng định dạng (ví dụ: abc@gmail.com)'}</small>
            </div>

            <div class="input-group ${not empty phoneError ? 'error' : ''}">
                <input type="tel" id="ContactPhone" name="phone"
                       value="${not empty phone ? phone : auth.phone}"
                       placeholder="Số điện thoại" autocomplete="off">
                <small class="error-msg">${not empty phoneError ? phoneError : 'Số điện thoại sai (10 số, bắt đầu 03, 05, 07, 08, 09)'}</small>
            </div>

            <div class="input-group ${not empty messageError ? 'error' : ''}">
                <textarea id="c-message" name="message" cols="30" rows="10" placeholder="Lời nhắn">${message}</textarea>
                <small class="error-msg">${not empty messageError ? messageError : 'Nội dung lời nhắn không được để trống'}</small>
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
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.25297734277!2d106.78659691136453!3d10.868370157450702!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752763982fd351%3A0xfa645fdc8bc56274!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBOw7RuZyBMw6JtIFRQLiBI4buTIENow60gTWluaA!5e0!3m2!1svi!2s!4v1712810000000!5m2!1svi!2s"
                    width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/tag/_footer.jsp"></jsp:include>
<script src="assets/js/scriptContact.js"></script>

</body>
</html>