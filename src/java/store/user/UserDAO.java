package store.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import store.utils.DBUtils;

public class UserDAO {

    private static final String LOGIN = "SELECT fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID=? AND password=?";
    private static final String CHECK_DUPLICATE = "SELECT fullName FROM tblUsers WHERE userID=?";
    private static final String INSERT = "INSERT tblUsers(userID, fullName, password, sex, roleID, address, birthday, phone, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SEARCH_USER = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID LIKE ?";
    private static final String SEARCH_USER_WITH_ROLE_ID = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID LIKE ? AND roleID LIKE ?";
    private static final String SEARCH_USER_WITH_STATUS = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID LIKE ? AND roleID LIKE ? AND status=?";
    private static final String GET_USER_BY_ID = "SELECT userID, fullName, password, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID=?";
    private static final String SEARCH_USER_ALL = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers";
    private static final String SEARCH_MANAGER = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE userID LIKE ? AND roleID LIKE 'MN' AND status=?";
    private static final String SEARCH_MANAGER_ALL = "SELECT userID, fullName, sex, roleID, address, birthday, phone, status FROM tblUsers WHERE roleID LIKE 'MN'";
    private static final String UPDATE_ACCOUNT = "UPDATE tblUsers SET fullName=?, sex=?, roleID=?, address=?, birthday=?, phone=? WHERE userID=?";
    private static final String UPDATE_PASSWORD = "UPDATE tblUsers SET password=? WHERE userID=?";
    private static final String UPDATE_NAME = "UPDATE tblUsers SET fullName=? WHERE userID=?";
    private static final String UPDATE_ADDRESS = "UPDATE tblUsers SET address=? WHERE userID=?";
    private static final String UPDATE_PHONE = "UPDATE tblUsers SET phone=? WHERE userID=?";
    private static final String ACTIVATE_ACCOUNT = "UPDATE tblUsers SET status=1 WHERE userID=?";
    private static final String DEACTIVATE_ACCOUNT = "UPDATE tblUsers SET status=0 WHERE userID=?";

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
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, status);
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

    public boolean addUser(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(INSERT);
            String id = user.getUserID();
            String name = user.getFullName();
            String password = user.getPassword();
            boolean sex = user.getSex();
            String roleID = user.getRoleID();
            String address = user.getAddress();
            Date date = user.getBirthday();
            String phone = user.getPhone();
            boolean status = user.isStatus();
            ptm.setString(1, id);
            ptm.setString(2, name);
            ptm.setString(3, password);
            ptm.setBoolean(4, sex);
            ptm.setString(5, roleID);
            ptm.setString(6, address);
            ptm.setDate(7, new java.sql.Date(date.getTime()));
            ptm.setString(8, phone);
            ptm.setBoolean(9, status);
            check = ptm.executeUpdate() > 0 ? true : false;

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

    public List<UserDTO> getListUsers(String search, String roleID, String Status) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                if (roleID == null) {
                    ptm = conn.prepareStatement(SEARCH_USER);
                    ptm.setString(1, "%" + search + "%");
                } else if ("true".equalsIgnoreCase(Status) || "false".equalsIgnoreCase(Status)) {
                    ptm = conn.prepareStatement(SEARCH_USER_WITH_STATUS);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, roleID);
                    ptm.setString(3, Status);
                } else {
                    ptm = conn.prepareStatement(SEARCH_USER_WITH_ROLE_ID);
                    ptm.setString(1, "%" + search + "%");
                    ptm.setString(2, roleID);

                }
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
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

    public List<UserDTO> getAllUsers() throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_USER_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
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

    public UserDTO getUserByID(String userID) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_USER_BY_ID);
                ptm.setString(1, userID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String fullName = rs.getString("fullName");
                    String password = rs.getString("password");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, status);
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
        return user;
    }

    public List<UserDTO> getListManagers(String search, String Status) throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_MANAGER);
                ptm.setString(1, "%" + search + "%");
                ptm.setString(2, Status);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
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

    public List<UserDTO> getAllManagers() throws SQLException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_MANAGER_ALL);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullName = rs.getString("fullName");
                    boolean sex = rs.getBoolean("sex");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    Date birthday = rs.getDate("birthday");
                    String phone = rs.getString("phone");
                    boolean status = rs.getBoolean("status");
                    list.add(new UserDTO(userID, fullName, "*******", sex, roleID, address, birthday, phone, status));
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

    public boolean updateAccount(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_ACCOUNT);
            ptm.setString(1, user.getFullName());
            ptm.setBoolean(2, user.getSex());
            ptm.setString(3, user.getRoleID());
            ptm.setString(4, user.getAddress());
            ptm.setDate(5, new java.sql.Date((user.getBirthday()).getTime()));
            ptm.setString(6, user.getPhone());
            ptm.setString(7, user.getUserID());

            check = ptm.executeUpdate() > 0 ? true : false;
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

    public boolean updatePassword(String password, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_PASSWORD);
            ptm.setString(1, password);
            ptm.setString(2, userID);

            check = ptm.executeUpdate() > 0 ? true : false;
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

    public boolean updateName(String newName, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_NAME);
            ptm.setString(1, newName);
            ptm.setString(2, userID);

            check = ptm.executeUpdate() > 0 ? true : false;
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

    public boolean updateAddress(String newAddress, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_ADDRESS);
            ptm.setString(1, newAddress);
            ptm.setString(2, userID);

            check = ptm.executeUpdate() > 0 ? true : false;
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

    public boolean updatePhone(String newPhone, String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(UPDATE_PHONE);
            ptm.setString(1, newPhone);
            ptm.setString(2, userID);

            check = ptm.executeUpdate() > 0 ? true : false;
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

    public boolean activateAccount(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(ACTIVATE_ACCOUNT);
            ptm.setString(1, userID);

            check = ptm.executeUpdate() > 0 ? true : false;
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

    public boolean deactivateAccount(String userID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(DEACTIVATE_ACCOUNT);
            ptm.setString(1, userID);
            check = ptm.executeUpdate() > 0 ? true : false;
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
