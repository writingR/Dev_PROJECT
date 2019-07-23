package adver.service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;

import adver.dao.AdverDao;
import adver.model.Adver;
import jdbc.ConnectionProvider;
import jdbc.jdbcUtil;

public class EditAdverService {

	// 싱글톤 처리
	private EditAdverService() {
	}

	private static EditAdverService service = new EditAdverService();

	public static EditAdverService getInstance() {
		return service;
	}
	// 싱글톤 완료

	public int editMessage(Adver adver, String dir, String companyId) throws SQLException, AdverAuthorityException {
		int resultCnt = 0;

		// 1. Connection 생성
		Connection conn = null;

		try {
			conn = ConnectionProvider.getConnection();
			// 2.Dao 생성
			AdverDao dao = AdverDao.getInstance();

			Adver getFileName = dao.select(conn, adver.getAdver_ID());

			if (!getFileName.getCompany_ID().equals(companyId)) {
				throw new AdverAuthorityException("삭제 못해요.");
			}
			File file = new File(dir + getFileName.getAdver_Photo());

			if(file.exists()) {
				if(file.delete()) {
					System.out.println("삭제 했어요");
				} else {
					System.out.println("삭제도 못하네요.");
				}
			} else {
				System.out.println("파일이 없네요.");
			}
			
			resultCnt = dao.editAdver(conn, adver);
			
		} catch (SQLException e) {
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		} catch (AdverAuthorityException e) {
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		}

		return resultCnt;

	}

}
