package com.com.com.Controller;



import java.awt.RenderingHints.Key;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.print.attribute.standard.SheetCollate;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.BoardInsertRequestDTO;
import com.com.com.DTO.BoardResponseDTO;
import com.com.com.DTO.PageInfo;
import com.com.com.DTO.UploadDTO;
import com.com.com.Service.BoardService;
import com.sun.rowset.internal.Row;

import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;



@Controller
@RequiredArgsConstructor

public class BoardController {
	
	private final BoardService boardservice;
    private final PageInfo pageInfo; 
    
    
    private String path="C:/uploadFile/";
    
    @Autowired
    public BoardController(BoardService boardservice) {
        this.boardservice = boardservice;
        this.pageInfo = new PageInfo(0,0,0); // 또는 다른 방식으로 초기화
    }

    // 기본 생성자
    public BoardController() {
        this.boardservice = null; // 초기화 필요
        this.pageInfo = new PageInfo(0,0,0); // 또는 다른 방식으로 초기화
    }
	
	@RequestMapping(value = "/list")
	public String getBoardList(@RequestParam Map<String,Object> map, Model model) {
		
		
		if(map.isEmpty()) {
			map.put("pageIndex", 1);
			map.put("pageSize", 10);
			
		}
		
		int pageIndex = map.get("pageIndex") == null ? 1 : Integer.parseInt(map.get("pageIndex").toString());
		int pageSize = 10;
        int totalRows = boardservice.countBoardList(map);

        
        PageInfo pageInfo = new PageInfo(pageIndex, pageSize, totalRows);
        
        
	    List<BoardDTO> boardList = boardservice.getBoardList(map);
	   
	    
		model.addAttribute("boardList", boardList);
		model.addAttribute("map", map);
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}
	
	@RequestMapping(value = "/list2")
	@ResponseBody
	public List<BoardDTO> boardList(@RequestParam Map<String,Object> map, Model model) {
		
		
		if(map.isEmpty()) {
			map.put("pageIndex", 1);
			map.put("pageSize", 10);
			
		}
		
		int pageIndex = map.get("pageIndex") == null ? 1 : Integer.parseInt(map.get("pageIndex").toString());
		int pageSize = 10;
        int totalRows = boardservice.countBoardList(map);

        
        PageInfo pageInfo = new PageInfo(pageIndex, pageSize, totalRows);
        
        
	    List<BoardDTO> boardList = boardservice.getBoardList(map);
	   
	    
		model.addAttribute("boardList", boardList);
		model.addAttribute("map", map);
		model.addAttribute("pageInfo", pageInfo);
		
		return boardList;
	}

	
	@RequestMapping(value = "/list1", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getBoardList1(@RequestBody Map<String, Object> map) {
	    
	    if (map.isEmpty()) {
	        map.put("pageIndex", 1);
	        map.put("pageSize", 10);
	    } else {
	        System.out.println("map으로 받음: " + map.toString());
	    }

	    int pageIndex = map.get("pageIndex") == null || map.get("pageIndex").toString().isEmpty() ? 1 : Integer.parseInt(map.get("pageIndex").toString());

	    int pageSize = map.get("pageSize") == null || map.get("pageSize").toString().isEmpty() ? 10 : Integer.parseInt(map.get("pageSize").toString());
	    
	    int totalRows = boardservice.countBoardList(map);

	    
	    PageInfo pageInfo = new PageInfo(pageIndex, pageSize, totalRows);
	    System.out.println(pageInfo.toString());

	    
	    List<BoardDTO> boardList = boardservice.getBoardList(map);

	    // 클라이언트에 반환할 데이터 구성
	    Map<String, Object> response = new HashMap<>();
	    response.put("boardList", boardList);
	    response.put("pageInfo", pageInfo);

	    // JSON 형식으로 반환
	    return response;
	}

	
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String getBoardInsert(Model model) {
		
		
		return "insert";
	}
	
	
	 @RequestMapping(value = "/insert", method = RequestMethod.POST)
	   
	 public String postBoardInsert(@ModelAttribute BoardDTO boardDTO, MultipartHttpServletRequest mReq) {
		  
		  
		  String uploadpath = path;
		  
	      Date regDate = new Date();
	      
	      System.out.println(boardDTO.toString());
	      
	      List<MultipartFile> files = mReq.getFiles("file"); // 'file'은 input name 속성 값
	      
	      System.out.println(files + " + 파일정보");
	      
	      boardDTO.setRegDate(regDate);
	      boardDTO.setViewCnt("0");
	      Long lastboardSeq = boardservice.lastboardSeq();
	      boardDTO.setSeq(lastboardSeq + 1);
	      
	      boardservice.boardInsert(boardDTO);
	      
	      System.out.println("생성된 seq: " + lastboardSeq + 1); // seq 출력
	      
	   // 파일 처리 로직
	      for (MultipartFile file : files) {
	          if (!file.isEmpty()) {
	              try {
	                  // 원본 파일 이름
	                  String originalFileName = file.getOriginalFilename();
	                  String uuid = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 8);

	                  // 저장할 파일의 경로를 설정.
	                  String uploadPath = path; 
	                  String filePath = uploadPath + uuid +originalFileName;
	                  
	                  // 해당 경로에 폴더가 존재하는지 확인하고, 없으면 생성합니다.
	                  File directory = new File(uploadPath);
	                  if (!directory.exists()) {
	                      directory.mkdirs(); // 디렉토리 생성
	                  }
	                  
	                  // 파일을 해당 경로에 저장합니다.
	                  File dest = new File(filePath);
	                  file.transferTo(dest); // 파일 저장
	                  
	                  System.out.println("파일 저장 완료: " + filePath);
	                  
	                  UploadDTO uploadDTO = new UploadDTO();
	                  uploadDTO.setListSeq(lastboardSeq + 1);
	                  uploadDTO.setRealName(originalFileName);
	                  uploadDTO.setRegDate(regDate);
	                  uploadDTO.setSaveName(uuid + originalFileName);
	                  uploadDTO.setSavePath(filePath);
	                  
	                  Long lastfileseq = boardservice.lastfileSeq();
	                  
	                  uploadDTO.setFileSeq(lastfileseq + 1);
	                 
	                  
	                  System.out.println(uploadDTO.toString() + "+uploadDTO의 정보");
	                  boardservice.uploadImage(uploadDTO);
	                  
	              } catch (IOException e) {
	                  e.printStackTrace();
	                  System.out.println("파일 저장 중 오류 발생: " + e.getMessage());
	              }
	          }
	      }

	 
	      return "redirect:/list";
	  }
	
