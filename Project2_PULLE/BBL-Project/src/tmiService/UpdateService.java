package tmiService;

import tmi.TmiDAO;

public class UpdateService {
	private UpdateService(){}
	
	private static UpdateService service= new  UpdateService();
	
	public static UpdateService getInstance() {
		return service;
	}
	
	public boolean chkResult(String uId,String tId) {
		TmiDAO dao = TmiDAO.getInstance();
		boolean chkResult = dao.idchk(uId, tId);
		return chkResult;
		
	}
	public void updateTmi(String tId, String tTitle, String tContent) {
		TmiDAO dao = TmiDAO.getInstance();
		dao.updateTmi(tId, tTitle, tContent);
		
	}

}
