package com.com.com.Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.com.com.DTO.FoodDTO;
import com.com.com.mapper.FoodMapper;

@Service
public class FoodService {
	
	private final FoodMapper foodMapper;
	
	@Autowired
    public FoodService(FoodMapper foodMapper) {
        this.foodMapper = foodMapper;
    }
	
	public List<FoodDTO> getFoodList(){
	        List<FoodDTO> foodList = foodMapper.selectFoodList();
	        return foodList;
	}
	public List<FoodDTO> getKorFoodList(){
        List<FoodDTO> korFoodList = foodMapper.selectKorFoodList();
        return korFoodList;
	}
	public List<FoodDTO> getJpaFoodList(){
        List<FoodDTO> jpaFoodList = foodMapper.selectJpaFoodList();
        return jpaFoodList;
	}
	public List<FoodDTO> getChaFoodList(){
        List<FoodDTO> chaFoodList = foodMapper.selectChaFoodList();
        return chaFoodList;
	}
	public Long CreateFood(FoodDTO foodDTO) {
		Long id = foodMapper.lastFoodSeq();
		foodDTO.setId(id+1);
		Long result = foodMapper.CreateFood(foodDTO);
		return result;
	}
	public FoodDTO ReadFood(Long id) {
		FoodDTO result = foodMapper.ReadFood(id);
		return result;
	}
	public Long UpdateFood(FoodDTO foodDTO) {
		Long result = foodMapper.UpdateFood(foodDTO);
		return result;
	}
	public Long DeleteFood(Long id) {
		Long result = foodMapper.DeleteFood(id);
		return result;
	}
	public void IncreseGood(Long id) {
		foodMapper.increaseGood(id);
	}
	public void DecreseGood(Long id) {
		foodMapper.decreaseGood(id);
	}
	
	
}