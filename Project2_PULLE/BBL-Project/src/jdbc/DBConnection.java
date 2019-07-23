package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getCon() throws SQLException{
		
		Connection conn = null;
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/BBL?useUnicode = true & useJDBCCompliantTimezoneShift=true & useLegacyDatetimeCode = false & serverTimezone=UTC";
			conn = DriverManager.getConnection(url, "root", "admin");
			return conn;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		}
	}
}
