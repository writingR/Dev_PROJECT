package notice.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import notice.dao.NoticeDao;
import notice.model.Notice;
import notice.model.NoticeListView;
import jdbc.ConnectionProvider;

public class GetNoticeService {
	
	// MessageListView를 생성해서 결과로 반환
	
	// singleton
	private GetNoticeService() {}
	
	private static GetNoticeService service = new GetNoticeService();
	
	public static GetNoticeService getInstance() {
		return service;
	}
	
	// 1. 한 페이지에 보여줄 게시물의 수 
	private static final int NOTICE_COUNT_PER_PAGE =10;
	
	
	public NoticeListView getNoticeListView(int pageNumber) {
		
		
		// 2. 현재 페이지 번호 
		int currentPageNumber = pageNumber;
		
		Connection conn;
		
		NoticeListView view = null;
		
		try {
			// connection
			conn = ConnectionProvider.getConnection();
			// DAO
			NoticeDao dao = NoticeDao.getInstance();
			//전체 게시물의 수
			int noticeTotalCount = dao.selectCount(conn);
			
			// 게시물 내용 리스트, db검색에 사용할 startrow, endrow
			//mysql : endRow불필요 
			List<Notice> noticeList = null;
			int firstRow = 0;
			
			if(noticeTotalCount > 0) {
				
				//mysql - sequence(+1) 설정 불필요 : auto increment되기 때문 
				firstRow = (pageNumber-1) * NOTICE_COUNT_PER_PAGE;
				noticeList = dao.selectList(conn, firstRow, NOTICE_COUNT_PER_PAGE);
				
			}else {
				currentPageNumber = 0;
				noticeList = Collections.emptyList();
			}
			view = new NoticeListView(NOTICE_COUNT_PER_PAGE, noticeTotalCount, currentPageNumber, noticeList, firstRow);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return view;
	}
	
	public Notice getNotice(int id) {
		Notice notice = null;
		
		Connection conn;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			NoticeDao dao = NoticeDao.getInstance();
			
			//DB에서 articleNum 에 맞는 게시글 1개 가져옴
			notice = dao.select(conn, id);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return notice;
	}


}
