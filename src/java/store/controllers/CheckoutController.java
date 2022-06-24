package store.controllers;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.CartProduct;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;
import store.shopping.OrderError;
import store.shopping.ProductDAO;
import store.user.UserDTO;

/**
 *
 * @author DuyLVL
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String INPUT_ERROR = "checkout.jsp";
    private static final String SUCCESS = "shop-cart.jsp"; //đổi thành trang thanh toán
    private static final String CART_ERROR = "shop-cart.jsp";
    private static final String EMAIL_PATTERN = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@ [^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INPUT_ERROR;
        try {
            HttpSession session = request.getSession();
            List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");
            // check cart
            if (cart != null) {
                String email = request.getParameter("email");
                String quantityErrorMessage = "Số lượng của những món hàng: ";
                String statusErrorMessage = "Những món hàng: ";
                OrderError orderError = new OrderError();
                Boolean check = true;
                
                UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                int total = Integer.parseInt(request.getParameter("total"));
                String fullname = request.getParameter("fullname");
                int provinceIndex = 1; // at least 1 so array is not out of bound
                String phone = request.getParameter("phone");
                String note = request.getParameter("note");
                

                // check fullName is empty or ""
                if (fullname.isEmpty() || fullname.equals("")) {
                    url = INPUT_ERROR;
                    check = false;
                    orderError.setFullName("Xin quý khách hãy điền đầy đủ Họ và Tên!");
                }
                
                // check calc_shipping_district is empty or ""
                if (request.getParameter("calc_shipping_provinces").isEmpty() || request.getParameter("calc_shipping_provinces").equals("")) {
                    url = INPUT_ERROR;
                    check = false;
                    orderError.setShippingProvinces("Xin quý khách hãy chọn Tỉnh/Thành Phố - Phường/Huyện nơi giao hàng!");
                } else{
                    provinceIndex = Integer.parseInt(request.getParameter("calc_shipping_provinces"));
                }
                String[] provinces = new String[]{"An Giang", "Bà Rịa - Vũng Tàu", "Bạc Liêu", "Bắc Kạn", "Bắc Giang", "Bắc Ninh", "Bến Tre", "Bình Dương", "Bình Định", "Bình Phước", "Bình Thuận", "Cà Mau", "Cao Bằng", "Cần Thơ", "Đà Nẵng", "Đắk Lắk", "Đắk Nông", "Đồng Nai", "Đồng Tháp", "Điện Biên", "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh", "Hải Dương", "Hải Phòng", "Hòa Bình", "Hậu Giang", "Hưng Yên", "Thành phố Hồ Chí Minh", "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lào Cai", "Lạng Sơn", "Lâm Đồng", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên", "Thanh Hóa", "Thừa Thiên - Huế", "Tiền Giang", "Trà Vinh", "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái"};
                String address = request.getParameter("address") + ", " + request.getParameter("calc_shipping_district") + ", " + provinces[provinceIndex - 1];
                
                
                // check address is empty or ""
                if (request.getParameter("address").isEmpty() || request.getParameter("address").equals("")) {
                    url = INPUT_ERROR;
                    check = false;
                    orderError.setAddress("Xin quý khách hãy nhập địa chỉ giao hàng!");
                }
                
                // check phone is empty or ""
                if (phone.isEmpty() || phone.equals("")) {
                    url = INPUT_ERROR;
                    check = false;
                    orderError.setPhone("Xin quý khách hãy nhập vào số điện thoại liên lạc!");
                }
                
                // check valid email and check empty or ""
                if (Pattern.matches(EMAIL_PATTERN, email) || email.equals("") || email.isEmpty()) {
                    url = INPUT_ERROR;
                    check = false;
                    orderError.setEmail("Email quý khách nhập không hợp lệ!");
//                    request.setAttribute("CART_MESSAGE", "Email quý khách nhập không hợp lệ!");
                }
                
                // check payType

                
                // store value
                OrderDTO order = new OrderDTO(Date.valueOf(LocalDate.now()), total, user.getFullName(), 1, "Chưa xác nhận", ""/*payType*/, fullname, address, phone, email, note);
                
                // check quantity and status
                boolean checkQuantity = true;
                boolean checkStatus = true;
                ProductDAO pdao = new ProductDAO();
                for (CartProduct item : cart) {
                    List<String> colorSize = new ArrayList<>();
                    colorSize.add(item.getColor());
                    colorSize.add(item.getSize());
                    int maxQuantity = pdao.getProductDetail(item.getProductID()).getColorSizeQuantity().get(colorSize);
                    checkQuantity = checkQuantity && (maxQuantity >= item.getQuantity());
                    // record which product quantity is larger than DB stock
                    if (!checkQuantity) {
                        quantityErrorMessage += item.getProductName() + " size " + item.getSize() + " màu " + item.getColor() + ", \n";
                    }
                    checkStatus = checkStatus && (pdao.getProductStatus(item.getProductID()) > 0);
                    // record which product status not availiable for purchase (Manager change status while product is in Customer cart) 
                    if (!checkStatus) {
                        statusErrorMessage += item.getProductName() + " size " + item.getSize() + " màu " + item.getColor() + ", \n";
                    }
                }

                // check quantity
                if (!checkQuantity) {
                    url = CART_ERROR;
                    quantityErrorMessage += "Bạn chọn hiện Shop không còn đủ để đáp ứng nhu cầu, xin quý khách cập nhật lại giỏ hàng!";
                    request.setAttribute("CART_MESSAGE", quantityErrorMessage);
                }
                // check status
                if (!checkStatus) {
                    url = CART_ERROR;
                    statusErrorMessage += "Bạn chọn hiện Shop không còn bán nữa, xin quý khách cập nhật lại giỏ hàng!";
                    request.setAttribute("CART_MESSAGE", statusErrorMessage);
                }

                // insert order only if check quantity and status and checkInputs == true
                if (checkQuantity && checkStatus && check) {
                    OrderDAO odao = new OrderDAO();
                    odao.insertOrder(order, user.getUserID());
                    int orderID = odao.getOrderID(user.getUserID());
                    //insert order detail
                    for (CartProduct item : cart) {
                        int productColorID = pdao.getProductColorID(item.getProductID(), item.getColor());
                        List<String> colorSize = new ArrayList<>();
                        colorSize.add(item.getColor());
                        colorSize.add(item.getSize());
                        int maxQuantity = pdao.getProductDetail(item.getProductID()).getColorSizeQuantity().get(colorSize);
                        if (productColorID > 0) {
                            pdao.updateProductQuantity(maxQuantity - item.getQuantity(), productColorID, item.getSize());// trừ luôn 2 cái
                        }
                    }
                    odao.insertOrderDetail(orderID, cart);
                    odao.updateOrderStatus(orderID, 1); // update mean insert into tblOrderStatusUpdate
                    if (orderID > 0) {
                        request.setAttribute("CART_MESSAGE", "Đặt hàng thành công! Mã đơn hàng của bạn là " + orderID);
                        session.removeAttribute("CART");
                        url = SUCCESS;
                    }
                }else{
                    request.setAttribute("ORDER_ERROR", orderError);
                }

            } else {
                url = CART_ERROR;
                request.setAttribute("CART_MESSAGE", "Ở đây chúng tôi không chơi chạy link vào thẳng Check Out >:( ");
            }

        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
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
