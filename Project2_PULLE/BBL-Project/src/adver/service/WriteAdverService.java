package adver.service;

import java.sql.Connection;
import java.sql.SQLException;

import adver.dao.AdverDao;
import adver.model.Adver;
import jdbc.ConnectionProvider;

public class WriteAdverService {

	private static WriteAdverService service = new WriteAdverService();

	public static WriteAdverService getInstance() {
		return service;
	}

	private WriteAdverService() {
	}

	public int write(Adver adver) {

		int rCnt = 0;

		// 1. Connection 생성
		// 2. dao 생성
		// 3. insert 메소드 실행

		Connection conn = null;

		try {
			conn = ConnectionProvider.getConnection();

			AdverDao dao = AdverDao.getInstance();

			rCnt = dao.insert(conn, adver);

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return rCnt;

	}
}
