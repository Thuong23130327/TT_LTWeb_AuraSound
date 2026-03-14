package dao;

import model.entity.Order;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrderDAO {
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //Lay all order
    public List<Order> getAllOrder() {
        String sql = "SELECT o.*, os.recipient_name  " +
                "from orders o  " +
                "LEFT JOIN ordershippings os ON o.id = os.Orders_id " +
                "ORDER BY o.order_date DESC;";

        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Order.class).list());
    }

    //Chi tiet 1 ord by ordId
    public Order getOrderById(String id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM orders WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Order.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    //Lay all ord cua UserID

    public List<Order> getAllOrderById(int userId) {
        String sql = "SELECT o.*, os.recipient_name  " +
                "from orders o  " +
                "LEFT JOIN ordershippings os ON o.id = os.Orders_id " +
                "WHERE o.Users_id = :uid " +
                "ORDER BY o.order_date DESC;";

        return jdbi.withHandle(handle -> handle.createQuery(sql).bind("uid", userId).mapToBean(Order.class).list());
    }


    public List<Order> getOrdersByStatus(int userId, String status) {
        String sql = "SELECT o.*, os.recipient_name " +
                "FROM orders o " +
                "LEFT JOIN ordershippings os ON o.id = os.Orders_id " +
                "WHERE o.Users_id = :uid AND o.status = :status " +
                "ORDER BY o.order_date DESC;";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("uid", userId)
                .bind("status", status)
                .mapToBean(Order.class).list());

    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        System.out.println(dao.getAllOrder().toString());
        System.out.println("--");
        System.out.println(dao.getAllOrderById(1).toString());
    }
}
