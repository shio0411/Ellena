package store.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.CategoryDAO;
import store.shopping.CategoryDTO;

/**
 *
 * @author vankh
 */
@WebServlet(name = "UpdateCategoryController", urlPatterns = {"/UpdateCategoryController"})
public class UpdateCategoryController extends HttpServlet {

    private static final String ERROR = "SearchCategoryController";
    private static final String SUCCESS = "SearchCategoryController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String categoryName = request.getParameter("categoryName");
            int order = Integer.parseInt(request.getParameter("order"));
            int i = order;
            CategoryDAO dao = new CategoryDAO();
            if (dao.checkDuplicateOrder(order)) {
                List<Integer> largerOrderCategoryID = dao.listLargerOrderCategoryID(order);
                for (Integer categoryId : largerOrderCategoryID) {
                    dao.incrementLargerOrderByOne(i, categoryId);
                    i++;
                }
            }
            CategoryDTO cat = new CategoryDTO(categoryID, categoryName, order, true);
            boolean checkUpdate = dao.updateCategory(cat);
            if (checkUpdate) {
                url = SUCCESS;
                request.setAttribute("MESSAGE", "Cập nhật thành công!");
            } else {
                request.setAttribute("MESSAGE", "Cập nhật thất bại!");
            }
        } catch (Exception e) {
            log("Error at UpdateAccountController: " + e.toString());
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
