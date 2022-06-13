package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.restfb.types.User;
import javax.servlet.http.HttpSession;
import store.login_with_facebook.RestFB;
import store.user.UserDAO;
import store.user.UserDTO;

/**
 *
 * @author DuyLVL
 */
@WebServlet(name = "LoginFacebookController", urlPatterns = {"/LoginFacebookController"})
public class LoginFacebookController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    //private static final long serialVersionUID = 1L;
    private static final String MN = "MN";
    private static final String CUSTOMER_PAGE = "home.jsp";
    private static final String ERROR = "login.jsp";

    public LoginFacebookController() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;
        try {
            String code = request.getParameter("code");
            if (!(code == null || code.isEmpty())) {
                String accessToken = RestFB.getToken(code);
                User user = RestFB.getUserInfo(accessToken);
                //String email = user.getEmail();
                UserDTO loginUser = new UserDTO();
                String name = user.getName();
                //String gender = user.getGender();
                String id = user.getId();
                
                loginUser.setUserID(id);
                loginUser.setFullName(name);
                loginUser.setRoleID("CM");
                loginUser.setStatus(true);
                
                UserDAO dao = new UserDAO();
                dao.addUser(loginUser);
                
                HttpSession session = request.getSession();
                session.setAttribute("LOGIN_USER", loginUser);
                url = CUSTOMER_PAGE;

            }
        } catch (Exception e) {
            log("Error at LoginFacebookController: " + e.toString());
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
