/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author parkchaebin
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RequestDTO {
    
    private Long frid;  // 요구사항 전체 목록 아이디 

    private Long pid;  // 프로젝트 아이디 

    private String rid;  // 요구사항 아이디 
    
    private String name;  // 요구사항 명 
    
    private String content;  // 요구사항 상세 설명 

    private int date;  // 요구사항 추정치 
    
    private String rank;  // 요구사항 우선 순위 
    
    private String stage;  // 요구사항 개발 단계 
    
    private String target;  // 요구사항 반복 대상 
    
    private String uid;  // 요구사항 담당자 
    
    private String note;  // 요구사항 비고 
    
    private String username;  // 담당자 이름 
    
}
