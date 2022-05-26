/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;

@WebServlet(name = "SearchOrderController", urlPatterns = {"/SearchOrderController"})
public class SearchOrderController extends HttpServlet {

    private static final String ERROR = "manager-order.jsp";
    private static final String SUCCESS = "manager-order.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String search = request.getParameter("search");
            String sNumberOfWeek = request.getParameter("numberOfWeek");
            String sStatusID = request.getParameter("statusID");
            OrderDAO dao = new OrderDAO();
            List<OrderDTO> listOrder = null;
            if (!"".equals(search)) {
                listOrder = dao.getOrderByEmail(search);
            } else if (!"%".equals(sNumberOfWeek) && !"%".equals(sStatusID)) {
                int numberOfWeek = Integer.parseInt(sNumberOfWeek);
                int statusID = Integer.parseInt(sStatusID);
                listOrder = dao.getOrder(numberOfWeek, statusID);
            } else if (!"%".equals(sNumberOfWeek) && "%".equals(sStatusID)) {
                int numberOfWeek = Integer.parseInt(sNumberOfWeek);
                listOrder = dao.getOrderByDate(numberOfWeek);
            } else if ("%".equals(sNumberOfWeek) && !"%".equals(sStatusID)) {
                int statusID = Integer.parseInt(sStatusID);
                listOrder = dao.getOrderByStatus(statusID);
            } else if ("%".equals(sNumberOfWeek) && "%".equals(sStatusID)) {
                listOrder = dao.getAllOrder();
            } 
            
            if (listOrder.size() > 0) {
                request.setAttribute("LIST_ORDER", listOrder);
                url = SUCCESS;
            } else {
                request.setAttribute("EMPTY_LIST_MESSAGE", "No result found!");
            }

        } catch (Exception e) {
            log("Error at SearchAccountController: " + e.toString());
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
