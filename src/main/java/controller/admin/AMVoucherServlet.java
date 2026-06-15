package controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.Role;
import model.entity.User;
import model.entity.Voucher;
import service.VoucherService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet(name = "AMVoucherServlet", urlPatterns = {"/admin/voucher"})
public class AMVoucherServlet extends HttpServlet {

    private final VoucherService voucherService = new VoucherService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!hasAdminRole(req, resp)) return;
        HttpSession session = req.getSession(false);
        String flash = (session != null) ? (String) session.getAttribute("voucherFlash") : null;
        if (flash != null) {
            String[] parts = flash.split("\\|", 2);
            req.setAttribute("flashType", parts[0]);
            req.setAttribute("flashMsg",  parts.length > 1 ? parts[1] : "");
            session.removeAttribute("voucherFlash");
        }

        List<Voucher> vouchers = voucherService.getAllVouchers();
        req.setAttribute("vouchers",   vouchers);
        req.setAttribute("pageTitle",  "Quản lý Voucher – AuraSound");
        req.setAttribute("activePage", "vou");

        req.setAttribute("now", LocalDateTime.now());

        req.getRequestDispatcher("/WEB-INF/views/admin/voucher.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (!hasAdminRole(req, resp)) return;
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            handleAdd(req, resp);
        } else if ("delete".equals(action)) {
            handleDelete(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/voucher");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String rawCode       = req.getParameter("code");
        String discountStr   = req.getParameter("discountAmount");
        String minOrderStr   = req.getParameter("minimumOrderAmount");
        String usageLimitStr = req.getParameter("usageLimit");
        String endDateStr    = req.getParameter("endDate");

        String trimCode = (rawCode != null) ? rawCode.trim().toUpperCase() : "";

        StringBuilder error = new StringBuilder();

        if (trimCode.isEmpty()) {
            error.append("Mã voucher không được để trống. ");
        } else if (!trimCode.matches("^[A-Z0-9_\\-]{3,30}$")) {
            error.append("Mã voucher chỉ gồm chữ IN HOA, số, dấu _ hoặc - (3–30 ký tự). ");
        }

        double discountAmount = 0;
        try {
            discountAmount = Double.parseDouble(discountStr);
            if (discountAmount <= 0) error.append("Số tiền giảm phải lớn hơn 0. ");
        } catch (NumberFormatException e) {
            error.append("Số tiền giảm không hợp lệ. ");
        }

        double minimumOrderAmount = 0;
        try {
            minimumOrderAmount = Double.parseDouble(minOrderStr);
            if (minimumOrderAmount < 0) error.append("Giá trị đơn tối thiểu không được âm. ");
        } catch (NumberFormatException e) {
            error.append("Giá trị đơn tối thiểu không hợp lệ. ");
        }

        int usageLimit = 0;
        try {
            usageLimit = Integer.parseInt(usageLimitStr);
            if (usageLimit <= 0) error.append("Số lượt dùng phải lớn hơn 0. ");
        } catch (NumberFormatException e) {
            error.append("Số lượt dùng không hợp lệ. ");
        }

        LocalDateTime endDate = null;
        try {
            if (!isBlank(endDateStr)) {
                endDate = LocalDateTime.parse(endDateStr,
                        DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
                if (endDate.isBefore(LocalDateTime.now())) {
                    error.append("Ngày hết hạn phải ở tương lai. ");
                }
            }else{
                endDate = LocalDateTime.of(2099, 12, 31, 23, 59, 59);
            }
        } catch (DateTimeParseException e) {
            error.append("Ngày hết hạn không đúng định dạng. ");
        }

        if (error.length() > 0) {
            List<Voucher> vouchers = voucherService.getAllVouchers();
            req.setAttribute("vouchers",       vouchers);
            req.setAttribute("showModal",      true);
            req.setAttribute("errorMsg",       error.toString().trim());
            req.setAttribute("formCode",       trimCode);
            req.setAttribute("formDiscount",   discountStr);
            req.setAttribute("formMinOrder",   minOrderStr);
            req.setAttribute("formUsageLimit", usageLimitStr);
            req.setAttribute("formEndDate",    endDateStr);
            req.setAttribute("pageTitle",      "Quản lý Voucher – AuraSound");
            req.setAttribute("activePage",     "vou");
            req.setAttribute("now",            LocalDateTime.now());
            req.getRequestDispatcher("/WEB-INF/views/admin/voucher.jsp")
                    .forward(req, resp);
            return;
        }

        Voucher voucher = new Voucher();
        voucher.setCode(trimCode);
        voucher.setDiscountAmount(discountAmount);
        voucher.setMinimumOrderAmount(minimumOrderAmount);
        voucher.setUsageLimit(usageLimit);
        voucher.setEndDate(endDate);

        boolean ok = voucherService.addVoucher(voucher);

        String flash = ok
                ? "success|Voucher <strong>" + trimCode + "</strong> đã được tạo thành công!"
                : "error|Mã voucher <strong>" + trimCode + "</strong> đã tồn tại trong hệ thống!";

        req.getSession().setAttribute("voucherFlash", flash);
        resp.sendRedirect(req.getContextPath() + "/admin/voucher");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        String flash;
        try {
            int id = Integer.parseInt(idStr);
            boolean ok = voucherService.deleteVoucher(id);
            flash = ok
                    ? "success|Voucher đã được xóa thành công!"
                    : "error|Không tìm thấy voucher để xóa!";
        } catch (NumberFormatException e) {
            flash = "error|ID voucher không hợp lệ!";
        }

        req.getSession().setAttribute("voucherFlash", flash);
        resp.sendRedirect(req.getContextPath() + "/admin/voucher");
    }

    private boolean hasAdminRole(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("auth") : null;

        if (auth == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }

        List<Role> roles = auth.getRoles();
        if (roles != null) {
            for (Role role : roles) {
                if ("admin".equalsIgnoreCase(role.getRoleName())) {
                    return true;
                }
            }
        }

        resp.sendRedirect(req.getContextPath() + "/");
        return false;
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}