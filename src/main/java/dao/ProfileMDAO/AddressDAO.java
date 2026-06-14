package dao.ProfileMDAO;

import model.entity.UserAddress;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class AddressDAO {

    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<UserAddress> getUserAddresses(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM user_addresses WHERE users_id = :userId ORDER BY is_default DESC, id DESC")
                        .bind("userId", userId)
                        .mapToBean(UserAddress.class)
                        .list()
        );
    }

    public UserAddress getAddressById(int addressId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM user_addresses WHERE id = :id")
                        .bind("id", addressId)
                        .mapToBean(UserAddress.class)
                        .findFirst()
                        .orElse(null)
        );
    }


    public boolean addressBelongsToUser(int addressId, int userId) {
        UserAddress addr = getAddressById(addressId);
        return addr != null && addr.getUserId() == userId;
    }


    public int getAddressCount(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM user_addresses WHERE users_id = :userId")
                        .bind("userId", userId)
                        .mapTo(Integer.class)
                        .findFirst()
                        .orElse(0)
        );
    }


    public boolean createAddress(UserAddress address) {
        return jdbi.withHandle(handle ->
                handle.createUpdate(
                        "INSERT INTO user_addresses (users_id, recipient_name, phone, address, city, province_id, district_id, ward_code, is_default) " +
                        "VALUES (:userId, :recipientName, :phone, :address, :city, :provinceId, :districtId, :wardCode, :isDefault)"
                )
                        .bind("userId", address.getUserId())
                        .bind("recipientName", address.getRecipientName())
                        .bind("phone", address.getPhone())
                        .bind("address", address.getAddress())
                        .bind("city", address.getCity())
                        .bind("provinceId", address.getProvinceId())
                        .bind("districtId", address.getDistrictId())
                        .bind("wardCode", address.getWardCode())
                        .bind("isDefault", address.getIsDefault())
                        .execute() > 0
        );
    }

    public boolean updateAddress(UserAddress address) {
        return jdbi.withHandle(handle ->
                handle.createUpdate(
                        "UPDATE user_addresses SET recipient_name = :recipientName, phone = :phone, " +
                        "address = :address, city = :city, province_id = :provinceId, district_id = :districtId, ward_code = :wardCode, is_default = :isDefault WHERE id = :id"
                )
                        .bind("id", address.getId())
                        .bind("recipientName", address.getRecipientName())
                        .bind("phone", address.getPhone())
                        .bind("address", address.getAddress())
                        .bind("city", address.getCity())
                        .bind("provinceId", address.getProvinceId())
                        .bind("districtId", address.getDistrictId())
                        .bind("wardCode", address.getWardCode())
                        .bind("isDefault", address.getIsDefault())
                        .execute() > 0
        );
    }

    public boolean deleteAddress(int addressId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM user_addresses WHERE id = :id")
                        .bind("id", addressId)
                        .execute() > 0
        );
    }

    public boolean setDefaultAddress(int addressId, int userId) {
        return jdbi.withHandle(handle -> {
            // First, unset all other defaults for this user
            handle.createUpdate("UPDATE user_addresses SET is_default = false WHERE users_id = :userId")
                    .bind("userId", userId)
                    .execute();

            // Then, set the new default
            return handle.createUpdate("UPDATE user_addresses SET is_default = true WHERE id = :id AND users_id = :userId")
                    .bind("id", addressId)
                    .bind("userId", userId)
                    .execute() > 0;
        });
    }


    public UserAddress getDefaultAddress(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM user_addresses WHERE users_id = :userId AND is_default = true LIMIT 1")
                        .bind("userId", userId)
                        .mapToBean(UserAddress.class)
                        .findFirst()
                        .orElse(null)
        );
    }
}
