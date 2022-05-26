package store.shopping;

import java.sql.Date;

public class OrderStatusDTO {

    private Date updateDate;
    private String statusName;

    public OrderStatusDTO() {
    }

    public OrderStatusDTO(Date updateDate, String statusName) {
        this.updateDate = updateDate;
        this.statusName = statusName;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

}
