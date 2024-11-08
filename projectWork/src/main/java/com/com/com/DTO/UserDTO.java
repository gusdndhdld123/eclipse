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
public class UserDTO {
	private int userIdx;
	private String userName;
	private String userId;
	private String userPw;
	private String userPhone;
	private String userEmail;
	private String userAddress;
	private String userDetailAddress;
	private String mktEmail;
	private String mktSms;
	private String mktAdr;
}
