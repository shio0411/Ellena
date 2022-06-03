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
                                                                    + "SELECT productID, productName, B.categoryName, A.status, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) as row# "
                                                                    + "FROM tblProduct A inner join tblCategory B on (A.categoryID = B.categoryID) "
                                                                    + ")"
                                                        + "SELECT productID, productName, categoryName, status, row# "
                                                        + "FROM subTable "
                                                        + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_PRODUCT = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct";
    private static final String SEARCH_PRODUCT_PAGINATION = "WITH subTable AS("
                                                                    + "SELECT productID, productName, B.categoryName, A.status, ROW_NUMBER() OVER(ORDER BY ? ASC) as row# "
                                                                    + "FROM tblProduct A inner join tblCategory B on (A.categoryID = B.categoryID) "
                                                                    + "WHERE dbo.fuChuyenCoDauThanhKhongDau(productName) LIKE ? AND A.status=? "
                                                                    + ")"
                                                        + "SELECT productID, productName, categoryName, status, row# "
                                                        + "FROM subTable "
                                                        + "WHERE row# BETWEEN ? AND ?";
    private static final String NUMBER_OF_SEARCH_PRODUCT = "SELECT Top 1 COUNT (*) OVER () AS ROW_COUNT FROM tblProduct WHERE productName LIKE ? AND status=?";
    private static final String ACTIVATE_PRODUCT= "UPDATE tblProduct SET status=1 WHERE productID=?";
    private static final String DEACTIVATE_PRODUCT= "UPDATE tblProduct SET status=0 WHERE productID=?";
    private static final String SHOW_PRODUCT = "SELECT productID, productName, description, price, discount, categoryID, lowStockLimit, status FROM tblProduct WHERE productID = ?";
    private static final String UPDATE_PRODUCT = "UPDATE tblProduct SET productName=?, categoryID=?, lowStockLimit=?, price=?, status=?, description=? WHERE productID=?";
    private static final String SEARCH_PRODUCT_IMAGE = "SELECT DISTINCT PrC.productColorID , PrC.image FROM tblProductColors PrC INNER JOIN tblColorSizes CS ON (PrC.productColorID = CS.productColorID) WHERE productID=? AND PrC.color LIKE ? AND CS.size LIKE ?";
    
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
                    String categoryName = rs.getString("categoryName");
                    Boolean status = rs.getBoolean("status");
                    listProduct.add(new ProductDTO(productID, productName, "", "", "", "", 0, 0.0, 0, 0, 0, categoryName, 0.0, status) );
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
                    String categoryName = rs.getString("categoryName");
                    Boolean statusParam = rs.getBoolean("status");
                    listProduct.add(new ProductDTO(productID, productName, "", "", "", "", 0, 0.0, 0, 0, 0, categoryName, 0.0, statusParam) );
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
    
    public ProductDTO getProduct(int productID) throws SQLException{
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn=DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOW_PRODUCT);
                ptm.setInt(1, productID);
                rs=ptm.executeQuery();
                if (rs.next()) {
                    String productName = rs.getNString("productName");
                    String description = rs.getNString("description");
                    int price = rs.getInt("price");
                    Double discount = rs.getDouble("discount");
                    int categoryID = rs.getInt("categoryID");
                    int lowStockLimit = rs.getInt("lowStockLimit");
                    boolean status = rs.getBoolean("status");
                    product = new ProductDTO(productID, productName, "", description, "", "", price, discount, 0, lowStockLimit, categoryID, "", 0.0, status);
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
        
        return product;
    }
    
    public boolean updateProduct(ProductDTO product) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn=DBUtils.getConnection();
            ptm=conn.prepareStatement(UPDATE_PRODUCT);
            ptm.setString(1, product.getProductName());
            ptm.setInt(2, product.getCategoryID());
            ptm.setInt(3, product.getLowStockLimit());
            ptm.setInt(4, product.getPrice());
            ptm.setBoolean(5, product.isStatus());
            ptm.setString(6, product.getDescription());
            ptm.setInt(7, product.getProductID());
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
    
    public List<ProductDTO> getListImage(int productID, String color, String size) throws SQLException{
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_PRODUCT_IMAGE);
                ptm.setInt(1, productID);
                ptm.setString(2, "%" + color + "%");
                ptm.setString(3, "%" + size + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String productImage = rs.getString("image");
                    listProduct.add(new ProductDTO(0, "", productImage, "", "", "", 0, 0.0, 0, 0, 0, "", 0.0, false) );
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

        return listProduct;
    }
    
}










