package service;

import dao.ContactDAO;
import model.entity.Contact;
import model.entity.User;
import model.enums.ContactStatus;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ContactService {
    private ContactDAO contactDAO = new ContactDAO();
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();
    public boolean sendContactMail(String email, String name, String phone, String message, User user) {
        if (message == null || message.trim().isEmpty()) return false;

        Contact contact = new Contact();
        contact.setUsersID(user != null ? user.getId() : null);
        contact.setSenderMail(email);
        contact.setSenderName(name);
        contact.setPhone(phone);
        contact.setMess(message);
        contact.setStatus(ContactStatus.NEW.getValue());
        contact.setStatus(0);

        return contactDAO.insertContact(contact);
    }

    public List<Contact> getAll() {
        return contactDAO.getAllContacts();
    }
}
