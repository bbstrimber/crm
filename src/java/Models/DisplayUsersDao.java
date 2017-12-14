package Models;


import utils.DBConnection;
import utils.UserBean;
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
public class DisplayUsersDao {
    

    public List<UserBean> displayUsers() {
        
        List<UserBean> users = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            statement = con.prepareStatement("SELECT * FROM users");
            
            rs = statement.executeQuery(); 
            while(rs.next()){
                UserBean user = new UserBean();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setUserType(rs.getString("user_type"));
                users.add(user);
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        
        return users;
    }
}
