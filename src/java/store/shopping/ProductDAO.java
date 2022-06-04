
package store.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import static jdk.nashorn.internal.objects.NativeArray.map;
import store.utils.DBUtils;


public class ProductDAO {
    private static final String GET_TREND_LIST = "SELECT p.productID, p.productName, p.price, p.discount, i.image\n" +
"FROM tblProduct p JOIN tblProductColors pc ON p.productID = pc.productID \n" +
"JOIN tblColorImage i ON pc.productColorID = i.productColorID\n" +
"WHERE p.productID IN (SELECT TOP 4 p.productID \n" +
"					FROM tblProduct p JOIN tblOrderDetail d ON p.productID = d.productID \n" +
"						JOIN tblOrder o ON d.orderID = o.orderID  \n" +
"					WHERE DATEDIFF(day,o.orderDate,GETDATE()) < 30 \n" +
"					GROUP BY p.productID\n" +
"					ORDER BY SUM(d.quantity) desc)";
    public List<ProductDTO> getTrendList() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<ProductDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_TREND_LIST);
                rs = ptm.executeQuery();
                int productID = 0;
                String productName = "";
                int price = 0;
                float discount = 0;
                Map<String, List<String>> image= new HashMap<>();
                
                while (rs.next()) {
                    int tempProductID = rs.getInt("productID");
                    String tempProductName = rs.getString("productName");
                    int tempPrice = rs.getInt("price");
                    float tempDiscount = rs.getFloat("discount");
                    String tempImage = rs.getString("image");
                    if(tempProductID != productID){
                        if(productID != 0){
                            ProductDTO product = new ProductDTO(productID, productName,"", price, discount, image);
                        }
                        
                    }
                    String productName = rs.getString("productName");
                    int price = rs.getInt("price");
                    float discount = rs.getFloat("discount");
                    String image = rs.getString("image");
                    ProductDTO product = new ProductDTO(productID, productName, "", );
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
        return map;
    }
}
