package com.com.com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.com.com.DTO.PizzaDTO;



@Mapper
public interface PizzaMapper {
	
	public int CreatePizza(PizzaDTO pizzaDTO); 
	public int lastPizzaIdx();
	List<PizzaDTO> selectPizzaList();
	public PizzaDTO readPizza(int menuIdx); 
}
