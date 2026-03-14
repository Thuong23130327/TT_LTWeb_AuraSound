package model.entity;

public class UserAddress {

        private int id;
        private int userId;
        private String recipientName;
        private String phone;
        private String address;
        private String city;
        private boolean isDefault;

        private User user;

        // Getter - Setter

        public int getId() { return id; }
        public void setId(int id) { this.id = id; }

        public int getUserId() { return userId; }
        public void setUserId(int userId) { this.userId = userId; }

        public String getRecipientName() { return recipientName; }
        public void setRecipientName(String recipientName) { this.recipientName = recipientName; }

        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }

        public String getAddress() { return address; }
        public void setAddress(String address) { this.address = address; }

        public String getCity() { return city; }
        public void setCity(String city) { this.city = city; }

        // Jdbi sẽ tự động hiểu isDefault từ cột is_default trong DB
        public boolean isDefault() { return isDefault; }
        public void setDefault(boolean isDefault) { this.isDefault = isDefault; }

        public User getUser() { return user; }
        public void setUser(User user) { this.user = user; }

        @Override
        public String toString() {
            return recipientName + " | " + phone + " | " + address + ", " + city;
        }


}
