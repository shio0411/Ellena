package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.RatingDAO;
import store.user.UserDTO;

/**
 *
 * @author VP
 */
@WebServlet(name = "UpdateRatingController", urlPatterns = {"/UpdateRatingController"})
public class UpdateRatingController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "RatingController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO)session.getAttribute("LOGIN_USER");
            String userID = user.getUserID();
            String test = request.getParameter("productID");
            int productID = Integer.parseInt(test);
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int star = Integer.parseInt(request.getParameter("rating"));
            String content = request.getParameter("content");
            String date = request.getParameter("rateDate");
            RatingDAO dao = new RatingDAO();
            boolean check = dao.addRating(productID, userID, orderID, content, star, date);
            String success = "SUCCESS";
            String fail = "FAIL";
            if(check){
                request.setAttribute("MESSAGE", success);
                url=SUCCESS + "?orderID=" + String.valueOf(orderID);
            }else{
                request.setAttribute("MESSAGE", fail);
                url=SUCCESS;
            }
        } catch (Exception e) {
            log("Error at UpdateRatingController: " + e.toString());
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
