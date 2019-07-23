package tmiService;

import tmi.TmiDAO;

public class DeleteService {
	private DeleteService() {}
	
	private static DeleteService service = new DeleteService();
	
	public static DeleteService getInstance() {
		
		return service;
	}
	public boolean chkResult(String uId,String tId) {
		TmiDAO dao = TmiDAO.getInstance();
		boolean chkResult = dao.idchk(uId, tId);
		return chkResult;
		
	}
	public void deleteTmi(String tId) {
		TmiDAO dao = TmiDAO.getInstance();
		dao.deleteTmi(tId);
	}
	
}
