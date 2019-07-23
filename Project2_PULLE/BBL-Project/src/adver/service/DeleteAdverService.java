package adver.service;

import java.sql.Connection;
import java.sql.SQLException;

import adver.dao.AdverDao;
import adver.model.Adver;
import jdbc.ConnectionProvider;
import jdbc.jdbcUtil;

public class DeleteAdverService {

	// 싱글톤 처리
	private DeleteAdverService() {
	}

	private static DeleteAdverService service = new DeleteAdverService();

	public static DeleteAdverService getInstance() {
		return service;
	}

	public String deleteMessage(int adverId, String companyId) throws SQLException, AdverNotFoundException, AdverAuthorityException {
		
		String fileName ="";
		
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			//트랜잭션 처리
			conn.setAutoCommit(false); //commit을 막아둔다.
			
			//Adver Dao 필요
			AdverDao dao = AdverDao.getInstance();
			
			//1. 전달받은 게시물 아이디로 게시물 확인
			Adver adver = dao.select(conn, adverId);
			
			//2. 게시물이 존재 하지 않으면 예외 처리
			if(adver == null) {
				throw new AdverNotFoundException("게시물이 존재하지 않습니다. : " + adverId);
				
			}
			
			if(!adver.getCompany_ID().equals(companyId)) {
				throw new AdverAuthorityException("삭제 권한이 없습니다.");
			}
			
			//3. 게시물이 존재 하면 비밀번호 확인(존재여부) -> 사용자가 입력한 비밀번호와 비교
			//4. 비밀번호가 존재하지 않거나 사용자 비밀번호가 틀린 경우 옝외처리 -> rollback
			/*
			 * if(!adver.hasPassword()) { throw new
			 * InvalidAdverPasswordException("비밀번호가 일치하지 않습니다."); }
			 */
			
			//비밀번호 비교
			/*
			 * if(!adver.matchPassword(password)) { throw new
			 * InvalidAdverPasswordException("비밀번호가 일치하지 않습니다."); }
			 */
			
			//5. 비밀번호가 일치하면 정상 처리(삭제 처리) -> commit
			/* dao.deleteMessage(conn, adverId); */
			fileName = adver.getAdver_Photo();
			dao.deleteAdver(conn, adverId);
			
			//정상 처리
			conn.commit(); //처리를 마치고 commit한다. 물리적 저장 실행
	
		} catch (SQLException e) {
			// TODO: handle exception
			//트랜잭션 롤백
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		} catch (AdverNotFoundException e) {
			// TODO: handle exception
			//트랜잭션 롤백
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		} catch (AdverAuthorityException e) {
			// TODO: handle exception
			//트랜잭션 롤백
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		}
		
		return fileName;
		
	}
}
