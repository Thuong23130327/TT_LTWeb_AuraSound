package dao;

import model.entity.Brand;
import org.jdbi.v3.core.Jdbi;
import java.util.List;

public class BrandDAO {

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Brand> getAll() {
        String sql = "SELECT * FROM Brands";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Brand.class).list());
    }

    public static void main(String[] args) {
        BrandDAO dao = new BrandDAO();
        System.out.println(dao.getAll());
    }

}
