/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.dto.MeetingDTO;
import pubilc.sw.monitoring.service.meetingService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/projectMeeting")
@RequiredArgsConstructor
public class MeetingController {
    
    private final meetingService meetingService; // UserService 클래스 사용을 위한 변수
    
    @GetMapping("/meeting")
    public String meeting(){
        return "projectMeeting/meeting";
    }
    
    @GetMapping("/meetingSave")
    public String meetingRegister(){
        return "projectMeeting/meetingSave";
    }
    
    @PostMapping("/addMeeting")
    public String addMeeting(@ModelAttribute MeetingDTO meetingDTO, @RequestParam(name="file") List<MultipartFile> file, RedirectAttributes attrs){
        if(meetingService.addMeeting(meetingDTO, file)){
            attrs.addFlashAttribute("msg", "회의록이 등록되었습니다.");
        }else{
            attrs.addFlashAttribute("msg", "회의록 등록에 실패하였습니다.");
        }
        return "redirect:/projectMeeting/meeting";
    }
}
