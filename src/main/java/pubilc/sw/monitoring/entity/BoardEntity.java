/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.entity;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;

/**
 *
 * @author qntjd
 * 게시글과 DB를 연결하기 위한 Entity 클래스
 */
@Data
@Entity
@Table(name="board")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardEntity {
    @Id // Primary Key 지정
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="board_id")
    private Long bid; // 게시물 아이디
    
    @Column(name="project_id")
    private Long pid; // 프로젝트 아이디
    
    @Column(name="board_title")
    private String title; // 제목
    
    @Column(name="board_category")
    private String category; // 카테고리
    
    @Column(name="board_content")
    private String content; // 본문 내용
    
    @Column(name="board_writer")
    private String writer; // 작성자
    
    @Column(name="board_date")
    @CreationTimestamp
    private LocalDateTime date; // 작성 날짜
    
    @Column(name="board_filecheck")
    @ColumnDefault("0")
    private int fileCheck; 
}
