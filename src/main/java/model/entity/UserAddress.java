package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class UserAddress {

        private int id;
        private int userId;
        private String recipientName;
        private String phone;
        private String address;
        private String city;

        // Tích hợp API GHN
        private int provinceId;
        private int districtId;
        private String wardCode;

        private boolean isDefault;

        private User user;

        // Getter - Setter

        public int getId() { return id; }
        public void setId(int id) { this.id = id; }

        public int getUserId() { return userId; }
        
        @ColumnName("users_id")
        public void setUserId(int userId) { this.userId = userId; }

        public String getRecipientName() { return recipientName; }
        public void setRecipientName(String recipientName) { this.recipientName = recipientName; }

        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }

        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }

        public String getCity() { return city; }
        public void setCity(String city) { this.city = city; }

        @ColumnName("province_id")
        public int getProvinceId() { return provinceId; }
        public void setProvinceId(int provinceId) { this.provinceId = provinceId; }

        @ColumnName("district_id")
        public int getDistrictId() { return districtId; }
        public void setDistrictId(int districtId) { this.districtId = districtId; }

        @ColumnName("ward_code")
        public String getWardCode() { return wardCode; }
        public void setWardCode(String wardCode) { this.wardCode = wardCode; }

        // Jdbi sẽ tự động hiểu isDefault từ cột is_default trong DB
        public boolean getIsDefault() { return isDefault; }
        
        @ColumnName("is_default")
        public void setIsDefault(boolean isDefault) { this.isDefault = isDefault; }

        public User getUser() { return user; }
        public void setUser(User user) { this.user = user; }
        @Override
        public String toString() {
                return "UserAddress [id=" + id + ", userId=" + userId + ", recipientName=" + recipientName
                        + ", phone=" + phone + ", address=" + address + ", city=" + city
                        + ", provinceId=" + provinceId + ", districtId=" + districtId + ", wardCode=" + wardCode
                        + ", isDefault=" + isDefault + "]";
        }

}
