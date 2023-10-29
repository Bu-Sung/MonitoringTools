/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.SessionManager;
import pubilc.sw.monitoring.dto.MeetingDTO;
import pubilc.sw.monitoring.dto.ScheduleDTO;
import pubilc.sw.monitoring.service.ProjectService;
import pubilc.sw.monitoring.service.ScheduleService;
import pubilc.sw.monitoring.service.meetingService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/project/meeting")
@RequiredArgsConstructor
public class MeetingController {

    private final SessionManager sessionManager;
    private final meetingService meetingService;
    private final ProjectService projectService;
    private final ScheduleService scheduleService;

    @GetMapping("/list")
    public String meeting(@RequestParam(value = "page", defaultValue = "1") int nowPage, Model model) {
        model.addAttribute("list", meetingService.getMeetingList(sessionManager.getProjectId(), nowPage));
        model.addAttribute("editRight", projectService.hasRight(sessionManager.getUserId(), sessionManager.getProjectId()));
        return "project/meeting/list";
    }

    @GetMapping("/save")
    public String addMeeting() {
        return "project/meeting/save";
    }

    @GetMapping("/update/{mid}")
    public String meetingDetails(@PathVariable Long mid, Model model, RedirectAttributes attrs) {
        try {
            MeetingDTO meetingDTO = meetingService.getMeeting(mid, sessionManager.getProjectId());
            if (meetingDTO == null) {
                attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
                return "redirect:/project/meeting/list";
            }
            model.addAttribute("meeting", meetingDTO);
            model.addAttribute("scheduleList", new ObjectMapper().writeValueAsString(scheduleService.getPageScheduleList(mid)));
        } catch (JsonProcessingException ex) {

        }
        return "project/meeting/details";
    }

    @GetMapping("/{mid}")
    public String meetingDetail(@PathVariable Long mid, Model model, RedirectAttributes attrs) {
        try {
            MeetingDTO meetingDTO = meetingService.getMeeting(mid, sessionManager.getProjectId());
            if (meetingDTO == null) {
                attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
                return "redirect:/project/meeting/list";
            }
            model.addAttribute("meeting", meetingDTO);
            model.addAttribute("editRight", projectService.hasRight(sessionManager.getUserId(), sessionManager.getProjectId()));
            model.addAttribute("scheduleList", new ObjectMapper().writeValueAsString(scheduleService.getPageScheduleList(mid)));
        } catch (JsonProcessingException ex) {

        }
        return "project/meeting/meeting";
    }

    @PostMapping("/addMeeting")
    public String addMeeting(@ModelAttribute MeetingDTO meetingDTO, @RequestParam(name = "file", required = false) List<MultipartFile> file, @RequestParam(name = "scheduleList", required = false) String scheduleJson, RedirectAttributes attrs) {
        ObjectMapper objectMapper = new ObjectMapper();
        List<ScheduleDTO> scheduleList = new ArrayList();
        try {
            scheduleList = objectMapper.readValue(scheduleJson, new TypeReference<List<ScheduleDTO>>() {
            });
            // Schedule DTO 리스트 처리 로직 추가
        } catch (IOException e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
        meetingDTO.setProjectId(sessionManager.getProjectId());
        meetingDTO.setWriter(sessionManager.getUserId());
        if (meetingService.addMeeting(meetingDTO, file, scheduleList)) {
            attrs.addFlashAttribute("msg", "회의록이 등록되었습니다.");
        } else {
            attrs.addFlashAttribute("msg", "회의록 등록에 실패하였습니다.");
        }
        return "redirect:/project/meeting/list";
    }

    // 첨부파일 다운로드
    @GetMapping("/download")
    public ResponseEntity<Resource> download(HttpServletRequest request) {
        return meetingService.downloadFile(request.getParameter("filename"), request.getParameter("mid"));
    }

    @PostMapping("update/update")
    public String updateMeeting(@ModelAttribute MeetingDTO meetingDTO, @RequestParam(name = "file", required = false) List<MultipartFile> files, @RequestParam(name = "scheduleList", required = false) String scheduleJson, HttpServletRequest request, Model model) {
        meetingDTO.setProjectId(sessionManager.getProjectId());
        meetingDTO.setWriter(sessionManager.getUserId());
        ObjectMapper objectMapper = new ObjectMapper();
        List<ScheduleDTO> scheduleList = new ArrayList();
        try {
            scheduleList = objectMapper.readValue(scheduleJson, new TypeReference<List<ScheduleDTO>>() {
            });
            // Schedule DTO 리스트 처리 로직 추가
        } catch (IOException e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
        MeetingDTO meeting = meetingService.updateMeeting(meetingDTO, files, request.getParameter("dellist"), Integer.parseInt(request.getParameter("fileExist")), scheduleList);
        return "redirect:/project/meeting/" + meeting.getId();
    }

    @GetMapping("delete/{mid}")
    public String meetingDelette(@PathVariable Long mid, Model model, RedirectAttributes attrs) {
         MeetingDTO meetingDTO = meetingService.getMeeting(mid, sessionManager.getProjectId());
            if (meetingDTO == null) {
                attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
                return "redirect:/project/meeting/list";
            }
        if (meetingService.deleteMeeintg(mid)) {
            attrs.addFlashAttribute("msg", "회의록이 삭제되었습니다.");
        } else {
            attrs.addFlashAttribute("msg", "회의록 삭제에 실패하였습니다.");
        }
        return "redirect:/project/meeting/list";
    }
}
