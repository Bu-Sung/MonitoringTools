/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author parkchaebin
 */
@Data
@Entity
@Table(name="request")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RequestEntity {
    
    @Id // Primary Key 지정
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 자동 증가
    @Column(name="full_request_id", nullable = false)
    private Long frid;  // 요구사항 전체 목록 아이디 
    
    @Column(name="project_id", nullable = false)
    private Long pid;  // 프로젝트 아이디 
    
    @Column(name="request_id", nullable = false)
    private String rid;  // 요구사항 아이디 
    
    @Column(name="request_name", nullable = false)
    private String name;  // 요구사항 명 
    
    @Column(name="request_content")
    private String content;  // 요구사항 상세 설명 
    
    @Column(name="request_date", nullable = false)
    private int date;  // 요구사항 추정치 
    
    @Column(name="request_rank", nullable = false)
    private String rank;  // 요구사항 우선 순위 
    
    @Column(name="request_stage", nullable = false)
    private String stage;  // 요구사항 개발 단계 
    
    @Column(name="request_target", nullable = false)
    private String target;  // 요구사항 반복 대상 
    
    @Column(name="user_id", nullable = false)
    private String uid;  // 요구사항 담당자 
    
    @Column(name="request_note")
    private String note;  // 요구사항 비고 
    
}
