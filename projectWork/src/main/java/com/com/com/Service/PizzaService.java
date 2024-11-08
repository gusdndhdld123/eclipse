package com.com.com.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.com.com.DTO.PizzaDTO;

import com.com.com.mapper.PizzaMapper;

@Service
public class PizzaService {
	private final PizzaMapper pizzaMapper;
	
	@Autowired
    public PizzaService(PizzaMapper pizzaMapper) {
        this.pizzaMapper = pizzaMapper;
    }
	
	public int CreatePizza(PizzaDTO pizzaDTO) {
		int id = pizzaMapper.lastPizzaIdx();
		pizzaDTO.setMenuIdx(id+1);
		int result = pizzaMapper.CreatePizza(pizzaDTO);
		return result;
	}
	public List<PizzaDTO> getPizzaList(){
		
		return pizzaMapper.selectPizzaList();
	}
	public PizzaDTO readPizza(int menuIdx) {
		return pizzaMapper.readPizza(menuIdx);
	}
}
