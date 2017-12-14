package Controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Models.LoginDao;
import utils.UserBean;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Code Blue
 */
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UserBean user = new UserBean();
        
        user.setUsername(username); 
        user.setPassword(password);
        
        LoginDao loginDao = new LoginDao(); 
       
        String userValidate = loginDao.authenticateUser(user); 
        
        if(userValidate.equals("admin"))
        {
            System.out.println("Admin's Home");
            HttpSession session = request.getSession(); //Creating a session
            session.setAttribute("Admin", username); //setting session attribute
            request.setAttribute("userName", username);
            request.getRequestDispatcher("DisplayTicketsServlet").forward(request, response);
        }
        else if(userValidate.equals("developer"))
        {
            System.out.println("Developer's Home");
            HttpSession session = request.getSession();
            session.setAttribute("Developer", username);
            request.setAttribute("userName", username);
            request.getRequestDispatcher("DisplayTicketsServlet").forward(request, response);
        }
        else if(userValidate.equals("client"))
        {
            System.out.println("Client's Home");
            HttpSession session = request.getSession();
            session.setAttribute("Client", username);
            request.setAttribute("userName", username);
            request.getRequestDispatcher("DisplayTicketsServlet").forward(request, response);
        }
        else
        {
            System.out.println("Error message = "+userValidate);
            request.setAttribute("errMessage", userValidate);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
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
