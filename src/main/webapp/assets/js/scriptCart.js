$(document).ready(function() {
    function formatVND(value) {
        return new Intl.NumberFormat('vi-VN').format(value) + ' đ';
    }

    function updateCart(id, change, action) {
        $.ajax({
            url: 'cart',
            type: 'GET',
            data: {
                action: action,
                id: id,
                q: change
            },
            success: function(res) {
                if(res.status === 'success') {
                    $('#total-price').text(formatVND(res.totalPrice));
                    $('#total-qty').text(res.totalQty);
                }
            }
        });
    }

    $('.qty-btn').click(function() {
        let btn = $(this);
        let id = btn.data('id');
        let change = btn.data('change');
        let input = btn.siblings('.qty-input');
        let newQty = parseInt(input.val()) + change;

        if (newQty >= 1) {
            input.val(newQty);
            updateCart(id, change, 'updateQty');
        }
    });
    $(document).on('click', '.ajax-qty', function() {
        let id = $(this).data('id');
        let q = $(this).data('qty');

        $.ajax({
            url: 'cart',
            type: 'GET',
            data: { action: 'updateQty', id: id, q: q },
            success: function(res) {
                if(res.status === 'success') {
                    // Đè toàn bộ HTML mới vào grid
                    $('.cart-items-list').html(res.html);

                    // Cập nhật tổng tiền bên dưới
                    $('.subtotal-price').text(new Intl.NumberFormat('vi-VN').format(res.totalPrice) + ' đ');
                    $('.total-qty-text').text(res.totalQty);
                }
            }
        });
    });
    $('.delete-btn').click(function() {
        if(confirm('Bạn muốn xóa sản phẩm này?')) {
            let id = $(this).data('id');
            let row = $(this).closest('.cart-item');

            $.ajax({
                url: 'cart',
                type: 'GET',
                data: { action: 'delete', id: id },
                success: function(res) {
                    row.remove();
                    $('#total-price').text(formatVND(res.totalPrice));
                    $('#total-qty').text(res.totalQty);
                    if($('.cart-item').length === 0) location.reload();
                }
            });
        }
    });
});