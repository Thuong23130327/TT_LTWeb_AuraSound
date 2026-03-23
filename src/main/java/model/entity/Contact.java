package model.entity;

import model.enums.ContactStatus;
import org.jdbi.v3.core.mapper.reflect.ColumnName;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Contact {
    private int id;
    private Integer usersID;
    private String senderMail;
    private String senderName;
    private String phone;
    private String mess;
    private String replyMess;
    private ContactStatus status;
    private Timestamp createdAt;

    public Contact() {
    }

    public Contact(int id, Integer usersID, String senderMail, String senderName, String phone, String mess, String replyMess, ContactStatus status, Timestamp createdAt) {
        this.id = id;
        this.usersID = usersID;
        this.senderMail = senderMail;
        this.senderName = senderName;
        this.phone = phone;
        this.mess = mess;
        this.replyMess = replyMess;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Integer getUsersID() { return usersID; }
    public void setUsersID(Integer usersID) { this.usersID = usersID; }

    @ColumnName("sender_email")
    public String getSenderMail() { return senderMail; }
    public void setSenderMail(String senderMail) { this.senderMail = senderMail; }

    @ColumnName("sender_name")
    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }

    @ColumnName("sender_phone")
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    @ColumnName("message")
    public String getMess() { return mess; }
    public void setMess(String mess) { this.mess = mess; }

    // JDBI sẽ gọi hàm này khi dùng .bindBean
    public int getStatus() {
        return status != null ? status.getValue() : 0;
    }

    // JDBI sẽ gọi hàm này khi map từ DB (Integer) vào Object
    public void setStatus(int value) {
        this.status = ContactStatus.fromValue(value);
    }

    public String getStringStatus() {
        return status != null ? status.getDescription() : "Không xác định";
    }

    @ColumnName("reply_content")
    public String getReplyMess() { return replyMess; }
    public void setReplyMess(String replyMess) { this.replyMess = replyMess; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getStringCreatedAt() {
        if (createdAt == null) return "Chưa xác định";
        return new SimpleDateFormat("dd/MM/yyyy HH:mm").format(createdAt);
    }

    @Override
    public String toString() {
        return "Contact{" +
                "id=" + id +
                ", usersID=" + usersID +
                ", senderMail='" + senderMail + '\'' +
                ", senderName='" + senderName + '\'' +
                ", phone='" + phone + '\'' +
                ", mess='" + mess + '\'' +
                ", replyMess='" + replyMess + '\'' +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }
}