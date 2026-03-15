package dao.listeners;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
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
        ServletContext context = sce.getServletContext();

        ProductService productService = new ProductService();
        List<Category> allCategories = productService.getAllCategories();
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
        context.setAttribute("MENU_TREE", rootCategories);
        context.setAttribute("AuraSound", context.getContextPath());

    }
}
