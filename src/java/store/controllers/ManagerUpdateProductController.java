/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;
import store.shopping.ProductError;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ManagerUpdateProductController", urlPatterns = {"/ManagerUpdateProductController"})
public class ManagerUpdateProductController extends HttpServlet {

    private static final String ERROR = "ManagerShowProductDetailController";
    private static final String SUCCESS = "ManagerShowProductDetailController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        ProductError productError = new ProductError();
        

        try {
//            product basic detail update
            int productID = Integer.parseInt(request.getParameter("productID"));
            String productName = request.getParameter("productName");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            int lowStockLimit = Integer.parseInt(request.getParameter("lowStockLimit"));
            int price = Integer.parseInt(request.getParameter("price"));
            Double discount = Double.parseDouble(request.getParameter("discount"));
            Boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String description = request.getParameter("description");
            boolean check = true;

            if (productName.length() < 5 || productName.length() > 50) {
                check = false;
                productError.setProductName("Tên sản phẩm phải trong khoảng [5..50]");
            }
            if (price < 1000) {
                check = false;
                productError.setPrice("Giá tiền sản phẩm phải trên 1000VND");
            }
            if (discount < 0.0 || discount > 1.0) {
                check = false;
                productError.setPrice("Giảm giá sản phẩm chỉ từ [0.0 , 1.0] (0% -> 100%)");
            }
            if (description.length() < 10 || description.length() > 500) {
                check = false;
                productError.setProductName("Mô tả sản phẩm phải trong khoảng [10..500]");
            }

            if (check) {
                ProductDAO dao = new ProductDAO();
                ProductDTO product = new ProductDTO(productID, productName, "", description, "", "", price, discount, 0, lowStockLimit, categoryID, "", 0.0, status);
                Boolean checkUpdate = dao.updateProduct(product);
                if (checkUpdate) {
                    url = SUCCESS;
                    request.setAttribute("MESSAGE", "Cập nhật thành công!");
                } else {
                    request.setAttribute("MESSAGE", "Cập nhật thất bại!");
                }
            } else {
                request.setAttribute("PRODUCT_ERROR", productError);
            }


            
            
            
        } catch (Exception e) {
            log("ERROR at ManagerUpdateProductController : " + toString());
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
