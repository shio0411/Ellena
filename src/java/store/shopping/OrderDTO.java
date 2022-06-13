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

    public OrderDTO() {
    }

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

}
