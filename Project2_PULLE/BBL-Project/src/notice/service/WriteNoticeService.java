package notice.service;

import java.sql.Connection;
import java.sql.SQLException;

import notice.dao.NoticeDao;
import notice.model.Notice;
import jdbc.ConnectionProvider;

public class WriteNoticeService {
	
	private static WriteNoticeService service = new WriteNoticeService();
	
	private WriteNoticeService() {};
	
	public static WriteNoticeService getInstance() {
		return service;
	}	
	//   <--singleton
	
	public int write(Notice notice){
		
		int rCnt = 0;
		
		Connection  conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			NoticeDao dao = NoticeDao.getInstance();
			
			rCnt = dao.insert(conn, notice);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rCnt;
	}
}
