//package service;
//
//import dao.CheckoutDAO;
//import model.entity.OrderShipping;
//import model.entity.Voucher;
//
//public class CheckoutService {
//    private CheckoutDAO checkoutDAO = new CheckoutDAO();
//
//    // Kiểm tra voucher
//    public Voucher checkVoucherValid(String code, double cartTotal) {
//        if (code == null || code.trim().isEmpty()) return null;
//        Voucher v = checkoutDAO.getVoucherByCode(code);
//        // Check giá trị tối thiểu
//        if (v != null && cartTotal >= v.getMinimumOrderAmount()) {
//            return v;
//        }
//        return null;
//    }
//
//    // Xử lý đặt hàng
//    public boolean placeOrder(OrderShipping shippingInfo, Cart cart, String voucherCode, User user) {
//        Order order = new Order();
//
//        // Tạo mã đơn
//        String orderCode = "ORD-" + System.currentTimeMillis() % 1000000;
//        order.setOrderCode(orderCode);
//
//        // Gán id người dùng
//        if (user != null) order.setUsersId(user.getId());
//
//        // Trạng thái mặc định
//        order.setStatus(OrderStatus.PENDING.name());
//        order.setPaymentStatus("Unpaid");
//
//        // Tính toán tiền
//        double totalProductPrice = cart.getTotalPrice();
//        double shippingFee = 30000; // Phí ship mặc định
//        double discount = 0;
//
//        // Check voucher trước khi lưu
//        Voucher v = checkVoucherValid(voucherCode, totalProductPrice);
//        if (v != null) {
//            order.setVouchersId(v.getId());
//            discount = v.getDiscountValue();
//        }
//
//        order.setTotalProductsPrice(totalProductPrice);
//        order.setShippingFee(shippingFee);
//        order.setDiscountAmount(discount);
//
//        double finalAmt = (totalProductPrice + shippingFee) - discount;
//        order.setFinalAmount(Math.max(finalAmt, 0));
//
//        // Gọi DAO để lưu vào DB
//        return checkoutDAO.saveOrderInTransaction(order, shippingInfo, cart.getListItems());
//    }
//}