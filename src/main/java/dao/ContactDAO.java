package dao;

import model.entity.Contact;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ContactDAO {

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Contact> getAll() {
        String sql = "SELECT * FROM contacts";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Contact.class).list());
    }

    public static void main(String[] args) {
        ContactDAO contactDAO = new ContactDAO();
        System.out.println(contactDAO.getAll());
    }

}
