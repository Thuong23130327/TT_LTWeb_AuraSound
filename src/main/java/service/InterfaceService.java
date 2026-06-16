package service;

import dao.BannerDAO;
import dao.BrandDAO;
import dao.CategoryDAO;
import dao.FooterLinkDAO;
import model.entity.*;

import java.util.List;

public class InterfaceService {
    private BannerDAO bannerDAO = new BannerDAO();
    private BrandDAO brandDAO = new BrandDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private FooterLinkDAO footerLinkDAO = new FooterLinkDAO();

    public List<Banner> getAllBanners() {
        return bannerDAO.getAll();
    }
    public void reorderBanners(String[] ids) {
        int sort = 1;
        for (String id : ids) {
            bannerDAO.updateSortOrder(Integer.parseInt(id), sort++);
        }
    }
    public List<Brand> getAllBrands() {
        return brandDAO.getAll();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAll();
    }

    public List<FooterLink> getAllFooterLinks() {
        return footerLinkDAO.getAll();
    }

    public boolean addBanner(String img, String url, String title, String description, int sortOrder) {
        return bannerDAO.insert(img, url, title, description, sortOrder);
    }

    public boolean toggleBannerStatus(int id, boolean currentStatus) {
        return bannerDAO.updateStatus(id, !currentStatus);
    }

    public boolean deleteBanner(int id) {
        return bannerDAO.delete(id);
    }

    public boolean addBrand(String name, String logo) {
        return brandDAO.insert(name, logo);
    }

    public boolean deleteBrand(int id) {
        return brandDAO.delete(id);
    }

    public boolean addCategory(String name, Integer pId) {
        return categoryDAO.insert(name, pId);
    }

    public boolean deleteCategory(int id) {
        return categoryDAO.delete(id);
    }

    public boolean addFooter(String title, String target, int sort) {
        FooterLink f = new FooterLink();
        f.setTitle(title);
        f.setTargetUrl(target);
        f.setSortOrder(sort);
        return footerLinkDAO.insert(f);
    }

    public boolean deleteFooter(int id) {
        return footerLinkDAO.delete(id);
    }

    public boolean updateBanner(int id, String title, String description, String targetUrl, int sortOrder) {
        return bannerDAO.update(id, title, description, targetUrl, sortOrder);
    }

    public boolean updateBrand(int id, String name, String logoUrl) {
        return brandDAO.update(id, name, logoUrl);
    }
    public boolean updateCategory(int id, String name, Integer parentId) {
        return categoryDAO.update(id, name, parentId);
    }
    public boolean updateFooter(int id, String title, String targetUrl, int sortOrder) {
        return footerLinkDAO.update(id, title, targetUrl, sortOrder);
    }
}