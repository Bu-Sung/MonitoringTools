/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.dto;

import java.util.List;
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
public class ProjectDTO {
    private Long pid;  // 프로젝트 아이디
    private String name;  // 프로젝트 이름
    private String content;  // 프로젝트 설명
    private String start;  // 프로젝트 시작 기간
    private String end;  // 프로젝트 종료 기간
    private String category;  // 게시글 카테고리
    private List<String> categoryList;  // 게시글 카테고리 리스트
    private Long cycle;  // 스프린트 주기
}
