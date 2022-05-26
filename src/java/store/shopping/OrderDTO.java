package store.shopping;

import java.sql.Date;

public class OrderDTO {
    private int orderID;
    private Date orderDate;
    private int total;
    private String userName;
    private int statusID;
    private String statusName;

    

    public OrderDTO() {
    }

    public OrderDTO(int orderID, Date orderDate, int total, String userID, int statusID, String statusName) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.userName = userID;
        this.statusID = statusID;
        this.statusName = statusName;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Date getOrderDate() {
        return orderDate;
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

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }
    
    
}
