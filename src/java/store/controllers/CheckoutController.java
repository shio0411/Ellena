package store.controllers;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import store.utils.Config;

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
            //If payType is VNPay, the parameters will be put on session, or else they will be killed when redirecting to vnpay.jsp
            HttpSession session = request.getSession();
            String payType = request.getParameter("payType");
            OrderError orderError = new OrderError();

            if ("".equals(request.getParameter("calc_shipping_provinces")) || "".equals(request.getParameter("calc_shipping_district"))) {
                orderError.setShippingProvinces("Xin quý khách hãy chọn Tỉnh/Thành Phố - Phường/Huyện nơi giao hàng!");
                request.setAttribute("ORDER_ERROR", orderError);
            } else {
                if (!"COD".equalsIgnoreCase(payType) && payType != null) {
                    session.setAttribute("PROVINCE", Integer.parseInt(request.getParameter("calc_shipping_provinces")));
                    session.setAttribute("FULL_NAME", request.getParameter("fullname"));
                    session.setAttribute("ADDRESS", request.getParameter("address"));
                    session.setAttribute("PHONE", request.getParameter("phone"));
                    session.setAttribute("NOTE", request.getParameter("note"));
                    session.setAttribute("DISTRICT", request.getParameter("calc_shipping_district"));
                    session.setAttribute("EMAIL", request.getParameter("email"));
                    session.setAttribute("PAY_TYPE", request.getParameter("payType"));
                }
                boolean paidStatus = false;
                List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");
                // check cart
                if (cart != null) {
                    paidStatus = Boolean.parseBoolean((String) session.getAttribute("PAID_STATUS"));
                    if (!"COD".equalsIgnoreCase(payType) && paidStatus == false) {
                        url = "vnpay.jsp";
                    } else {
                        String transactionNumber = "";
                        Map fields = new HashMap();
                        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                            String fieldName = (String) params.nextElement();
                            String fieldValue = request.getParameter(fieldName);
                            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                                fields.put(fieldName, fieldValue);
                            }
                        }
                        transactionNumber = request.getParameter("vnp_TransactionNo");
                        String responseCode = request.getParameter("vnp_ResponseCode");
                        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
                        if (fields.containsKey("vnp_SecureHashType")) {
                            fields.remove("vnp_SecureHashType");
                        }
                        if (fields.containsKey("vnp_SecureHash")) {
                            fields.remove("vnp_SecureHash");
                        }
                        String signValue = Config.hashAllFields(fields);

                        //if customer tries to return to checkout.jsp after they canceled paying
                        if (transactionNumber == null && paidStatus == true) {
                            url = "vnpay.jsp";
                        }else if(!"00".equalsIgnoreCase(responseCode)){                              
                            url = INPUT_ERROR;
                            request.setAttribute("CART_MESSAGE", "Giao dịch không thành công!");
                        } else {
                            String email = request.getParameter("email");
                            String quantityErrorMessage = "Số lượng của những món hàng: ";
                            String statusErrorMessage = "Những món hàng: ";

                            Boolean check = true;
                            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                            int total = Integer.parseInt(session.getAttribute("TOTAL").toString());

                            String fullname, address, phone, note;
                            int provinceIndex;
                            String[] provinces = new String[]{"An Giang", "Bà Rịa - Vũng Tàu", "Bạc Liêu", "Bắc Kạn", "Bắc Giang", "Bắc Ninh", "Bến Tre", "Bình Dương", "Bình Định", "Bình Phước", "Bình Thuận", "Cà Mau", "Cao Bằng", "Cần Thơ", "Đà Nẵng", "Đắk Lắk", "Đắk Nông", "Đồng Nai", "Đồng Tháp", "Điện Biên", "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh", "Hải Dương", "Hải Phòng", "Hòa Bình", "Hậu Giang", "Hưng Yên", "Thành phố Hồ Chí Minh", "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu", "Lào Cai", "Lạng Sơn", "Lâm Đồng", "Long An", "Nam Định", "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên", "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị", "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên", "Thanh Hóa", "Thừa Thiên - Huế", "Tiền Giang", "Trà Vinh", "Tuyên Quang", "Vĩnh Long", "Vĩnh Phúc", "Yên Bái"};
                            //if return from ajaxServlet (the vnpay servlet)
                            if (payType == null) {
                                email = session.getAttribute("EMAIL").toString();
                                fullname = session.getAttribute("FULL_NAME").toString();
                                provinceIndex = Integer.parseInt(session.getAttribute("PROVINCE").toString());
                                address = session.getAttribute("ADDRESS").toString() + ", " + session.getAttribute("DISTRICT").toString() + ", " + provinces[provinceIndex - 1];
                                phone = session.getAttribute("PHONE").toString();
                                note = session.getAttribute("NOTE").toString();
                                payType = session.getAttribute("PAY_TYPE").toString();
                            } else {
                                fullname = request.getParameter("fullname");
                                provinceIndex = Integer.parseInt(request.getParameter("calc_shipping_provinces"));;
                                phone = request.getParameter("phone");
                                note = request.getParameter("note");
                                address = request.getParameter("address") + ", " + request.getParameter("calc_shipping_district") + ", " + provinces[provinceIndex - 1];
                            }

                            // check valid email and check empty or ""
                            if (Pattern.matches(EMAIL_PATTERN, email)) {
                                url = INPUT_ERROR;
                                check = false;
                                orderError.setEmail("Email quý khách nhập không hợp lệ!");
//                    request.setAttribute("CART_MESSAGE", "Email quý khách nhập không hợp lệ!");
                            }

                            OrderDTO order = new OrderDTO(Date.valueOf(LocalDate.now()), total, user.getFullName(), 1, "Chưa xác nhận", payType, fullname, address, phone, email, note, transactionNumber);

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
                                // new insert order
                                OrderDAO odao = new OrderDAO();
                                boolean checkAddOrder = odao.addOrder(order, user.getUserID(), cart);
                                if (checkAddOrder) {
                                    // update product quantity
                                    for (CartProduct item : cart) {
                                        int productColorID = pdao.getProductColorID(item.getProductID(), item.getColor());
                                        List<String> colorSize = new ArrayList<>();
                                        colorSize.add(item.getColor());
                                        colorSize.add(item.getSize());
                                        int maxQuantity = pdao.getProductDetail(item.getProductID()).getColorSizeQuantity().get(colorSize);
                                        if (productColorID > 0) {
                                            pdao.updateProductQuantity(maxQuantity - item.getQuantity(), productColorID, item.getSize());
                                        }
                                    }
                                    int orderID = odao.getOrderID(user.getUserID());
                                    if (orderID > 0) {
                                        request.setAttribute("CART_MESSAGE", "Đặt hàng thành công! Mã đơn hàng của bạn là " + orderID);
                                        session.removeAttribute("CART");
                                        url = SUCCESS;
                                        session.removeAttribute("PAID_STATUS");
                                    }
                                } else {
                                    request.setAttribute("CART_MESSAGE", "Đặt hàng không thành công!");
                                    url = CART_ERROR;
                                }

                            } else {
                                request.setAttribute("ORDER_ERROR", orderError);
                            }
                        }
                    }
                } else {
                    url = CART_ERROR;
                    request.setAttribute("CART_MESSAGE", "Ở đây chúng tôi không chơi chạy link vào thẳng Check Out >:( ");
                }

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
