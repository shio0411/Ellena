package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import store.utils.DBUtils;

public class CategoryDAO {
    
    private static final String SEARCH_CATEGORY = "SELECT categoryID, categoryName, [order], status FROM tblCategory WHERE dbo.fuChuyenCoDauThanhKhongDau(categoryName) LIKE ? AND status=?";
    private static final String SEARCH_CATEGORY_ALL = "SELECT categoryID, categoryName, [order], status FROM tblCategory";
    private static final String INSERT_CATEGORY = "INSERT INTO tblCategory VALUES (?, ?, ?)";
    
    public List<CategoryDTO> getListCategory(String search, String Status) throws SQLException {
        List<CategoryDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_CATEGORY);
                ptm.setString(1, "%" + search + "%");
                ptm.setString(2, Status);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    int order = rs.getInt("order");
                    boolean status = rs.getBoolean("status");
                    list.add(new CategoryDTO(categoryID, categoryName, order, status));
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
    
    public List<CategoryDTO> getAllCategory() throws SQLException {
        List<CategoryDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_CATEGORY_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    int order = rs.getInt("order");
                    boolean status = rs.getBoolean("status");
                    list.add(new CategoryDTO(categoryID, categoryName, order, status));
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
    
    public boolean addCategory(CategoryDTO cat) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(INSERT_CATEGORY);
                stm.setString(1, cat.getCategoryName());
                stm.setInt(2, cat.getOrder());
                stm.setBoolean(3, true);
                check = stm.executeUpdate() > 0;
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
        return check;
    }
}
