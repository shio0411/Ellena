package store.shopping;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import store.utils.DBUtils;

public class OrderDAO {

    private static final String UPDATE_TRACKINGID = "UPDATE tblOrder SET trackingID = ? WHERE orderID = ?";
    private static final String SEARCH_ORDER_ALL = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID  "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID ";

    private static final String SEARCH_ORDER_BY_STATUS = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID  FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE statusID = ? "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String SEARCH_ORDER = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID  \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE (orderDate BETWEEN DATEADD(DAY, -DATEPART(WEEKDAY, GETDATE()) + 2 - 7 * ?, GETDATE()) \n"
            + "                 AND DATEADD(DAY, (-DATEPART(WEEKDAY, GETDATE()) + 2) * ? - 7 * ?, GETDATE())) \n"
            + "     AND statusID = ? "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String SEARCH_ORDER_BY_DATE = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID  \n"
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID \n"
            + "WHERE orderDate BETWEEN DATEADD(DAY, -DATEPART(WEEKDAY, GETDATE()) + 2 - 7 * ?, GETDATE()) \n"
            + "                 AND DATEADD(DAY, (-DATEPART(WEEKDAY, GETDATE()) + 2) * ? - 7 * ?, GETDATE()) "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String UPDATE_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate, modifiedBy, roleID) VALUES (?, ?, GETDATE(), ?, ?)";

    private static final String SEARCH_ORDER_BY_NAME = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, [TenKhongDau], payType, trackingID  "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    //Order detail
    private static final String SEARCH_ORDER_DETAIL = "SELECT productName, t1.price, quantity, size, color "
            + "FROM tblOrderDetail t1 JOIN tblProduct t2 ON t1.productID = t2.productID "
            + "WHERE orderID = ?";

    //Order status
    private static final String SEARCH_ORDER_STATUS = "SELECT t1.statusID, updateDate, statusName FROM tblOrderStatusUpdate t1 JOIN tblOrderStatus t2 ON t1.statusID = t2.statusID WHERE orderID = ?";

    private static final String INSERT_ORDER = "INSERT INTO tblOrder(orderDate, total, userID, payType, fullName, [address], phone, email, note, transactionNumber) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_ORDER_DETAIL = "INSERT INTO tblOrderDetail(price, quantity, size, color, orderID, productID) VALUES(?, ?, ?, ?, ?, ?)";

    private static final String GET_ORDER_ID = "SELECT TOP 1 orderID FROM tblOrder WHERE userID LIKE ? + '%' ORDER BY orderID DESC";

    public int getOrderID(String userID) throws SQLException {
        int orderID = 0;

        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_ORDER_ID);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    orderID = rs.getInt("orderID");
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

        return orderID;
    }
    
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
                    int statusID = rs.getInt("statusID");
                    Timestamp updateDate = rs.getTimestamp("updateDate");
                    String statusName = rs.getString("statusName");

                    list.add(new OrderStatusDTO(statusID, updateDate, statusName));
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
                    String payType = rs.getString("payType");
                    String trackingID = rs.getString("trackingID");
                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID));

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

    public boolean updateOrderStatus(int orderID, int statusID, String modifiedBy, String role) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            List<OrderStatusDTO> list = getUpdateStatusHistory(orderID);
            int currentStatusID = list.get(list.size() - 1).getStatusID();// got ArrayIndexOutOfBoundsException for new product add in with no previous history so list = 0 and can't -1
            if (currentStatusID != statusID) {
                conn = DBUtils.getConnection();
                conn.setAutoCommit(false);
                ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                ptm.setInt(1, statusID);
                ptm.setInt(2, orderID);
                ptm.setString(3, modifiedBy);
                ptm.setString(4, role);

                check = ptm.executeUpdate() > 0;
                conn.commit();
            } else {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException e2) {
            }
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

    public boolean updateOrderTrackingID(int orderID, String trackingID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_TRACKINGID);
                ptm.setString(1, trackingID);
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
                    String payType = rs.getString("payType");
                    String trackingID = rs.getString("trackingID");

                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID));
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

    public boolean addOrder(OrderDTO order, String userID, List<CartProduct> cart) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            // insert Order
            ptm = conn.prepareStatement(INSERT_ORDER);
            ptm.setDate(1, Date.valueOf(LocalDate.now()));
            ptm.setInt(2, order.getTotal());
            ptm.setString(3, userID);
            ptm.setString(4, order.getPayType());
            ptm.setString(5, order.getFullName());
            ptm.setString(6, order.getAddress());
            ptm.setString(7, order.getPhone());
            ptm.setString(8, order.getEmail());
            ptm.setString(9, order.getNote());
            ptm.setString(10, order.getTransactionNumber());
            check = ptm.executeUpdate() > 0;
            if (check) {
                // get new orderID
                ptm = conn.prepareStatement(GET_ORDER_ID);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    boolean orderDetailCheck = true;
                    // insert orderDetail
                    for (CartProduct item : cart) {
                        ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                        ptm.setInt(1, item.getPrice());
                        ptm.setInt(2, item.getQuantity());
                        ptm.setString(3, item.getSize());
                        ptm.setString(4, item.getColor());
                        ptm.setInt(5, orderID);
                        ptm.setInt(6, item.getProductID());
                        orderDetailCheck = orderDetailCheck && ptm.executeUpdate() > 0;
                        if (!orderDetailCheck) {
                            throw new SQLException("Fail to insert orderDetail");// use throw exception cause i don't know if break; can catch exception to do rollback();
                        }
                    }
                    // update orderStatus
                    if (orderDetailCheck) {
                        ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                        ptm.setInt(1, 1); // set statusID = 1 as new order always come with status = 1
                        ptm.setInt(2, orderID);
                        ptm.setString(3, "System");
                        ptm.setString(4, "");
                        check = ptm.executeUpdate() > 0;
                    }

                }

            }
            // check if insert successfully
            if (check) {
                conn.commit();
            } else {
                throw new SQLException("Fail to insert order");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }

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

        return check;
    }

}
