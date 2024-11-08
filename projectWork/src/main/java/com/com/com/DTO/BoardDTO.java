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
public class BoardDTO {
	private Long seq;
	private String memName;
	private String memId;
	private String boardSubject;
	private String boardContent;
	private Date regDate;
	private Date uptDate;
	private String viewCnt;
	private String useyn;
	
}
