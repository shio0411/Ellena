package store.shopping;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class OrderStatusDTO {

    private int statusID;
    private Timestamp updateDate;
    private String statusName;

    public OrderStatusDTO() {
    }

    public OrderStatusDTO(int statusID, Timestamp updateDate, String statusName) {
        this.statusID = statusID;
        this.updateDate = updateDate;
        this.statusName = statusName;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public String getUpdateDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return sdf.format(updateDate);
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

}
