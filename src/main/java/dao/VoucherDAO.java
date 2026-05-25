package dao;

import model.entity.Voucher;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class VoucherDAO {
    private final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //Lấy ds vouchers
    public List<Voucher> getAllVouchers() {
        String sql = "SELECT id, code, discount_amount, min_order_value, usage_limit, end_date, created_at " +
                "FROM vouchers ORDER BY created_at DESC";
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .mapToBean(Voucher.class)
                .list());
    }

    //Tìm voucher
    public Voucher getVoucherByCode(String code) {
        String sql = "SELECT id, code, discount_amount, min_order_value, usage_limit, end_date, created_at " +
                "FROM vouchers WHERE code = :code";
        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("code", code)
                .mapToBean(Voucher.class)
                .findOne()
                .orElse(null));
    }

    //Thêm voucher
    public boolean insertVoucher(Voucher voucher) {
        String sql = "INSERT INTO vouchers (code, discount_amount, min_order_value, usage_limit, end_date, created_at) " +
                "VALUES (:code, :discountAmount, :minimumOrderAmount, :usageLimit, :endDate, NOW())";
        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bindBean(voucher)
                .execute() > 0);
    }

    //Xóa voucher
    public boolean deleteVoucher(int id) {
        String sql = "DELETE FROM vouchers WHERE id = :id";
        return jdbi.withHandle(handle -> handle.createUpdate(sql)
                .bind("id", id)
                .execute() > 0);
    }

    //Giảm số lần nhập
    public void decreaseUsageLimit(int id) {
        String sql = "UPDATE vouchers SET usage_limit = usage_limit - 1 WHERE id = :id AND usage_limit > 0";
        jdbi.useHandle(handle -> handle.createUpdate(sql)
                .bind("id", id)
                .execute());
    }
}