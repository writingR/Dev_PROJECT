package adver.service;

import java.sql.Connection;
import java.sql.SQLException;

import adver.dao.AdverDao;
import adver.model.Adver;
import jdbc.ConnectionProvider;

public class GetContentService {
	
	//싱글톤
	private static GetContentService service = new GetContentService();
	
	private GetContentService() {
	}
	
	public static GetContentService getInstance() {
		return service;
	}
	
	public Adver getAdver(int adver_ID) {
		
		Connection conn;
		Adver adver = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			AdverDao dao = AdverDao.getInstance();
			
			adver = dao.select(conn, adver_ID);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return adver;
	}
}
