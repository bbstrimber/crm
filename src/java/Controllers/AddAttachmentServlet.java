/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.AddTicketDao;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import utils.AttachmentBean;

/**
 *
 * @author Blumie
 */
@WebServlet( urlPatterns = {"/AddAttachment"})
@MultipartConfig
public class AddAttachmentServlet extends HttpServlet {

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
        int perPage = Integer.parseInt(request.getParameter("perPage"));
        int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        String sort = request.getParameter("sort");
        
        List<Part> attachments = request.getParts().stream().filter(part -> "attachment".equals(part.getName())).collect(Collectors.toList()); 
        //Part attachment = request.getPart("attachment"); 
        String attachmentName = "";
        InputStream input = null;
        

        if(attachments != null){
            for(Part attachment : attachments)
            {
                AddTicketDao addAttachment = new AddTicketDao();
                int ticketId = Integer.parseInt(request.getParameter("id"));
                attachmentName = Paths.get(attachment.getSubmittedFileName()).getFileName().toString(); 
                input = attachment.getInputStream();
                AttachmentBean attachmentBean = new AttachmentBean();
                attachmentBean.setAttachment(input);
                attachmentBean.setAttachmentName(attachmentName);
                attachmentBean.setTicketId(ticketId);
                addAttachment.addAttachment(attachmentBean);
            }
        }
        
        request.setAttribute("addedAttachment", attachmentName);
        response.sendRedirect(request.getContextPath() + "/ViewTicket?id=" + id + "&perPage=" + perPage + "&pageNumber=" + pageNumber + "&sort=" + sort);
        //request.getRequestDispatcher("ViewTicket").forward(request, response);
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
