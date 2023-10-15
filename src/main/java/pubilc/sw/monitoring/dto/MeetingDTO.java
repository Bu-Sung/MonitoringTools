/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.dto;

import java.time.LocalDateTime;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author qntjd
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MeetingDTO {
    private Long id;
    private int projectId; // 회의록이 작성된 프로젝트 아이디
    private String title; // 회의록 제목
    private String writer; // 회의록 작성자
    private String start; // 회의 시작 시간
    private String end; // 회의 종료 시간
    private String place; // 회의 장소
    private String content; // 회의 내용
    private List<String> files; // 첨부 파일
    private String date; // 작성 날짜
    private List<String> delScheduleList;
    private List<ScheduleDTO> scheduleList;
}
