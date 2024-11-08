package com.com.com.Controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.com.com.DTO.PageInfo;
import com.com.com.DTO.PizzaDTO;
import com.com.com.Service.BoardService;
import com.com.com.Service.PizzaService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PizzaController {
	@Autowired
	private final PizzaService pizzaService;

    // 기본 생성자
    public PizzaController() {
        this.pizzaService = null; // 초기화 필요
        
    }
    
    @RequestMapping(value = "/pizzainsert", method = RequestMethod.GET)
	public String getPizzaInsert(Model model) {

		return "pizzainsert";
	}
    @RequestMapping(value = "/pizzainsert", method = RequestMethod.POST)
	public String postPizzaInsert(PizzaDTO pizzaDTO) {
    	
    	Date regDate = new Date();
    	System.out.println(regDate);
    	System.out.println(pizzaDTO.toString());
    	pizzaDTO.setRegDate(regDate);
    	pizzaService.CreatePizza(pizzaDTO);
		return "redirect:/pizzainsert";
	}
    @RequestMapping(value= "pizzalist")
    @ResponseBody
    public List<PizzaDTO> getPizzaList(){
    	return pizzaService.getPizzaList();
    }
    
    @RequestMapping(value= "/pizza/{menuIdx}", method = RequestMethod.GET)
    @ResponseBody
    public PizzaDTO getPizza(@PathVariable int menuIdx) {
    	System.out.println(menuIdx);
    	
        return pizzaService.readPizza(menuIdx);
    }


}
