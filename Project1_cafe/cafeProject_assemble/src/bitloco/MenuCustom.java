package bitloco;

import java.util.ArrayList;

public class MenuCustom {

	private ArrayList<Beverage> orderBev; // 주문시
	private ArrayList<Food> orderFood; // 주문
	
	
	private MenuCustom() {
		this.orderBev = new ArrayList<Beverage>();
		this.orderFood = new ArrayList<Food>();
	}
	
	private static MenuCustom custom = new MenuCustom(); 
	
	public static MenuCustom getInstance() {
		MenuCustom meCustom = (custom == null ? new MenuCustom() : custom);
		return meCustom;
	}
	
	
	
}
