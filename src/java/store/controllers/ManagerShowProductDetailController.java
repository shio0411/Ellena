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
import javax.servlet.http.HttpSession;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "ManagerShowProductDetailController", urlPatterns = {"/ManagerShowProductDetailController"})
public class ManagerShowProductDetailController extends HttpServlet {

    public static final String ERROR = "manager-product-detail.jsp";
    public static final String SUCCESS = "manager-product-detail.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            ProductDAO dao = new ProductDAO();
            HttpSession session = request.getSession();
            
//            ------------------getProduct----------------------
            int productID = Integer.parseInt(request.getParameter("productID"));
            ProductDTO product = dao.getProduct(productID);
            session.setAttribute("PRODUCT", product);
            
            
            
//            --------------------------------------------------




//            ----------------getProductImage-------------------
//            list images
            List<ProductDTO> listImage = dao.getListImage(productID, "%", "%");
            request.setAttribute("LIST_IMAGE", listImage);

//            --------------------------------------------------





//            ---------------getListProductDetail---------------

//            --------------------------------------------------


            url = SUCCESS;
            
        } catch (Exception e) {
            log("Error at ManagerShowProductDetailController : "+ toString());
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
