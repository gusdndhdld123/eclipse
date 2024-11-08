package com.com.com.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.com.com.DTO.UserDTO;
import com.com.com.mapper.UserMapper;

@Service
public class UserService {
private final UserMapper userMapper;
	
	@Autowired
    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }
	
	public UserDTO login(String userId, String userPw) {
	    UserDTO result1 = userMapper.selectUserId(userId);
	    
	    if(result1 == null) {
	        // 아이디가 없음
	        System.out.println("아이디 조회 실패");
	        return null;
	    } else {
	        String pw = result1.getUserPw();
	        if (!userPw.equals(pw)) { 
	            System.out.println("비밀번호 일치하지 않음");
	            System.out.println("비밀번호 : " + pw);
	            System.out.println("입력한 비밀번호: " + userPw);
	            return null;
	        } else {
	            return result1;
	        }
	    }
	}

	public int SignUp(UserDTO userDTO) {
		int userIdx = userMapper.lastIdx();
		userDTO.setUserIdx(userIdx +1);
		int result = userMapper.signUp(userDTO);
		return result;
	}
	
	
}
