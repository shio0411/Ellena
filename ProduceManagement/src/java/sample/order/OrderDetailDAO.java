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
import sample.utils.DBUtils;

/**
 *
 * @author giama
 */
public class OrderDetailDAO {
    
    private static final String INSERT = "INSERT tblOrderDetail (detailID, unitPrice, quantity, orderID, productID) VALUES (?, ?, ?, ?, ?)";
    private static final String GET_ID = "SELECT MAX(detailID) as detailID FROM tblOrderDetail";
    
    public int getID() throws SQLException {
        int detailID = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_ID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    detailID = rs.getInt("detailID");
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

        return detailID;
    }

    public boolean add(OrderDetailDTO detail) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            ptm.setInt(1, detail.getDetailID());
            ptm.setDouble(2, detail.getPrice());
            ptm.setDouble(3, detail.getQuantity());
            ptm.setInt(4, detail.getOrderID());
            ptm.setString(5, detail.getProductID());

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
