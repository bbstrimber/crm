package Models;


import utils.DBConnection;
import utils.UserBean;
import com.mysql.jdbc.Connection;
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
public class LoginDao {
    public String authenticateUser(UserBean loginBean)
    {
        String username = loginBean.getUsername(); 
        String password = loginBean.getPassword();
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try
        {
            con = (Connection) DBConnection.createConnection();
            statement = con.prepareStatement("Select username, password, user_type from users where username=? and password=?");
            statement.setString(1, username);
            statement.setString(2, password); 
            resultSet = statement.executeQuery(); 
            if(resultSet.next()) 
            {
                String userNameDB = resultSet.getString("username"); 
                String passwordDB = resultSet.getString("password");
                String userTypeDB = resultSet.getString("user_type");
                if(username.equals(userNameDB) && password.equals(passwordDB) && userTypeDB.equals("admin")){
                return "admin";}
                else if(username.equals(userNameDB) && password.equals(passwordDB) && userTypeDB.equals("developer")){
                return "developer";}
                else if(username.equals(userNameDB) && password.equals(passwordDB) && userTypeDB.equals("client")){
                return "client";}
                
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return "Invalid user credentials"; 
    }
}