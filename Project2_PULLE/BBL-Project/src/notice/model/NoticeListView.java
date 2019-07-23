package notice.model;

import java.util.List;

public class NoticeListView {
	
	private int noticeCountPerPage;
	private int noticeTotalCount;
	private int pageTotalCount;
	private int curruntPageNumber;
	private List<Notice> noticeList;
	private int firstRow;
//	mysql : endRow 불필요 
	
	
	public NoticeListView(int noticeCountPerPage, int noticeTotalCount, int curruntPageNumber,
			List<Notice> noticeList, int firstRow) {
		super();
		this.noticeCountPerPage = noticeCountPerPage;
		this.noticeTotalCount = noticeTotalCount;
		this.curruntPageNumber = curruntPageNumber;
		this.noticeList = noticeList;
		this.firstRow = firstRow;
		calculatePageTotalCount();
	}
	
	
	private void calculatePageTotalCount() {
		if(noticeTotalCount == 0) {
			pageTotalCount = 0;
			
		} else {
			pageTotalCount = noticeTotalCount / noticeCountPerPage;
			if(noticeTotalCount % noticeCountPerPage >0 ) {
				pageTotalCount++;
			}
		}
	}


	public int getNoticeCountPerPage() {
		return noticeCountPerPage;
	}


	public int getNoticeTotalCount() {
		return noticeTotalCount;
	}


	public int getPageTotalCount() {
		return pageTotalCount;
	}


	public int getCurruntPageNumber() {
		return curruntPageNumber;
	}


	public List<Notice> getNoticeList() {
		return noticeList;
	}


	public int getFirstRow() {
		return firstRow;
	}


	public boolean isEmpty() {
		return noticeTotalCount == 0 ;
	}
	
	
}
