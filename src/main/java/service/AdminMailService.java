package service;

import dao.ContactDAO;
import model.Contact;

import java.sql.SQLException;
import java.util.List;

public class AdminMailService {
    ContactDAO dao = new ContactDAO();

//    public List<Contact> sort(String type) throws SQLException, ClassNotFoundException {
//        return dao.sort(type);
//    }

    public void saveReply(String mailId, String replyContent) {
        if (mailId == null || mailId.isEmpty() || replyContent == null || replyContent.isEmpty())
            return;
        dao.saveReply(mailId, replyContent);
    }

    public List<Contact> getAllContacts() throws SQLException, ClassNotFoundException {
        return dao.getAllContacts();
    }

    public Contact getContact(String id) throws SQLException, ClassNotFoundException {
        return dao.getContact(id);
    }
}
