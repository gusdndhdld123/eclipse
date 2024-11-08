package com.com.com.DTO;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@Getter
@Setter
@ToString
@NoArgsConstructor
public class PageInfo {
    private int pageIndex; // 현재 페이지
    private int pageSize; // 페이지 사이즈
    private int totalRows; // 전체 row 수
    private int totalPages; // 전체 페이지 수
    private int startPage; // 시작 페이지
    private int endPage; // 종료 페이지

    private static final int BLOCK_SIZE = 5; // 블록 당 페이지 수
   
    public PageInfo(int pageIndex, int pageSize, int totalRows) {
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
        this.totalRows = totalRows;

        // 전체 페이지 수 계산
        this.totalPages = (int) Math.ceil((double) totalRows / pageSize);

        // 현재 페이지가 속한 블록의 시작 페이지와 끝 페이지 계산
        int currentBlock = (int) Math.ceil((double) pageIndex / BLOCK_SIZE);
        this.startPage = (currentBlock - 1) * BLOCK_SIZE + 1;
        this.endPage = Math.min(currentBlock * BLOCK_SIZE, totalPages);
    }
    
    
    
	// 페이지 블록의 첫 페이지를 반환하는 메서드
    public int getBlockStartPage() {
        return (int) Math.ceil((double) pageIndex / BLOCK_SIZE) * BLOCK_SIZE - (BLOCK_SIZE - 1);
    }

    // 페이지 블록의 끝 페이지를 반환하는 메서드
    public int getBlockEndPage() {
        int blockEnd = getBlockStartPage() + BLOCK_SIZE - 1;
        return Math.min(blockEnd, totalPages);
    }
}

