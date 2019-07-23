package mainpage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jdbc.jdbcUtil;
import mainpage.model.MainPage;

public class MainPageDao {
	
private static MainPageDao dao = new MainPageDao();
	
	public static MainPageDao getInstance() {
		return dao;
	}
	
	private MainPageDao() {}
	
	
	public int insert(Connection conn, MainPage mainpage) {
		int rCnt = 0;
		PreparedStatement pstmt = null;
		
		String sql = "insert into mainpage(mainpage_ID,user_ID,mainpage_Title,mainpage_Content,mainpage_Photo,mainpage_Loc) "
				+ "values(mainpage_ID_SEQ.nextval,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mainpage.getUser_ID());
			pstmt.setString(2, mainpage.getMainpage_Title());
			pstmt.setString(3, mainpage.getMainpage_Content());
			pstmt.setString(4, mainpage.getMainpage_Photo());
			pstmt.setString(5, mainpage.getMainpage_Loc());

			
			rCnt = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return rCnt;
	}
	
	public MainPage select(Connection conn, int messgeId) {
		
		MainPage mainpage = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM mainpage WHERE mainpage_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, messgeId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mainpage = new MainPage();
				mainpage.setMainpage_ID(rs.getInt(1));
				mainpage.setUser_ID(rs.getString(2));
				mainpage.setMainpage_Title(rs.getString(3));
				mainpage.setMainpage_Content(rs.getString(4));
				mainpage.setMainpage_Date(rs.getDate(5));
				mainpage.setMainpage_Photo(rs.getString(6));
				mainpage.setMainpage_Loc(rs.getString(7));

			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return mainpage;
	}
	
	
	public int selectCount(Connection conn) {
		Statement stmt = null;
		ResultSet rs = null;
		int totalCnt = 0;
		String sql = "SELECT COUNT(*) FROM mainpage";
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return totalCnt;
	}

	public List<MainPage> selectList(Connection conn, int firstRow, int endRow) {
		List<MainPage> list = new ArrayList<MainPage>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * " + 
		"from (select rownum rnum, mainpage_ID, user_ID, mainpage_Title, mainpage_Content,mainpage_Date, mainpage_Photo, mainpage_Loc" + 
		"    from (select * from mainpage m order by m.mainpage_ID desc ) " + 
		"    where rownum <= ?) " + 
		"    where rnum >= ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MainPage mainpage = new MainPage();
				mainpage.setMainpage_ID(rs.getInt(2));
				mainpage.setUser_ID(rs.getString(3));
				mainpage.setMainpage_Title(rs.getString(4));
				mainpage.setMainpage_Content(rs.getString(5));
				mainpage.setMainpage_Date(rs.getDate(6));
				mainpage.setMainpage_Photo(rs.getString(7));
				mainpage.setMainpage_Loc(rs.getString(8));
				
				list.add(mainpage);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int searchCount(Connection conn, String word) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCnt = 0;
		String sql = "SELECT COUNT(*) FROM mainpage WHERE mainpage_title like '%' || ? || '%'";
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, word);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return totalCnt;
	}

	public List<MainPage> search(Connection conn, int firstRow, int endRow, String word) {
		
		List<MainPage> list = new ArrayList<MainPage>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * " + 
				"from (select rownum rnum, mainpage_ID, user_ID, mainpage_Title, mainpage_Content,mainpage_Date, mainpage_Photo, mainpage_Loc" + 
				"    from (select * from mainpage m where mainpage_title like '%' || ? || '%' order by m.mainpage_ID desc ) " + 
				"    where rownum <= ?) " + 
				"    where rnum >= ?";
				
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, word);
					pstmt.setInt(2, endRow);
					pstmt.setInt(3, firstRow);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						MainPage mainpage = new MainPage();
						mainpage.setMainpage_ID(rs.getInt(2));
						mainpage.setUser_ID(rs.getString(3));
						mainpage.setMainpage_Title(rs.getString(4));
						mainpage.setMainpage_Content(rs.getString(5));
						mainpage.setMainpage_Date(rs.getDate(6));
						mainpage.setMainpage_Photo(rs.getString(7));
						mainpage.setMainpage_Loc(rs.getString(8));
						
						list.add(mainpage);
					}
					
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				return list;
	}

	public int deleteMainpage(Connection conn, int mainpage_ID) throws SQLException {
		int resultCnt = 0;
		//PreparedStatement 객체 생성
		PreparedStatement pstmt = null;
		
		String sql = "DELETE FROM mainpage WHERE mainpage_ID = ?";
		try {
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mainpage_ID);
			resultCnt = pstmt.executeUpdate();
			
		}finally {
			jdbcUtil.close(pstmt);
		}
		
		return resultCnt;
		
	}
	
	public int updateMainPage(Connection conn, MainPage mainpage) {
		
		int resultCnt = 0;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE mainpage " + 
				"SET mainpage_Title=?, mainpage_Content=?, mainpage_Photo=?, mainpage_Loc=?" + 
				"WHERE MAINPAGE_ID=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mainpage.getMainpage_Title());
			pstmt.setString(2, mainpage.getMainpage_Content());
			pstmt.setString(3, mainpage.getMainpage_Photo());
			pstmt.setString(4, mainpage.getMainpage_Loc());
			pstmt.setInt(5, mainpage.getMainpage_ID());
			
			resultCnt = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return resultCnt;
		
		
		
	}
	
}

