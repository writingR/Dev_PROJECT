package adver.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import adver.model.Adver;
import jdbc.jdbcUtil;

public class AdverDao {

	// 싱글톤 처리
	private static AdverDao dao = new AdverDao();

	// 다른 곳에서 getInstance로 참조할 수 있게 public처리
	public static AdverDao getInstance() {
		return dao;
	}

	private AdverDao() {
	}
	// 싱글톤 완료

	// 메세지 입력 메소드 DATE는 자동 입력으로 기본값 SYSDATE처리
	public int insert(Connection conn, Adver adver) {
		int rCnt = 0;

		PreparedStatement pstmt = null;

		String sql = "INSERT INTO adver (adver_ID, company_ID, adver_Title, adver_Content, adver_Photo) "
				+ "VALUES (adver_adver_ID_SEQ.nextval, ?, ?, ?, ?)";
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adver.getCompany_ID());
			pstmt.setString(2, adver.getAdver_Title());
			pstmt.setString(3, adver.getAdver_Content());
			pstmt.setString(4, adver.getAdver_Photo());

			rCnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return rCnt;

	}

	public Adver select(Connection conn, int messageId) {

		Adver adver = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from adver where adver_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, messageId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				adver = new Adver();
				adver.setAdver_ID(rs.getInt(1));
				adver.setCompany_ID(rs.getString(2));
				adver.setAdver_Title(rs.getString(3));
				adver.setAdver_Content(rs.getString(4));
				adver.setAdver_Date(rs.getDate(5));
				adver.setAdver_Photo(rs.getString(6));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return adver;

	}

	public int selectCount(Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;

		int totalCnt = 0;

		String sql = "SELECT COUNT(*) FROM ADVER";

		try {
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return totalCnt;

	}

	public List<Adver> selectList(Connection conn, int firstRow, int endRow) {

		List<Adver> list = new ArrayList<Adver>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select adver_ID, company_ID, adver_Title, "
				+ "adver_Content, adver_Date, adver_Photo from "
				+ "(select rownum rnum, adver_ID, company_ID, adver_Title, "
				+ "adver_Content, adver_Date, adver_Photo from (select * "
				+ "from adver m order by m.adver_ID desc) "
				+ "where rownum <= ?) where rnum >= ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				Adver adver = new Adver();
				
				adver.setAdver_ID(rs.getInt(1));
				adver.setCompany_ID(rs.getString(2));
				adver.setAdver_Title(rs.getString(3));
				adver.setAdver_Content(rs.getString(4));
				adver.setAdver_Date(rs.getDate(5));
				adver.setAdver_Photo(rs.getString(6));

				list.add(adver);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public int deleteAdver(Connection conn, int adver_Id) throws SQLException {
		// PreparedStatement 객체 생성

		int resultCnt = 0;

		PreparedStatement pstmt = null;

		String sql = "DELETE FROM ADVER WHERE ADVER_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, adver_Id);

			resultCnt = pstmt.executeUpdate();

		} finally {
			jdbcUtil.close(pstmt);
		}

		return resultCnt;
	}
	
	public int editAdver(Connection conn, Adver adver) throws SQLException {
		// PreparedStatement 객체 생성
		int resultCnt = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE ADVER " 
				+ "SET ADVER_TITLE = ?, ADVER_CONTENT = ?, ADVER_PHOTO = ? "
				+ "WHERE ADVER_ID = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adver.getAdver_Title());
			pstmt.setString(2, adver.getAdver_Content());
			pstmt.setString(3, adver.getAdver_Photo());
			pstmt.setInt(4, adver.getAdver_ID());
			
			resultCnt = pstmt.executeUpdate();
		
		} finally {
			jdbcUtil.close(pstmt);
		}
		
		
		return resultCnt;
		
	}

}
