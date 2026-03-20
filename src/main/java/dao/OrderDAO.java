package dao;

import model.entity.Order;
import model.entity.OrderItem;
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




    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
     //   System.out.println(dao.getAll().toString());
        System.out.println("--");
        System.out.println(dao.getOrderById("1"));
    }
}
