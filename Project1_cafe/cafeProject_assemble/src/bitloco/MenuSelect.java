package bitloco;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
/*
 * ver.03 작성자: 김나연 날 짜: 05.27.2019. am.01:40 수정사항 1. 메뉴번호 예외처리(String넣지않게) 2.
 * menuPlate() 메서드에서 1.음료선택후 음료번호(1~4)를 누르지 않을 때, 혹은 그 역일 때 예외처리 3. 1인당 결제가능한
 * 수량제한하는 basket field만듬 4. checkOrder메서드 변경 : 주문가능수량(==현재 매장에 있는 상품)인 cnt
 * field가 감소하는 기능을 추가함.
 */
import java.util.ArrayList;
import java.util.Date;
import java.util.InputMismatchException;

import bitloco.Menu;
import util.Menu_Inter;
import util.Util;

public class MenuSelect {
	ArrayList<Menu> menu; // 메뉴판보여주기
	ArrayList<Beverage> orderBev; // 주문-음료용
	ArrayList<Food> orderFood; // 주문-푸드용
	ArrayList<Menu> order; // 주문-영수증 넣는 field.

	int cnt = 10;
	int basket = 3; // 주문 가능한 횟수. 최대 넣을 수 있는 수량.
	int total = 0; // 총 구매금액(주문한 상품 total)
	Menu m;
	
	public static MenuSelect getInstance() {
		if(s == null) {
			s=new MenuSelect();
		}return s;
	}
	static MenuSelect s = new MenuSelect();
	
	public MenuSelect() {
		this.menu = new ArrayList<Menu>();

		menu.add(new Americano());
		menu.add(new Cappuchino());
		menu.add(new Sparkling());
		menu.add(new Lemonade());

		menu.add(new Cheeze());
		menu.add(new Choco());
		menu.add(new Cookies());
		menu.add(new Sandwiches());

		for (Menu m : menu) {
			m.setCnt(cnt);
		}

		this.orderBev = new ArrayList<Beverage>();
		this.orderFood = new ArrayList<Food>();

		this.order = new ArrayList<Menu>(5);// 고객당 한번에 처리할 수 있는 주문.
	}

	void menuPlate(int choice) { // 메뉴판 셋팅

		System.out.println("■■■■■■■■■■■■■■■■■ 메뉴 ■■■■■■■■■■■■■■■■■ ");

		// 음료선택시
		if (choice == Menu_Inter.BEVERAGE) {
			System.out.println("================= 음료 =================");
			System.out.println("no |   상품명   |   가격   | 주문가능수량 ");

			for (int i = 0; i < Menu_Inter.LEMONADE; i++) {
				System.out.print((i + 1) + "번| ");
				menu.get(i).showPrint();
				System.out.println("                                   " + menu.get(i).getCnt() + "개");
			}

			// 푸드선택시
		} else if (choice == Menu_Inter.FOOD) {
			System.out.println("================= 푸드 =================");
			System.out.println("no |  상품명  |    가격    | 주문가능수량 ");

			for (int i = Menu_Inter.CHEEZE - 1; i < menu.size(); i++) {
				System.out.print((i + 1) + "번| ");
				menu.get(i).showPrint();
				System.out.println("                                   " + menu.get(i).getCnt() + "개");
			}
		}

		System.out.println("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ");
		System.out.print("구매할 상품의 번호(no)를 눌러주세요: ");
	}

	public void showMenu(String id) { // 메뉴판보여주기
		System.out.println("환영합니다. " + id + "고객님");

		while (true) {
			System.out.println("========================================");
			System.out.println("\t어떤 메뉴를 원하십니까? ");
			System.out.printf("%d.음료 %d.푸드 3.주문보기 4.결제 5.나가기\n", Menu_Inter.BEVERAGE, Menu_Inter.FOOD);
			System.out.println("========================================");

			try {
				// choice 음료냐 푸드냐를 선택하는 변수값
				int choice = Util.keyboard.nextInt();
				switch (choice) {
				case Menu_Inter.BEVERAGE:
					orderProcess(choice);
					break;

				case Menu_Inter.FOOD:
					orderProcess(choice);
					break;

				case 3:
					showCurOrder();
					break;

				case 4:
					// 마지막 결제전 삭제메뉴 있음!
					showBill(id);
					break;

				case 5:
					System.out.println("나갑니다.");
					Util.keyboard.nextLine();
					return;
				}// switch

			} catch (InputMismatchException e) {
				System.out.println("숫자만 입력해 주세요.");

			} // try-catch
		} // while
	}

