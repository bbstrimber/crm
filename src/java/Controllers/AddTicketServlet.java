package Controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Models.AddTicketDao;
import Models.EmailDao;
import utils.TicketBean;
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
 * @author Code Blue
 */
@WebServlet(urlPatterns = {"/AddTicket"})
@MultipartConfig
public class AddTicketServlet extends HttpServlet {

    
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
        
        String senderName;
        if(request.getSession().getAttribute("Client") != null)
        {
            senderName = (String) request.getSession().getAttribute("Client");
        }
        else if(request.getSession().getAttribute("Developer") != null)
        {
            senderName = (String) request.getSession().getAttribute("Developer");
        }
        else
        {
            senderName = "Admin";
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String priority = request.getParameter("priority");
        
        if(!"".equals(title) && !"".equals(content))
        {
            java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
            
            TicketBean ticketBean = new TicketBean();
            ticketBean.setSenderName(senderName);
            ticketBean.setTitle(title);
            ticketBean.setContent(content);
            ticketBean.setPriority(priority);
            ticketBean.setStatus("new");
            ticketBean.setDeveloper("Unassigned");
            ticketBean.setDate(date);
            
            AddTicketDao addTicketDao = new AddTicketDao();
            int ticketId = addTicketDao.addTicket(ticketBean);
            
            List<Part> attachments = request.getParts().stream().filter(part -> "attachment".equals(part.getName())).collect(Collectors.toList()); 
            //Part attachment = request.getPart("attachment"); 
            String attachmentName = "";
            InputStream input = null;
            
            if(attachments != null){
                for(Part attachment : attachments)
                {
                    attachmentName = Paths.get(attachment.getSubmittedFileName()).getFileName().toString(); 
                    input = attachment.getInputStream();
                    AttachmentBean attachmentBean = new AttachmentBean();
                    attachmentBean.setAttachment(input);
                    attachmentBean.setAttachmentName(attachmentName);
                    attachmentBean.setTicketId(ticketId);
                    addTicketDao.addAttachment(attachmentBean);
                }
            }
            
            request.setAttribute("newTicket", title);
            
            String emailSubject = "New Ticket";
            String emailBody = "New Ticket sent from " + senderName + ". <br> \t Title: " + title + " <br> \t Content: " + content;
            EmailDao emailDao = new EmailDao();
            emailDao.sendEmail(emailSubject, emailBody);
            
            request.getRequestDispatcher("Tickets").forward(request, response);
        }
        else
        {
            request.setAttribute("failAdd", title);
            request.getRequestDispatcher("newTicket").forward(request, response);
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


