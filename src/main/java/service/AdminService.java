package service;


import dao.AdminDAO.AdminDAO;

import java.util.Map;

public class AdminService {

    public static Map<String, Object> getDashboardStats() {
        return AdminDAO.getDashboardStats();
    }

}