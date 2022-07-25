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
import store.utils.VNCharacterUtils;

@WebServlet(name = "AddCategoryController", urlPatterns = {"/AddCategoryController"})
public class AddCategoryController extends HttpServlet {

    private static final String ERROR = "add-category.jsp";
    private static final String SUCCESS = "ShowCategoryController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String categoryName = request.getParameter("categoryName");
            String categoryNameWithoutVN = VNCharacterUtils.removeAccent(categoryName);
            int order = Integer.parseInt(request.getParameter("order"));
            CategoryDAO dao = new CategoryDAO();
            int i = order;
            if (!dao.checkDuplicateCategoryName(categoryNameWithoutVN)) {
                if (dao.checkDuplicateOrder(order)) {
                    List<Integer> largerOrderCategoryID = dao.listLargerOrderCategoryID(order);
                    for (Integer categoryId : largerOrderCategoryID) {
                        dao.incrementLargerOrderByOne(i, categoryId);
                        i++;
                    }
                }
                CategoryDTO cat = new CategoryDTO(categoryName, order, true);
                boolean checkInsert = dao.addCategory(cat);
                if (checkInsert) {
                    url = SUCCESS;
                }
            }else{
                request.setAttribute("ERROR_MESSAGE", "Tên thể loại sản phầm không được trùng nhau.");
            }
        } catch (Exception e) {
            log("Error at AddCategoryController: " + e.toString());
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
