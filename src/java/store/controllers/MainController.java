package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class MainController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "Login";
    private static final String REGISTER = "Register";
    private static final String REGISTER_CONTROLLER = "Register";
    private static final String LOGIN_GOOGLE = "LoginGoogle";
    private static final String LOGIN_GOOGLE_CONTROLLER = "LoginGoogleController";
    private static final String SEARCH_ACCOUNT = "SearchAccount";
    private static final String SEARCH_ACCOUNT_CONTROLLER = "SearchAccountController";
    private static final String ADD_ACCOUNT = "Create an account";
    private static final String ADD_ACCOUNT_CONTROLLER = "AddAccountController";
    private static final String ADD_PRODUCT = "Add a product";
    private static final String ADD_PRODUCT_CONTROLLER = "AddProductController";
    private static final String SEARCH_MANAGER = "SearchManager";
    private static final String SEARCH_MANAGER_CONTROLLER = "SearchManagerController";
    private static final String SEARCH_CATALOG = "search-catalog";
    private static final String SEARCH_CATALOG_CONTROLLER = "SearchCatalogController";
    private static final String SEARCH_CATEGORY = "SearchCategory";
    private static final String SEARCH_CATEGORY_CONTROLLER = "SearchCategoryController";
    private static final String MANAGER_SEARCH_PRODUCT = "ManagerSearchProduct";
    private static final String MANAGER_SEARCH_PRODUCT_CONTROLLER = "ManagerSearchProductController";
    private static final String ADD_CATEGORY = "AddCategory";
    private static final String ADD_CATEGORY_CONTROLLER = "AddCategoryController";
    private static final String UPDATE_CATEGORY = "UpdateCategory";
    private static final String UPDATE_CATEGORY_CONTROLLER = "UpdateCategoryController";
    private static final String REMOVE = "Remove";
    private static final String REMOVE_CONTROLLER = "RemoveController";
    private static final String UPDATE_ACCOUNT = "UpdateAccount";
    private static final String UPDATE_ACCOUNT_PAGE = "UpdateAccountController";
    private static final String UPDATE_PASSWORD = "UpdatePassword";
    private static final String UPDATE_PASSWORD_PAGE = "UpdatePasswordController";
    private static final String UPDATE_NAME = "UpdateName";
    private static final String UPDATE_NAME_PAGE = "UpdateNameController";
    private static final String UPDATE_ADDRESS = "UpdateAddress";
    private static final String UPDATE_ADDRESS_PAGE = "UpdateAddressController";
    private static final String UPDATE_PHONE = "UpdatePhone";
    private static final String UPDATE_PHONE_PAGE = "UpdatePhoneController";
    private static final String DEACTIVATE_ACCOUNT = "DeactivateAccount";
    private static final String DEACTIVATE_ACCOUNT_CONTROLLER = "DeactivateAccountController";
    private static final String ACTIVATE_ACCOUNT = "ActivateAccount";
    private static final String ACTIVATE_ACCOUNT_CONTROLLER = "ActivateAccountController";
    private static final String DEACTIVATE_CATEGORY = "DeactivateCategory";
    private static final String DEACTIVATE_CATEGORY_CONTROLLER = "DeactivateCategoryController";
    private static final String ACTIVATE_CATEGORY = "ActivateCategory";
    private static final String ACTIVATE_CATEGORY_CONTROLLER = "ActivateCategoryController";
    private static final String ACTIVATE_PRODUCT = "ActivateProduct";
    private static final String ACTIVATE_PRODUCT_CONTROLLER = "ActivateProductController";
    private static final String DEACTIVATE_PRODUCT = "DeactivateProduct";
    private static final String DEACTIVATE_PRODUCT_CONTROLLER = "DeactivateProductController";
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String INSERT = "Insert";
    private static final String INSERT_CONTROLLER = "InsertController";
    private static final String VIEW_USER = "ViewUser";
    private static final String VIEW_USER_CONTROLLER = "ViewUserController";
    private static final String HIDE = "Hide";
    private static final String HIDE_CONTROLLER = "HideController";
    private static final String UNHIDE = "Unhide";
    private static final String UNHIDE_CONTROLLER = "UnhideController";
    private static final String CREATE = "Create";
    private static final String CREATE_CONTROLLER = "CreateController";
    private static final String ADD_TO_CART = "AddToCart";
    private static final String ADD_TO_CART_CONTROLLER = "AddToCartController";
    private static final String UPDATE_CART = "UpdateCart";
    private static final String UPDATE_CART_CONTROLLER = "UpdateCartController";
    private static final String CHECKOUT = "Checkout";
    private static final String CHECKOUT_CONTROLLER = "CheckoutController";
    private static final String SUBSCRIBE = "Subscribe";
    private static final String SUBSCRIBE_CONTROLLER = "SubscribeController";
    private static final String VIEW_IMAGES = "ViewImages";
    private static final String VIEW_IMAGES_CONTROLLER = "ViewImagesController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (null != action) {
                switch (action) {
                    case LOGIN:
                        url = LOGIN_CONTROLLER;
                        break;
                    case REGISTER:
                        url = REGISTER_CONTROLLER;
                        break;
                    case LOGIN_GOOGLE:
                        url = LOGIN_GOOGLE_CONTROLLER;
                        break;
                    case SEARCH_ACCOUNT:
                        url = SEARCH_ACCOUNT_CONTROLLER;
                        break;
                    case SEARCH_MANAGER:
                        url = SEARCH_MANAGER_CONTROLLER;
                        break;
                    case SEARCH_CATEGORY:
                        url = SEARCH_CATEGORY_CONTROLLER;
                        break;
                    case MANAGER_SEARCH_PRODUCT:
                        url = MANAGER_SEARCH_PRODUCT_CONTROLLER;
                        break;
                    case SEARCH_CATALOG:
                        url = SEARCH_CATALOG_CONTROLLER;
                        break;
                    case ADD_CATEGORY:
                        url = ADD_CATEGORY_CONTROLLER;
                        break;
                    case ADD_ACCOUNT:
                        url = ADD_ACCOUNT_CONTROLLER;
                        break;
                    case ADD_PRODUCT:
                        url = ADD_PRODUCT_CONTROLLER;
                        break;
                    case VIEW_USER:
                        url = VIEW_USER_CONTROLLER;
                        break;
                    case INSERT:
                        url = INSERT_CONTROLLER;
                        break;
                    case UPDATE_ACCOUNT:
                        url = UPDATE_ACCOUNT_PAGE;
                        break;
                    case UPDATE_CATEGORY:
                        url = UPDATE_CATEGORY_CONTROLLER;
                        break;
                    case UPDATE_PASSWORD:
                        url = UPDATE_PASSWORD_PAGE;
                        break;
                    case UPDATE_NAME:
                        url = UPDATE_NAME_PAGE;
                        break;
                    case UPDATE_ADDRESS:
                        url = UPDATE_ADDRESS_PAGE;
                        break;
                    case UPDATE_PHONE:
                        url = UPDATE_PHONE_PAGE;
                        break;
                    case DEACTIVATE_ACCOUNT:
                        url = DEACTIVATE_ACCOUNT_CONTROLLER;
                        break;
                    case ACTIVATE_ACCOUNT:
                        url = ACTIVATE_ACCOUNT_CONTROLLER;
                        break;
                    case DEACTIVATE_CATEGORY:
                        url = DEACTIVATE_CATEGORY_CONTROLLER;
                        break;
                    case ACTIVATE_CATEGORY:
                        url = ACTIVATE_CATEGORY_CONTROLLER;
                        break;
                    case DEACTIVATE_PRODUCT:
                        url = DEACTIVATE_PRODUCT_CONTROLLER;
                        break;
                    case ACTIVATE_PRODUCT:
                        url = ACTIVATE_PRODUCT_CONTROLLER;
                        break;
                    case LOGOUT:
                        url = LOGOUT_CONTROLLER;
                        break;
                    case REMOVE:
                        url = REMOVE_CONTROLLER;
                        break;
                    case HIDE:
                        url = HIDE_CONTROLLER;
                        break;
                    case UNHIDE:
                        url = UNHIDE_CONTROLLER;
                        break;
                    case CREATE:
                        url = CREATE_CONTROLLER;
                        break;
                    case ADD_TO_CART:
                        url = ADD_TO_CART_CONTROLLER;
                        break;
                    case UPDATE_CART:
                        url = UPDATE_CART_CONTROLLER;
                        break;
                    case CHECKOUT:
                        url = CHECKOUT_CONTROLLER;
                        break;
                    case SUBSCRIBE:
                        url = SUBSCRIBE_CONTROLLER;
                        break;
                    case VIEW_IMAGES:
                        url = VIEW_IMAGES_CONTROLLER;
                        break;
                    default:
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
