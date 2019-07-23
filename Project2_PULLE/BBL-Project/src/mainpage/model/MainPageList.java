package mainpage.model;

import java.util.List;


public class MainPageList {

	private int mainpageTotalCount;
	private int currentPageNumber;
	private List<MainPage> mainpageList;
	private int pageTotalCount;
	private int mainpageCountPerPage;
	private int firstRow;
	private int endRow;
	
	public MainPageList(int mainpageTotalCount, int currentPageNumber, List<MainPage> mainpageList, 
			int mainpageCountPerPage, int firstRow, int endRow) {
		this.mainpageTotalCount = mainpageTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.mainpageList = mainpageList;
		this.mainpageCountPerPage = mainpageCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		calcuratePageTotalCount();
	}

	private void calcuratePageTotalCount() {
		if(mainpageTotalCount == 0) {
			pageTotalCount = 0;
		}else {
			pageTotalCount = mainpageTotalCount/mainpageCountPerPage;
			
			if(mainpageTotalCount%mainpageCountPerPage>0) {
				pageTotalCount++;
			}
		}
	}

	public int getMainpageTotalCount() {
		return mainpageTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public List<MainPage> getMainpageList() {
		return mainpageList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getMainpageCountPerPage() {
		return mainpageCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public boolean isEmpty() {
		return mainpageTotalCount == 0;
	}
	
	
	
}
