package tmi;

import java.util.Date;

public class Tmi {

	private int tmi_ID;
	private String user_ID; 
	private String tmi_Title;
	private String tmi_Content;
	private Date tmi_Date;
	private String tmi_Photo;
	
	
	
	public Tmi(int tmi_ID, String user_ID, String tmi_Title, String tmi_Content, String tmi_Photo) {
		super();
		this.tmi_ID = tmi_ID;
		this.user_ID = user_ID;
		this.tmi_Title = tmi_Title;
		this.tmi_Content = tmi_Content;
		this.tmi_Photo = tmi_Photo;
		this.tmi_Date = new Date();
	}
	public Tmi() {
		this.tmi_Date=new Date();
	}
	
	public int getTmi_ID() {
		return tmi_ID;
	}
	public void setTmi_ID(int tmi_ID) {
		this.tmi_ID = tmi_ID;
	}
	public String getUser_ID() {
		return user_ID;
	}
	public void setUser_ID(String user_ID) {
		this.user_ID = user_ID;
	}
	public String getTmi_Title() {
		return tmi_Title;
	}
	public void setTmi_Title(String tmi_Title) {
		this.tmi_Title = tmi_Title;
	}
	public String getTmi_Content() {
		return tmi_Content;
	}
	public void setTmi_Content(String tmi_Content) {
		this.tmi_Content = tmi_Content;
	}
	public String getTmi_Photo() {
		return tmi_Photo;
	}
	public void setTmi_Photo(String tmi_Photo) {
		this.tmi_Photo = tmi_Photo;
	}
	public Date getTmi_Date() {
		return tmi_Date;
	}
	public void setTmi_Date(Date tmi_Date) {
		this.tmi_Date = tmi_Date;
	}
	@Override
	public String toString() {
		return "Tmi [tmi_ID=" + tmi_ID + ", user_ID=" + user_ID + ", tmi_Title=" + tmi_Title + ", tmi_Content="
				+ tmi_Content + ", tmi_Date=" + tmi_Date + ", tmi_Photo=" + tmi_Photo + "]";
	}

	
	
	
}
