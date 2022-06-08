/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;

/**
 *
 * @author vankh
 */
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {

    private static final String ERROR = "add-product.jsp";
    private static final String SUCCESS = "ManagerShowProductController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productName = request.getParameter("productName").toUpperCase();
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            int lowStockLimit = Integer.parseInt(request.getParameter("lowStockLimit"));
            int price = Integer.parseInt(request.getParameter("price"));
            float discount = Float.parseFloat(request.getParameter("discount"));
            String description = request.getParameter("description");
            String[] color = request.getParameterValues("color");
            
            String[] variantsCountString = request.getParameterValues("variantsCount");
            int[] variantsCount = new int[variantsCountString.length];
            for (int i = 0; i < variantsCountString.length; i++) {
                variantsCount[i] = Integer.parseInt(variantsCountString[i]);
            }
            String[] size = request.getParameterValues("size");
            
            String[] quantityString = request.getParameterValues("quantity");
            int[] quantity = new int[quantityString.length];
            for (int i = 0; i < quantityString.length; i++) {
                quantity[i] = Integer.parseInt(quantityString[i]);
            }
            
            Map<List<String>, Integer> colorSizeQuantity = new HashMap<>();
            
            for(int i =0; i< color.length; i++){
                List<String> colorSize = new ArrayList<>();
                colorSize.add(color[i].substring(0, 1).toUpperCase() + color[i].substring(1)); //capitalize the string
                colorSize.add(size[i].toUpperCase());
                colorSizeQuantity.put(colorSize, quantity[i]);
            }
            
            Map<String, List<String>> colorImage = new HashMap<>();
            
            
            boolean check = true;
            ProductDAO dao = new ProductDAO();

            if (check) {
                ProductDTO product = new ProductDTO();
//                boolean checkInsert = dao.addUser(user);
//                if (checkInsert) {
//                    url = SUCCESS;
//                }

            } else {
               // request.setAttribute("USER_ERROR", userError);
               //for push
            }
        } catch (Exception e) {
            log("Error at AddProductController: " + e.toString());
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
