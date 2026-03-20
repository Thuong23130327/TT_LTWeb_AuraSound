package model.entity;

import org.jdbi.v3.core.mapper.Nested;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class OrderShipping {
    private int id;
    private int orderId;
    private String note;
    private UserAddress userAddress;
    
    
//    Get- set
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderId() {
		return orderId;
	}

    @ColumnName("Orders_id")
    public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
    public String getNote() {
        if (note == null || note.trim() == "")
            return "Không có ghi chú";
        return note;
    }
	public void setNote(String note) {
		this.note = note;
	}
	public UserAddress getUserAddress() {
		return userAddress;
	}
    @Nested("ua")
	public void setUserAddress(UserAddress userAddress) {
		this.userAddress = userAddress;
	}
	@Override
	public String toString() {
		return "OrderShipping [id=" + id + ", orderId=" + orderId + ", note=" + note + ", userAddress=" + userAddress
				+ "]\n";
	}




}
