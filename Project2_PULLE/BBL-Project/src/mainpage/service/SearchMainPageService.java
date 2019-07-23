package mainpage.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import jdbc.ConnectionProvider;
import mainpage.dao.MainPageDao;
import mainpage.model.MainPage;
import mainpage.model.MainPageList;

public class SearchMainPageService {
	private static SearchMainPageService service = new SearchMainPageService();
	
	public static SearchMainPageService getInstance() {
		return service;
	}
	
	private SearchMainPageService() {}

	public MainPageList search(int pageNumber, int countPerPage, String word) {
		
		int currentPageNumber = pageNumber;
		
		Connection conn;
		MainPageList list = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			MainPageDao dao = MainPageDao.getInstance();
			
			int mainpageTotalCount = dao.searchCount(conn, word);
			//게시물 내용 리스트, DB 검색에 사용할 firstRow, endRow
			List<MainPage> mainpageList = null;
			int firstRow = 0;
			int endRow = 0;
			
			if(mainpageTotalCount > 0) {
				firstRow = (currentPageNumber - 1)*countPerPage + 1;
				endRow = firstRow + countPerPage -1;
				
				mainpageList = dao.search(conn, firstRow, endRow, word);
			}else {
				currentPageNumber = 0;
				mainpageList = Collections.emptyList();
			}
			
			list = new MainPageList(mainpageTotalCount, currentPageNumber, mainpageList, countPerPage, firstRow, endRow);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		return list;
		
	}
	
}
