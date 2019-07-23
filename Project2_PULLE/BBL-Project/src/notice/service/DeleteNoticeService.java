package notice.service;

import java.sql.Connection;
import java.sql.SQLException;

import notice.dao.NoticeDao;
import notice.model.Notice;
import jdbc.ConnectionProvider;
import jdbc.jdbcUtil;

public class DeleteNoticeService {
	
	private DeleteNoticeService() {}
	
	private static DeleteNoticeService service = new DeleteNoticeService();
	
	public static DeleteNoticeService getInstance() {
		return service;
	}
	
	public int deleteNotice(int id) throws SQLException, NoticeNotFoundException {
		int rCnt = 0;
		
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			//트랜젝션 처리 
			conn.setAutoCommit(false);
			
			// 1. 전달받은 게시물 아이디로 게시물 확인
			// message dao 필요
			NoticeDao dao = NoticeDao.getInstance();
			
			Notice notice = dao.select(conn, id);
			
			
			// 2. 게시물이 존재하지 않으면 예외처리 
			if(notice == null) {
				throw new NoticeNotFoundException("공지사항이 존재하지 않습니다.");
			} 
					

			// 4. 비밀번호가 존재하지 않거나 사용자 비밀번호가 틀린경우 예외처리
			// 5. 비밀번호가 일치하면 전상처리 commit 
			rCnt = dao.deleteNotice(conn, id);
			
			
			
			// 정상처리 
			conn.commit();
			
		} catch (SQLException  e) {
			//트랜젝션 롤백
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		} catch (NoticeNotFoundException e){
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		}
		
		return rCnt;
		
	}
}
