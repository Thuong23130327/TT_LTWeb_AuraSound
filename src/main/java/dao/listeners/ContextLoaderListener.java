package dao.listeners;

import dao.DB.DBConnect;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import model.entity.Brand;
import model.entity.Category;
import service.ProductService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebListener
public class ContextLoaderListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DBConnect.init();
        System.out.println("HikariCP & JDBI start thanh cong");
        ServletContext context = sce.getServletContext();

        ProductService productService = new ProductService();
        List<Category> allCategories = productService.getAllCategories();
        List<Brand> allBrands = productService.getListBrands();

        Map<Integer, Category> map = new HashMap<>();
        for (Category cat : allCategories) {
            map.put(cat.getId(), cat);
        }
        List<Category> rootCategories = new ArrayList<>();

        for (Category cat : allCategories) {
            if (cat.getParentId() == 0) {
                rootCategories.add(cat);
            } else {
                Category parent = map.get(cat.getParentId());
                if (parent != null) {
                    parent.getChildren().add(cat);
                }
            }
        }
        context.setAttribute("brandList", allBrands);
        context.setAttribute("MENU_TREE", rootCategories);
        context.setAttribute("AuraSound", context.getContextPath());

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DBConnect.close();
        System.out.println("HikariCP đã được đóng an toàn!");

        try {
            java.sql.Driver mySqlDriver = java.sql.DriverManager.getDriver("jdbc:mysql://localhost:3306/");
            java.sql.DriverManager.deregisterDriver(mySqlDriver);
        } catch (java.sql.SQLException ex) {
            System.out.println("Không thể hủy đăng ký driver MySQL.");
        }
    }
}
