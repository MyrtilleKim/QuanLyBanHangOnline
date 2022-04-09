/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package supermarket;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author Admin
 */
public class JDBCConnection {
    public static java.sql.Connection getConnection(String user, String pasword){
        String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=qlbh_onl;encrypt=true;trustServerCertificate=true;";

        try {
            java.sql.Connection connection = DriverManager.getConnection(connectionUrl,user,pasword);
            return connection;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
