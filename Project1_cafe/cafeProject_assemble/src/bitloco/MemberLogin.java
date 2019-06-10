package bitloco;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import util.Menu_Inter;
import util.Util;

public class MemberLogin {

	/*
	 * 변수설명
	 * 
	 * @bit : 해쉬맵, 회원들 정보 저장
	 */

	private ArrayList<MemberInfo> mList;
	public MemberInfo m;
	int cnt;
	public Map<String, String> bit = new HashMap<String, String>();
	private int select;
	private boolean findN = false;
	Event e = new Event();

	MenuSelect plate;

	private MemberLogin() {
		mList = new ArrayList<MemberInfo>();
		plate = new MenuSelect();
		cnt = 0;
	}

	private static MemberLogin loco = new MemberLogin();

	public static MemberLogin getInstance() {
		if (loco == null) {
			loco = new MemberLogin();
		}
		return loco;
	}

	// 로그인 메서드
	public void login() throws IOException {
		System.out.println("1. 이 전 화 면\n2. 로   그   인");
		System.out.print("Select Number:");
		select = Util.keyboard.nextInt();
		Util.keyboard.nextLine();
		if (select == 1) {
			System.out.println("초기화면으로 돌아갑니다.");
			return;
		} else {

			choice: while (true) {

				System.out.println("■■■■■  L  O  G  I  N  ■■■■■");

				System.out.print("I  D:");

				String id = Util.keyboard.nextLine();

				System.out.print("P  W:");
				String pw = Util.keyboard.nextLine();
				System.out.println("***** 접속시간을 체크합니다 ******");

				if (bit.containsKey(id)) {
					if (bit.get(id).equals(pw)) {
						System.out.println(getTime() + "접속!");
						System.out.println(id + "님 , 로그인하셨습니다.");
						System.out.println("===========================");
						System.out.println();
						while (true) {
							System.out.println("---------------------------");
							System.out.println("1.나  의  정  보\n2.주  문  하  기\n3.이     벤    트 \n4.이  전  화  면");
							System.out.println("---------------------------");
							System.out.print("Select Number:");
							select = Util.keyboard.nextInt();
							Util.keyboard.nextLine();
							cafe: switch (select) {
							case 1:
								first();
								if (select < 1 || select > 4) {
									System.out.println("잘못 선택하셨습니다.다시 선택해주세요.");
								} else if (select == 1) {
									showAllData();
								} else if (select == 2) {
									editInfo();
								} else if (select == 3) {
									deleteInfo();
								} else if (select == 4) {
									System.out.println("이전화면으로 돌아갑니다.");
								}
								break;

							case 2:
								plate.showMenu(id);
								break;
							case 3:
								e.showEvent();
								break;
							case 4:
								System.out.println("이전화면으로 돌아갑니다.");
								return;
							}
						} // while 문

//					return;
					} else {
						System.out.println("[Password do not match]");
						return;
					} // else문 종료 (비밀번호가 일치하지 않는 회원)
				} else {
					System.out.println("[존재하지 않는 회원입니다.다시 확인해주세요.]");
					System.out.println("회원가입하시겠습니까?");
					System.out.println("1. J O I N \n2. H O M E ");
					System.out.print("Select Number:");
					select = Util.keyboard.nextInt();
					switch (select) {
					case 1:
						joinMember();
					case 2:
						System.out.println("홈화면으로 돌아갑니다.");
						return;
					}

				} // else문 종료 (존재하지 않는 회원)
			} // while문 종료
		} // else문 종료 (맨위)

	}

	// Members 안에 선택창
	public int first() {
		System.out.println("===========================");
		System.out.println("please select number :)");
		System.out.println("1. I N F O\n2. E D I T\n3. D E L E T E\n4. H O M E");
		System.out.println("===========================");
		System.out.print("Select Number:");
		select = Util.keyboard.nextInt();
		Util.keyboard.nextLine();
		return select;
	}

	// 회원가입
	public void joinMember() {

//				m = null;
		Util.keyboard.nextLine();
		System.out.println("회원가입 양식에 따라 입력해주세요!");
		System.out.print("I      D :");
		String id = Util.keyboard.nextLine();

		while (loco.bit.containsKey(id)) {
			System.out.println("ID가 사용중입니다.다시 입력해주세요.");
			System.out.print("I      D :");
			id = Util.keyboard.nextLine();
		}
		System.out.print("Password :");
		String pw = Util.keyboard.nextLine();

		System.out.print("N A  M E :");
		String name = Util.keyboard.nextLine();

		System.out.print("PhoneNum :");
		String pNum = Util.keyboard.nextLine();

		m = new MemberInfo(id, pw, name, pNum);
		System.out.println(id+"님, "+"회원가입 되었습니다. ");
		mList.add(m);

		loco.bit.put(id, pw);
	}

