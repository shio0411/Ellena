/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.product;

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
public class ProductDAO {
    private static final String GET = "SELECT * FROM tblProduct";
    private static final String SEARCH = "SELECT * FROM tblProduct WHERE productName like ?";
    private static final String GET_BY_ID = "SELECT * FROM tblProduct WHERE productID=?";
    private static final String HIDE = "UPDATE tblProduct SET status=0 WHERE productID=?";
    private static final String UNHIDE = "UPDATE tblProduct SET status=1 WHERE productID=?";
    private static final String UPDATE = "UPDATE tblProduct SET productName=?, image=?, currentPrice=?, categoryID=?, unitInStock=?, importDate=?, expiryDate=? WHERE productID=?";
    private static final String INSERT = "INSERT tblProduct(productID, productName, image, currentPrice, unitInStock, categoryID, importDate, expiryDate, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, 1)";
    private static final String UPDATE_QUANTITY = "UPDATE tblProduct SET unitInStock = ? WHERE productID = ?";
    private static final String CHECK_DUPLICATE = "SELECT productName FROM tblProduct WHERE productID = ?";
    
    
    public List<ProductDTO> getListProduct(String search) throws SQLException {
        List<ProductDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH);
                ptm.setString(1, "%"+search+"%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("productID");
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    double price = rs.getDouble("currentPrice");
                    double quantity = rs.getDouble("unitInStock");
                    String categoryID = rs.getString("categoryID");
                    Date importDate = rs.getDate("importDate");
                    Date expiryDate = rs.getDate("expiryDate");
                    boolean status = rs.getBoolean("status");
                    list.add(new ProductDTO(id, name, img, price, quantity, categoryID, importDate, expiryDate, status));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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
    
    public List<ProductDTO> getListProduct() throws SQLException {
        List<ProductDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("productID");
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    double price = rs.getDouble("currentPrice");
                    double quantity = rs.getDouble("unitInStock");
                    String categoryID = rs.getString("categoryID");
                    Date importDate = rs.getDate("importDate");
                    Date expiryDate = rs.getDate("expiryDate");
                    boolean status = rs.getBoolean("status");
                    list.add(new ProductDTO(id, name, img, price, quantity, categoryID, importDate, expiryDate, status));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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
    
    public ProductDTO getProduct(String id) throws SQLException {
        ProductDTO result = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BY_ID);
                ptm.setString(1, id);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("productName");
                    String img = rs.getString("image");
                    double price = rs.getDouble("currentPrice");
                    double quantity = rs.getDouble("unitInStock");
                    String categoryID = rs.getString("categoryID");
                    Date importDate = rs.getDate("importDate");
                    Date expiryDate = rs.getDate("expiryDate");
                    boolean status = rs.getBoolean("status");
                    result = new ProductDTO(id, name, img, price, quantity, categoryID, importDate, expiryDate, status);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
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
        return result;
    }
    
    public boolean hideProduct (String id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(HIDE);
            ptm.setString(1, id);
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
    
    
    public boolean unhideProduct (String id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UNHIDE);
            ptm.setString(1, id);
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
    
    public boolean updateProduct (ProductDTO product) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE);
            ptm.setString(1, product.getName());
            ptm.setString(2, product.getImg());
            ptm.setDouble(3, product.getCurrentPrice());
            ptm.setString(4, product.getCategoryID());
            ptm.setDouble(5, product.getUnitInStock());
            ptm.setDate(6, new java.sql.Date((product.getImportDate()).getTime()));
            ptm.setDate(7, new java.sql.Date((product.getExpiryDate()).getTime()));
            ptm.setString(8, product.getId());
            check = ptm.executeUpdate()>0?true: false;            
        } catch (ClassNotFoundException | SQLException e) {
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
    
    public boolean insertProduct (ProductDTO product) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            ptm.setString(1, product.getId());
            ptm.setString(2, product.getName());
            ptm.setString(3, product.getImg());
            ptm.setDouble(4, product.getCurrentPrice());
            ptm.setDouble(5, product.getUnitInStock());
            ptm.setString(6, product.getCategoryID());
            ptm.setDate(7, new java.sql.Date((product.getImportDate()).getTime()));
            ptm.setDate(8, new java.sql.Date((product.getExpiryDate()).getTime()));
            
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
    
    
    public boolean updateQuantity (double quantity, String productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_QUANTITY);
            ptm.setDouble(1, quantity);
            ptm.setString(2, productID);
            check = ptm.executeUpdate()>0?true: false;            
        } catch (ClassNotFoundException | SQLException e) {
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
    
    public boolean checkDuplicate(String productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(CHECK_DUPLICATE);
                stm.setString(1, productID);
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
}
