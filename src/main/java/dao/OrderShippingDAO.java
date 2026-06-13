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
                "ua.province_id AS ua_province_id, " +
                "ua.district_id AS ua_district_id, " +
                "ua.ward_code AS ua_ward_code, " +
                "ua.is_default AS ua_is_default " +
                "FROM ordershippings os " +
                "LEFT JOIN user_addresses ua ON os.useraddresses_id = ua.id " +
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
                        ua.setProvinceId(rs.getInt("ua_province_id"));
                        ua.setDistrictId(rs.getInt("ua_district_id"));
                        ua.setWardCode(rs.getString("ua_ward_code"));
                        ua.setIsDefault(rs.getBoolean("ua_is_default"));

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
                                 String address, int provinceId, int districtId, String wardCode) {
        return jdbi.withHandle(handle -> {
            handle.createUpdate(
                            "INSERT INTO user_addresses " +
                                    "  (users_id, recipient_name, phone, city, address, province_id, district_id, ward_code, is_default) " +
                                    "VALUES " +
                                    "  (:userId, :recipientName, :phone, :city, :address, :provinceId, :districtId, :wardCode, 0)"
                    )
                    .bind("userId",        userId)
                    .bind("recipientName", recipientName)
                    .bind("phone",         phone)
                    .bind("city",          city)
                    .bind("address",       address)
                    .bind("provinceId",    provinceId)
                    .bind("districtId",    districtId)
                    .bind("wardCode",      wardCode)
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
