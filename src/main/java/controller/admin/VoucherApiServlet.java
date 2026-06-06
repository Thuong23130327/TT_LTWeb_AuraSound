package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.Voucher;
import service.VoucherService;

import java.io.IOException;

@WebServlet(name = "VoucherApiServlet", urlPatterns = {"/api/voucher/validate"})
public class VoucherApiServlet extends HttpServlet {

    private final VoucherService voucherService = new VoucherService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String code     = req.getParameter("code");
        String totalStr = req.getParameter("orderTotal");

        double orderTotal;
        try {
            orderTotal = Double.parseDouble(totalStr);
        } catch (NumberFormatException | NullPointerException e) {
            resp.getWriter().write(json("error", "Giá trị đơn hàng không hợp lệ.", null, null));
            return;
        }

        try {
            Voucher v = voucherService.validateVoucher(code, orderTotal);

            String successMsg = "Áp dụng mã <strong>" + escapeJson(v.getCode())
                    + "</strong> thành công! Giảm " + formatVnd(v.getDiscountAmount()) + "đ";

            resp.getWriter().write(json("ok", successMsg, v.getCode(), v.getDiscountAmount()));

        } catch (Exception e) {
            resp.getWriter().write(json("error", e.getMessage(), null, null));
        }
    }

    private String json(String status, String message, String voucherCode, Double discountAmount) {
        StringBuilder sb = new StringBuilder("{");
        sb.append("\"status\":\"").append(escapeJson(status)).append("\"");
        sb.append(",\"message\":\"").append(escapeJson(message)).append("\"");
        if (voucherCode != null) {
            sb.append(",\"voucherCode\":\"").append(escapeJson(voucherCode)).append("\"");
        }
        if (discountAmount != null) {
            sb.append(",\"discountAmount\":").append(discountAmount.longValue());
        }
        sb.append("}");
        return sb.toString();
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("<", "\\u003c")
                .replace(">", "\\u003e");
    }

    private String formatVnd(double amount) {
        long v = (long) amount;
        StringBuilder sb = new StringBuilder(Long.toString(v));
        int i = sb.length() - 3;
        while (i > 0) { sb.insert(i, '.'); i -= 3; }
        return sb.toString();
    }
}