package com.com.com.DTO;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class BoardInsertRequestDTO {
    
    private BoardDTO boardDTO;          // Board 정보
    private List<UploadDTO> uploadList; // 여러 개의 Upload 정보
}
