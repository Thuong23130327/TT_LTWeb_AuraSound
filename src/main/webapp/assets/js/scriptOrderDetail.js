document.addEventListener('DOMContentLoaded', function() {
    const logDataContainer = document.getElementById('shippingLogData');
    if (logDataContainer) {
        const logJsonStr = logDataContainer.value;
        if (logJsonStr && logJsonStr.trim() !== "") {
            try {
                const parser = new DOMParser();
                const decodedJsonStr = parser.parseFromString(logJsonStr, "text/html").documentElement.textContent;
                const logData = JSON.parse(decodedJsonStr);

                if (logData && logData.code === 200 && logData.data && logData.data.log) {
                    const logs = logData.data.log;
                    const timelineList = document.getElementById('ghn-timeline-list');

                    if (timelineList && logs.length > 0) {
                        let html = '';

                        [...logs].reverse().forEach((item, index) => {
                            const isLatest = index === 0;
                            const dateObj = new Date(item.updated_date);
                            const formattedDate = dateObj.toLocaleString('vi-VN', {
                                year: 'numeric',
                                month: '2-digit',
                                day: '2-digit',
                                hour: '2-digit',
                                minute: '2-digit'
                            });

                            const dotColor = isLatest ? '#e53935' : '#ccc';
                            const textColor = isLatest ? '#e53935' : '#666';
                            const fontWeight = isLatest ? '600' : '400';

                            html += '<li style="position: relative; margin-bottom: 15px; padding-left: 15px;">' +
                                '<span style="position: absolute; left: -21px; top: 0; width: 10px; height: 10px; border-radius: 50%; background-color: ' + dotColor + '; border: 2px solid #fff; box-shadow: 0 0 0 2px ' + dotColor + ';"></span>' +
                                '<p style="margin: 0; color: ' + textColor + '; font-weight: ' + fontWeight + ';">' + item.status + ' - ' + formattedDate + '</p>' +
                                '</li>';
                        });
                        timelineList.innerHTML = html;
                    } else if (timelineList) {
                        timelineList.innerHTML = '<li>Chưa có thông tin hành trình</li>';
                    }
                }
            } catch (e) {
                console.error("Error parsing GHN log JSON:", e);
            }
        }
    }

    const reviewButtons = document.querySelectorAll('.btn-open-review');
    reviewButtons.forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            const orderId = this.getAttribute('data-order-id');

            const modalPidInput = document.getElementById('reviewProductId');
            const modalOidInput = document.getElementById('reviewOrderId');

            if (modalPidInput) modalPidInput.value = productId;
            if (modalOidInput) modalOidInput.value = orderId;

            const reviewModalEl = document.getElementById('reviewModal');
            if (reviewModalEl) {
                const modal = new bootstrap.Modal(reviewModalEl);
                modal.show();
            }
        });
    });
});