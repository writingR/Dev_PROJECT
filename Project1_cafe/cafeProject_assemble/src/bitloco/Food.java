package bitloco;

abstract class Food extends Menu {

	/*
	 * 변수선언
	 * 
	 * @hot: 기본이 따뜻X, 1로 초기화 (따뜻하면 2로) // 베이커리류만 오버라이딩하면 됨.
	 * 
	 * @honey: 기본이 정량, 2가 생크림 추가
	 */
	private String hot;
	private String cream;
	private String sinamon;
	private String honey;

	public String getCream() {
		return cream;
	}

	public void setCream(String cream) {
		this.cream = cream;
	}

	public String getSinamon() {
		return sinamon;
	}

	public void setSinamon(String sinamon) {
		this.sinamon = sinamon;
	}

	public String getHoney() {
		return honey;
	}

	public void setHoney(String honey) {
		this.honey = honey;
	}

	// 생성자
	public Food() {
		super();
		this.hot = "기본";
	}

	public void setHot(String hot) {
		this.hot = "따뜻한";
	}

	public String getHot() {
		return this.hot;
	}

	public void noCold() {
		this.hot = "따끈한";

	}

	public void addCream() {

		setName(getName() + "(생크림 추가)");
		setPrice(getPrice() + 800);
	}

	public void addSinamon() {

		setName(getName() + "(시나몬 추가)");
		setPrice(getPrice() + 500);
	}

	public void addHoney() {

		setName(getName() + "(꿀 추가)");
		setPrice(getPrice() + 600);
	}

	@Override
	public void showProduct() {
		System.out.println(getHot() + " " + getName() + " | " + getPrice() + " 원");
	}
	

	@Override
	public String toString() {
		String str = getHot() + " " + getName() + " | " + getPrice() + " 원";
		return str;
	}

}


class Cheeze extends Food {

	public Cheeze() {

		super();
		this.setPrice(5500);
		this.setName("치즈케이크");
	}

	@Override
	public void showPrint() {
		System.out.println(this.getName() + " | " + this.getPrice() + " 원");

	}

}

class Choco extends Food {

	public Choco() {

		super();
		setPrice(6000);
		setName("초코케이크");
	}

	@Override
	public void showPrint() {
		System.out.println(getName() + " | " + getPrice() + " 원");
	}

}

class Cookies extends Food {

	public Cookies() {

		super();
		setPrice(2800);
		setName("쿠키      ");
	}

	@Override
	public void showPrint() {
		System.out.println(getName() + " | " + getPrice() + " 원");
	}

}

class Sandwiches extends Food {

	public Sandwiches() {

		super();
		setPrice(5600);
		setName("샌드위치  ");
	}

	@Override
	public void showPrint() {
		System.out.println(getName() + " | " + getPrice() + " 원");
	}
}

class Scone extends Food {

	public Scone() {
		super();
		setPrice(3300);
		setName("스콘      ");
	}

	@Override
	public void showPrint() {
		System.out.println(getName() + " | " + getPrice() + " 원");
	}
}

class Honeybread extends Food {

	public Honeybread() {
		super();
		setPrice(6000);
		setName("허니브레드");
	}

	@Override
	public void showPrint() {
		System.out.println(getName() + " | " + getPrice() + " 원");
	}
}
