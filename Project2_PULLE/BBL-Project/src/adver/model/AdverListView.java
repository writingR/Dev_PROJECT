package adver.model;

import java.util.List;

public class AdverListView {

	private int adverTotalCount;
	private int currentPageNumber;
	private List<Adver> adverList;
	private int pageTotalCount;
	private int adverCountPerPage;
	private int firstRow;
	private int endRow;
	
	
	public AdverListView(int adverTotalCount, int currentPageNumber, List<Adver> adverList,
			int adverCountPerPage, int firstRow, int endRow) {
		super();
		this.adverTotalCount = adverTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.adverList = adverList;
		this.adverCountPerPage = adverCountPerPage;
		this.firstRow = firstRow;
		this.endRow = endRow;
		calcuratePageTotalCount();
	}


	private void calcuratePageTotalCount() {
		
		if(adverTotalCount == 0) {
			pageTotalCount = 0;
		} else {
			
			pageTotalCount = adverTotalCount / adverCountPerPage;
			
			if(adverTotalCount % adverCountPerPage >0 ) {
				pageTotalCount++;
			}
		}
		
	}


	public int getAdverTotalCount() {
		return adverTotalCount;
	}


	public int getCurrentPageNumber() {
		return currentPageNumber;
	}


	public List<Adver> getAdverList() {
		return adverList;
	}


	public int getPageTotalCount() {
		return pageTotalCount;
	}


	public int getAdverCountPerPage() {
		return adverCountPerPage;
	}


	public int getFirstRow() {
		return firstRow;
	}


	public int getEndRow() {
		return endRow;
	}
	
	public boolean isEmpty() {
		return adverCountPerPage == 0;
	}
	

	
}
