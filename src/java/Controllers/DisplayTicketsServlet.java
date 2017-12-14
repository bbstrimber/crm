package Controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Models.DisplayTicketsDao;
import utils.TicketBean;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Code Blue
 */
@WebServlet(urlPatterns = {"/DisplayTicketsServlet"})
public class DisplayTicketsServlet extends HttpServlet {

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
        
        String sort = "FIELD(status, 'new') DESC, id";
        String where = "1=1";
        String username = (String) request.getSession().getAttribute("Admin");
        
        if(request.getSession().getAttribute("Developer") != null){
            sort = " FIELD(status, 'Assigned') DESC,  id ";
            username = (String)request.getSession().getAttribute("Developer");
            where = " developer= '" + username + "' ";
        }
        else if(request.getSession().getAttribute("Client") != null)
        {
            sort = " id ";
            username = (String)request.getSession().getAttribute("Client");
            where = " sender_name= '" + username + "' ";
        }
        
        DisplayTicketsDao displayTicketsDao = new DisplayTicketsDao();
        
        
        
        if(request.getParameter("sort")!= null){
            sort = request.getParameter("sort");
        }
        if(request.getAttribute("status") != null){
            String status = (String) request.getAttribute("status");
            where += " AND status = '" + status + "' ";
        }
        if(request.getAttribute("developer") != null){
            String developer = (String) request.getAttribute("developer");
            where += " AND developer = '" + developer + "' ";
        }
        if(request.getAttribute("dateMin") != null && request.getAttribute("dateMax") != null){
            
            where += " AND date BETWEEN " + request.getAttribute("dateMin") + "AND " + request.getAttribute("dateMax");
        }
        
        List<TicketBean> tickets = displayTicketsDao.displayTickets(sort, where);
        
        List<String> developers = displayTicketsDao.displayDevelopers();
        
        
        request.setAttribute("ticketList", tickets); 
        
        if(request.getSession().getAttribute("Developer") != null){
            request.getRequestDispatcher("/developer.jsp").forward(request, response);
        }
        else if(request.getSession().getAttribute("Client") != null){
            request.getRequestDispatcher("/client.jsp").forward(request, response);
        }
        else{
            request.setAttribute("developers", developers);
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
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