	// 현재까지 주문완료한 주문창
	void showCurOrder() {

		if (order.size() != 0) {
			System.out.println("■■■■■■■■■■ 현재 주문한 상품들 ■■■■■■■■■■ ");
			for (Menu o : order) {
				o.showProduct();
			}
		} else {
			System.out.println("주문 내역이 없습니다.");
		}
	}

	// 결제로 넘어가게 하는 주문창
	void showBill(String id) {
		if (order.size() != 0) {
			System.out.println("....결제창으로 넘어갑니다....\n");

			try {
				billFormat(id);
				System.out.println("주문이 완료되었습니다.");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else {
			System.out.println("주문 내역이 없습니다.");
		}
	}

	void orderProcess(int choice) {

		if (order.size() == basket) {
			System.out.println("장바구니 초과! 결제하세요!");
			return;
		}

		menuPlate(choice);

		// @select : menuPlate내에서 1~4 or 5~8 선택할 때의 변수값.
		int select = Util.keyboard.nextInt();

		while (choice == Menu_Inter.BEVERAGE && select > Menu_Inter.LEMONADE || select < Menu_Inter.AMERICANO) {
			System.out.println("음료 번호를 입력해 주세요");
			select = Util.keyboard.nextInt();
		}

		while (choice == Menu_Inter.FOOD && select < Menu_Inter.CHEEZE || select > Menu_Inter.SANDWITCHES) {
			System.out.println("푸드 번호를 입력해 주세요");
			select = Util.keyboard.nextInt();
		}

		custum(select);
		checkOrder(choice, select);

	}

	void custum(int choice) {

		switch (choice) {
		case Menu_Inter.AMERICANO:
			orderBev.add(new Americano());
			customBev(orderBev);
			break;

		case Menu_Inter.CAPPUCHINO:
			orderBev.add(new Cappuchino());
			customBev(orderBev);
			break;

		case Menu_Inter.SPARKLING:
			orderBev.add(new Sparkling());
			customBev(orderBev);
			break;

		case Menu_Inter.LEMONADE:
			orderBev.add(new Lemonade());
			customBev(orderBev);
			break;

		case Menu_Inter.CHEEZE:
			orderFood.add(new Cheeze());
			customFood(orderFood);
			break;

		case Menu_Inter.CHOCO:
			orderFood.add(new Choco());
			customFood(orderFood);
			break;

		case Menu_Inter.COOCKIES:
			orderFood.add(new Cookies());
			customFood(orderFood);
			break;

		case Menu_Inter.SANDWITCHES:
			orderFood.add(new Sandwiches());
			customFood(orderFood);
			break;
		}
	}

	// 음료 커스텀
	void customBev(ArrayList<Beverage> b) {

		// @index: 지금 커스텀하고있는 메뉴의 인덱스값
		int index = orderBev.size() - 1;

		System.out.println("선택하신 음료: " + orderBev.get(index).getName());

		// coffee 류면 hot/iced 선택
		if (b.get(b.size() - 1) instanceof Americano || b.get(b.size() - 1) instanceof Cappuchino) {
			System.out.printf("%d.차갑게 %d.따뜻하게\n", Menu_Inter.BEV_COLD, Menu_Inter.BEV_HOT);

			int answer = Util.keyboard.nextInt();

			while (answer < Menu_Inter.BEV_COLD || answer > Menu_Inter.BEV_HOT) {
				System.out.println("!!다시 입력!!");
				answer = Util.keyboard.nextInt();
			}

			if (answer == Menu_Inter.BEV_HOT) {
				orderBev.get(index).noCold();
			}
		} // hot<>iced change

		System.out.println("사이즈업하시겠습니까? 1.예 2.아니오");
		int sizeUp = Util.keyboard.nextInt();

		if (sizeUp == 1) {
			orderBev.get(index).sizeUP();
		}

		while (sizeUp > 2) {
			System.out.println("다시 입력해주세요.");
			sizeUp = Util.keyboard.nextInt();
		}
		order.add(orderBev.get(index));
	}

	// 푸드 커스텀
	void customFood(ArrayList<Food> f) {

		// @index: 지금 커스텀하고있는 메뉴의 인덱스값
		int index = orderFood.size() - 1;

		System.out.println("선택하신 푸드: " + orderFood.get(index).getName());

		// 샌드위치/쿠키만
		if (f.get(f.size() - 1) instanceof Cookies || f.get(f.size() - 1) instanceof Sandwiches) {
			System.out.printf("%d.기본 %d.따뜻하게\n", Menu_Inter.FOOD_COLD, Menu_Inter.FOOD_HOT);

			int answer = Util.keyboard.nextInt();

			while (answer < Menu_Inter.FOOD_COLD || answer > Menu_Inter.FOOD_HOT) {
				System.out.println("!!다시 입력!!");
				answer = Util.keyboard.nextInt();

			}

			if (answer == Menu_Inter.FOOD_HOT) {
				orderFood.get(index).noCold();
			}
		}
		order.add(orderFood.get(index));
	}

	void checkOrder(int choice, int select) {
		System.out.println("■■■■■■■■■■■■■■ 주문 확인 ■■■■■■■■■■■■■■ ");
		System.out.print("주문상품: ");

		order.get(order.size() - 1).showProduct();

		System.out.println("선택하신 상품이 맞으신가요?");
		System.out.println("1. 예  2. 아니오");

		// 상품재확인 1.맞다. 2.아니다(== order에서 빼라.)
		choice = Util.keyboard.nextInt();

		while (choice > 2 || choice < 1) {
			System.out.println("!!다시 입력!!");
			choice = Util.keyboard.nextInt();
		}

		if (choice == 2) {
			order.remove(order.size() - 1);
			System.out.println("메뉴창으로 다시 돌아갑니다.");

		} else if (choice == 1) {

			int curCnt = menu.get(select - 1).getCnt();
			menu.get(select - 1).setCnt(--curCnt);
		}
		
	}

	public void showMenuPlate() {
		System.out.println("■■■■■■■■■■ 메 뉴 ■■■■■■■■■■ ");

		System.out.println("========== 음 료 ==========");
		System.out.println("   상 품 명  |    가 격 ");

		for (int i = 0; i < Menu_Inter.LEMONADE; i++) {
			menu.get(i).showPrint();
		}

		System.out.println("========== 푸 드 ==========");
		System.out.println("   상 품 명  |    가 격 ");

		for (int i = Menu_Inter.CHEEZE - 1; i < menu.size(); i++) {
			menu.get(i).showPrint();
		}

		System.out.println("■■■■■■■■■■■■■■■■■■■■■■■■■■■ ");
	}

	// 주문시간 프린트.
	String getOrderTime() {

		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		String result = format.format(new Date());

		return result;
	}

	void billFormat(String id) throws IOException {
		System.out.println("■■■■■■■■■■■■ B I T L O C O ■■■■■■■■■■■■■ ");
		System.out.println("대표자: 최아리");
		System.out.print("주문시각: ");
		System.out.println(getOrderTime());
		System.out.println("----------------------------------------");

		System.out.println("================= 메뉴 ================= ");
		System.out.println("   상  품  명         |    가   격 ");
		System.out.println("----------------------------------------");

		for (Menu e : order) {
			total += e.getPrice();
			e.showProduct();
			System.out.println("----------------------------------------");
			
		}

		System.out.printf(" T O T A L :        ￦ %15d \n", total);
		System.out.println("========================================");
		
		{
			BufferedWriter out = new BufferedWriter(new FileWriter("bill.txt"));
			out.write("주문시각: " + getOrderTime());
			out.newLine();
			out.write("----------------------------------------");
			out.newLine();

			out.write("주문자 아이디: " + id);

			out.newLine();
			out.write("----------------------------------------");
			out.newLine();
			out.write("  T O T A L :        ￦  " + total);
			out.newLine();
			out.write("----------------------------------------");
			out.close();
		}

	}
}