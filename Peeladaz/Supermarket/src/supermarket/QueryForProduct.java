/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package supermarket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.management.Query;
/**
 *
 * @author ranco
 */
public class QueryForProduct {
    public Connection getConnection(){
        Connection con = null;
        try {
            con = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=qlbh_onl;encrypt=true;trustServerCertificate=true;", "kubi", "28112001");
        } catch (SQLException ex) {
            Logger.getLogger(Query.class.getName()).log(Level.SEVERE, null, ex);
        }
        return con;
    }
    
    public ArrayList<ListOfProducts> BindTable(){
        
    ArrayList<ListOfProducts> list = new ArrayList<ListOfProducts>();
    Connection con = getConnection();
    Statement st;
    ResultSet rs;
   
   try {
        st = con.createStatement();
        rs = st.executeQuery("SELECT ProductName, Unit, Price, Img FROM Product");

        ListOfProducts p;
        while(rs.next()){
             p = new ListOfProducts(
                             rs.getString("ProductName"),
                             rs.getString("Unit"),
                             rs.getInt("Price"),
                             rs.getString("Img")
                     );
        list.add(p);
        }
    } catch (SQLException ex) {
        Logger.getLogger(QueryForProduct.class.getName()).log(Level.SEVERE, null, ex);
    }
        return list;
   }
}

