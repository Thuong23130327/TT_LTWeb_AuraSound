package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.User;
import model.entity.UserAddress;
import service.AddressService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AddressServlet", value = "/address")
public class AddressServlet extends HttpServlet {

    private AddressService addressService = new AddressService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("auth") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            System.out.println("Fetching addresses for user ID: " + user.getId()); // Debug log
            List<UserAddress> addresses = addressService.getUserAddresses(user.getId());
            System.out.println("User " + user.getId() + " has " + addresses.size() + " addresses."); // Debug log
            request.setAttribute("addresses", addresses);
            request.setAttribute("addressCount", addresses.size());

            if ("edit".equals(action)) {
                String addressId = request.getParameter("id");
                if (addressId != null) {
                    int id = Integer.parseInt(addressId);
                    UserAddress address = addressService.getAddressById(id);

                    if (address != null && address.getUserId() == user.getId()) {
                        request.setAttribute("editAddress", address);
                    } else {
                        request.setAttribute("error", "Địa chỉ không tồn tại.");
                    }
                }
            }

            request.setAttribute("activePage", "address");
            request.getRequestDispatcher("/WEB-INF/views/profileM/address.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                handleCreate(request, response, user);
            } else if ("edit".equals(action)) {
                handleEdit(request, response, user);
            } else if ("delete".equals(action)) {
                handleDelete(request, response, user);
            } else if ("setDefault".equals(action)) {
                handleSetDefault(request, response, user);
            } else {
                response.sendRedirect(request.getContextPath() + "/address");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu.");
            doGet(request, response);
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException, ServletException {

        String recipientName = request.getParameter("recipientName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("cityText");
        String provinceIdStr = request.getParameter("provinceId");
        String districtIdStr = request.getParameter("districtId");
        String wardCode = request.getParameter("wardCode");
        String isDefaultStr = request.getParameter("isDefault");
        boolean isDefault = "on".equals(isDefaultStr) || "true".equals(isDefaultStr);

        int provinceId = 0;
        int districtId = 0;
        try {
            if (provinceIdStr != null && !provinceIdStr.isEmpty()) provinceId = Integer.parseInt(provinceIdStr);
            if (districtIdStr != null && !districtIdStr.isEmpty()) districtId = Integer.parseInt(districtIdStr);
        } catch (NumberFormatException e) {
            // Log or ignore
        }

        String result = addressService.createAddress(user.getId(), recipientName, phone, address, city, provinceId, districtId, wardCode, isDefault);

        if ("success".equals(result)) {
            request.setAttribute("message", "Thêm địa chỉ thành công!");
        } else {
            request.setAttribute("error", result);
        }

        doGet(request, response);
    }

    private void handleEdit(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException, ServletException {

        String addressIdStr = request.getParameter("addressId");
        String recipientName = request.getParameter("recipientName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("cityText");
        String provinceIdStr = request.getParameter("provinceId");
        String districtIdStr = request.getParameter("districtId");
        String wardCode = request.getParameter("wardCode");
        String isDefaultStr = request.getParameter("isDefault");
        boolean isDefault = "on".equals(isDefaultStr) || "true".equals(isDefaultStr);

        if (addressIdStr == null || addressIdStr.isEmpty()) {
            request.setAttribute("error", "ID địa chỉ không hợp lệ.");
            doGet(request, response);
            return;
        }

        int addressId = Integer.parseInt(addressIdStr);
        int provinceId = 0;
        int districtId = 0;
        try {
            if (provinceIdStr != null && !provinceIdStr.isEmpty()) provinceId = Integer.parseInt(provinceIdStr);
            if (districtIdStr != null && !districtIdStr.isEmpty()) districtId = Integer.parseInt(districtIdStr);
        } catch (NumberFormatException e) {
            // Log or ignore
        }

        String result = addressService.updateAddress(addressId, user.getId(), recipientName, phone, address, city, provinceId, districtId, wardCode, isDefault);

        if ("success".equals(result)) {
            request.setAttribute("message", "Cập nhật địa chỉ thành công!");
        } else {
            request.setAttribute("error", result);
        }

        doGet(request, response);
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException, ServletException {

        String addressIdStr = request.getParameter("addressId");

        if (addressIdStr == null || addressIdStr.isEmpty()) {
            request.setAttribute("error", "ID địa chỉ không hợp lệ.");
            doGet(request, response);
            return;
        }

        int addressId = Integer.parseInt(addressIdStr);
        String result = addressService.deleteAddress(addressId, user.getId());

        if ("success".equals(result)) {
            request.setAttribute("message", "Xóa địa chỉ thành công!");
        } else {
            request.setAttribute("error", result);
        }

        doGet(request, response);
    }

    private void handleSetDefault(HttpServletRequest request, HttpServletResponse response, User user)
            throws SQLException, IOException, ServletException {

        String addressIdStr = request.getParameter("addressId");

        if (addressIdStr == null || addressIdStr.isEmpty()) {
            request.setAttribute("error", "ID địa chỉ không hợp lệ.");
            doGet(request, response);
            return;
        }

        int addressId = Integer.parseInt(addressIdStr);
        String result = addressService.setDefaultAddress(addressId, user.getId());

        if ("success".equals(result)) {
            request.setAttribute("message", "Đặt địa chỉ mặc định thành công!");
        } else {
            request.setAttribute("error", result);
        }

        doGet(request, response);
    }
}
