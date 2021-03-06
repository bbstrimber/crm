package Controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Models.ViewTicketDao;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.AttachmentBean;
import utils.CommentBean;
import utils.TicketBean;

/**
 *
 * @author Code Blue
 */
@WebServlet(urlPatterns = {"/ViewTicket"})
public class ViewTicketServlet extends HttpServlet {

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
        
        ViewTicketDao ViewTicketDao = new ViewTicketDao();
        
        int id = Integer.parseInt(request.getParameter("id"));
        int perPage = Integer.parseInt(request.getParameter("perPage"));
        int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        String sort = request.getParameter("sort");
        
        TicketBean ticket = ViewTicketDao.displayTicket(id);
        List<AttachmentBean> attachments = ViewTicketDao.displayAttachments(id);
        
        if(attachments != null){
            for(AttachmentBean attachment : attachments){
                String fileName = new File(attachment.getAttachmentName()).getName();
                int dotIndex = fileName.lastIndexOf('.');
                String fileExtension = (dotIndex == -1) ? "" : fileName.substring(dotIndex + 1);
                if(!"docx".equals(fileExtension) && !"doc".equals(fileExtension)){
                    String mimeType = getServletContext().getMimeType(attachment.getAttachmentName());
                    if (mimeType.startsWith("image/")){
                        attachment.setAttachmentType("image");
                    }
                }
            }
            request.setAttribute("attachments", attachments);
        }
        
        List<CommentBean> comments = ViewTicketDao.displayComments(id);
        
        List<String> developers = ViewTicketDao.displayDevelopers();
        
        
        request.setAttribute("ticket", ticket); 
        request.setAttribute("comments", comments);
        request.setAttribute("developers", developers);
        request.setAttribute("perPage", perPage);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("sort", sort);
        request.getRequestDispatcher("/viewTicket.jsp").forward(request, response);
        
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
