/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.DisplayTicketsDao;
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
@WebServlet(urlPatterns = {"/Filter"})
public class FilterServlet extends HttpServlet {

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
        
        if(request.getParameterMap().containsKey("status")) {
            if(!request.getParameter("status").equals("By Status")){
                String status = request.getParameter("status");
                request.setAttribute("status", status);
            }
        }
        if (request.getParameterMap().containsKey("developer")) {
            if(!request.getParameter("developer").equals("By Developer")){
                String developer = request.getParameter("developer");
                request.setAttribute("developer", developer);
            }
        }
        if(request.getParameterMap().containsKey("dateMin") && request.getParameterMap().containsKey("dateMax")) {
            if(request.getParameter("dateMin")!= null && request.getParameter("dateMax")!= null){
                String dateMin = request.getParameter("dateMin");
                String dateMax = request.getParameter("dateMax");
                request.setAttribute("dateMin", dateMin);
                request.setAttribute("dateMax", dateMax);
            }
        }
        if (request.getParameterMap().containsKey("perPage")) {
                
            DisplayTicketsDao displayTicketsDao = new DisplayTicketsDao();
            int perPage = displayTicketsDao.numOfTickets();
                
            if(!request.getParameter("perPage").equals("View All") && !request.getParameter("perPage").equals("View Per Page")){
                    
                perPage = Integer.parseInt(request.getParameter("perPage"));
            }
            request.getSession().setAttribute("perPage", perPage);
            request.getSession().setAttribute("pageNumber", 0);
        }
        
        request.getRequestDispatcher("Tickets").forward(request, response);
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
