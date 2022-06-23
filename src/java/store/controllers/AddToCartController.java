package store.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.Cart;
import store.shopping.CartProduct;
import store.shopping.ProductDAO;

@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "ProductRouteController?productID=";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            if (session.getAttribute("LOGIN_USER") != null) {
//            int productID = Integer.parseInt(request.getParameter("productID"));
                int productID = (int) session.getAttribute("productID");
                String color = (String) session.getAttribute("color");
                String size = request.getParameter("size");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");

                if (cart == null) {
                    cart = new ArrayList<>();
                }
                ProductDAO dao = new ProductDAO();

                List<String> colorSize = new ArrayList<>();
                colorSize.add(color);
                colorSize.add(size);

                int maxQuantity = dao.getProductDetail(productID).getColorSizeQuantity().get(colorSize);

                CartProduct cp = new Cart().getProductInfo(productID, color, size, quantity);
                boolean checkDuplicateItem = false;
                boolean checkQuantity = quantity <= maxQuantity && quantity > 0;
                for (CartProduct item : cart) {
                    if (cp.equals(item)) {
                        if ((quantity + item.getQuantity()) < maxQuantity) {
                            item.setQuantity(quantity + item.getQuantity());
                        } else {
                            checkQuantity = false;
                        }

                        checkDuplicateItem = true;
                        break;
                    }
                }

                if (checkQuantity && !checkDuplicateItem) {
                    cart.add(cp);
                }

                if (checkQuantity) {
                    session.setAttribute("CART", cart);
                } else {
                    request.setAttribute("QUANTITY_MESSAGE", "Chỉ còn lại " + maxQuantity + " sản phẩm này!");
                }

                url = SUCCESS + productID;
            } 
        } catch (Exception e) {
            log("Error at AddToCartController: " + e.toString());
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
