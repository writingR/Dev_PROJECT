package tmiService;

import java.util.List;

import tmi.Tmi;
import tmi.TmiDAO;

public class ListService {
	private ListService() {
	};

	private static ListService service = new ListService();

	public static ListService getInstance() {
		return service;

	}

	public List<Tmi> tmiList() {
		TmiDAO dao = TmiDAO.getInstance();

		List<Tmi> list = null;
		list = dao.tmiList();
		return list;
	
	}
	
	public int count() {
		int cnt=0;
		TmiDAO dao = TmiDAO.getInstance();
		cnt=dao.totalTmi();
		return cnt;
		
		
	}

}
