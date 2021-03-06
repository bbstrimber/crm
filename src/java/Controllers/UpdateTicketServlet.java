package Controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Models.UpdateTicketDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Code Blue
 */
@WebServlet(urlPatterns = {"/UpdateTicket"})
public class UpdateTicketServlet extends HttpServlet {

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
        
        
        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String developerName = null;
        int perPage = Integer.parseInt(request.getParameter("perPage"));
        int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        String sort = request.getParameter("sort");
        
        if(request.getParameter("developer") != null){
            developerName = request.getParameter("developer");
        }
        
        request.setAttribute("perPage", perPage);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("sort", sort);
        
        if(!"Update Status".equals(status) && status != null){
            
            UpdateTicketDao updateTicketDao = new UpdateTicketDao();
            
            updateTicketDao.updateStatus(id, status);

            request.setAttribute("updateTicket", id);
            request.setAttribute("statusChanged", status);
            request.getRequestDispatcher("SendEmailOnUpdate").forward(request, response);
                  
        }
        else if(!"Assign to Developer".equals(developerName) && developerName != null)
        {
            UpdateTicketDao updateTicketDao = new UpdateTicketDao();
            updateTicketDao.updateDeveloper(id, developerName);

            request.setAttribute("updateTicket", id);
            request.setAttribute("statusChanged", "Assigned");
            request.setAttribute("assignedDeveloper", developerName);
            request.getRequestDispatcher("SendEmailOnUpdate").forward(request, response);
        }
        else
        {
            request.setAttribute("failUpdate", id);
            request.getRequestDispatcher("ViewTicket").forward(request, response);
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
