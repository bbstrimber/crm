package utils;


import java.sql.Connection;
import java.sql.DriverManager;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Code Blue
 */
public class DBConnection {
    public static Connection createConnection()
    {
        Connection con = null;
        String url = "jdbc:mysql://localhost:3306/codeblue_crm"; 
        String username = "root";
        String password = "";
        try 
        {
            try 
            {
                Class.forName("com.mysql.jdbc.Driver"); 
            } 
            catch (ClassNotFoundException e)
            {
                e.printStackTrace();
            } 
            con = DriverManager.getConnection(url, username, password);
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
        return con; 
    }
}