package dao;

import model.entity.Order;
import model.entity.OrderItem;
import model.enums.OrderStatus;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrderDAO {
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    // Lay all order - OK
    public List<Order> getAll() {
        String sql = "SELECT o.*, ua.recipient_name AS recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN user_addresses ua ON os.useraddresses_id = ua.id " +
                "ORDER BY o.order_date DESC;";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .mapToBean(Order.class)
                .list());
    }

    // Chi tiet 1 ord by ordId -OK
    public Order getOrderById(String id) {
        String sql = "SELECT o.*, ua.recipient_name AS recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN user_addresses ua ON os.useraddresses_id = ua.id " +
                "WHERE o.id = :id";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .mapToBean(Order.class)
                .findOne()
                .orElse(null));
    }

    // Lay all ord cua UserID
    // public List<Order> getAllOrderById(int userId) {
    // String sql = "SELECT o.*, os.recipient_name AS recipient_name " +
    // "from orders o " +
    // "LEFT JOIN ordershippings os ON o.id = os.Orders_id " +
    // "WHERE o.Users_id = :uid " +
    // "ORDER BY o.order_date DESC;";
    //
    // return jdbi.withHandle(handle -> handle.createQuery(sql).bind("uid",
    // userId).mapToBean(Order.class).list());
    // }

    // public List<Order> getAllOrderById(int userId) {
    // String sql = "SELECT * FROM orders WHERE users_id = :uid ORDER BY order_date
    // DESC";
    //
    // return jdbi.withHandle(handle ->
    // handle.createQuery(sql)
    // .bind("uid", userId)
    // .mapToBean(Order.class)
    // .list()
    // );
    // }

    public List<Order> getAllOrderById(int userId) {
        String sql = "SELECT o.*, ua.recipient_name AS recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN user_addresses ua ON os.useraddresses_id = ua.id " +
                "WHERE o.users_id = :uid " +
                "ORDER BY o.order_date DESC";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("uid", userId)
                .mapToBean(Order.class)
                .list());
    }

    // lấy đon hàng theo trạng thái
    public List<Order> getOrdersByStatus(int userId, String statusName) {

        int statusValue;
        try {
            statusValue = OrderStatus.valueOf(statusName.toUpperCase()).getValue();
        } catch (Exception e) {
            statusValue = 0;
        }

        final int finalStatus = statusValue;
        String sql = "SELECT o.*, ua.recipient_name AS recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN user_addresses ua ON os.useraddresses_id = ua.id " +
                "WHERE o.users_id = :uid AND o.status = :status " +
                "ORDER BY o.order_date DESC";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("uid", userId)
                .bind("status", finalStatus)
                .mapToBean(Order.class)
                .list());
    }

    // đơn hàng đang chờ duyệt
    public List<Order> getPendingOrders(int userId) {
        return getOrdersByStatus(userId, "PENDING");
    }

    // đơn hàng đang giao
    public List<Order> getShippingOrders(int userId) {
        return getOrdersByStatus(userId, "SHIPPING");
    }

    // đơn hàng đã hoàn thành
    public List<Order> getCompletedOrders(int userId) {
        return getOrdersByStatus(userId, "COMPLETED");
    }

    // đơn hàng đã hủy
    public List<Order> getCancelledOrders(int userId) {
        return getOrdersByStatus(userId, "CANCELLED");
    }

    public List<OrderItem> getAllOrdersItem(String orderId) {
        String sql = "SELECT oi.*, " +
                "       p.name AS productName, " +
                "       pv.id AS pv_id, " +
                "       pv.products_id AS pv_products_id, " +
                "       pv.variant_sku AS pv_variant_sku, " +
                "       pv.color_name AS pv_color_name, " +
                "       pv.main_image_url AS pv_main_image_url, " +
                "       pv.market_price AS pv_market_price, " +
                "       pv.sell_price AS pv_sell_price, " +
                "       pv.stock_quantity AS pv_stock_quantity, " +
                "       pv.sold_quantity AS pv_sold_quantity, " +
                "       pv.is_default AS pv_is_default " +
                "FROM orderitems oi " +
                "JOIN productvariants pv ON oi.productvariants_id = pv.id " +
                "JOIN products p ON pv.products_id = p.id " +
                "WHERE oi.orders_id = :orderId";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("orderId", orderId)
                .mapToBean(OrderItem.class)
                .list());
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        // System.out.println(dao.getAll().toString());
        System.out.println("--");
        // System.out.println(dao.getOrderById("1"));
        System.out.println(dao.getAllOrderById(10).toString());
        System.out.println("-1-");
        System.out.println(dao.getOrdersByStatus(10, "COMPLETED").toString());
        System.out.println("-2-");
        System.out.println(dao.getAllOrdersItem("4").toString());
    }

    // Tạo đơn mới
    public int createOrder(int userId, Integer vouchersId,
            double totalProductsPrice, double shippingFee,
            double discountAmount, double finalAmount) {

        String orderCode = "ORD-" + java.util.UUID.randomUUID()
                .toString()
                .substring(0, 8)
                .toUpperCase();
        return jdbi.withHandle(handle -> {
            handle.createUpdate(
                    "INSERT INTO orders " +
                            "  (users_id, vouchers_id, order_code, order_date, " +
                            "   status, payment_status, " +
                            "   total_products_price, shipping_fee, discount_amount, final_amount) " +
                            "VALUES " +
                            "  (:userId, :vouchersId, :orderCode, NOW(), " +
                            "   0, 0, " + // 0 = PENDING
                            "   :totalProductsPrice, :shippingFee, :discountAmount, :finalAmount)")
                    .bind("userId", userId)
                    .bind("vouchersId", vouchersId) // null nếu ko sài voucher
                    .bind("orderCode", orderCode)
                    .bind("totalProductsPrice", totalProductsPrice)
                    .bind("shippingFee", shippingFee)
                    .bind("discountAmount", discountAmount)
                    .bind("finalAmount", finalAmount)
                    .execute();

            return handle.createQuery("SELECT LAST_INSERT_ID()")
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(0);
        });
    }

    public void updatePaymentStatus(int orderId, int paymentStatus) {
        jdbi.useHandle(handle -> handle.createUpdate(
                "UPDATE orders SET payment_status = :paymentStatus WHERE id = :id")
                .bind("paymentStatus", paymentStatus)
                .bind("id", orderId)
                .execute());
    }

    public void updateOrderStatus(int orderId, int status) {
        jdbi.useHandle(handle -> handle.createUpdate(
                "UPDATE orders SET status = :status WHERE id = :id")
                .bind("status", status)
                .bind("id", orderId)
                .execute());
    }

    public void updateShippingOrderCode(int orderId, String shippingOrderCode) {
        jdbi.useHandle(handle -> handle.createUpdate(
                        "UPDATE orders SET shipping_order_code = :code WHERE id = :id")
                .bind("code", shippingOrderCode)
                .bind("id", orderId)
                .execute()
        );
    }

    public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).one()
        );
    }

    //Dùng cho qly đơn admin
    public Order getAdminOrderDetailById(String id) {
        String sql = "SELECT o.*, " +
                "ua.recipient_name AS recipient_name, " +
                "ua.phone AS shipping_phone, " +
                "ua.address AS shipping_address, " +
                "ua.city AS shipping_city, " +
                "u.email AS customer_email, " +
                "os.note AS shipping_note " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN useraddresses ua ON os.useraddresses_id = ua.id " +
                "LEFT JOIN users u ON o.users_id = u.id " +
                "WHERE o.id = :id";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .mapToBean(Order.class)
                .findOne()
                .orElse(null));
    }

    public List<OrderItem> getAdminOrderItemsByOrderId(String orderId) {
        String sql = "SELECT oi.*, " +
                "pv.id AS pv_id, " +
                "pv.products_id AS pv_products_id, " +
                "pv.variant_sku AS pv_variant_sku, " +
                "pv.color_name AS pv_color_name, " +
                "pv.main_image_url AS pv_main_image_url, " +
                "pv.market_price AS pv_market_price, " +
                "pv.sell_price AS pv_sell_price, " +
                "pv.stock_quantity AS pv_stock_quantity, " +
                "pv.sold_quantity AS pv_sold_quantity, " +
                "pv.is_default AS pv_is_default " +
                "FROM orderitems oi " +
                "LEFT JOIN productvariants pv ON oi.productvariants_id = pv.id " +
                "WHERE oi.orders_id = :orderId";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("orderId", orderId)
                .mapToBean(OrderItem.class)
                .list());
    }

}
