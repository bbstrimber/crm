package Models;


import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

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
    PreparedStatement checkStatement = null;
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
    public void addComment(String comment, String author, Timestamp date, int ticketId, String clientView){
         
        try
        {
            con = DBConnection.createConnection();
            checkStatement = con.prepareStatement("SELECT * FROM comments WHERE author=? AND comment=? AND ticket_id=?");
            checkStatement.setString(1, author);
            checkStatement.setString(2, comment);
            checkStatement.setInt(3, ticketId);
            rs = checkStatement.executeQuery(); 
            if(!rs.next()) 
            {
                updateStatement = con.prepareStatement("INSERT INTO comments (comment, author, date, ticket_id, client_view) values (?, ?, ?, ?, ?)");

                updateStatement.setString(1, comment);
                updateStatement.setString(2, author);
                updateStatement.setTimestamp(3, date);
                updateStatement.setInt(4, ticketId);
                updateStatement.setString(5, clientView);
                updateStatement.executeUpdate();
            }
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
    
    public void editComment(int commentId, String comment, String clientView){
        
        try
        {
            con = DBConnection.createConnection();
            updateStatement = con.prepareStatement("UPDATE comments SET comment=?, client_view=? WHERE id=?");

            updateStatement.setString(1, comment);
            updateStatement.setString(2, clientView);
            updateStatement.setInt(3, commentId);
            updateStatement.executeUpdate();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
    public void deleteComment(int commentId){
        
        try
        {
            con = DBConnection.createConnection();
            updateStatement = con.prepareStatement("DELETE FROM comments WHERE id = ?");
            
            updateStatement.setInt(1, commentId);
            updateStatement.executeUpdate();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
    
    
}
