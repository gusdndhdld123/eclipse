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
public class UploadDTO {
	
	private Long fileSeq;
	private String realName;
	private String saveName;
	private Date regDate;
	private String savePath;
	private Long listSeq;
	
}