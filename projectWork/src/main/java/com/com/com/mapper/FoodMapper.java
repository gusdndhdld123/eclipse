package com.com.com.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;

import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.FoodDTO;

@Mapper
public interface FoodMapper {
    List<FoodDTO> selectFoodList(); 
    List<FoodDTO> selectKorFoodList();
    List<FoodDTO> selectJpaFoodList();
    List<FoodDTO> selectChaFoodList();
    
    public Long CreateFood(FoodDTO foodDTO);
    FoodDTO ReadFood(Long id);
    public Long UpdateFood(FoodDTO foodDTO);
    public Long DeleteFood(Long id);
    public void increaseGood(Long id);
    public void decreaseGood(Long id);
    public Long lastFoodSeq();
}
