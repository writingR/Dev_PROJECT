package adver.model;

import java.util.Date;

public class Adver {

	private int adver_ID;			//number(4)
	private String company_ID;		//varchar2(50)
	private String adver_Title;		//varchar2(255)
	private String adver_Content;	//long
	private Date adver_Date;		//date
	private String adver_Photo;		//varchar2(150)
	
	public int getAdver_ID() {
		return adver_ID;
	}
	public void setAdver_ID(int adver_ID) {
		this.adver_ID = adver_ID;
	}
	public String getCompany_ID() {
		return company_ID;
	}
	public void setCompany_ID(String company_ID) {
		this.company_ID = company_ID;
	}
	public String getAdver_Title() {
		return adver_Title;
	}
	public void setAdver_Title(String adver_Title) {
		this.adver_Title = adver_Title;
	}
	public String getAdver_Content() {
		return adver_Content;
	}
	public void setAdver_Content(String adver_Content) {
		this.adver_Content = adver_Content;
	}
	public Date getAdver_Date() {
		return adver_Date;
	}
	public void setAdver_Date(Date adver_Date) {
		this.adver_Date = adver_Date;
	}
	public String getAdver_Photo() {
		return adver_Photo;
	}
	public void setAdver_Photo(String adver_Photo) {
		this.adver_Photo = adver_Photo;
	}

	/*
	 * public boolean hasPassword() { return company_Pw != null &&
	 * !company_Pw.isEmpty(); }
	 * 
	 * //삭제시 비밀번호 비교 public boolean matchPassword(String pw) { return hasPassword()
	 * && company_Pw.equals(pw); }
	 */
	
	
}
