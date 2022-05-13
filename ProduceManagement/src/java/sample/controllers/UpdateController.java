/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sample.product.ProductDAO;
import sample.product.ProductDTO;

/**
 *
 * @author giama
 */
@WebServlet(name = "UpdateController", urlPatterns = {"/UpdateController"})
public class UpdateController extends HttpServlet {

    private static final String SUCCESS = "MainController?action=Search&search=";
    private static final String ERROR = "MainController?action=Search&search=";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String id = request.getParameter("id");

            Date importDate = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("importDate"));
            Date expiryDate = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("expiryDate"));

            if (importDate.after(expiryDate)) {
                request.setAttribute("ERROR_MESSAGE", "Expiry date must be after import date!");
            } else {
                double price = Double.parseDouble(request.getParameter("price"));
                double quantity = Double.parseDouble(request.getParameter("quantity"));

                if (price < 0 || quantity < 0) {
                    request.setAttribute("ERROR_MESSAGE", "Price and quantity can't be less than zero!");
                } else {
                    String name = request.getParameter("name");
                    String categoryID = request.getParameter("categoryID");

                    String image = request.getParameter("image");
                    ProductDTO product = new ProductDTO(id, name, image, price, quantity, categoryID, importDate, expiryDate, false);

                    ProductDAO dao = new ProductDAO();
                    boolean check = dao.updateProduct(product);
                    if (check) {
                        url = SUCCESS;
                    }
                }
            }
        } catch (Exception e) {
            System.out.print(e);
            log("Error at UpdateController: " + e.toString());
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
