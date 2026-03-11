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

    //    Lay brand theo id brand
    public Brand getById(int id){
        String sql = "SELECT * FROM Brands WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Brand.class)
                        .findFirst()
                        .orElse(null)
        );
    }

}
