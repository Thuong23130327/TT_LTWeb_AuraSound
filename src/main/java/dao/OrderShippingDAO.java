package dao;

import model.entity.OrderShipping;
import org.jdbi.v3.core.Jdbi;


public class OrderShippingDAO {
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public OrderShipping getByOrderId(int orderId) {
        String sql = "SELECT os.*, " +
                "ua.id AS ua_id, " +
                "ua.users_id AS ua_users_id, " +
                "ua.recipient_name AS ua_recipient_name, " +
                "ua.phone AS ua_phone, " +
                "ua.address AS ua_address, " +
                "ua.city AS ua_city, " +
                "ua.is_default AS ua_is_default " +
                "FROM ordershippings os " +
                "LEFT JOIN useraddresses ua ON os.useraddresses_id = ua.id " +
                "WHERE os.orders_id = :orderId";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("orderId", orderId)
                .mapToBean(OrderShipping.class)
                .findOne()
                .orElse(null));
    }
    public static void main(String[] args) {
        OrderShippingDAO dao = new OrderShippingDAO();
        OrderShipping os = dao.getByOrderId(1); // Test với order_id = 1

        System.out.println(os.getUserAddress());
    }

}
