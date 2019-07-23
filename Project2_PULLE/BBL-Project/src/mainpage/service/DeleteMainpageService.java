package mainpage.service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionProvider;
import jdbc.jdbcUtil;
import mainpage.dao.MainPageDao;
import mainpage.model.MainPage;

public class DeleteMainpageService {

private DeleteMainpageService() {}
	
	private static DeleteMainpageService service = new DeleteMainpageService();
	
	public static DeleteMainpageService getInstance() {
		return service;
	}
	
	public String deleteMessage(int mainpageId, String uesrId) throws SQLException, MainpageNotFoundException, MainpageAuthorityException {
		String fileName = "";
		
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			
			//트랜젝션 처리
			conn.setAutoCommit(false);
			
			//MessageDao 필요
			MainPageDao dao = MainPageDao.getInstance();
			
			//1.전달받은 게시물 아이디로 게시물 확인
			MainPage mainpage = dao.select(conn, mainpageId);
			
			//2.게시물이 존재 하지 않으면 예외 처리
			if(mainpage==null) {
				throw new MainpageNotFoundException("게시글이 존재하지 않습니다 : "+mainpageId);
			}
			
			if(!mainpage.getUser_ID().equals(uesrId)) {
				throw new MainpageAuthorityException("삭제 권한이 없습니다.");
			}
			
			//5.비밀번호가 일치하면 정상처리 (삭제) -> commit
			fileName = mainpage.getMainpage_Photo();
			dao.deleteMainpage(conn, mainpageId);
			
			//정상 처리
			conn.commit();
			
		} catch (SQLException e) {
			//트랜젝션 롤백
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		} catch (MainpageNotFoundException e) {
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		} catch (MainpageAuthorityException e) {
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		}
		
		return fileName;
	}
	
}
