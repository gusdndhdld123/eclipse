package com.com.com.Controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.print.attribute.standard.SheetCollate;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.PageInfo;
import com.com.com.DTO.UploadDTO;
import com.com.com.Service.BoardService;
import com.sun.corba.se.spi.orbutil.threadpool.Work;
import com.sun.rowset.internal.Row;

import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Controller



public class FileController {
	
    private final BoardService boardservice;
    
    @Autowired
    public FileController(BoardService boardservice) {
        this.boardservice = boardservice;
       
    }

    

    @RequestMapping(value = "/download/{fileSeq}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Resource> downloadFile(@PathVariable Long fileSeq) throws IOException {
    	
    	System.out.println("컨트롤러로 온 " + fileSeq);
    	
        UploadDTO uploadDTO = boardservice.downloadFile(fileSeq);
        
        System.out.println(uploadDTO.toString());       
        
        FileSystemResource resource = new FileSystemResource(uploadDTO.getSavePath());

        if (resource.exists() && resource.isReadable()) {
        	
            HttpHeaders headers = new HttpHeaders(); // HttpHeaders 객체 생성
            
            String encodedFileName = URLEncoder.encode(uploadDTO.getRealName(), "UTF-8"); // 파일 이름 인코딩
            
            headers.add("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"; filename*=UTF-8''" + encodedFileName); // 문자열로 헤더 설정
            
            // ResponseEntity 반환
            return new ResponseEntity(resource, headers, HttpStatus.OK);
        } else {
            // 파일이 존재하지 않거나 읽을 수 없는 경우
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @RequestMapping(value = "/image/{fileSeq}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Resource> viewImage(@PathVariable Long fileSeq) throws IOException {
       
    	UploadDTO uploadDTO = boardservice.downloadFile(fileSeq);

        FileSystemResource resource = new FileSystemResource(uploadDTO.getSavePath());

        if (resource.exists() && resource.isReadable()) {
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", "image/jpeg"); // 이미지 형식에 맞는 Content-Type 설정
            return new ResponseEntity(resource, headers, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
   



}
