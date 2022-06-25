package store.shopping;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class OrderDTO {

    private int orderID;
    private Date orderDate;
    private int total;
    private String userName;
    private int statusID;
    private String statusName;
    private String payType;
    private String trackingID;
    private String fullName;
    private String address;
    private String phone;
    private String email;
    private String note;
    private String transactionNumber;

    public OrderDTO() {
    }

    // constructor for Manager-order/Employee-order 
    public OrderDTO(int orderID, Date orderDate, int total, String userName, int statusID, String statusName, String payType, String trackingID) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.userName = userName;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.trackingID = trackingID;
    }

    // normal constructor with no transactionNumber, orderID, trackingID
    public OrderDTO(Date orderDate, int total, String userName, int statusID, String statusName, String payType, String fullName, String address, String phone, String email, String note) {
        this.orderDate = orderDate;
        this.total = total;
        this.userName = userName;
        this.statusID = statusID;
        this.statusName = statusName;
        this.payType = payType;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.note = note;
    }
    

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getOrderDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(orderDate);
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getTrackingID() {
        return trackingID;
    }

    public void setTrackingID(String trackingID) {
        this.trackingID = trackingID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getTransactionNumber() {
        return transactionNumber;
    }

    public void setTransactionNumber(String transactionNumber) {
        this.transactionNumber = transactionNumber;
    }

    
    

}
