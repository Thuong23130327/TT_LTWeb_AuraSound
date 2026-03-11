package dao;

import model.Category;
import model.Contact;
import model.ContactReply;
import model.Product;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {
    private static Connection conn = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;

    static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Contact> getAllContacts() throws SQLException, ClassNotFoundException {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT * FROM contactmails WHERE message is not null and trim(message) <>''").mapToBean(Contact.class).list());
    }

    public Contact getContact(String id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM contactmails WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Contact.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public static boolean insertContact(Contact contact) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO ContactMails "
                                + "(Users_id, sender_name, sender_email, sender_phone, message, reply_content, status, created_at) "
                                + "VALUES (:usersID, :senderName, :senderMail, :phone, :mess, :replyMess, :status, NOW())")
                        .bindBean(contact)
                        .execute() > 0
        );
    }

    private Contact mapContact(ResultSet rs) throws SQLException {
        Contact contact = new Contact();
        contact.setId(rs.getInt(1));
        contact.setUsersID(rs.getInt(2));
        contact.setSenderName(rs.getString(3));
        contact.setSenderMail(rs.getString(4));
        contact.setPhone(rs.getString(5));
        contact.setMess(rs.getString(6));
        contact.setReplyMess(rs.getString(7));
        contact.setStatus(Contact.Status.valueOf(rs.getString(8)));
        contact.setCreatedAt(rs.getTimestamp(9));
        return contact;
    }
//Fix JDBI


    public List<ContactReply> getReplies(int contactId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ContactReplies WHERE contact_id = :contactId ORDER BY created_at ASC")
                        .bind("contactId", contactId)
                        .mapToBean(ContactReply.class)
                        .list()
        );
    }

    public void addReply(ContactReply reply) {
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO ContactReplies (contact_id, sender_type, message, created_at) " +
                                "VALUES (:contactId, :senderType, :message, NOW())")
                        .bindBean(reply)
                        .execute()
        );
    }


    public void saveReply(String mailId, String replyContent) {
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE contactmails SET status = 'Replied', reply_content = :replyContent WHERE id = :id")
                        .bind("replyContent", replyContent)
                        .bind("id", mailId)
                        .execute()
        );
    }

    public List<Contact> sort(String type) {
        if (type == null) return new ArrayList<>();
//    Dùng StringBuilder nối chuỗi sql rồi mapToBean chuyển đổi kq
        StringBuilder sql = new StringBuilder("SELECT * FROM contactmails WHERE message IS NOT NULL AND TRIM(message) <> ''");

        switch (type) {
            case "rep":
                sql.append(" AND status = 'Replied' ORDER BY created_at DESC");
                break;
            case "non":
                sql.append(" AND status = 'New' ORDER BY created_at DESC");
                break;
            case "old":
                sql.append(" ORDER BY created_at");
                break;
            case "new":
                sql.append(" ORDER BY created_at DESC");
                break;
            default:
                sql.append(" ORDER BY created_at DESC");

                return jdbi.withHandle(handle ->
                        handle.createQuery(sql.toString())
                                .mapToBean(Contact.class)
                                .list()
                );

    }
        return List.of();
    }
}
