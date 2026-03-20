package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class ProductSpec {
        private int id;
        private int productId;
        private String specName;
        private String specValue;


        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getProductId() {
            return productId;
        }

        @ColumnName("Products_id")
        public void setProductId(int productId) {
            this.productId = productId;
        }

        public String getSpecName() {
            return specName;
        }

        public void setSpecName(String specName) {
            this.specName = specName;
        }

        public String getSpecValue() {
            return specValue;
        }

        public void setSpecValue(String specValue) {
            this.specValue = specValue;
        }

        @Override
        public String toString() {
            return "ProductSpec [id=" + id + ", productId=" + productId + ", specName=" + specName + ", specValue="
                    + specValue + "]\n";
        }


}
