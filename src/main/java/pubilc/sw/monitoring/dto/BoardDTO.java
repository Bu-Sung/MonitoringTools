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
 * @author qntjd
 * 게시글의 정보를 전달하기위한 DTO클래스
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardDTO {
    private Long bid; // 게시물 아이디
    private int pid;
    private String writer; // 작성자
    private String title; // 제목
    private String content; // 본문 내용
    private String date; // 작성 날짜
    private String category;
    private List<String> files; // 파일명
}
