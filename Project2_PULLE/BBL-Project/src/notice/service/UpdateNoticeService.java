package notice.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionProvider;
import notice.dao.NoticeDao;
import notice.model.Notice;

public class UpdateNoticeService {
	
	public static UpdateNoticeService service = new UpdateNoticeService();
	
	public static UpdateNoticeService getInstance() {
		return service;
	}
	
	
	public int update(Notice notice) throws SQLException {
		int rCnt=0;
		//1.Connection 생성
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();		
	
			// message dao 필요
			NoticeDao dao = NoticeDao.getInstance();
			
			// id != admin일 때 exception 생성하기
			
			// 5. 비밀번호가 일치하면 전상처리 commit 
			rCnt = dao.updateNotice(conn, notice);
			
		} catch (SQLException  e) {
			//트랜젝션 롤백
//			JdbcUtil.rollback(conn);
			e.printStackTrace();
//			throw e;
			
		}
		
		return rCnt;
		
	}
}
