package dao;

import model.entity.OrderShipping;
import org.jdbi.v3.core.Jdbi;


public class OrderShippingDAO {
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public OrderShipping getByOrderId(int orderId) {
        String sql = "SELECT os.id, os.orders_id, os.note, " +
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
                .map((rs, ctx) -> {
                    OrderShipping os = new OrderShipping();
                    os.setId(rs.getInt("id"));
                    os.setOrderId(rs.getInt("orders_id"));
                    os.setNote(rs.getString("note"));

                    if (rs.getObject("ua_id") != null) {
                        model.entity.UserAddress ua = new model.entity.UserAddress();
                        ua.setId(rs.getInt("ua_id"));
                        ua.setUserId(rs.getInt("ua_users_id"));
                        ua.setRecipientName(rs.getString("ua_recipient_name"));
                        ua.setPhone(rs.getString("ua_phone"));
                        ua.setAddress(rs.getString("ua_address"));
                        ua.setCity(rs.getString("ua_city"));
                        ua.setDefault(rs.getBoolean("ua_is_default"));

                        os.setUserAddress(ua);
                    }
                    return os;
                })
                .findOne()
                .orElse(null));
    }
    public static void main(String[] args) {
        OrderShippingDAO dao = new OrderShippingDAO();
        OrderShipping os = dao.getByOrderId(2); // Test với order_id = 2

        System.out.println(os.getUserAddress());
    }
    //Tạo dchi giao hàng mới
    public int insertUserAddress(int userId, String recipientName,
                                 String phone, String city,
                                 String address) {
        return jdbi.withHandle(handle -> {
            handle.createUpdate(
                            "INSERT INTO useraddresses " +
                                    "  (users_id, recipient_name, phone, city, address, is_default) " +
                                    "VALUES " +
                                    "  (:userId, :recipientName, :phone, :city, :address, 0)"
                    )
                    .bind("userId",        userId)
                    .bind("recipientName", recipientName)
                    .bind("phone",         phone)
                    .bind("city",          city)
                    .bind("address",       address)
                    .execute();

            return handle.createQuery("SELECT LAST_INSERT_ID()")
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(0);
        });
    }

    //Lket đơn hàng vs dchi giao
    public void insertOrderShipping(int ordersId, int userAddressId, String note) {
        jdbi.useHandle(handle ->
                handle.createUpdate(
                                "INSERT INTO ordershippings " +
                                        "  (orders_id, useraddresses_id, note) " +
                                        "VALUES " +
                                        "  (:ordersId, :userAddressId, :note)"
                        )
                        .bind("ordersId",       ordersId)
                        .bind("userAddressId",  userAddressId)
                        .bind("note",           note)
                        .execute()
        );
    }
}
