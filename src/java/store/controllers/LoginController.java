/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.CategoryDAO;
import store.shopping.CategoryDTO;
import store.user.UserDAO;
import store.user.UserDTO;

public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String ADMIN_PAGE = "ShowAccountController";
    private static final String CUSTOMER_PAGE = "home.jsp";
    private static final String MANAGER_PAGE = "ManagerShowProductController";
    private static final String EMPLOYEE_PAGE = "employee.jsp";
    private static final String CM = "CM";
    private static final String AD = "AD";
    private static final String MN = "MN";
    private static final String EM = "EM";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userID = request.getParameter("userID");
            String password = request.getParameter("password");
            UserDAO dao = new UserDAO();
            UserDTO user = dao.checkLogin(userID, password);
            HttpSession session = request.getSession();
            CategoryDAO ctdao = new CategoryDAO();
            List<CategoryDTO> listCategory = ctdao.getListCategory("", "True");
            if (null != user) {
                session.setAttribute("LOGIN_USER", user);
                session.setAttribute("LIST_CATEGORY", listCategory);
                String roleID = user.getRoleID();
                if (!user.isStatus()) {
                    request.setAttribute("ERROR", "Tài khoản của bạn đang bị vô hiệu hoá!");
                } else {
                    switch (roleID) {
                        case AD:
                            url = ADMIN_PAGE;
                            break;
                        case CM:
                            url = CUSTOMER_PAGE;
                            break;
                        case MN:
                            url = MANAGER_PAGE;
                            break;
                        case EM:
                            url = EMPLOYEE_PAGE;
                            break;
                        default:
                            request.setAttribute("ERROR", "Quyền của bạn không được hỗ trợ!");
                            break;
                    }
                }

            } else {
                request.setAttribute("ERROR", "Bạn đã nhập sai ID hoặc mật khẩu!");
            }

        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
