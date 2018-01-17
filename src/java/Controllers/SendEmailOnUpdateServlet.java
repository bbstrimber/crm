/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.EmailDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Blumie
 */
@WebServlet(urlPatterns = {"/SendEmailOnUpdate"})
public class SendEmailOnUpdateServlet extends HttpServlet {

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
        
        int id = (int) request.getAttribute("updateTicket");
        String status = (String) request.getAttribute("statusChanged");
        String username = (String) request.getSession().getAttribute("userName");
        String from = "blumie@codeblue.ventures";
        String pass = "blumie1818";
        String to = "blumie@codeblue.ventures";
        
        String subject = "Ticket #" + id + " Status Updated";
        String body = "Ticket #" + id + " status updated to '" + status + "' by " + username;
        if(request.getAttribute("statusChanged").equals("Assigned")){
            String developer = (String) request.getAttribute("assignedDeveloper");
            subject = "Ticket #" + id + " Assigned to a Developer";
            body = "Ticket #" + id + " assigned to " + developer + ". Status updated to " + status + ".";
        }
        
        
        
        EmailDao email = new EmailDao();
        email.sendEmail(from, pass, to, subject, body);
        
        request.getRequestDispatcher("ViewTicket").forward(request, response);
        
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
