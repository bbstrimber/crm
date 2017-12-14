package Models;


import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Code Blue
 */
public class UpdateTicketDao {
    
    Connection con = null;
    PreparedStatement updateStatement = null;
    ResultSet rs = null;
    
    public void updateDeveloper( int id, String developer){
        
        try
        {
            con = DBConnection.createConnection();
            String status = "Assigned";
            updateStatement = con.prepareStatement("UPDATE tickets SET developer=?, status=? WHERE id=?");
            updateStatement.setString(1, developer);
            updateStatement.setString(2, status);
            updateStatement.setInt(3, id);
            updateStatement.executeUpdate();
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        } 
    }
    public void updateStatus( int id, String status){
        
        try
        {
            
            con = DBConnection.createConnection();
            
            updateStatement = con.prepareStatement("UPDATE tickets SET status=? WHERE id=?");
            
            updateStatement.setString(1, status);
            updateStatement.setInt(2, id);
            updateStatement.executeUpdate();
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        } 
    }
    public void addComment(String comment, String author, int ticketId, String clientView){
         
        try
        {
            con = DBConnection.createConnection();
            
            updateStatement = con.prepareStatement("INSERT INTO comments (comment, author, ticket_id, client_view) values (?, ?, ?, ?)");
            
            updateStatement.setString(1, comment);
            updateStatement.setString(2, author);
            updateStatement.setInt(3, ticketId);
            updateStatement.setString(4, clientView);
            updateStatement.executeUpdate();
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
    
}
