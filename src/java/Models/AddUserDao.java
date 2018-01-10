package Models;


import utils.DBConnection;
import utils.UserBean;
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
public class AddUserDao {
    
    public String addUser(UserBean addUserBean)
    {
        
        String username = addUserBean.getUsername(); 
        String password = addUserBean.getPassword();
        String userType = addUserBean.getUserType();
        String companyName = addUserBean.getCompany();
        int coId = 0;
        
        Connection con = null;
        PreparedStatement checkStatement = null;
        PreparedStatement updateStatement = null;
        PreparedStatement findIdStatement = null;
        ResultSet rs = null;
        
       try
        {
            con = DBConnection.createConnection();
            checkStatement = con.prepareStatement("SELECT * FROM users WHERE username = ?");
            checkStatement.setString(1, username);
            rs = checkStatement.executeQuery(); 
            if(!rs.next()) 
            {
                
                findIdStatement = con.prepareStatement("SELECT id FROM companies WHERE name = ?");
                findIdStatement.setString(1, companyName);
                rs = findIdStatement.executeQuery();
                if(rs.next()){
                    coId = rs.getInt("id"); 
                    updateStatement = con.prepareStatement("INSERT INTO users (username, password, user_type, company_id) values (?, ?, ?, ?)");
                    updateStatement.setString(1, username);
                    updateStatement.setString(2, password);
                    updateStatement.setString(3, userType);
                    updateStatement.setInt(4, coId);
                    updateStatement.executeUpdate();
                    return "SUCCESS";
                }
            }
            else
            {
                return "That username already exists. Please select a new username"; 
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        } 
        return "ERROR. User not added"; 
    }
}
