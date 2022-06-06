/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import javafx.util.Pair;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.StatisticDAO;
import store.shopping.StatisticDTO;

/**
 *
 * @author VP
 */
@WebServlet(name = "ManagerStatisticController", urlPatterns = {"/ManagerStatisticController"})
public class ManagerStatisticController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "manager-statistic.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            StatisticDAO dao = new StatisticDAO();
            Map<String, StatisticDTO> orderStatistic7Day = dao.getStatisticOrder7Day();
            Map<String, StatisticDTO> orderStatistic4Week = dao.getStatisticOrder4Week();
            Map<String, StatisticDTO> orderStatistic1Year = dao.getStatisticOrder1Year();
            StatisticDTO today = dao.getStatisticOrderToday();
            List<Pair<String, StatisticDTO>> bestSeller = dao.getBestSeller();
            List<Pair<String, StatisticDTO>> bestIncome = dao.getBestIncome();
            if (orderStatistic7Day.size() > 0) {
                request.setAttribute("ORDER_STATISTIC_7DAY", orderStatistic7Day);
                request.setAttribute("ORDER_STATISTIC_4WEEK", orderStatistic4Week);
                request.setAttribute("ORDER_STATISTIC_1YEAR", orderStatistic1Year);
                request.setAttribute("ORDER_STATISTIC_TODAY", today);
                request.setAttribute("BEST_SELLER", bestSeller);
                request.setAttribute("BEST_INCOME", bestIncome);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at ManagerStatisticController: " + e.toString());
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
