package store.shopping;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import store.utils.DBUtils;

public class OrderDAO {

    private static final String SEARCH_ORDER_ALL = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, trackingID  "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID ";

    private static final String SEARCH_ORDER_BY_STATUS = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, trackingID  FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE statusID = ? "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String SEARCH_ORDER = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, trackingID  \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE (orderDate BETWEEN DATEADD(DAY, -DATEPART(WEEKDAY, GETDATE()) + 2 - 7 * ?, GETDATE()) \n"
            + "                 AND DATEADD(DAY, (-DATEPART(WEEKDAY, GETDATE()) + 2) * ? - 7 * ?, GETDATE())) \n"
            + "     AND statusID = ? "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String SEARCH_ORDER_BY_DATE = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, trackingID  \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE orderDate BETWEEN DATEADD(DAY, -DATEPART(WEEKDAY, GETDATE()) + 2 - 7 * ?, GETDATE()) \n"
            + "                 AND DATEADD(DAY, (-DATEPART(WEEKDAY, GETDATE()) + 2) * ? - 7 * ?, GETDATE()) "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String UPDATE_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate) VALUES (?, ?, GETDATE())";

    private static final String SEARCH_ORDER_BY_NAME = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, [TenKhongDau], trackingID  "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    //Order detail
    private static final String SEARCH_ORDER_DETAIL = "SELECT productName, t1.price, quantity, size, color "
            + "FROM tblOrderDetail t1 JOIN tblProduct t2 ON t1.productID = t2.productID "
            + "WHERE orderID = ?";

    //Order status
    private static final String SEARCH_ORDER_STATUS = "SELECT updateDate, statusName FROM tblOrderStatusUpdate t1 JOIN tblOrderStatus t2 ON t1.statusID = t2.statusID WHERE orderID = ?";

    public List<OrderDetailDTO> getOrderDetail(int orderID) throws SQLException {
        List<OrderDetailDTO> list = new ArrayList<>();

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(SEARCH_ORDER_DETAIL);
                stm.setInt(1, orderID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productName = rs.getString("productName");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    String size = rs.getString("size");
                    String color = rs.getString("color");

                    list.add(new OrderDetailDTO(productName, price, quantity, size, color));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return list;
    }

    public List<OrderStatusDTO> getUpdateStatusHistory(int orderID) throws SQLException {
        List<OrderStatusDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_STATUS);
                ptm.setInt(1, orderID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    Timestamp updateDate = rs.getTimestamp("updateDate");
                    String statusName = rs.getString("statusName");

                    list.add(new OrderStatusDTO(updateDate, statusName));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<OrderDTO> getOrder(String search, String sNumberOfWeek, String sStatusID) throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (!"%".equals(sNumberOfWeek) && !"%".equals(sStatusID)) {
                    int numberOfWeek = Integer.parseInt(sNumberOfWeek);
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(SEARCH_ORDER);
                    ptm.setInt(1, numberOfWeek);
                    //this week : numberOfWeek == 0
                    //last week : numberOfWeek == 1
                    //2 weeks ago: numberOfWeek == 2
                    //...
                    //  --first "?": n week(s) before
                    //	--second "?": this week --> 0, else 1
                    //	--third "?": n - 1 week(s) before
                    if (numberOfWeek == 0) {
                        ptm.setInt(2, 0);
                        ptm.setInt(3, 0);
                    } else {
                        ptm.setInt(2, 1);
                        ptm.setInt(3, numberOfWeek - 1);
                    }
                    ptm.setInt(4, statusID);
                    ptm.setString(5, search);
                } else if (!"%".equals(sNumberOfWeek) && "%".equals(sStatusID)) {
                    int numberOfWeek = Integer.parseInt(sNumberOfWeek);
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_DATE);

                    ptm.setInt(1, numberOfWeek);
                    if (numberOfWeek == 0) {
                        ptm.setInt(2, 0);
                        ptm.setInt(3, 0);
                    } else {
                        ptm.setInt(2, 1);
                        ptm.setInt(3, numberOfWeek - 1);
                    }
                    ptm.setString(4, search);
                } else if ("%".equals(sNumberOfWeek) && !"%".equals(sStatusID)) {
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setString(2, search);
                } else if ("%".equals(sNumberOfWeek) && "%".equals(sStatusID)) {
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_NAME);
                    ptm.setString(1, search);
                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    String userName = rs.getString("fullName");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");
                    String trackingID = rs.getString("trackingID");
                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, trackingID));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;

    }

    public boolean updateOrderStatus(int orderID, int statusID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                ptm.setInt(1, statusID);
                ptm.setInt(2, orderID);

                check = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<OrderDTO> getAllOrder() throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String userName = rs.getString("fullName");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");
                    String trackingID = rs.getString("trackingID");

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, trackingID));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

}
