package com.com.com.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.com.com.DTO.UserDTO;

@Mapper
public interface UserMapper {
	UserDTO selectUserId(@Param("userId")String userId);
	UserDTO selectUserPw(@Param("userPw") String userPw,@Param("userIdx") int userIdx);
	UserDTO selectUserIdx(@Param("userIdx")int UserIdx);
	public int signUp(UserDTO userDTO);
	public int lastIdx();
}
