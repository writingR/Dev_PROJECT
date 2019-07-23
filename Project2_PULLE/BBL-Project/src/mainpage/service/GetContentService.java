package mainpage.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionProvider;
import mainpage.dao.MainPageDao;
import mainpage.model.MainPage;

public class GetContentService {
	
	private static GetContentService service = new GetContentService();
	
	public static GetContentService getInstance() {
		return service;
	}
	
	private GetContentService() {}

	public MainPage getMainPage(int mainpage_ID) {
		
		Connection conn;
		MainPage mainpage = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			MainPageDao dao = MainPageDao.getInstance();
			
			mainpage = dao.select(conn, mainpage_ID);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return mainpage;
	}
	
}
