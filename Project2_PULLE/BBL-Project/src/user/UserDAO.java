package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserDAO {

	private Connection conn ;

	private ResultSet rs;
	private PreparedStatement pstmt;
	

	public UserDAO() {
		try {
			

			
			String dbURL = "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbID = "scott";
			String dbPassword = "tiger";
			
	
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			

			
		} catch(Exception e){
			e.printStackTrace();
		}
		
	}
	

	public int login(String user_ID,String user_Pw) {
		

		String SQL = "SELECT user_Pw FROM custom WHERE user_ID = ? "; 
		
		try {
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user_ID);
			rs = pstmt.executeQuery(); 
									
			if(rs.next()) {
				


				if(rs.getString(1).equals(user_Pw)) {
					return 1; 
				} else {

					return 0; 
				}
				
			} 
			return -1; 
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2; 
	}
	

	public int join(User user) {
		

		String SQL = "INSERT INTO custom VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUser_ID());
			pstmt.setString(2, user.getUser_Pw());
			pstmt.setString(3, user.getUser_Name());
			pstmt.setString(4, user.getUser_Nic());
			pstmt.setString(5, user.getUser_Gen());
			pstmt.setString(6, user.getUser_Email());
			pstmt.setString(7, user.getUser_Memo());
			

			return pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	
}
