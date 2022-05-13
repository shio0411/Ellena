/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package sample.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.user.UserDTO;

/**
 *
 * @author vankh
 */
public class SearchResult extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchResult</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Search: " + request.getParameter("search") + "</h1>");
            List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
            out.println("<table border='1'>");
                out.println("<tr>");
                    out.println("<th>No</th>");
                    out.println("<th>UserID</th>");
                    out.println("<th>Full Name</th>");
                    out.println("<th>Role ID</th>");
                    out.println("<th>Password</th>");
                out.println("</tr>");
                int count = 1;
                for (UserDTO user : listUser) {
                    out.println("<tr>");
                    out.println("<td>" + count++ + "</td>");
                    out.println("<td>" + user.getUserID() + "</td>");
                    out.println("<td>" + user.getFullName() + "</td>");
                    out.println("<td>" + user.getRoleID() + "</td>");
                    out.println("<td>" + user.getPassword() + "</td>");
                    out.println("</tr>");
                }
            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
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
