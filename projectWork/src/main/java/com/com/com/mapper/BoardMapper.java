package com.com.com.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.com.com.DTO.BoardDTO;
import com.com.com.DTO.UploadDTO;

@Mapper
public interface BoardMapper {
	
	
	public List<BoardDTO> selectBoardList(Map<String,Object> map);
	
	public List<UploadDTO> selectUploadList(Long listSeq);
	
	public int countBoardList(Map<String,Object> map);
	
	
	public Long CreateBoard(BoardDTO boardDTO);
	
	BoardDTO ReadBoard(Long seq);
	
	UploadDTO downloadFile(Long fileSeq);
	
	public int UpdateBoard(BoardDTO boardDTO);
	
	public int DeleteBoard(Long seq);
	
	public void increaseViewCount(Long seq);
	
	public int uploadImage(UploadDTO uploadDTO);
	
	public Long getNextFileSeq();
	
	public Long lastboardSeq();
	
	public Long lastfileSeq();
	
	public Long DeleteFile(Long fileSeq);
}
