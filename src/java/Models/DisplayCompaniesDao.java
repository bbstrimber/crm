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
import utils.CompanyBean;
import utils.DBConnection;
import utils.UserBean;

/**
 *
 * @author Blumie
 */
public class DisplayCompaniesDao {
    
    public List<CompanyBean> displayCompanies() {
        
        List<CompanyBean> companies = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            statement = con.prepareStatement("SELECT * FROM companies");
            
            rs = statement.executeQuery(); 
            while(rs.next()){
                CompanyBean company = new CompanyBean();
                company.setId(rs.getInt("id"));
                company.setName(rs.getString("name"));
                company.setCity(rs.getString("city"));
                company.setState(rs.getString("state"));
                company.setZip(rs.getString("zip"));
                companies.add(company);
            }
        }
        
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        for(CompanyBean company : companies){
            List<UserBean> users = displayCompanyUsers(company.getId());
            company.setUsers(users);
        }
        
        return companies;
    }
    public List<UserBean> displayCompanyUsers(int id) {
        
        List<UserBean> users = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try
        {
            con = DBConnection.createConnection();
            statement = con.prepareStatement("SELECT * FROM users WHERE company_id=?");
            statement.setInt(1, id);
            
            rs = statement.executeQuery(); 
            while(rs.next()){
                UserBean user = new UserBean();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
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
