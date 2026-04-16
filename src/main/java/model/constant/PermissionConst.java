package model.constant;

import java.util.LinkedHashMap;
import java.util.Map;

public class PermissionConst {
    // CATEGORY
    public static final String CAN_CATEGORY_CREATE = "can_category_create";
    public static final String CAN_CATEGORY_VIEW = "can_category_view";

    // PRODUCT
    public static final String CAN_PRODUCT_CREATE = "can_product_create";
    public static final String CAN_PRODUCT_VIEW = "can_product_view";

    // SYSTEM
    public static final String CAN_SYSTEM_CONFIG = "can_system_config";

    // Danh sách
    public static final Map<String, String> MASTER_LIST = new LinkedHashMap<>();

    static {
        MASTER_LIST.put(CAN_CATEGORY_CREATE, "Tạo danh mục");
        MASTER_LIST.put(CAN_CATEGORY_VIEW, "Xem danh mục");
        MASTER_LIST.put(CAN_PRODUCT_CREATE, "Tạo sản phẩm");
        MASTER_LIST.put(CAN_PRODUCT_VIEW, "Xem sản phẩm");
        MASTER_LIST.put(CAN_SYSTEM_CONFIG, "Cấu hình hệ thống");
    }
}