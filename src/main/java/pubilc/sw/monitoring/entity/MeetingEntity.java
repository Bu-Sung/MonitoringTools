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
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;

/**
 *
 * @author qntjd
 */
@Data
@Entity
@Table(name="meeting")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MeetingEntity {
    @Id // Primary Key 지정
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="meeting_id")
    private Long id;
    
    @Column(name="project_id")
    private int projectId;
    
    @Column(name="meeting_title")
    private String title;
    
    @Column(name="meeting_writer")
    private String writer;
    
    @Column(name="meeting_start")
    private LocalDateTime start;
    
    @Column(name="meeting_end")
    private LocalDateTime end;
    
    @Column(name="meeting_place")
    private String place;

    @Column(name="meeting_content")
    private String content;

    @Column(name="meeting_filecheck")
    private int fileCheck;
    
    @Column(name="meeting_date")
    @CreationTimestamp
    private LocalDateTime date;
    
}
