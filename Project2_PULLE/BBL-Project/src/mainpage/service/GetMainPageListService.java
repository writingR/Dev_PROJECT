package mainpage.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import jdbc.ConnectionProvider;
import mainpage.dao.MainPageDao;
import mainpage.model.MainPage;
import mainpage.model.MainPageList;

public class GetMainPageListService {

private static GetMainPageListService service = new GetMainPageListService();

public static GetMainPageListService getInstance() {
	return service;
}
	
private GetMainPageListService() {}
	
	public MainPageList getMainPageList(int pageNumber, int countPerPage) {
		//2.현재 페이지 번호
		int currentPageNumber = pageNumber;
		
		Connection conn;
		
		MainPageList list = null;
		
		try {
			//Connection
			conn = ConnectionProvider.getConnection();
			//DAO
			MainPageDao dao = MainPageDao.getInstance();
			//전체 게시물 개수
			int mainpageTotalCount = dao.selectCount(conn);
			//게시물 내용 리스트, DB 검색에 사용할 firstRow, endRow
			List<MainPage> mainpageList = null;
			int firstRow = 0;
			int endRow = 0;
			
			if(mainpageTotalCount > 0) {
				firstRow = (currentPageNumber - 1)*countPerPage + 1;
				endRow = firstRow + countPerPage -1;
				
				mainpageList = dao.selectList(conn, firstRow, endRow);
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
