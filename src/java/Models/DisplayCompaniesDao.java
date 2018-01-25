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
        
        return companies;
    }
    
}
