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
@WebServlet(urlPatterns = {"/Tickets"})
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
        
        String sort = " id ";
        String where = " 1=1 ";
        String username;
        String limitPerPage = " LIMIT ";
        int perPage = 10;
        int pageNumber = 1;
        
        if(request.getSession().getAttribute("Developer") != null){
            username = (String)request.getSession().getAttribute("Developer");
            where += "AND developer= '" + username + "' " + "OR sender_name= '" + username + "' ";
        }
        else if(request.getSession().getAttribute("Client") != null)
        {
            username = (String)request.getSession().getAttribute("Client");
            where += "AND sender_name= '" + username + "' ";
        }
        if(request.getParameterMap().containsKey("sort")) {
            sort = (String) request.getParameter("sort");
            if(sort.equals("priority")){
                sort = "FIELD(priority, 'Low', 'Medium', 'High')";
            }
        }
        
        if(request.getParameterMap().containsKey("status")) {
            if(!request.getParameter("status").equals("By Status")){
                String status = request.getParameter("status");
                where += " AND status = '" + status + "' ";
                request.setAttribute("filterStatus", status);
            }
        }
        if (request.getParameterMap().containsKey("developer")) {
            if(!request.getParameter("developer").equals("By Developer")){
                String developer = request.getParameter("developer");
                where += " AND developer = '" + developer + "' ";
                request.setAttribute("filterDeveloper", developer);
            }
        }
        if(request.getParameterMap().containsKey("dateMin") && request.getParameterMap().containsKey("dateMax")) {
            if(request.getParameter("dateMin")!= null && request.getParameter("dateMax")!= null){
                String dateMin = request.getParameter("dateMin");
                String dateMax = request.getParameter("dateMax");
                where += " AND date BETWEEN " + request.getAttribute("dateMin") + "AND " + request.getAttribute("dateMax");
            }
        }
        if (request.getParameterMap().containsKey("pageNumber")) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }
        if (request.getParameterMap().containsKey("perPage")) {
            if(!request.getParameter("perPage").equals("View All") && !request.getParameter("perPage").equals("View Per Page")){
                perPage = Integer.parseInt(request.getParameter("perPage"));
            }
            else if(request.getParameter("perPage").equals("View All")){
                DisplayTicketsDao displayTicketsDao = new DisplayTicketsDao();
                if(request.getSession().getAttribute("Client") != null){
                    username = (String)request.getSession().getAttribute("Client");
                    where = " sender_name= '" + username + "' ";
                }
                else if(request.getSession().getAttribute("Developer") != null){
                    username = (String)request.getSession().getAttribute("Developer");
                    where = " developer= '" + username + "' ";
                }
                
                perPage = displayTicketsDao.numOfTickets(where);
            }
            limitPerPage += (perPage * (pageNumber- 1)) + ", " + perPage;
        }
        else
        {
            limitPerPage += perPage;
        }
        
        
        DisplayTicketsDao displayTicketsDao = new DisplayTicketsDao();
        
        List<TicketBean> tickets = displayTicketsDao.displayTickets(sort, where, limitPerPage);
        List<String> developers = displayTicketsDao.displayDevelopers();
        
        int numOfTickets = displayTicketsDao.numOfTickets(where);
        int numOfPages = numOfTickets / perPage;
        if (numOfTickets % perPage > 0) {
            numOfPages++;
        }
        
        if(request.getSession().getAttribute("Developer") == null){
            request.setAttribute("developers", developers);
        }
        request.setAttribute("ticketList", tickets);
        request.setAttribute("perPage", perPage);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("numOfPages", numOfPages);
        if(sort.equals("FIELD(priority, 'Low', 'Medium', 'High')")){
            sort = "priority";
        }
        request.setAttribute("sort", sort);
        
        
        
        request.getRequestDispatcher("/ticketList.jsp").forward(request, response);
        

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
