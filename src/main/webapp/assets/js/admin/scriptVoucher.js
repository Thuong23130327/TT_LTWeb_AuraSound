document.addEventListener("DOMContentLoaded", function () {
    const addVoucherModalEl = document.getElementById('addVoucherModal');
    if (addVoucherModalEl) {
        const shouldOpen = addVoucherModalEl.getAttribute('data-should-open') === 'true';
        if (shouldOpen) {
            new bootstrap.Modal(addVoucherModalEl).show();
        }
    }

    const toast = document.getElementById('flashToast');
    if (toast) {
        setTimeout(() => {
            toast.style.transition = 'opacity .4s';
            toast.style.opacity = '0';
            setTimeout(() => toast.remove(), 400);
        }, 4000);
    }

    const codeInput = document.getElementById('voucherCode');
    const discountInput = document.querySelector('input[name="discountAmount"]');
    const previewCode = document.getElementById('previewCode');
    const previewDiscount = document.getElementById('previewDiscount');

    function updatePreview() {
        if (!codeInput || !discountInput) return;
        const code = (codeInput.value || 'VOUCHER').toUpperCase();
        const amount = parseInt(discountInput.value) || 0;
        codeInput.value = code; // ép viết hoa khi gõ
        if (previewCode) previewCode.textContent = code;
        if (previewDiscount) {
            previewDiscount.innerHTML = 'Giảm <strong>' + amount.toLocaleString('vi-VN') + 'đ</strong>';
        }
    }

    if (codeInput && discountInput) {
        codeInput.addEventListener('input', updatePreview);
        discountInput.addEventListener('input', updatePreview);
    }

    const inp = document.getElementById('endDateInput');
    if (inp) {
        const now = new Date();
        now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
        inp.min = now.toISOString().slice(0, 16);
    }

    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function () {
            const keyword = this.value.toLowerCase().trim();
            const rows = document.querySelectorAll('#voucherTable tbody tr');
            let visible = 0;
            rows.forEach(row => {
                const badge = row.querySelector('.code-badge');
                if (!badge) { row.style.display = ''; return; }
                const match = !keyword || badge.textContent.toLowerCase().includes(keyword);
                row.style.display = match ? '' : 'none';
                if (match) visible++;
            });
            const rowCountEl = document.getElementById('rowCount');
            if (rowCountEl) rowCountEl.textContent = visible;
        });
    }
});

function confirmDelete(id, code) {
    const deleteIdInp = document.getElementById('deleteId');
    const deleteCodeDisplay = document.getElementById('deleteCodeDisplay');
    const confirmModalEl = document.getElementById('confirmDeleteModal');

    if (deleteIdInp && deleteCodeDisplay && confirmModalEl) {
        deleteIdInp.value = id;
        deleteCodeDisplay.textContent = code;
        new bootstrap.Modal(confirmModalEl).show();
    }
}

function copyCode(code, el) {
    navigator.clipboard.writeText(code).then(() => {
        const orig = el.innerHTML;
        el.innerHTML = '<i class="bi bi-check2"></i> Đã sao chép!';
        el.style.background = '#e8f8f1';
        el.style.color = '#1a9e5c';
        setTimeout(() => {
            el.innerHTML = orig;
            el.style.background = '';
            el.style.color = '';
        }, 1800);
    });
}