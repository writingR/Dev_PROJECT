package adver.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import adver.dao.AdverDao;
import adver.model.Adver;
import adver.model.AdverListView;
import jdbc.ConnectionProvider;

public class GetAdverListService {

	// AdverListView를 생성해서 결과로 반환

	private GetAdverListService() {
	}

	private static GetAdverListService service = new GetAdverListService();

	public static GetAdverListService getInstance() {
		return service;
	}

	// 1. 한 페이지에 보여줄 게시글의 개수
	private static final int ADVER_COUNT_PER_PAGE = 3;

	public AdverListView getAdverListView(int pageNumber) {

		// 2. 현재 페이지 번호
		int currentPageNumber = pageNumber;

		Connection conn;

		AdverListView view = null;

		try {
			// Connection
			conn = ConnectionProvider.getConnection();

			// Dao
			AdverDao dao = AdverDao.getInstance();

			// 전체 게시물의 개수
			int adverTotalCount = dao.selectCount(conn);

			// 게시물 내용 리스트, DB 검색에 사용할 start_row, end_row
			List<Adver> adverList = null;
			int firstRow = 0;
			int endRow = 0;

			if (adverTotalCount > 0) {

				firstRow = (currentPageNumber - 1) * ADVER_COUNT_PER_PAGE + 1;
				endRow = firstRow + ADVER_COUNT_PER_PAGE - 1;

				adverList = dao.selectList(conn, firstRow, endRow);

			} else {
				currentPageNumber = 0;
				adverList = Collections.emptyList();
			}

			view = new AdverListView(
					adverTotalCount,
					currentPageNumber,
					adverList,
					ADVER_COUNT_PER_PAGE,
					firstRow,
					endRow);

		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return view;

	}
}
