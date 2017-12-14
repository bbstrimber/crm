/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.CommentBean;
import utils.DBConnection;
import utils.TicketBean;

/**
 *
 * @author Code Blue
 */
public class ViewTicketDao {
    
    public TicketBean displayTicket(int id) {
        
        TicketBean ticket = new TicketBean();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            
            statement = con.prepareStatement("SELECT * FROM tickets WHERE id=?");
            
            statement.setInt(1, id);
            
            rs = statement.executeQuery(); 
            
            while(rs.next()){
                
                ticket.setId(rs.getInt("id"));
                ticket.setDate(rs.getTimestamp("date"));
                ticket.setSenderName(rs.getString("sender_name"));
                ticket.setTitle(rs.getString("title"));
                ticket.setContent(rs.getString("content"));
                ticket.setStatus(rs.getString("status"));
                ticket.setDeveloper(rs.getString("developer"));
                ticket.setAttachment(rs.getBinaryStream("attachment"));
                ticket.setAttachmentName(rs.getString("attachment_name"));
            }
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        
        return ticket;
    }
    
    public List<CommentBean> displayComments(int id){
        
        List<CommentBean> comments = new ArrayList<CommentBean>();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            statement = con.prepareStatement("SELECT * FROM comments WHERE ticket_id=?");
            statement.setInt(1,id);
            rs = statement.executeQuery(); 
            
            while(rs.next()){
                
                CommentBean comment = new CommentBean();
                comment.setId(rs.getInt("id"));
                comment.setComment(rs.getString("comment"));
                comment.setAuthor(rs.getString("author"));
                comment.setDate(rs.getTimestamp("date"));
                comment.setTicketId(rs.getInt("ticket_id"));
                comment.setClientView(rs.getString("client_view"));
                
                comments.add(comment);
            }
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return comments;
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
