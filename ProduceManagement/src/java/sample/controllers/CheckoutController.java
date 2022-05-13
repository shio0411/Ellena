/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.order.OrderDAO;
import sample.order.OrderDTO;
import sample.order.OrderDetailDAO;
import sample.order.OrderDetailDTO;
import sample.product.ProductDAO;
import sample.product.ProductDTO;
import sample.shopping.Cart;
import sample.shopping.Product;
import sample.user.UserDTO;

/**
 *
 * @author giama
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String SUCCESS = "MainController?action=Search&search=";
    private static final String ERROR = "cart.jsp";

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
            HttpSession session = request.getSession();
            if (session == null) {
                request.setAttribute("MESSAGE", "Session timed out!");
            } else {
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart == null) {
                    request.setAttribute("MESSAGE", "Cart not found!");
                } else {
                    boolean checkProduct = true;
                    for (Product product : cart.getCart().values()) {
                        ProductDAO pdao = new ProductDAO();
                        ProductDTO dto = pdao.getProduct(product.getId());
                        String s = "";
                        if (product.getQuantity() > dto.getUnitInStock()) {
                            checkProduct = false;
                            s = s + product.getName() + " ";
                            request.setAttribute("MESSAGE", s.trim() + " is currently out of stock!");
                        }
                    }
                    if (checkProduct) {
                        OrderDAO odao = new OrderDAO();
                        int orderID = odao.getID() + 1;
                        Timestamp orderDate = new Timestamp(System.currentTimeMillis());
                        double total = Double.parseDouble(request.getParameter("total"));
                        UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                        String userID = loginUser.getUserID();
                        OrderDTO order = new OrderDTO(orderID, orderDate, total, userID);

                        boolean checkOrder = odao.add(order);

                        OrderDetailDAO oddao = new OrderDetailDAO();
                        boolean checkDetail = false;
                        for (Product product : cart.getCart().values()) {
                            int detailID = oddao.getID() + 1;
                            double price = product.getPrice();
                            double quantity = product.getQuantity();
                            ProductDAO pdao = new ProductDAO();
                            String productID = product.getId();
                            OrderDetailDTO detail = new OrderDetailDTO(detailID, price, quantity, orderID, productID);

                            checkDetail = oddao.add(detail);

                            if (checkDetail) {
                                pdao.updateQuantity(pdao.getProduct(productID).getUnitInStock() - quantity, productID);
                            }
                        }

                        if (checkOrder && checkDetail) {
                            url = SUCCESS;
                            request.setAttribute("MESSAGE", "Check your mail for the bill! Thank you for shopping at HappyVege");
                            

                            String to = request.getParameter("email");

                            String from = "giamanho371@gmail.com";

                            String host = "smtp.gmail.com";

                            // Get system properties
                            Properties properties = System.getProperties();

                            // Setup mail server
                            properties.put("mail.smtp.host", host);
                            properties.put("mail.smtp.port", "465");
                            properties.put("mail.smtp.ssl.enable", "true");
                            properties.put("mail.smtp.auth", "true");

                            // Get the Session object.// and pass username and password
                            Session sessionmail = Session.getInstance(properties, new javax.mail.Authenticator() {

                                @Override
                                protected PasswordAuthentication getPasswordAuthentication() {

                                    return new PasswordAuthentication("giamanho371@gmail.com", "123123asdzxc");

                                }

                            });
                            // Used to debug SMTP issues
                            sessionmail.setDebug(true);

                            // Create a default MimeMessage object.
                            MimeMessage message = new MimeMessage(sessionmail);

                            // Set From: header field of the header.
                            message.setFrom(new InternetAddress(from));

                            // Set To: header field of the header.
                            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

                            // Set Subject: header field
                            message.setSubject("Your HappyVege bill");

                            // Now set the actual message
                            String html = "<html><p>OrderID: " + orderID + 
                                    "</p><p>UserID: " + userID + 
                                    "</p><p>Total: " + total + 
                                    "</p></p>OrderDate: " + orderDate + 
                                    "</p><table style='border:2px solid black'>"
                                    + "<thead><tr>"
                                    + "<th style='border:2px solid black'>No</th>"
                                    + "<th style='border:2px solid black'>Product ID</th>"
                                    + "<th style='border:2px solid black'>Quantity</th>"
                                    + "<th style='border:2px solid black'>Price</th>"
                                    + "</tr>"
                                    + "</thead>"
                                    + "<tbody>";
                            int count = 1;
                            for (Product product: cart.getCart().values()) {
                                html = html + "<tr>"
                                        + "<td style='border:2px solid black'>" + count++ + "</td>"
                                        + "<td style='border:2px solid black'>" + product.getId() + "</td>"
                                        + "<td style='border:2px solid black'>" + product.getQuantity() + "</td>"
                                        + "<td style='border:2px solid black'>" + product.getPrice() + "</td>"
                                        + "</tr>";
                            }
                            
                            html = html + "</tbody></table></html>";
                            
                            message.setContent(html, "text/html");

                            // Send message
                            Transport.send(message);
                            session.setAttribute("CART", null);

                            
                        }

                    }
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
