package notice.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import jdbc.jdbcUtil;
import notice.model.Notice;

public class NoticeDao {

	private static NoticeDao dao = new NoticeDao();

	public static NoticeDao getInstance() {
		return dao;
	}

	private NoticeDao() {
	}

	// 게시글 등록
	public int insert(Connection conn, Notice notice) {
		int rCnt = 0;

		PreparedStatement pstmt = null;

		String sql = "insert into notice(notice_ID, user_ID,notice_Title, notice_Content, notice_Photo) "
				+ "values(notice_ID_SEQ.nextval,?,?,?,?)";			
//		String sql = "insert into notice (user_ID, notice_Title, notice_Content, notice_Photo) values (?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getUser_ID());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getCon());
			pstmt.setString(4, notice.getPhoto());

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
	

	// 게시글 리스트 출력 
	public List<Notice> selectList(Connection conn, int firstRow, int endRow) {

		List<Notice> list = new ArrayList<Notice>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from (select rownum rnum, notice_ID, notice_Title, notice_date from (select * from notice n order by n.notice_ID desc )"
				+ " where rownum <= ?) where rnum >= ?";	

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Notice notice = new Notice();
				notice.setId(rs.getInt(2));
				notice.setTitle(rs.getString(3));
				notice.setDate(rs.getDate(4));

				list.add(notice);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// 전체 게시글 수 
	public int selectCount(Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;

		int totalCnt = 0;

		String sql = "select count(*) from notice";

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
	
	// 리스트에서 게시글 선택 
	public Notice select(Connection conn, int id) {

		Notice notice = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from notice where notice_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery(); // 揶쏆빘猿쒑쳸�꼹�넎

			if (rs.next()) {
				notice = new Notice();
				notice.setId(rs.getInt(1));
				notice.setUser_ID(rs.getString(2));
				notice.setTitle(rs.getString(3));
				notice.setCon(rs.getString(4));
				notice.setDate(rs.getDate(5));
				notice.setPhoto(rs.getString(6));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return notice;
	}

	// 게시글 삭제
	public int deleteNotice(Connection conn, int id) {
		// preparedStatement 揶쏆빘猿� 占쎄문占쎄쉐
		int rCnt = 0;

		PreparedStatement pstmt = null;

		String sql = "delete from notice where notice_ID 	= ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rCnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			jdbcUtil.close(pstmt);
		}
		return rCnt;
	}
	
	// 게시글 수정	
	public int updateNotice(Connection conn, Notice notice) {
		
		int rCnt = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = "update notice set notice_Title=?, notice_Content=? where notice_ID=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getCon());
			pstmt.setInt(3, notice.getId());
			
			rCnt = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return rCnt;
		
	}
	
	

}
