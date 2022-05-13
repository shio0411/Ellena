/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;

/**
 *
 * @author giama
 */
public class UserDAO {

    private static final String LOGIN = "SELECT fullName, roleID, address, birthday, phone, email FROM tblUsers WHERE userID=? AND password=?";
    private static final String CHECK_DUPLICATE = "SELECT fullName FROM tblUsers WHERE userID=?";
    private static final String GET = "SELECT * FROM tblUsers";
    private static final String INSERT_GOOGLE = "INSERT tblUsers(userID, fullName, roleID, email) VALUES(?, ?, ?, ?)";
    private static final String INSERT = "INSERT tblUsers(userID, fullName, roleID, password, address, birthday, phone, email) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
    public UserDTO checkLogin(String userID, String password) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(LOGIN);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    user = new UserDTO(userID, fullName, roleID, "********", address, birthday, phone, email);
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

        return user;
    }

    public boolean checkDuplicate(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(CHECK_DUPLICATE);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    check = true;
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

        return check;
    }
    
    public boolean addGoogleUser (UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT_GOOGLE);
            ptm.setString(1, user.getUserID());
            ptm.setString(2, user.getFullName());
            ptm.setString(3, user.getRoleID());
            ptm.setString(4, user.getEmail());
            check = ptm.executeUpdate()>0?true: false;
            
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
    
    public boolean addUser (UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            ptm.setString(1, user.getUserID());
            ptm.setString(2, user.getFullName());
            ptm.setString(3, user.getRoleID());
            ptm.setString(4, user.getPassword());
            ptm.setString(5, user.getAddress());
            ptm.setDate(6, new java.sql.Date((user.getBirthday()).getTime()));
            ptm.setString(7, user.getPhone());
            ptm.setString(8, user.getEmail());
            check = ptm.executeUpdate()>0?true: false;
            
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
    
    public List<UserDTO> getListUser() throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(GET);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String roleID = rs.getString("roleID");
                String password = "********";
                String address = rs.getString("address");
                Date date = rs.getDate("birthday");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                list.add(new UserDTO(userID, fullName, roleID, password, address, date, phone, email));
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
