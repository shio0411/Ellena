package store.shopping;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import store.utils.DBUtils;

public class OrderDAO {

    private static final String SEARCH_ORDER_ALL = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID";

    private static final String SEARCH_ORDER_BY_STATUS = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID WHERE statusID = ?";

    private static final String SEARCH_ORDER = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE (orderDate BETWEEN DATEADD(DAY, -DATEPART(WEEKDAY, GETDATE()) + 2 - 7 * ?, GETDATE()) \n"
            + "                 AND DATEADD(DAY, (-DATEPART(WEEKDAY, GETDATE()) + 2) * ? - 7 * ?, GETDATE())) \n"
            + "     AND statusID = ?";

    private static final String SEARCH_ORDER_BY_DATE = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE orderDate BETWEEN DATEADD(DAY, -DATEPART(WEEKDAY, GETDATE()) + 2 - 7 * ?, GETDATE()) \n"
            + "                 AND DATEADD(DAY, (-DATEPART(WEEKDAY, GETDATE()) + 2) * ? - 7 * ?, GETDATE())";

    private static final String UPDATE_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate) VALUES (?, ?, GETDATE())";

    private static final String SEARCH_ORDER_BY_EMAIL = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, [TenKhongDau] "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    

    public List<OrderDTO> getOrderByEmail(String search) throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_BY_EMAIL);
                ptm.setString(1, search);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    String userName = rs.getString("fullName");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName));

                }
            }
        } catch (Exception e) {
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

    public List<OrderDTO> getOrder(int numberOfWeek, int statusID) throws SQLException {
        //this week : numberOfWeek == 0
        //last week : numberOfWeek == 1
        //2 weeks ago: numberOfWeek == 2
        //...
//      --first "?": n week(s) before
//	--second "?": this week --> 0, else 1
//	--third "?": n - 1 week(s) before
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER);
                ptm.setInt(1, numberOfWeek);

                if (numberOfWeek == 0) {
                    ptm.setInt(2, 0);
                    ptm.setInt(3, 0);
                } else {
                    ptm.setInt(2, 1);
                    ptm.setInt(3, numberOfWeek - 1);
                }
                ptm.setInt(4, statusID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String userName = rs.getString("fullName");
                    String statusName = rs.getString("statusName");

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName));

                }
            }
        } catch (Exception e) {
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

    public List<OrderDTO> getOrderByDate(int numberOfWeek) throws SQLException {
        //this week : numberOfWeek == 0
        //last week : numberOfWeek == 1
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_BY_DATE);

                ptm.setInt(1, numberOfWeek);
                if (numberOfWeek == 0) {
                    ptm.setInt(2, 0);
                    ptm.setInt(3, 0);
                } else {
                    ptm.setInt(2, 1);
                    ptm.setInt(3, numberOfWeek - 1);
                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String userName = rs.getString("fullName");
                    int statusID = rs.getInt("statusID");
                    String statusName = rs.getString("statusName");

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName));

                }
            }
        } catch (Exception e) {
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

    //gửi statusID qua
    public List<OrderDTO> getOrderByStatus(int statusID) throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_ORDER_BY_STATUS);
                ptm.setInt(1, statusID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    Date orderDate = rs.getDate("orderDate");
                    int total = rs.getInt("total");
                    String userName = rs.getString("fullName");
                    String statusName = rs.getString("statusName");

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName));
                }
            }
        } catch (Exception e) {
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

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName));
                }
            }
        } catch (Exception e) {
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
