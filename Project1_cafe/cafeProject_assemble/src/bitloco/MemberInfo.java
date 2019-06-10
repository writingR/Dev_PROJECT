package bitloco;

import util.Util;

public class MemberInfo {

	private String id;
	private String pw;
	private String name;
	private String pNum;
	String nicName;

	public MemberInfo(String id, String pw, String name, String pNum) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.pNum = pNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getpNum() {
		return pNum;
	}

	public void setpNum(String pNum) {
		this.pNum = pNum;
	}

	public void showData() {
		System.out.println("=== M E M B E R S H I P ===");
		System.out.println("I      D : " + id);
		System.out.println("Password : " + pw);
		System.out.println("UserName : " + name);
		System.out.println("PhoneNum : " + pNum);
	}
	

	
	

}

