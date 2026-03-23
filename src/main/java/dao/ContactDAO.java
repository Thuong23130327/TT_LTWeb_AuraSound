package dao;

import model.entity.Contact;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class ContactDAO {

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public Contact getContact(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM contactmails WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Contact.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public boolean insertContact(Contact contact) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO contactmails "
                                + "(Users_id, sender_name, sender_email, sender_phone, message, status, created_at) "
                                + "VALUES (:usersID, :senderName, :senderMail, :phone, :mess, :status, NOW())")
                        .bindBean(contact)
                        .execute() > 0
        );
    }

    public List<Contact> getAllContacts() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM contactmails WHERE message IS NOT NULL AND TRIM(message) <> ''")
                        .mapToBean(Contact.class).list());
    }

    public List<Contact> sort(String type) {
        StringBuilder sql = new StringBuilder("SELECT * FROM contactmails WHERE message IS NOT NULL AND TRIM(message) <> ''");

        if ("rep".equals(type)) sql.append(" AND status = 1");
        else if ("non".equals(type)) sql.append(" AND status = 0");

        if ("old".equals(type)) sql.append(" ORDER BY created_at ASC");
        else sql.append(" ORDER BY created_at DESC");

        return jdbi.withHandle(handle -> handle.createQuery(sql.toString()).mapToBean(Contact.class).list());
    }

}
