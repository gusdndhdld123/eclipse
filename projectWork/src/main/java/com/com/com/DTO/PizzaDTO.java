package com.com.com.DTO;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class PizzaDTO {
	private int menuIdx; //pk
	private String menuName;//메뉴명
	private String subTitle;
	private String menuImg1;//메뉴 메인 이미지 링크
	private String menuImg2;//메뉴 메인 이미지 링크
	private String menuImg3;//메뉴 메인 이미지 링크
	private int menuPriceS;// 메뉴 가격S
	private int menuPriceM;// 메뉴 가격M
	private int menuPriceL;// 메뉴 가격L
	private String menuDiscription;//메뉴 설명 멘트
	private String menuDough; //도우
	private String menuEdge; //엣지
	private char menuType; //(S:시그니처/P:프리미엄/C:클래식/O: other)
	private char menuSet; //세트메뉴 여부 Y/N
	private char menuSide; //사이드메뉴 여부 Y/N
	private String detailImg; //메뉴 눌렀을 때 상세페이지에 보여줄 이미지 링크
	private int withGood; // 함께하면 좋은 메뉴를 메뉴idx로 한 필드에 쉬표로 구분, 여러 개 넣기
	private Date regDate;
}
