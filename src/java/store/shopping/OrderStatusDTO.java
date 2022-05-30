package store.shopping;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class OrderStatusDTO {

    private Timestamp updateDate;
    private String statusName;

    public OrderStatusDTO() {
    }

    public OrderStatusDTO(Timestamp updateDate, String statusName) {
        this.updateDate = updateDate;
        this.statusName = statusName;
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
