package store.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;
import store.user.UserDTO;

@WebServlet(name = "ShowOrderController", urlPatterns = {"/ShowOrderController"})
public class ShowOrderController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String MANAGER_SUCCESS = "manager-order.jsp";
    private static final String EMPLOYEE_SUCCESS = "employee-order.jsp";
    private static final String MN = "MN";
    private static final String EM = "EM";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            OrderDAO dao = new OrderDAO();
            List<OrderDTO> listOrder = dao.getAllOrder();
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (listOrder.size() > 0) {
                request.setAttribute("LIST_ORDER", listOrder);
                switch (loginUser.getRoleID()) {
                    case MN:
                        url = MANAGER_SUCCESS;
                        break;
                    case EM:
                        url = EMPLOYEE_SUCCESS;
                        break;
                    default:
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at ShowOrderController: " + e.toString());
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
