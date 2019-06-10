package bitloco;

import java.io.IOException;

import util.Menu_Inter;
import util.Util;

public class LocoEX {


	public static void main(String[] args) throws IOException {	 
	 MemberLogin bitloco = MemberLogin.getInstance();
	 MenuSelect m = new MenuSelect();


//		member m = new member (null, null); 
//		Set <LoginMember> login = new HashSet ();
    
    	System.out.println("B   I   T   L   O   C   O");
    	System.out.println("-------------------------");
		System.out.println("최상의 서비스를 위해 항상 노력하겠습니다.");
		System.out.println("--------------------------");
		
		
     while(true) {
		System.out.printf("%d. 멤     버    스 \n%d. 회  원  가  입 \n%d. 메  뉴  보  기 \n%d. 종            료\n",Menu_Inter.MEMBERS,Menu_Inter.JOIN,
				Menu_Inter.MENU,Menu_Inter.QUIT);
	    System.out.println("===========================");
	    System.out.print("Select Number:");
		int select = Util.keyboard.nextInt();

		switch (select) {
		case Menu_Inter.MEMBERS:
			bitloco.login();
			break;
			
		case Menu_Inter.JOIN:
			bitloco.joinMember(); 
			break;
			
		case Menu_Inter.MENU:
			m.showMenuPlate();
			break;
			
		case Menu_Inter.QUIT:
			System.out.println();
			System.out.println("  "+bitloco.getTime()+"종료!");
			System.out.println("   이용해주셔서 감사합니다. \n   다음에 또 봐요 :)\n       \t_ BITLOCO");
			return;
			
		default:
			System.out.println("Please, re-select!");
			break;
		
		 }
	  }
   }


	
}