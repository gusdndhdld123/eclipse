package com.com.com.Controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.PageInfo;
import com.com.com.Service.BoardService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nexacro.java.xapi.data.DataSet;
import com.nexacro.java.xapi.data.DataTypes;
import com.nexacro.java.xapi.data.PlatformData;
import com.nexacro.java.xapi.data.VariableList;
import com.nexacro.java.xapi.data.datatype.DataType;
import com.nexacro.java.xapi.tx.HttpPlatformRequest;
import com.nexacro.java.xapi.tx.HttpPlatformResponse;
import com.nexacro.java.xapi.tx.PlatformException;
import com.nexacro.java.xapi.tx.PlatformType;

@Controller
@RequestMapping("/api")
public class ApiController {
	
    private final BoardService boardService;

    @Autowired
    public ApiController(BoardService boardService) {
        this.boardService = boardService;
    }

    @RequestMapping(value = "/list")
    @ResponseBody
    public void getBoardList(
            @RequestParam Map<String, Object> map,
            HttpServletRequest request,
            HttpServletResponse response
           )  throws PlatformException {
    	
    	
    }
    
    @RequestMapping(value = "/delete")
    public void deleteBoard(
            HttpServletRequest request,
            HttpServletResponse response)  throws PlatformException{
    	
    	HttpPlatformRequest req = new HttpPlatformRequest(request);
    	req.receiveData();
    	
    	PlatformData platformData = req.getData();
    	
    	VariableList variableList = platformData.getVariableList();

        variableList.add("ErrorCode", 0);
        variableList.add("ErrorMsg", "SUCC");
    	
    	String seqString = variableList.getString("seq");
    	Long seq = Long.parseLong(seqString); // 문자열을 Long으로 변환
    	
    	System.out.println(seq);
    	
    	
        HttpPlatformResponse res = new HttpPlatformResponse(response, 
            req);
    	
    	
    	
        boardService.boardDelete(seq);
        
        res.setData(platformData);
        
         
        try {
            res.sendData();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @RequestMapping(value = "/update")
    @ResponseBody
    public void BoardUpdate(
            @RequestParam Map<String, Object> map,
            HttpServletRequest request,
            HttpServletResponse response)  throws PlatformException{
    	
    	HttpPlatformRequest req = new HttpPlatformRequest(request);
    	req.receiveData();
    	
    	PlatformData platformData = req.getData();
    	
    	VariableList variableList = platformData.getVariableList();

        variableList.add("ErrorCode", 0);
        variableList.add("ErrorMsg", "업데이트 완료!");
    	
    	DataSet ds = platformData.getDataSet("updateData");
    	
    	Long seq = ds.getLong(0, "seq");
    	String memId = ds.getString(0, "memId");
    	String boardSubject= ds.getString(0, "boardSubject");
    	String boardContent= ds.getString(0, "boardContent");
    	
    	System.out.println(seq + "콘트롤러에서 추출한 seq");
    	
    	BoardDTO boardDTO = new BoardDTO();
    	
    	boardDTO.setSeq(seq);
    	boardDTO.setMemId(memId);
    	boardDTO.setBoardSubject(boardSubject);
    	boardDTO.setBoardContent(boardContent);
    	
    	
    	boardService.boardUpdate(boardDTO);
    	
    	HttpPlatformResponse res = new HttpPlatformResponse(response, 
    	            req);
    	
    	res.setData(platformData);
         
         
        try {
            res.sendData();
             
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
