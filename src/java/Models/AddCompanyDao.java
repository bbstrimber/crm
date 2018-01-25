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
import utils.CompanyBean;
import utils.DBConnection;
import utils.UserBean;

/**
 *
 * @author Blumie
 */
public class AddCompanyDao {
    
    public String addCompany(CompanyBean addCompanyBean)
    {
        
        String name = addCompanyBean.getName();
        String city = addCompanyBean.getCity();
        String state = addCompanyBean.getState();
        String zip = addCompanyBean.getZip();
        
        Connection con = null;
        PreparedStatement checkStatement = null;
        PreparedStatement updateStatement = null;
        ResultSet rs = null;
        
       try
        {
            con = DBConnection.createConnection();
            checkStatement = con.prepareStatement("SELECT * FROM companies WHERE name = ?");
            checkStatement.setString(1, name);
            rs = checkStatement.executeQuery(); 
            if(!rs.next()) 
            {
                updateStatement = con.prepareStatement("INSERT INTO companies (name, city, state, zip) values (?, ?, ?, ?)");
                updateStatement.setString(1, name);
                updateStatement.setString(2, city);
                updateStatement.setString(3, state);
                updateStatement.setString(4, zip);
                updateStatement.executeUpdate();
                return "SUCCESS";
            }
            else
            {
                return "That company name already exists. Please select a new company name"; 
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        } 
        
        
        return "ERROR. User not added"; 
    }
}

