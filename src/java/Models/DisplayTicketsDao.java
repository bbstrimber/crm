package Models;


import utils.DBConnection;
import utils.TicketBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Code Blue
 */
public class DisplayTicketsDao {
    
    public List<TicketBean> displayTickets(String sort, String where) {
        
        List<TicketBean> tickets = new ArrayList<TicketBean>();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            
            String sql = "SELECT id, date, title, status, developer FROM tickets WHERE " + where + " ORDER BY " + sort;
            //String sql = "SELECT * FROM tickets ORDER BY FIELD(status, 'new') DESC,  " + sort;
            
            statement = con.prepareStatement(sql);
            
            
            rs = statement.executeQuery(); 
            
            while(rs.next()){
                TicketBean ticket = new TicketBean();
                ticket.setId(rs.getInt("id"));
                ticket.setDate(rs.getTimestamp("date"));
                ticket.setTitle(rs.getString("title"));
                ticket.setStatus(rs.getString("status"));
                ticket.setDeveloper(rs.getString("developer"));
                
                tickets.add(ticket);
                
            }
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        
        return tickets;
    }
    
    public List<String> displayDevelopers(){
        
        List<String> developers = new ArrayList<String>();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            statement = con.prepareStatement("SELECT username FROM users WHERE user_type=?");
            statement.setString(1, "developer");
            rs = statement.executeQuery(); 
            
            while(rs.next()){
                developers.add(rs.getString("username"));
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        
        return developers;
    }
    
}