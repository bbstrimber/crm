package Models;



import java.io.InputStream;
import utils.DBConnection;
import utils.TicketBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import utils.AttachmentBean;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Code Blue
 */
public class AddTicketDao {
    
    public int addTicket(TicketBean addTicketBean) 
    {
        String senderName = addTicketBean.getSenderName(); 
        String title = addTicketBean.getTitle();
        String content = addTicketBean.getContent();
        String priority = addTicketBean.getPriority();
        String status = addTicketBean.getStatus();
        String developer = addTicketBean.getDeveloper();
        /*InputStream input = addTicketBean.getAttachment();
        String attachmentName = addTicketBean.getAttachmentName();*/
        Timestamp date = addTicketBean.getDate();
        
        Connection con = null;
        PreparedStatement updateStatement = null;
        ResultSet rs = null;
        PreparedStatement checkStatement = null;
        int ticketId = -1;
        
        try 
        {
            con = DBConnection.createConnection();
            
            checkStatement = con.prepareStatement("SELECT * FROM tickets WHERE sender_name=? AND title=? AND content=?");
            checkStatement.setString(1, senderName);
            checkStatement.setString(2, title);
            checkStatement.setString(3, content);
            rs = checkStatement.executeQuery(); 
            if(!rs.next()) 
            {
            
                updateStatement = con.prepareStatement("INSERT INTO tickets (date, sender_name, title, content, priority, status, developer) values (?, ?, ?, ?, ?, ?, ?)", updateStatement.RETURN_GENERATED_KEYS);
                updateStatement.setTimestamp(1, date);
                updateStatement.setString(2, senderName);
                updateStatement.setString(3, title);
                updateStatement.setString(4, content);
                updateStatement.setString(5, priority);
                updateStatement.setString(6, status);
                updateStatement.setString(7, developer);
                /*updateStatement.setBinaryStream(7, input);
                updateStatement.setString(8, attachmentName);*/

                updateStatement.executeUpdate();
                ResultSet rs2 = updateStatement.getGeneratedKeys();
                if(rs2.next()){
                    ticketId = rs2.getInt(1);
                }
                
            }
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            
        } 
        return ticketId;
    }
    
    public void addAttachment(AttachmentBean attachmentBean){
        
        Connection con = null;
        PreparedStatement updateStatement = null;
        InputStream input = attachmentBean.getAttachment();
        String attachmentName = attachmentBean.getAttachmentName();
        int ticketId = attachmentBean.getTicketId();
        
        try
        {
            con = DBConnection.createConnection();
            updateStatement = con.prepareStatement("INSERT INTO attachments (attachment, attachment_name, ticket_id) VALUES (?, ?, ?)");
            updateStatement.setBinaryStream(1, input);
            updateStatement.setString(2, attachmentName);
            updateStatement.setInt(3, ticketId);
            updateStatement.executeUpdate();
        }
        catch(SQLException e){
            e.printStackTrace();
        }
    }
    
}
