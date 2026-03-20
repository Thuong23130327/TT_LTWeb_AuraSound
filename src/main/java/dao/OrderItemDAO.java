package dao;

import model.entity.OrderItem;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrderItemDAO {
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //    OK
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        String sql = "SELECT oi.*, " +
                "pv.id AS pv_id, " +
                "pv.products_id AS pv_products_id, " +
                "pv.variant_sku AS pv_variant_sku, " +
                "pv.color_name AS pv_color_name, " +
                "pv.main_image_url AS pv_main_image_url, " +
                "pv.market_price AS pv_market_price, " +
                "pv.sell_price AS pv_sell_price, " +
                "pv.stock_quantity AS pv_stock_quantity, " +
                "pv.sold_quantity AS pv_sold_quantity " +

                "FROM orderitems oi " +
                "JOIN productvariants pv ON oi.productvariants_id = pv.id " +
                "WHERE oi.orders_id = :orderId";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("orderId", orderId)
                .mapToBean(OrderItem.class)
                .list());
    }

    public static void main(String[] args) {
        OrderItemDAO dao = new OrderItemDAO();
        System.out.println(dao.getOrderItemsByOrderId(2).toString());

    }
}
