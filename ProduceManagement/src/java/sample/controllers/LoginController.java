/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.user.UserDAO;
import sample.user.UserDTO;
import sample.utils.VerifyUtils;

/**
 *
 * @author giama
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String ADMIN_PAGE = "MainController?action=Search&search=";
    private static final String USER_PAGE = "MainController?action=Search&search=";
    private static final String US = "US";
    private static final String AD = "AD";

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
            if (user != null) {

                String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

                // Verify CAPTCHA.
                boolean valid = VerifyUtils.verify(gRecaptchaResponse);
                if (!valid) {
                    request.setAttribute("ERROR_MESSAGE", "Captcha invalid!");
                } else {

                    session.setAttribute("LOGIN_USER", user);
                    String roleID = user.getRoleID();
                    if (null == roleID) {
                        request.setAttribute("ERROR_MESSAGE", "Your role is not supported!");
                    } else {
                        switch (roleID) {
                            case AD:
                                url = ADMIN_PAGE;
                                break;
                            case US:
                                url = USER_PAGE;
                                break;
                            default:
                                request.setAttribute("ERROR_MESSAGE", "Your role is not supported!");
                                break;
                        }
                    }
                }
            } else {
                request.setAttribute("ERROR_MESSAGE", "Incorrect user ID or password!");
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
