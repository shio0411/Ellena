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
import javafx.util.Pair;
import store.utils.DBUtils;

public class StatisticDAO {
    private static final String STATISTIC_ORDER_7DAY = "SELECT orderDate, COUNT(*) AS [orderQuantity], SUM(total) AS [income], SUM(quantity) as [productQuantity] \n" +
"FROM tblOrder o JOIN tblOrderDetail d ON o.orderID = d.orderID \n" +
"WHERE DATEDIFF(day,orderDate,GETDATE()) < 7 AND o.orderID IN (SELECT orderID FROM tblOrderStatusUpdate WHERE statusID = '4')\n" +
"GROUP BY orderDate \n" +
"ORDER BY orderDate asc";
    private static final String STATISTIC_ORDER_4WEEK = "SELECT 'Week ' + LTRIM(STR(DATEDIFF(day,orderDate,GETDATE())/7+1)) AS [Week], COUNT(*) AS [orderQuantity], SUM(total) AS [income], SUM(quantity) as [productQuantity] \n" +
"FROM tblOrder o JOIN tblOrderDetail d ON o.orderID = d.orderID \n" +
"WHERE DATEDIFF(day,orderDate,GETDATE()) < 28 AND o.orderID IN (SELECT orderID FROM tblOrderStatusUpdate WHERE statusID = '4')\n" +
"GROUP BY DATEDIFF(day,orderDate,GETDATE())/7";
    private static final String STATISTIC_ORDER_1YEAR = "SELECT LTRIM(STR(year(orderDate)))+'-'+LTRIM(STR(month(orderDate))) AS [Month], COUNT(*) AS [orderQuantity], SUM(total) AS [income], SUM(quantity) as [productQuantity] \n" +
"FROM tblOrder o JOIN tblOrderDetail d ON o.orderID = d.orderID \n" +
"WHERE DATEDIFF(month, orderDate, GETDATE()) < 12  AND o.orderID IN (SELECT orderID FROM tblOrderStatusUpdate WHERE statusID = '4')\n" +
"GROUP BY year(orderDate),month(orderDate) \n" +
"ORDER BY year(orderDate) asc";
    private static final String STATISTIC_ORDER_TODAY = "SELECT COUNT(*) AS [orderQuantity], SUM(total) AS [income], SUM(quantity) as [productQuantity] \n" +
"FROM tblOrder o JOIN tblOrderDetail d ON o.orderID = d.orderID \n" +
"WHERE DATEDIFF(day,orderDate,GETDATE()) < 1 AND o.orderID IN (SELECT orderID FROM tblOrderStatusUpdate WHERE statusID = '4')\n" +
"GROUP BY orderDate \n" +
"ORDER BY orderDate asc";
    private static final String STATISTIC_BEST_SELLER = "SELECT TOP 5 p.productID, p.productName, SUM(d.quantity) AS [sale], SUM(d.price*d.quantity) AS [income] \n" +
"FROM tblProduct p JOIN tblOrderDetail d ON p.productID = d.productID \n" +
"JOIN tblOrder o ON d.orderID = o.orderID\n" +
"WHERE DATEDIFF(day, o.orderDate,GETDATE()) < ? AND o.orderID IN (SELECT orderID FROM tblOrderStatusUpdate WHERE statusID = '4')\n" +
"GROUP BY p.productID, p.productName \n" +
"ORDER BY Sale desc";
    private static final String STATISTIC_BEST_INCOME = "SELECT TOP 5 p.productID, p.productName, SUM(d.quantity) AS [sale], SUM(d.price*d.quantity) AS [income] \n" +
"FROM tblProduct p JOIN tblOrderDetail d ON p.productID = d.productID \n" +
"JOIN tblOrder o ON d.orderID = o.orderID\n" +
"WHERE DATEDIFF(day, o.orderDate,GETDATE()) < ? AND o.orderID IN (SELECT orderID FROM tblOrderStatusUpdate WHERE statusID = '4')\n" +
"GROUP BY p.productID, p.productName \n" +
"ORDER BY Sale desc";
    public Map<String, StatisticDTO> getStatisticOrder7Day() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Map<String, StatisticDTO> map = new HashMap<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_ORDER_7DAY);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String date = rs.getString("orderDate");
                    int orderQuantity = rs.getInt("orderQuantity");
                    int income = rs.getInt("income");
                    int productQuantity = rs.getInt("productQuantity");
                    StatisticDTO triplet = new StatisticDTO(orderQuantity, income, productQuantity);
                    map.put(date, triplet);
                }
                SimpleDateFormat DateFor = new SimpleDateFormat("yyyy-MM-dd");
                Calendar cal = Calendar.getInstance();
                for (int i = 0; i < 7; i++) {
                    String stringDate = DateFor.format(cal.getTime());
                    if (map.get(stringDate) == null) {
                        map.put(stringDate, new StatisticDTO(0, 0, 0));
                    }

                    cal.add(Calendar.DATE, -1);
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
    public Map<String, StatisticDTO> getStatisticOrder4Week() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Map<String, StatisticDTO> map = new HashMap<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_ORDER_4WEEK);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String date = rs.getString("Week");
                    int orderQuantity = rs.getInt("orderQuantity");
                    int income = rs.getInt("income");
                    int productQuantity = rs.getInt("productQuantity");
                    StatisticDTO triplet = new StatisticDTO(orderQuantity, income, productQuantity);
                    map.put(date, triplet);
                    String week = "Week ";
                    for (int i = 1; i < 5; i++) {
                    if (map.get(new String(week+i)) == null) {
                        map.put(new String(week+i), new StatisticDTO(0, 0, 0));
                    }
                }
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
    public Map<String, StatisticDTO> getStatisticOrder1Year() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Map<String, StatisticDTO> map = new HashMap<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_ORDER_1YEAR);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String date = rs.getString("Month");
                    int orderQuantity = rs.getInt("orderQuantity");
                    int income = rs.getInt("income");
                    int productQuantity = rs.getInt("productQuantity");
                    StatisticDTO triplet = new StatisticDTO(orderQuantity, income, productQuantity);
                    map.put(date, triplet);
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
    public StatisticDTO getStatisticOrderToday() throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        StatisticDTO today = new StatisticDTO(0, 0, 0);
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_ORDER_TODAY);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int orderQuantity = rs.getInt("orderQuantity");
                    int income = rs.getInt("income");
                    int productQuantity = rs.getInt("productQuantity");
                    today = new StatisticDTO(orderQuantity, income, productQuantity);
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
        return today;
    }  
    public List<Pair<String, StatisticDTO>> getBestSeller(int duration) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Pair<String, StatisticDTO>> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_BEST_SELLER);
                ptm.setInt(1, duration);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    int sale = rs.getInt("sale");
                    int income = rs.getInt("income");
                    StatisticDTO number = new StatisticDTO(productID, sale, income);
                    Pair<String, StatisticDTO> pair = new Pair(productName, number);
                    list.add(pair);
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
    public List<Pair<String, StatisticDTO>> getBestIncome(int duration) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Pair<String, StatisticDTO>> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(STATISTIC_BEST_INCOME);
                ptm.setInt(1, duration);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    int sale = rs.getInt("sale");
                    int income = rs.getInt("income");
                    StatisticDTO number = new StatisticDTO(productID, sale, income);
                    Pair<String, StatisticDTO> pair = new Pair(productName, number);
                    list.add(pair);
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
}