	// 회원정보 수정
	public void editInfo() {
		System.out.print("INSERT-ID: ");
		String id = Util.keyboard.nextLine();

		while (searchIndex(id) < 0) {
			System.out.println("wrong ID!");
			System.out.print("I      D :");
			id = Util.keyboard.nextLine();
		}

//				int index = searchIndex(id);
//				if(!(mList.get(index).equals(m))) {
//					System.out.println("wrong ID!");
//					System.out.print("I      D :");
//					id = Util.keyboard.nextLine();
//				}
		System.out.println("[edit" + loco.bit.get(id) + "'s Information]");

		System.out.print("PASSWORD :");
		String pw = Util.keyboard.nextLine();

		System.out.print("N  A  M E:");
		String name = Util.keyboard.nextLine();

		System.out.print("Phone Num:");
		String pNum = Util.keyboard.nextLine();

		m = new MemberInfo(id, pw, name, pNum);
		int index = searchIndex(id);
		mList.add(index, m);
		loco.bit.put(id, pw);
		System.out.println(loco.bit.get(id) + "\n[Your edit is complete!]");
	}

	// 회원정보 삭제
	public void deleteInfo() {
		System.out.println("insert ID ");
		String id = Util.keyboard.nextLine();
		while (!(bit.containsKey(id))) {
			System.out.println("wrong ID!");
			System.out.print("I      D :");
			id = Util.keyboard.nextLine();
		}
		System.out.print("PASSWORD :");
		String pw = Util.keyboard.nextLine();
		while (bit.containsKey(id) && !(bit.get(id).equals(pw))) {
			System.out.println("wrong ID!" + "\nPASSWORD :");
			pw = Util.keyboard.nextLine();
		}

		if (bit.get(id) != null && bit.get(id).equals(pw)) {
			mList.remove(searchIndex(id));
			bit.remove(id, pw);
			System.out.println("회원 정보가 확인되었습니다.\n등록된 정보를 삭제합니다.");
			System.out.println("---------------------------");
		}
		System.out.println("[Your ID has been successfully deleted!]");
		return;
	}

	// 회원정보 검색시 사용할 메서드
	int searchIndex(String id) {
		int index = -1;
		for (int i = 0; i < mList.size(); i++) {
			if (mList.get(i).getId().equals(id)) {

				index = i;
				break;
			}
		}
		return index;
	}

	// 회원정보 출력
	public void showAllData() {
		// int index = searchIndex(id);
		String id = null;
		if (mList.size() > 0) {
			for (int i = 0; i < mList.size(); i++) {
				mList.get(i).showData();
				System.out.println("===========================");
				break;
			}
		} else {
			System.out.println("등록된 회원정보가 없습니다.");
		}
	}

	public void eventMenu() {
		System.out.println("이벤트 창입니다");
		// 로그인메서드
		System.out.println("하고싶으신 이벤트를 선택해주세요.");
		while (true) {
			int select = 0;
			System.out.println("1. 랜덤커피 \t 2. 오늘의 기분 \t3. 나가기");
			select = Util.keyboard.nextInt();
			switch (select) {
			case 1:
				randomCoffee();
				askBuy();
				break;
			case 2:
				System.out.println("오늘의 기분은?");
				break;
			case 3:
				return;
			}
			break;

		}

	}

	static void randomCoffee() {
		// System.out.println((int) (Math.random() * 4+1));
		int num = (int) (Math.random() * 4 + 1);
		switch (num) {
		case Menu_Inter.AMERICANO:
			System.out.println("오늘의 추천 음료는  아메리카노 입니다.");
			break;
		case Menu_Inter.CAPPUCHINO:
			System.out.println("오늘의 추천 음료는 카푸치노 입니다.");
			break;
		case Menu_Inter.SPARKLING:
			System.out.println("오늘의 추천 음료는 스파클링입니다.");
			break;
		case Menu_Inter.LEMONADE:
			System.out.println("오늘의 추천음료는 스파클링입니다.");
			break;
		}

	}

	static void howareyou() {

		System.out.println("오늘의 기분을 숫자로 입력해주세요");
		System.out.println("10. 좋아요");
		System.out.println("5. 그냥 그래요");
		System.out.println("1. 별로에요");
		Util.keyboard.nextInt();

		askBuy();

	}

	static void askBuy() {
		System.out.println("결제하시겠습니까? ");
		System.out.println("1. Yes\t 2. No");
		int num = Util.keyboard.nextInt();
		if (num == 1) {
			System.out.println("결제창으로 이동합니다.");
			// 결제창으로 이동

		} else {
			// 메뉴선택창으로 이동

		}
	}

	public static String getTime() {

		SimpleDateFormat format = new SimpleDateFormat(" hh시 mm분 ss초 ");

		return format.format(new Date());

	}

}





