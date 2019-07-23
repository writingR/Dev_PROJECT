package mainpage.service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;

import jdbc.ConnectionProvider;
import jdbc.jdbcUtil;
import mainpage.dao.MainPageDao;
import mainpage.model.MainPage;

public class UpdateMainpageService {
private static UpdateMainpageService write = new UpdateMainpageService();
	
	private UpdateMainpageService() {};
	
	public static UpdateMainpageService getInstance() {
		return write;
	}
	
	
	public int update(MainPage mainpage, String dir, String userId) throws MainpageAuthorityException, SQLException {
		int rCnt=0;
		//1.Connection 생성
		Connection conn = null;
		
		try {
			conn = ConnectionProvider.getConnection();
			//2.DAO 생성
			MainPageDao dao = MainPageDao.getInstance();
			
			MainPage getFileName = dao.select(conn, mainpage.getMainpage_ID());
			
			if(!getFileName.getUser_ID().equals(userId)) {
				throw new MainpageAuthorityException("삭제 권한이 없습니다.");
			}

			File file = new File(dir+getFileName.getMainpage_Photo());
	        if( file.exists() ){
	            if(file.delete()){
	                System.out.println("파일삭제 성공");
	            }else{
	                System.out.println("파일삭제 실패");
	            }
	        }else{
	            System.out.println("파일이 존재하지 않습니다.");
	        }
			
			rCnt = dao.updateMainPage(conn, mainpage);
			
		} catch (SQLException e) {
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
		} catch (MainpageAuthorityException e) {
			jdbcUtil.rollback(conn);
			e.printStackTrace();
			throw e;
			
		}
		
		return rCnt;
	}
	
}
