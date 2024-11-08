package com.com.com.Controller;

import java.util.HashMap;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.com.com.DTO.UserDTO;
import com.com.com.Service.UserService;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor


public class UserController {
	
	@Autowired
	private final UserService userService;
	
	public UserController() {
        this.userService = null; // 초기화 필요
        
    }
	@RequestMapping(value = "/user/signup", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> signUp(@RequestBody UserDTO userDTO) {
		
	    System.out.println("수신된 UserDTO 데이터: " + userDTO.toString());
	    
	    userService.SignUp(userDTO);
	    return new ResponseEntity<>("회원가입 완료", HttpStatus.OK); 
	}

	
	@RequestMapping(value = "/user/login", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<?> login(@RequestBody Map<String, String> map) {
	    String userId = map.get("userId");
	    String userPw = map.get("userPw");
	    
	    UserDTO result = userService.login(userId, userPw);
	    
	    if (result == null) {
	        // 로그인 실패 시 명확한 응답을 반환
	    	Map<String, String> errorResponse = new HashMap<String, String>();

	        errorResponse.put("message", "로그인 실패: 잘못된 사용자 ID 또는 비밀번호입니다.");
	        return new ResponseEntity<>(errorResponse, HttpStatus.UNAUTHORIZED);
	    }
	    
	    // 로그인 성공 시 유저 정보 반환
	    return new ResponseEntity<>(result, HttpStatus.OK);
	}

}
