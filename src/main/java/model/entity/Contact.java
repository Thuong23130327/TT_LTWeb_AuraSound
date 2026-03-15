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


    //    Get -set
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer getUsersID() {
        return usersID;
    }

    public void setUsersID(Integer usersID) {
        this.usersID = usersID;
    }

    public String getSenderMail() {
        return senderMail;
    }

    @ColumnName("sender_email")
    public void setSenderMail(String senderMail) {
        this.senderMail = senderMail;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getPhone() {
        return phone;
    }

    @ColumnName("sender_phone")
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMess() {
        return mess;
    }

    @ColumnName("message")
    public void setMess(String mess) {
        this.mess = mess;
    }

    public ContactStatus getStatus() {
        return status;
    }

    public String getStringStatus() {
        return status.toString();
    }

    public void setStatus(int value) {
        this.status = ContactStatus.fromValue(value);
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public String getStringCreatedAt() {
        if (createdAt == null)
            return "Chưa xác định";
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        return sdf.format(createdAt);
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getReplyMess() {
        return replyMess;
    }

    @ColumnName("reply_content")
    public void setReplyMess(String replyMess) {
        this.replyMess = replyMess;
    }


}
