/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.UpdateTicketDao;
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
@WebServlet(urlPatterns = {"/Comment"})
public class CommentServlet extends HttpServlet {

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
        
        String commentAction = request.getParameter("commentAction");
        int commentId = 0;
        if (request.getParameterMap().containsKey("commentId")){
            commentId = Integer.parseInt(request.getParameter("commentId"));
        }
        
        UpdateTicketDao updateTicketDao = new UpdateTicketDao();
        switch(commentAction){
            case "addEdit":
                int ticketId = Integer.parseInt(request.getParameter("id"));
                String comment = "";
                if(request.getParameter("comment")!= null){
                    comment = request.getParameter("comment");
                }
                String clientView = "false";
                if(request.getParameter("clientView") != null){
                    clientView = "true";
                }

                java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
                if(!comment.isEmpty())
                {
                    String author = null;
                    if(request.getSession().getAttribute("Admin") != null){
                        author = (String) request.getSession().getAttribute("Admin");
                    }
                    else
                    {
                        author = (String) request.getSession().getAttribute("Developer");
                    }
                    if(commentId > 0)
                    {
                        updateTicketDao.editComment(commentId, comment, clientView);
                    }
                    else
                    {
                        updateTicketDao.addComment(comment, author, date, ticketId, clientView);
                        request.setAttribute("addComment", ticketId);
                    }
                }
                break;
            case "delete":
                updateTicketDao.deleteComment(commentId);
                break;
        }
            
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
