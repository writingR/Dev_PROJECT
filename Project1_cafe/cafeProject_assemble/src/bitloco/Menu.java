package bitloco;

import java.util.ArrayList;

import util.Menu_Inter;

public abstract class Menu implements Menu_Inter{
	
	
	/* 실제 상품 클래스에서 count 추가해주는 메서드 있어야 함.
		// 실제 상품클래스에서 price 아예 정해주세요~!
		//price, cnt, size, cold 는 가변적이라 상수가 안되므로 인터페이스에 없습니다.

		*
		 * 변수선언
		 * 
		 * @price: 가격
		 * 
		 * @cnt: 주문시 객체 개수
		 * 
		 * @name: 상품의 이름
		 */
	private int price;
	private int cnt;
	private String name;

	/* 생성자 */
	public Menu() {
	}

	public abstract void showPrint();
	
	public void showProduct() { //주문선택한게 맞는지 물어보는 메서드
		System.out.println(getName() + " | " + getPrice() + " 원");
	}

	public int getCnt() { // 다른클래스가 접근가능하도록 리턴
		return this.cnt;
	}
	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public void addCnt() { // cnt 추가.
		cnt++;
	}

	public int getPrice() {
		return this.price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