	@RequestMapping(value = "/read/{seq}", method = RequestMethod.GET)
	@ResponseBody
	public BoardResponseDTO getBoardRead(@PathVariable Long seq) {
	    BoardDTO boardDTO = boardservice.boardRead(seq);
	    
	    Long listSeq = seq;
	    
	    List<UploadDTO> uploadDTOList = boardservice.uploadDTOList(listSeq);
	    
	    
	    
	    return new BoardResponseDTO(boardDTO, uploadDTOList); // Spring은 자동으로 객체를 JSON으로 변환
	}
	
	

	@RequestMapping(value = "/update/{seq}", method = RequestMethod.GET)
	@ResponseBody
	public BoardDTO getBoardUpdate(@PathVariable Long seq, Model model) {
		
		BoardDTO boardDTO = boardservice.boardRead(seq);
	    return boardDTO;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String postBoardUpdate(BoardDTO boardDTO) {
		
		
	    boardservice.boardUpdate(boardDTO);
		
	    return "redirect:/list";
	}
	
	@RequestMapping(value = "/delete/{seq}", method = RequestMethod.POST)
	@ResponseBody
	public String postBoardDelete(@PathVariable Long seq) {
		
		
	    boardservice.boardDelete(seq);
		
	    return "redirect:/list";
	}
	
	@RequestMapping(value = "/deletelist", method = RequestMethod.POST)
	@ResponseBody
	public void boardDeleteList(@RequestBody List<String> seqList, HttpServletResponse response) {
		try {
            // 리스트를 순회하며 삭제 작업 수행
            for (String seq : seqList) {
            	Long seq1 = new Long(seq);
            	System.out.println(seq);
                boardservice.boardDelete(seq1);
            }
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("삭제 완료");
        } catch (Exception e) {
            e.printStackTrace();
            try {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("삭제 실패");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
    
        }
	}
	
	@RequestMapping(value = "/excel")
	public String getExcel(@RequestParam Map<String, Object> map, Model model){
	    // 기본 페이지 설정
	    if (map.isEmpty()) {
	        map.put("pageIndex", 1);
	        map.put("pageSize", 10);
	    }

	    int pageIndex = map.get("pageIndex") == null ? 1 : Integer.parseInt(map.get("pageIndex").toString());
	    int pageSize = 10;
	    int totalRows = boardservice.countBoardList(map);

	    PageInfo pageInfo = new PageInfo(pageIndex, pageSize, totalRows);
	    List<BoardDTO> boardList = boardservice.getBoardList(map);
	    System.out.println(boardList.toString());
	    
	   
	    model.addAttribute("boardList", boardList);
		model.addAttribute("map", map);
		model.addAttribute("pageInfo", pageInfo);
	    return "/download";
	    

	}
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String condingTest() {
		
		
		return "test";
	}
}

