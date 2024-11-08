package com.com.com.Service;


import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import javax.sound.midi.MidiDevice.Info;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.BoardInsertRequestDTO;
import com.com.com.DTO.UploadDTO;
import com.com.com.mapper.BoardMapper;



@Service
public class BoardService {
	
	private final BoardMapper boardmapper;
	
	@Autowired
    public BoardService(BoardMapper boardmapper) {
        this.boardmapper = boardmapper;
    }
	
	public List<BoardDTO> getBoardList(Map<String,Object> map){

        List<BoardDTO> boardList = boardmapper.selectBoardList(map);
        
 
        return boardList;
	}
	
	public int countBoardList(Map<String,Object> map) {
		int countBoardList = boardmapper.countBoardList(map);
		
		
		return countBoardList;
	}
	
	public Long boardInsert(BoardDTO boardDTO) {
	   
	   
	    boardmapper.CreateBoard(boardDTO); // DB에 삽입
        return boardDTO.getSeq(); // 생성된 seq 반환
	   
	}

	public int uploadImage(UploadDTO uploadDTO) {
		int result = boardmapper.uploadImage(uploadDTO);
		return result;
	}
	
	public BoardDTO boardRead(Long seq) {
		
		boardmapper.increaseViewCount(seq);
		
		BoardDTO boardDTO = boardmapper.ReadBoard(seq);
		
		
		return boardDTO;
	}
	
	public UploadDTO downloadFile(Long fileSeq) {
		System.out.println("서비스로 온 fileSeq="+fileSeq);
		UploadDTO uploadDTO = boardmapper.downloadFile(fileSeq);
		return uploadDTO;
	}
	
	public List<UploadDTO>uploadDTOList(Long listSeq){
	 
		return boardmapper.selectUploadList(listSeq);
	}
	
	public int boardUpdate(BoardDTO boardDTO) {
		
		Date uptDate = new Date();
		boardDTO.setUptDate(uptDate);
		int result = boardmapper.UpdateBoard(boardDTO);
		return result;
	}
	
	 public int boardDeleteList(List<Long> checkedBoxList) {
	        int totalDeleted = 0;
	        for (Long seq : checkedBoxList) {
	            totalDeleted += boardmapper.DeleteBoard(seq);
	        }
	        return totalDeleted;
	    }
	 
	 public int boardDelete(Long seq) {
		 
		 int result =boardmapper.DeleteBoard(seq);
		 Long listSeq = seq;
		 boardmapper.DeleteFile(listSeq);
		 return result;
	 }
	 public Long lastboardSeq() {
		 Long result = boardmapper.lastboardSeq();
		 return result;
	 }
	 public Long lastfileSeq() {
		 Long result = boardmapper.lastfileSeq();
		 return result;
	 }
	 
}
