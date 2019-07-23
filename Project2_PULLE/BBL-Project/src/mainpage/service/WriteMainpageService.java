package mainpage.service;

import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionProvider;
import mainpage.dao.MainPageDao;
import mainpage.model.MainPage;

public class WriteMainpageService {
	
	private static WriteMainpageService write = new WriteMainpageService();
	
	private WriteMainpageService() {};
	
	public static WriteMainpageService getInstance() {
		return write;
	}
	
	public int write(MainPage mainpage) {
		int rCnt=0;
		//1.Connection 생성
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			//2.DAO 생성
			MainPageDao dao = MainPageDao.getInstance();
			//3.insert 메서드 실행
			rCnt = dao.insert(conn, mainpage);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rCnt;
	}

}
