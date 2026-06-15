package service;

import dao.VoucherDAO;
import model.entity.Voucher;
import java.time.LocalDateTime;
import java.util.List;

public class VoucherService {
    private final VoucherDAO voucherDAO = new VoucherDAO();

    public List<Voucher> getAllVouchers() {
        return voucherDAO.getAllVouchers();
    }

    public boolean addVoucher(Voucher voucher) {
        //Ktra bị trùng
        if (voucherDAO.getVoucherByCode(voucher.getCode().trim()) != null) {
            return false;
        }
        return voucherDAO.insertVoucher(voucher);
    }

    public boolean deleteVoucher(int id) {
        return voucherDAO.deleteVoucher(id);
    }

    //Ktra dkien voucher
    public Voucher validateVoucher(String code, double currentOrderTotal) throws Exception {
        if (code == null || code.trim().isEmpty()) {
            throw new Exception("Vui lòng nhập mã giảm giá!");
        }

        Voucher voucher = voucherDAO.getVoucherByCode(code.trim().toUpperCase());
        if (voucher == null) {
            throw new Exception("Mã giảm giá không tồn tại!");
        }

        //Ktra hsd
        if (voucher.getEndDate() != null && voucher.getEndDate().isBefore(LocalDateTime.now())) {
            throw new Exception("Mã giảm giá này đã hết hạn sử dụng!");
        }

        //Ktra số lần nhập còn lại
        if (voucher.getUsageLimit() <= 0) {
            throw new Exception("Mã giảm giá này đã hết lượt sử dụng!");
        }

        //Ktra gtri tối thiểu
        if (currentOrderTotal < voucher.getMinimumOrderAmount()) {
            throw new Exception("Đơn hàng chưa đạt giá trị tối thiểu để áp dụng mã này!");
        }

        return voucher;
    }
        public void decreaseUsageLimit(int voucherId) {
            voucherDAO.decreaseUsageLimit(voucherId);
        }
        public Voucher getVoucherByCode(String code) {
            if (code == null || code.trim().isEmpty()) return null;
            return voucherDAO.getVoucherByCode(code.trim().toUpperCase());
        }

    public List<Voucher> getVouchersForUserWallet(int userId) {
        return voucherDAO.getVouchersForUserWallet(userId);
    }
    }