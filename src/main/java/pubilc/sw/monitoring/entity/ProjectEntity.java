/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.entity;

import java.util.Date;
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
 * @author parkchaebin
 */
@Data
@Entity
@Table(name="project")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProjectEntity {
    @Id // Primary Key 지정
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 자동 증가
    @Column(name="project_id")
    private Long id; // 프로젝트 아이디
    @Column(name="project_name")
    private String name;  // 프로젝트 이름
    @Column(name="project_content")
    private String content;  // 프로젝트 설명
    @Column(name="project_start")
    private Date start;  // 프로젝트 시작 기간
    @Column(name="project_end")
    private Date end;  // 프로젝트 종료 기간
    @Column(name="project_category")
    private String category;  // 게시글 카테고리
}