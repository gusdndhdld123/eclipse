package com.com.com.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.BoardResponseDTO;
import com.com.com.DTO.FoodDTO;
import com.com.com.DTO.PageInfo;
import com.com.com.DTO.UploadDTO;
import com.com.com.Service.BoardService;
import com.com.com.Service.FoodService;

import lombok.RequiredArgsConstructor;

@Controller

public class FoodController {
	
	private final FoodService foodService;
    

    @Autowired
    public FoodController(FoodService foodService) {
        this.foodService = foodService;
        
    }

    // 기본 생성자
    public FoodController() {
        this.foodService = null; // 초기화 필요
        
    }
    
    @RequestMapping(value = "/foods")
	@ResponseBody
	public List<FoodDTO> getFoodList() {

    	List<FoodDTO> foodList = foodService.getFoodList();

		return foodList;
	}
    
  
    
    @RequestMapping(value = "/korfoods")
	@ResponseBody
	public List<FoodDTO> getkorFoodList() {

    	List<FoodDTO> korfoodList = foodService.getKorFoodList();

		return korfoodList;
	}
    
    @RequestMapping(value = "/jpafoods")
	@ResponseBody
	public List<FoodDTO> getjpaFoodList() {

    	List<FoodDTO> jpafoodList = foodService.getJpaFoodList();

		return jpafoodList;
	}
    
    @RequestMapping(value = "/chafoods")
	@ResponseBody
	public List<FoodDTO> getchaFoodList() {

    	List<FoodDTO> chafoodList = foodService.getChaFoodList();

		return chafoodList;
	}
    
    @RequestMapping(value = "food/read/{id}")
	@ResponseBody
	public FoodDTO getFoodRead(@PathVariable Long id) {
    	System.out.println(id);
	    FoodDTO foodDTO = foodService.ReadFood(id);
	    System.out.println(foodDTO.toString());
	    return foodDTO;
	}
    
    @RequestMapping(value = "food/insert", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> postFoodCreate(@RequestBody FoodDTO foodDTO) {
    	
    	foodService.CreateFood(foodDTO);
    	
    	return new ResponseEntity<>("음식 추가 완료", HttpStatus.OK); 
    	
	}
    @RequestMapping(value = "food/update/{id}")
	@ResponseBody
	public ResponseEntity<String> postFoodUpdate(@RequestBody FoodDTO foodDTO) {
    	
	   foodService.UpdateFood(foodDTO);
	   
	   return new ResponseEntity<>("음식 업데이트 완료", HttpStatus.OK); 
	}
    @RequestMapping(value = "food/delete/{id}")
	@ResponseBody
	public ResponseEntity<String> postFoodDelete(@PathVariable Long id) {
    	
	   foodService.DeleteFood(id);
	   
	   return new ResponseEntity<>("음식 삭제 완료", HttpStatus.OK);
	}
    @RequestMapping(value = "food/deletes")
    @ResponseBody
    public ResponseEntity<String> foodDeleteList(@RequestBody List<String> idList) {
       
            for (String idStr : idList) {
                Long id = Long.parseLong(idStr); 
                foodService.DeleteFood(id);
            }
            return new ResponseEntity<>("음식 삭제 완료", HttpStatus.OK);
    }

    
    
    
}
