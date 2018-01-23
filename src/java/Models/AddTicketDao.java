package Models;



import java.io.InputStream;
import utils.DBConnection;
import utils.TicketBean;
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
public class AddTicketDao {
    
    public void addTicket(TicketBean addTicketBean) 
    {
        String senderName = addTicketBean.getSenderName(); 
        String title = addTicketBean.getTitle();
        String content = addTicketBean.getContent();
        String status = addTicketBean.getStatus();
        String developer = addTicketBean.getDeveloper();
        InputStream input = addTicketBean.getAttachment();
        String attachmentName = addTicketBean.getAttachmentName();
        Timestamp date = addTicketBean.getDate();
        
        Connection con = null;
        PreparedStatement updateStatement = null;
        ResultSet rs = null;
        PreparedStatement checkStatement = null;
        
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
            
                updateStatement = con.prepareStatement("INSERT INTO tickets (date, sender_name, title, content, status, developer, attachment, attachment_name) values (?, ?, ?, ?, ?, ?, ?, ?)");
                updateStatement.setTimestamp(1, date);
                updateStatement.setString(2, senderName);
                updateStatement.setString(3, title);
                updateStatement.setString(4, content);
                updateStatement.setString(5, status);
                updateStatement.setString(6, developer);
                updateStatement.setBinaryStream(7, input);
                updateStatement.setString(8, attachmentName);

                updateStatement.executeUpdate();
            }
            
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            
        } 
    }
    
}
