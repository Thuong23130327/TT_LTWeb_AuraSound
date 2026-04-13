package dao;

import model.entity.Order;
import model.entity.OrderItem;
import model.enums.OrderStatus;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrderDAO {
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //Lay all order - OK
    public List<Order> getAll() {
        String sql = "SELECT o.*, ua.recipient_name AS recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN useraddresses ua ON os.useraddresses_id = ua.id " +
                "ORDER BY o.order_date DESC;";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .mapToBean(Order.class)
                .list());
    }

    //Chi tiet 1 ord by ordId -OK
    public Order getOrderById(String id) {
        String sql = "SELECT o.*, ua.recipient_name AS recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.orders_id " +
                "LEFT JOIN useraddresses ua ON os.useraddresses_id = ua.id " +
                "WHERE o.id = :id";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .mapToBean(Order.class)
                .findOne()
                .orElse(null));
    }


    //Lay all ord cua UserID
//    public List<Order> getAllOrderById(int userId) {
//        String sql = "SELECT o.*, os.recipient_name AS recipient_name  " +
//                "from orders o  " +
//                "LEFT JOIN ordershippings os ON o.id = os.Orders_id " +
//                "WHERE o.Users_id = :uid " +
//                "ORDER BY o.order_date DESC;";
//
//        return jdbi.withHandle(handle -> handle.createQuery(sql).bind("uid", userId).mapToBean(Order.class).list());
//    }

    public List<Order> getAllOrderById(int userId) {
        String sql = "SELECT * FROM orders WHERE users_id = :uid ORDER BY order_date DESC";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("uid", userId)
                        .mapToBean(Order.class)
                        .list()
        );
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
        String sql = "SELECT * FROM orders WHERE users_id = :uid AND status = :status ORDER BY order_date DESC";

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("uid", userId)
                        .bind("status", finalStatus)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    //đơn hàng đang chờ duyệt
    public List<Order> getPendingOrders(int userId) {
        return getOrdersByStatus(userId, "PENDING");
    }

    //đơn hàng đang giao
    public List<Order> getShippingOrders(int userId) {
        return getOrdersByStatus(userId, "SHIPPING");
    }

    //đơn hàng đã hoàn thành
    public List<Order> getCompletedOrders(int userId) {
        return getOrdersByStatus(userId, "COMPLETED");
    }

    //đơn hàng đã hủy
    public List<Order> getCancelledOrders(int userId) {
        return getOrdersByStatus(userId, "CANCELLED");
    }

    public List<OrderItem> getAllOrdersItem(String orderId) {
        String sql = "SELECT oi.*, " +
                "       p.name AS pv_product_name, " +
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

        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
     //   System.out.println(dao.getAll().toString());
        System.out.println("--");
//        System.out.println(dao.getOrderById("1"));
        System.out.println(dao.getAllOrderById(2).toString());
        System.out.println("-1-");
        System.out.println(dao.getOrdersByStatus(2,"COMPLETED").toString());
        System.out.println("-2-");
        System.out.println(dao.getAllOrdersItem("2").toString());
    }
}
