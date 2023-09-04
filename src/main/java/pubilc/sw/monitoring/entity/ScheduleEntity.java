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

/**
 *
 * @author qntjd
 */
@Data
@Entity
@Table(name="schedule")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheduleEntity {
    @Id // Primary Key 지정
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="schedule_id")
    private Long sid; // 일정 아이디
    
    @Column(name="project_id")
    private Long pid; // 프로젝트 아이디 
    
    @Column(name="schedule_alltime")
    private int allTime; // 날짜만 사용하는 일정 : 0, 시간을 사용하면 1
    
    @Column(name="schedule_title")
    private String title; // 제목
    
    @Column(name="schedule_content")
    private String content; // 내용
    
    @Column(name="schedule_start")
    private LocalDateTime start; // 일정 시작일
    
    @Column(name="schedule_end")
    private LocalDateTime end; // 일정 종료일
    
    @Column(name="schedule_color")
    private String color; // 일정 색깔
    
    @Column(name="schedule_member")
    private String member; // 일정 멤버  

}
