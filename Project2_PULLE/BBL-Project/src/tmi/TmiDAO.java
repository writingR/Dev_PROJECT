package tmi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import com.sun.xml.internal.ws.api.ha.StickyFeature;

import jdbc.ConnectionProvider;

public class TmiDAO {
	private static TmiDAO dao = new TmiDAO();

	public static TmiDAO getInstance() {
		return dao;
	}

	private TmiDAO() {
	}

	public int insert(Tmi tmi) {
		
		Connection conn = null;
		int rcnt = 0;

		// insert
		PreparedStatement pstmt = null;
		String sql = "insert into tmi(tmi_ID,user_ID,tmi_Title,tmi_Content,tmi_Photo)VALUES(tmi_ID_seq.nextval,?,?,?,?)";
		try {
			conn=ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tmi.getUser_ID());
			pstmt.setString(2, tmi.getTmi_Title());
			pstmt.setString(3, tmi.getTmi_Content());
			pstmt.setString(4, tmi.getTmi_Photo());
			rcnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return rcnt;
	}

	// list만들기
	public List<Tmi> tmiList() {
		List<Tmi> list = new ArrayList<Tmi>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select  tmi_id, user_id, tmi_title,tmi_content,tmi_date,tmi_photo\r\n" + 
				"from(select * from tmi order by tmi_id desc)";

		try {
			Connection conn=ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Tmi tmi =new Tmi();
				tmi.setTmi_ID(rs.getInt(1));
				tmi.setUser_ID(rs.getString(2));
				tmi.setTmi_Title(rs.getString(3));
				tmi.setTmi_Content(rs.getString(4));
				tmi.setTmi_Date(rs.getDate(5));
				tmi.setTmi_Photo(rs.getString(6));
				list.add(tmi);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				System.out.println("리스트가 맛탱이가 가버렸어..");
				e.printStackTrace();
			}
		}

		return list;
	}//검색
	public List<Tmi> tmiSearch(String keyword) {
		List<Tmi> list=new ArrayList<Tmi>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select tmi_id,user_id, tmi_title,tmi_content,tmi_date,tmi_photo\r\n" + 
				"from(select * from tmi order by tmi_id desc)\r\n" + 
				"where tmi_title like ?";

		try {
			
			Connection conn=ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,"%"+keyword+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Tmi tmi =new Tmi();
				tmi.setTmi_ID(rs.getInt(1));
				tmi.setUser_ID(rs.getString(2));
				tmi.setTmi_Title(rs.getString(3));
				tmi.setTmi_Content(rs.getString(4));
				tmi.setTmi_Date(rs.getDate(5));
				tmi.setTmi_Photo(rs.getString(6));
				list.add(tmi);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				System.out.println("검색이 맛탱이가 가버렸어..");
				e.printStackTrace();
			}
		}

		return list;
	}

	// 검색 게시글 수
	public int searchCnt(String keyword) {
		int totalCnt = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*)from tmi where tmi_title like ?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,"%"+keyword+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("검색 갯수가 맛탱이가 가버렸어..");
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return totalCnt;
	}
	
	

	// 총 게시글 수
	public int totalTmi() {
		int totalCnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select count(*)from tmi";
		try {
			Connection conn=ConnectionProvider.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				totalCnt = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("총 갯수가 맛탱이가 가버렸어..");
			e.printStackTrace();
		}
		return totalCnt;
	}
	
	// ajax쪽에서 아이디체크
	public boolean idchk(String uId, String pId) {
		boolean	result = false;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from tmi where user_Id =?and TMi_id=?";
		String userDbId="";
		
		try {
			Connection conn=ConnectionProvider.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, uId);
			pstmt.setString(2, pId);
			rs=pstmt.executeQuery();
			if (rs.next()) {
			userDbId = rs.getString(2);
			if(userDbId.equals(uId)) {
				result=true;
				}
			
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
	}finally {
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
		return result;
	}
	//삭제
	public int deleteTmi(String pid) {
		int rcnt=0;
		
		PreparedStatement pstmt=null;
		String sql = "delete from tmi where tmi_id=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			rcnt=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rcnt;
	}
	
	//수정
	public int updateTmi(String tid, String tTitle,String tContent ) {
		int rcnt=0;
		
		PreparedStatement pstmt=null;
		String sql = "update tmi\r\n" + 
				"set tmi_title=?,tmi_content=?\r\n" + 
				"where tmi_id=?";
		try {
			Connection conn=ConnectionProvider.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, tTitle);
			pstmt.setString(2, tContent);
			pstmt.setString(3, tid);
			rcnt=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rcnt;
	}
	
	
}





