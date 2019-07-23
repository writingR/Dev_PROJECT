package tmiService;

import tmi.Tmi;
import tmi.TmiDAO;

public class WriteService {

	private WriteService() {
	};

	private static WriteService service = new WriteService();

	public static WriteService getInstance() {
		return service;
	}
	
	public int write(Tmi tmi) {
		int cnt=0;
		TmiDAO dao = TmiDAO.getInstance();
		cnt=dao.insert(tmi);
		return cnt;
		
		
	}
	

}
