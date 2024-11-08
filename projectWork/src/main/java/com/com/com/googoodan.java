package com.com.com;

public class googoodan {

	public static void main(String[] args) {
		for(int i = 1; i<6; i++) {
			for(int dan = 2; dan<10; dan++) {
				if(dan%2==0) {//짝수면
					System.out.print(dan +  " x " + i + " = " + dan*i + "\t");
				}
				else {//홀수면
					if(i < 5) {//9단까지
						System.out.print(dan +  " x " + (i+5) + " = " + dan*(i+5) + "\t");
						
					}else {
						System.out.print("\t"); //10단은 없으니 빈칸 만들어주기
						System.out.print("\t");
					}
					
				}
			}System.out.println(); //한 번 돌리고 다음 줄은 엔터
		}
	}
}