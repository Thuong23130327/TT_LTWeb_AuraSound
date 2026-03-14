package dao;

import dao.DB.DBConnect;
import model.entity.Product;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ProductDAO {
    private Connection conn= null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private Jdbi jdbi = dao.DB.DBConnect.getJdbi();
    static Map<Integer, Product> data = new HashMap<>();

    public List<Product> getAllProduct(){
        return jdbi.withHandle(handle -> handle.createQuery("select * from products").mapToBean(Product.class).list());
    }

    public List<Product> getFeaturedProducts(int limit) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT *, (avg_rating + (view_count / (SELECT SUM(view_count) + 1 FROM products) * 100) " +
                                "+ (search_count / (SELECT SUM(search_count) + 1 FROM products) * 100)) as hot_score " +
                                "FROM products WHERE is_active = 1 ORDER BY hot_score DESC LIMIT :limit")
                        .bind("limit", limit)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public List<Product> getProductByCategoryId(String cateId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE Categories_id = :cateId OR " +
                                "Categories_id IN (SELECT id FROM categories WHERE Categories_id = :cateId)")
                        .bind("cateId", cateId)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public Product getById(String id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM products WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public List<Product> searchProductByText(String textSearch) {
        String searchTerm = "%" + textSearch + "%";
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT p.* FROM products p " +
                                "JOIN brands b ON b.id = p.Brands_id " +
                                "JOIN categories c ON c.id = p.Categories_id " +
                                "WHERE p.name LIKE :search " +
                                "OR p.sku LIKE :search " +
                                "OR p.display_sell_price LIKE :search " +
                                "OR p.display_market_price LIKE :search " +
                                "OR b.name LIKE :search " +
                                "OR c.name LIKE :search")
                        .bind("search", searchTerm)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public Map<Integer, Integer> getTotalStock() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT Products_id, SUM(stock_quantity) as total FROM productvariants GROUP BY Products_id")
                        .reduceResultSet(new HashMap<Integer, Integer>(), (map, rs, ctx) -> {
                            map.put(rs.getInt("Products_id"), rs.getInt("total"));
                            return map;
                        })
        );
    }

    public boolean deleteProduct(String pid) {
        try {
            return jdbi.inTransaction(handle -> {

                handle.createUpdate("DELETE FROM productspecs WHERE Products_id = :id")
                        .bind("id", pid)
                        .execute();

                handle.createUpdate("DELETE FROM productvariants WHERE Products_id = :id")
                        .bind("id", pid)
                        .execute();

                handle.createUpdate("DELETE FROM productgalleries WHERE Products_id = :id")
                        .bind("id", pid)
                        .execute();


//                 return handle.createUpdate("DELETE FROM products WHERE id = :id").bind("id", pid).execute() > 0;

                return true;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Map<Integer, Integer> getVarTotal() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT Products_id, count(id) as total_count FROM productvariants GROUP BY Products_id")
                        .reduceResultSet(new HashMap<Integer, Integer>(), (map, rs, ctx) -> {
                            map.put(rs.getInt("Products_id"), rs.getInt("total_count"));
                            return map;
                        })
        );
    }

    public List<Product> getPerPageProductByCategoryId(int numPerPage, int page, String cateId, String selectedSort) {
        StringBuilder sql = new StringBuilder(
                "SELECT * FROM products WHERE Categories_id = :cateId OR " +
                        "Categories_id IN (SELECT id FROM categories WHERE Categories_id = :cateId) ");

        if ("price-asc".equals(selectedSort)) {
            sql.append(" ORDER BY display_sell_price ASC ");
        } else if ("price-desc".equals(selectedSort)) {
            sql.append(" ORDER BY display_sell_price DESC ");
        } else {
            sql.append(" ORDER BY id ");
        }

        sql.append(" LIMIT :limit OFFSET :offset");

        return jdbi.withHandle(handle ->
                handle.createQuery(sql.toString())
                        .bind("cateId", cateId)
                        .bind("limit", numPerPage)
                        .bind("offset", (page - 1) * numPerPage)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    private Product mapRStoProduct(ResultSet rs) throws SQLException {
        return new Product(rs.getInt("id"), rs.getInt("Brands_id"), rs.getInt("Categories_id"),
                rs.getString("sku"), rs.getString("name"), rs.getString("description"),
                rs.getFloat("avg_rating"), rs.getInt("sold_count"), rs.getBoolean("is_active"),
                rs.getTimestamp("created_at"),
                rs.getDouble("display_market_price"), rs.getDouble("display_sell_price"), rs.getString("display_image_url"));
    }

    public List<Product> getPerPageAllProduct(int numPerPage, int page, String selectedSort) {
        StringBuilder sql = new StringBuilder("SELECT * FROM products");

        if ("price-asc".equals(selectedSort)) {
            sql.append(" ORDER BY display_sell_price ASC");
        } else if ("price-desc".equals(selectedSort)) {
            sql.append(" ORDER BY display_sell_price DESC");
        } else {
            sql.append(" ORDER BY id");
        }

        sql.append(" LIMIT :limit OFFSET :offset");

        return jdbi.withHandle(handle ->
                handle.createQuery(sql.toString())
                        .bind("limit", numPerPage)
                        .bind("offset", (page - 1) * numPerPage)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public int pageNeed(String cateId, int sizePerPage) {
        long totalRecords;

        if (cateId == null || "0".equals(cateId)) {
            totalRecords = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT COUNT(*) FROM products")
                            .mapTo(Long.class)
                            .findFirst() // Lấy kết quả đầu tiên
                            .orElse(0L)); // Nếu không có mặc định là 0
        } else {
            totalRecords = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT COUNT(*) FROM products WHERE Categories_id = :cateId OR " +
                                    "Categories_id IN (SELECT id FROM categories WHERE Categories_id = :cateId)")
                            .bind("cateId", cateId)
                            .mapTo(Long.class)
                            .findFirst()
                            .orElse(0L));
        }

        if (totalRecords == 0) return 1;
        // Tính số trang
        return (int) Math.ceil((double) totalRecords / sizePerPage);
    }

    private List<String> getListCategoryIdsIncludingChildren(String[] cateIds) {
        if (cateIds == null || cateIds.length == 0) return new ArrayList<>();

        Set<String> allCategoryIds = new HashSet<>(Arrays.asList(cateIds));

        List<String> childIds = jdbi.withHandle(handle ->
                handle.createQuery("SELECT id FROM categories WHERE Categories_id IN (<ids>)")
                        .bindList("ids", Arrays.asList(cateIds))
                        .mapTo(String.class)
                        .list()
        );

        allCategoryIds.addAll(childIds);
        return new ArrayList<>(allCategoryIds);
    }

    public List<Product> filterProduct(String[] brandIds, String[] cateIds, int numPerPage, int page, String selectedSort) {
        StringBuilder sql = new StringBuilder("SELECT p.* FROM Products p ");
        sql.append("LEFT JOIN Brands b ON p.Brands_id = b.id ");
        sql.append("LEFT JOIN Categories c ON p.Categories_id = c.id ");
        sql.append("WHERE p.display_sell_price <> 0 ");
        sql.append("AND p.display_image_url IS NOT NULL ");
        sql.append("AND TRIM(p.display_image_url) <> '' ");
        //brands
        if (brandIds != null && brandIds.length > 0) {
            sql.append(" AND p.Brands_id IN (<brandIds>) ");
        }
        // cate
        if (cateIds != null && cateIds.length > 0) {
            List<String> allCateIds = getListCategoryIdsIncludingChildren(cateIds);
            if (!allCateIds.isEmpty()) {
                sql.append(" AND p.Categories_id IN (<cateIds>) ");
            }
        }
        if (selectedSort == null) {
            sql.append(" ORDER BY p.id DESC ");
        } else if (selectedSort.equals("price-asc")) {
            sql.append(" ORDER BY p.display_sell_price ASC ");
        } else if (selectedSort.equals("price-desc")) {
            sql.append(" ORDER BY p.display_sell_price DESC ");
        }
        boolean hasPagination = (page * numPerPage != 0);
        if (hasPagination) {
            sql.append(" LIMIT :limit OFFSET :offset");
        }
        return jdbi.withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            if (brandIds != null && brandIds.length > 0) {
                query.bindList("brandIds", Arrays.asList(brandIds));
            }
            if (cateIds != null && cateIds.length > 0) {
                List<String> allCateIds = getListCategoryIdsIncludingChildren(cateIds);
                if (!allCateIds.isEmpty()) {
                    query.bindList("cateIds", allCateIds);
                }
            }
            if (hasPagination) {
                query.bind("limit", numPerPage)
                        .bind("offset", (page - 1) * numPerPage);
            }
            return query.mapToBean(Product.class).list();
        });
    }

    public boolean updateProduct(String pid, String brandid, String cateid, String name, String sku, String discript, String varSelected, String isActive) {
        try {
            return jdbi.inTransaction(handle -> {
                handle.createUpdate("UPDATE products SET brands_id = :brandId, categories_id = :cateId, name = :name, sku = :sku, description = :desc, is_active = :isActive WHERE id = :id")
                        .bind("brandId", brandid)
                        .bind("cateId", cateid)
                        .bind("name", name)
                        .bind("sku", sku)
                        .bind("desc", discript)
                        .bind("isActive", isActive)
                        .bind("id", pid)
                        .execute();

                handle.createUpdate("UPDATE productvariants SET is_default = 0 WHERE products_id = :id")
                        .bind("id", pid)
                        .execute();

                handle.createUpdate("UPDATE productvariants SET is_default = 1 WHERE id = :varId")
                        .bind("varId", varSelected)
                        .execute();

                handle.createUpdate("UPDATE products p " +
                                "JOIN productvariants v ON p.id = v.products_id " +
                                "SET p.display_image_url = v.main_image_url, " +
                                "    p.display_sell_price = v.sell_price, " +
                                "    p.display_market_price = v.market_price " +
                                "WHERE v.id = :varId AND p.id = :id")
                        .bind("varId", varSelected)
                        .bind("id", pid)
                        .execute();

                return true;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSpecs(String[] inputSpecIds, String[] inputSpecValue) {
        try {
            jdbi.useHandle(handle -> {
                var batch = handle.prepareBatch("UPDATE productspecs SET spec_value = :value WHERE id = :id");
                for (int i = 0; i < inputSpecIds.length; i++) {
                    batch.bind("value", inputSpecValue[i])
                            .bind("id", inputSpecIds[i])
                            .add();
                }
                batch.execute();
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int addProduct(Product p) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO products (Brands_id, Categories_id, sku, name, description, is_active, avg_rating) " +
                                "VALUES (:brandId, :categoriesId, :sku, :name, :description, :isActive, :avgRating)")
                        .bindBean(p)
                        .bind("avgRating", 5.0)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .findFirst()
                        .orElse(-1)
        );
    }

    public void updateSearchCount(String id) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE products SET search_count = search_count + 1 WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public void updateViewCount(String pid) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE products SET view_count = view_count + 1 WHERE id = :id")
                        .bind("id", pid)
                        .execute()
        );
    }
}
