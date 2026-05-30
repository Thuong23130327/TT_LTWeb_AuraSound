package service;

import dao.ProfileMDAO.AddressDAO;
import model.entity.UserAddress;

import java.sql.SQLException;
import java.util.List;

public class AddressService {

    private AddressDAO addressDAO = new AddressDAO();
    private static final int MAX_ADDRESSES = 5;

    public List<UserAddress> getUserAddresses(int userId) throws SQLException {
        return addressDAO.getUserAddresses(userId);
    }

    public UserAddress getAddressById(int addressId) throws SQLException {
        return addressDAO.getAddressById(addressId);
    }

    public UserAddress getDefaultAddress(int userId) throws SQLException {
        return addressDAO.getDefaultAddress(userId);
    }


    public String createAddress(int userId, String recipientName, String phone, String address, String city, boolean isDefault) throws SQLException {
        if (recipientName == null || recipientName.trim().isEmpty()) {
            return "Tên người nhận không được để trống.";
        }
        if (phone == null || phone.trim().isEmpty()) {
            return "Số điện thoại không được để trống.";
        }
        if (address == null || address.trim().isEmpty()) {
            return "Địa chỉ không được để trống.";
        }
        if (city == null || city.trim().isEmpty()) {
            return "Tỉnh/Thành phố không được để trống.";
        }

        if (recipientName.trim().length() < 2 || recipientName.trim().length() > 100) {
            return "Tên người nhận phải từ 2 đến 100 ký tự.";
        }
        if (phone.trim().length() < 10 || phone.trim().length() > 20) {
            return "Số điện thoại phải từ 10 đến 20 ký tự.";
        }
        if (address.trim().length() < 5 || address.trim().length() > 255) {
            return "Địa chỉ phải từ 5 đến 255 ký tự.";
        }

        int addressCount = addressDAO.getAddressCount(userId);
        if (addressCount >= MAX_ADDRESSES) {
            return "Bạn đã đạt giới hạn " + MAX_ADDRESSES + " địa chỉ. Vui lòng xóa một địa chỉ cũ trước khi thêm mới.";
        }

        if (isDefault) {
            addressDAO.setDefaultAddress(0, userId);
        }

        UserAddress newAddress = new UserAddress();
        newAddress.setUserId(userId);
        newAddress.setRecipientName(recipientName.trim());
        newAddress.setPhone(phone.trim());
        newAddress.setAddress(address.trim());
        newAddress.setCity(city.trim());
        newAddress.setIsDefault(isDefault);

        boolean success = addressDAO.createAddress(newAddress);
        return success ? "success" : "Thêm địa chỉ thất bại.";
    }

    public String updateAddress(int addressId, int userId, String recipientName, String phone, String address, String city, boolean isDefault) throws SQLException {

        if (!addressDAO.addressBelongsToUser(addressId, userId)) {
            return "Địa chỉ không tồn tại.";
        }

        if (recipientName == null || recipientName.trim().isEmpty()) {
            return "Tên người nhận không được để trống.";
        }
        if (phone == null || phone.trim().isEmpty()) {
            return "Số điện thoại không được để trống.";
        }
        if (address == null || address.trim().isEmpty()) {
            return "Địa chỉ không được để trống.";
        }
        if (city == null || city.trim().isEmpty()) {
            return "Tỉnh/Thành phố không được để trống.";
        }

        if (recipientName.trim().length() < 2 || recipientName.trim().length() > 100) {
            return "Tên người nhận phải từ 2 đến 100 ký tự.";
        }
        if (phone.trim().length() < 10 || phone.trim().length() > 20) {
            return "Số điện thoại phải từ 10 đến 20 ký tự.";
        }
        if (address.trim().length() < 5 || address.trim().length() > 255) {
            return "Địa chỉ phải từ 5 đến 255 ký tự.";
        }

        if (isDefault) {
            addressDAO.setDefaultAddress(addressId, userId);
        }

        UserAddress updatingAddress = new UserAddress();
        updatingAddress.setId(addressId);
        updatingAddress.setUserId(userId);
        updatingAddress.setRecipientName(recipientName.trim());
        updatingAddress.setPhone(phone.trim());
        updatingAddress.setAddress(address.trim());
        updatingAddress.setCity(city.trim());
        updatingAddress.setIsDefault(isDefault);

        boolean success = addressDAO.updateAddress(updatingAddress);
        return success ? "success" : "Cập nhật địa chỉ thất bại.";
    }

    public String deleteAddress(int addressId, int userId) throws SQLException {

        if (!addressDAO.addressBelongsToUser(addressId, userId)) {
            return "Địa chỉ không tồn tại.";
        }

        UserAddress address = addressDAO.getAddressById(addressId);

        boolean success = addressDAO.deleteAddress(addressId);
        if (!success) {
            return "Xóa địa chỉ thất bại.";
        }

        if (address.getIsDefault()) {
            List<UserAddress> remaining = addressDAO.getUserAddresses(userId);
            if (!remaining.isEmpty()) {
                addressDAO.setDefaultAddress(remaining.get(0).getId(), userId);
            }
        }

        return "success";
    }

    public String setDefaultAddress(int addressId, int userId) throws SQLException {
        if (!addressDAO.addressBelongsToUser(addressId, userId)) {
            return "Địa chỉ không tồn tại.";
        }

        boolean success = addressDAO.setDefaultAddress(addressId, userId);
        return success ? "success" : "Đặt địa chỉ mặc định thất bại.";
    }
}
