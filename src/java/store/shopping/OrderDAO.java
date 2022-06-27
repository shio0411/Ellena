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
    private static final String SEARCH_ORDER_ALL = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID ";

    private static final String SEARCH_ORDER_BY_STATUS = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "AND statusID = ? "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String SEARCH_ORDER = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE (orderDate BETWEEN ? AND ?) "
            + "AND statusID = ? "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String SEARCH_ORDER_BY_DATE = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "WHERE (orderDate BETWEEN ? AND ?) "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    private static final String UPDATE_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate, modifiedBy, roleID) VALUES (?, ?, GETDATE(), ?, ?)";
    private static final String INSERT_ORDER_STATUS = "INSERT INTO tblOrderStatusUpdate(statusID, orderID, updateDate, modifiedBy, roleID) VALUES (?, ?, GETDATE(), 'System', '')";

    private static final String SEARCH_ORDER_BY_NAME = "SELECT orderID, orderDate, total, userID, fullName, statusID, statusName, payType, trackingID, [orderFullName], [address], phone, email, note, transactionNumber "
            + "FROM currentStatusRow v1 JOIN orderReview v2 ON v1.ID = v2.ID "
            + "AND [TenKhongDau] LIKE '%' + [dbo].[fuChuyenCoDauThanhKhongDau](?) + '%'";

    //Order detail
    private static final String SEARCH_ORDER_DETAIL = "SELECT productName, t1.price, quantity, size, color "
            + "FROM tblOrderDetail t1 JOIN tblProduct t2 ON t1.productID = t2.productID "
            + "WHERE orderID = ?";

    //Order status
    private static final String SEARCH_ORDER_STATUS = "SELECT t1.statusID, updateDate, statusName, modifiedBy, roleID FROM tblOrderStatusUpdate t1 JOIN tblOrderStatus t2 ON t1.statusID = t2.statusID WHERE orderID = ?";

    private static final String INSERT_ORDER = "INSERT INTO tblOrder(orderDate, total, userID, payType, fullName, [address], phone, email, note) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

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

    public boolean insertOrderDetail(int orderID, List<CartProduct> cart) throws SQLException {
        boolean result = true;

        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                for (CartProduct item : cart) {
                    stm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                    stm.setInt(1, item.getPrice());
                    stm.setInt(2, item.getQuantity());
                    stm.setString(3, item.getSize());
                    stm.setString(4, item.getColor());
                    stm.setInt(5, orderID);
                    stm.setInt(6, item.getProductID());
                    result = result && stm.executeUpdate() > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return result;
    }

    public boolean insertOrder(OrderDTO order, String userID) throws SQLException {
        boolean result = false;

        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_ORDER);
                stm.setDate(1, Date.valueOf(LocalDate.now()));
                stm.setInt(2, order.getTotal());
                stm.setString(3, userID);
                stm.setString(4, order.getPayType());
                stm.setString(5, order.getFullName());
                stm.setString(6, order.getAddress());
                stm.setString(7, order.getPhone());
                stm.setString(8, order.getEmail());
                stm.setString(9, order.getNote());
                result = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return result;
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
                    String modifiedBy = rs.getString("modifiedBy");
                    String roleID = rs.getString("roleID");

                    list.add(new OrderStatusDTO(statusID, updateDate, statusName, modifiedBy, roleID));
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

    public List<OrderDTO> getOrder(String search, String sDateFrom, String sDateTo, String sStatusID) throws SQLException {
        List<OrderDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (!sDateFrom.isEmpty() && !sDateTo.isEmpty() && !sStatusID.isEmpty()) {
                    Date dateFrom = Date.valueOf(sDateFrom);
                    Date dateTo = Date.valueOf(sDateTo);
                    int statusID = Integer.parseInt(sStatusID);

                    ptm = conn.prepareStatement(SEARCH_ORDER);
                    ptm.setDate(1, dateFrom);
                    ptm.setDate(2, dateTo);
                    ptm.setInt(3, statusID);
                    ptm.setString(4, search);
                } else if (!sDateFrom.isEmpty() && !sDateTo.isEmpty() && sStatusID.isEmpty()) {
                    Date dateFrom = Date.valueOf(sDateFrom);
                    Date dateTo = Date.valueOf(sDateTo);

                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_DATE);
                    ptm.setDate(1, dateFrom);
                    ptm.setDate(2, dateTo);
                    ptm.setString(3, search);
                } else if (!(!sDateFrom.isEmpty() && !sDateTo.isEmpty()) && !sStatusID.isEmpty()) {
                    int statusID = Integer.parseInt(sStatusID);
                    ptm = conn.prepareStatement(SEARCH_ORDER_BY_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setString(2, search);
                } else if ((sDateFrom.isEmpty() || sDateTo.isEmpty()) && sStatusID.isEmpty()) {
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
                    String fullName = rs.getString("orderFullName");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String note = rs.getString("note");
                    String transactionNumber = rs.getString("transactionNumber");
                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, transactionNumber));

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

    public boolean updateOrderStatus(int orderID, int statusID, String userID, String roleID) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        
/**
*        - Chưa xác nhận: hệ thống
*        - Đã xác nhận: manager/employee 
*        - Đang giao: manager 
*        - Đã giao: manager 
*        - Đã huỷ: manager tự chuyển/ hệ thống chuyển; chỉ áp dụng với trường hợp COD.
*        - Nếu trả trước (online banking):khi huỷ chuyển thành Chờ hoàn tiền: he thong chuyen, manager chuyen
*        - Sau khi hoàn tiền online, manager chuyển thành Da hoan tien.
*
*        - Chỉ có thể huỷ khi Chưa xác nhận.
*/
        try {
            List<OrderStatusDTO> list = getUpdateStatusHistory(orderID);
            int currentStatusID = list.get(list.size() - 1).getStatusID();
            boolean isValidStatus = false;
            if (currentStatusID == 1) {
                if (statusID > currentStatusID) {
                    isValidStatus = true;
                }
            } else {
                if (!(currentStatusID == 5 || currentStatusID == 7)) {
                    if (statusID > currentStatusID && statusID < 5) {
                        isValidStatus = true;
                    }
                }
                if (currentStatusID == 6 && statusID == 7) {
                    isValidStatus = true;
                }
            }
            if (isValidStatus) {
                conn = DBUtils.getConnection();
                if (conn != null) {
                    ptm = conn.prepareStatement(UPDATE_ORDER_STATUS);
                    ptm.setInt(1, statusID);
                    ptm.setInt(2, orderID);
                    ptm.setString(3, userID);
                    ptm.setString(4, roleID);
                    result = ptm.executeUpdate() > 0;
                }
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
        return result;
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
                    String fullName = rs.getString("orderFullName");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String note = rs.getString("note");
                    String transactionNumber = rs.getString("transactionNumber");
                    list.add(new OrderDTO(orderID, orderDate, total, userName, statusID, statusName, payType, trackingID, fullName, address, phone, email, note, transactionNumber));

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

    public boolean insertOrderStatus(int orderID, int statusID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;

        try {
            List<OrderStatusDTO> list = getUpdateStatusHistory(orderID);
            
                conn = DBUtils.getConnection();
                if (conn != null) {
                    ptm = conn.prepareStatement(INSERT_ORDER_STATUS);
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
}
