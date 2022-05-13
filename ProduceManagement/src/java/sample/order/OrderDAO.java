/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import sample.utils.DBUtils;

/**
 *
 * @author giama
 */
public class OrderDAO {

    private static final String INSERT = "INSERT dbo.tblOrder (orderID, orderDate, totalPrice, userID) VALUES (?, ?, ?, ?)";
    private static final String GET_ID = "SELECT MAX(orderID) as orderID FROM tblOrder";

    public int getID() throws SQLException {
        int orderID = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_ID);
                rs = stm.executeQuery();
                if (rs.next()) {
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

    public boolean add(OrderDTO order) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            int orderID = order.getOrderID();
            Timestamp orderDate = order.getOrderDate();
            double totalPrice = order.getTotalPrice();
            String userID = order.getUserID();
            ptm.setInt(1, orderID);
            ptm.setTimestamp(2, orderDate);
            ptm.setDouble(3, totalPrice);
            ptm.setString(4, userID);
                     
            if (ptm.executeUpdate()>0) {
                check = true;
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
