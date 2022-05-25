package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import store.utils.DBUtils;

public class ProductDAO {

    private static final String SHOW_PRODUCT_PAGINATION = "WITH subTable AS("
                                                                    + "SELECT productID, productName, categoryID, status, ROW_NUMBER() OVER(ORDER BY productID ASC) as row# "
                                                                    + "FROM tblProduct "
                                                                    + ")"
                                                        + "SELECT productID, productName, categoryID, status, row# "
                                                        + "FROM subTable "
                                                        + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_PRODUCT = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct";
    private static final String SEARCH_PRODUCT_PAGINATION = "WITH subTable AS("
                                                                    + "SELECT productID, productName, categoryID, status, ROW_NUMBER() OVER(ORDER BY ? ASC) as row# "
                                                                    + "FROM tblProduct "
                                                                    + "WHERE productName LIKE ? AND status=?"
                                                                    + ")"
                                                        + "SELECT productID, productName, categoryID, status, row# "
                                                        + "FROM subTable "
                                                        + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_PRODUCT = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct WHERE productName LIKE ? AND status=?";
    private static final String ACTIVATE_PRODUCT= "UPDATE tblProduct SET status=1 WHERE productID=?";
    private static final String DEACTIVATE_PRODUCT= "UPDATE tblProduct SET status=0 WHERE productID=?";
    
    //-------------------------------
    private int numberOfProduct;

    public int getNumberOfProduct() {
        return numberOfProduct;
    }

    //-------------------------------
    
//    getAllProduct get only shown the full product list in manager's home page. Only 4 columns will be shown : productID, productName, categoryID, status
    public List<ProductDTO> getAllProduct(int offset, int noOfProducts) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOW_PRODUCT_PAGINATION);
                ptm.setInt(1, offset);
                ptm.setInt(2, noOfProducts);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    int categoryID = rs.getInt("categoryID");
                    Boolean status = rs.getBoolean("status");
                    listProduct.add(new ProductDTO(productID, productName, "", "", "", "", 0, 0, categoryID, null, status) );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                ptm = conn.prepareStatement(NUMBER_OF_PRODUCT);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfProduct = rs.getInt("ROW_COUNT");
                }
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return listProduct;
    }
    
//    getListProduct get only shown the full product list in manager's home page. Only 4 columns will be shown : productID, productName, categoryID, status    
    public List<ProductDTO> getListProduct(String orderBy, String name, String status, int offset, int noOfProducts) throws SQLException{
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_PRODUCT_PAGINATION);
                ptm.setString(1, orderBy);
                ptm.setString(2, "%" + name + "%");
                ptm.setString(3, status);
                ptm.setInt(4, offset);
                ptm.setInt(5, noOfProducts);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    int categoryID = rs.getInt("categoryID");
                    Boolean statusParam = rs.getBoolean("status");
                    listProduct.add(new ProductDTO(productID, productName, "", "", "", "", 0, 0, categoryID, null, statusParam) );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                ptm = conn.prepareStatement(NUMBER_OF_SEARCH_PRODUCT);
                ptm.setString(1, "%" + name + "%");
                ptm.setString(2, status);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    this.numberOfProduct = rs.getInt("ROW_COUNT");
                }
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return listProduct;
    }

    public boolean activateProduct(int productID) throws SQLException{
        boolean check=false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn=DBUtils.getConnection();
            ptm=conn.prepareStatement(ACTIVATE_PRODUCT);
            ptm.setInt(1, productID);
            
            check=ptm.executeUpdate()>0?true:false;
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
    
    public boolean deactivateProduct(int productID) throws SQLException{
        boolean check=false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn=DBUtils.getConnection();
            ptm=conn.prepareStatement(DEACTIVATE_PRODUCT);
            ptm.setInt(1, productID);
            
            check=ptm.executeUpdate()>0?true:false;
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
    
}










