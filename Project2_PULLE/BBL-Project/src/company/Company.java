package company;

public class Company {
	
	private String company_ID; // varchar (50)
	private String company_Pw; // varchar (30)
	private String company_Name; // varchar (50)
	private String company_Email; // varchar (40)
	private String company_Num; // varchar (20)
	private String company_Memo; // varchar(1000)

	
	public Company() {}


	public String getCompany_ID() {
		return company_ID;
	}


	public void setCompany_ID(String company_ID) {
		this.company_ID = company_ID;
	}


	public String getCompany_Pw() {
		return company_Pw;
	}


	public void setCompany_Pw(String company_Pw) {
		this.company_Pw = company_Pw;
	}


	public String getCompany_Name() {
		return company_Name;
	}


	public void setCompany_Name(String company_Name) {
		this.company_Name = company_Name;
	}

	
	
	public String getCompany_Email() {
		return company_Email;
	}


	public void setCompany_Email(String company_Email) {
		this.company_Email = company_Email;
	}


	public String getCompany_Num() {
		return company_Num;
	}


	public void setCompany_Num(String company_Num) {
		this.company_Num = company_Num;
	}


	public String getCompany_Memo() {
		return company_Memo;
	}


	public void setCompany_Memo(String company_Memo) {
		this.company_Memo = company_Memo;
	}

	
	
	
}
