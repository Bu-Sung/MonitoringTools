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
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ScheduleDTO {
    private Long sid; // 일정 아이디
    private int allTime; // 날짜만 사용하는 일정 : 0, 시간을 사용하면 1
    private String title; // 제목
    private String content; // 내용
    private String start; // 일정 시작일
    private String end; // 일정 종료일
    private String color; // 일정 색깔
    private List<String> memberList; // 일정 멤버  
}
