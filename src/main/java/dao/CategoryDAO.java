package dao;

import dao.DB.DBConnect;
import model.entity.Category;
import model.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    private Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Category> getAllCategories() throws SQLException, ClassNotFoundException {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try {
            conn = DBConnect.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category(rs.getInt(1), rs.getString(2));
                int idParent = rs.getInt(3) != 0 ? rs.getInt(3) : 0;
                c.setParentID(idParent);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        CategoryDao dao = new CategoryDao();
        List<Category> l = dao.getAllCategories();
        System.out.println(l);
    }


}
