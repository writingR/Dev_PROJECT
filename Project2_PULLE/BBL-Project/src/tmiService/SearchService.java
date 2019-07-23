package tmiService;

import java.util.List;

import tmi.Tmi;
import tmi.TmiDAO;

public class SearchService {
	private SearchService() {}
	private static SearchService service= new SearchService();
	public static SearchService getInstance() {
		return service;
	}
	public List<Tmi> searchList(String keyword) {
		TmiDAO dao = TmiDAO.getInstance();
		
		List<Tmi> list = null;
		if(!keyword.isEmpty()) {
		list = dao.tmiSearch(keyword);
		}
		return list;
	
	}
	public int sCount(String keyword) {
		int cnt=0;
		TmiDAO dao = TmiDAO.getInstance();
		cnt=dao.searchCnt(keyword);
		return cnt;
		
	}
}
