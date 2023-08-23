/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
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
import pubilc.sw.monitoring.dto.MeetingDTO;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.service.meetingService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/project/meeting")
@RequiredArgsConstructor
public class MeetingController {
    
    @Autowired
    private HttpSession session;
    
    private final meetingService meetingService; // UserService 클래스 사용을 위한 변수
    
    @GetMapping("/list")
    public String meeting(@RequestParam(value = "page", defaultValue = "1") int nowPage,Model model){
        model.addAttribute("meetingList", meetingService.getMeetingList((Long)session.getAttribute("pid"), nowPage));
        return "project/meeting/list";
    }
    
    @GetMapping("/save")
    public String meetingRegister(){
        return "project/meeting/save";
    }
    
    @GetMapping("/{mid}")
    public String meetingDetail(@PathVariable Long mid, Model model){
        model.addAttribute("meeting", meetingService.getMeeting(mid));
        return "project/meeting/meeting";
    }
    
    @PostMapping("/addMeeting")
    public String addMeeting(@ModelAttribute MeetingDTO meetingDTO, @RequestParam(name="file", required=false) List<MultipartFile> file, RedirectAttributes attrs){
        Long pid = (Long)session.getAttribute("pid");
        UserDTO user = (UserDTO) session.getAttribute("user");
        meetingDTO.setProjectId(pid.intValue());
        meetingDTO.setWriter(user.getName());
        if(meetingService.addMeeting(meetingDTO, file)){
            attrs.addFlashAttribute("msg", "회의록이 등록되었습니다.");
        }else{
            attrs.addFlashAttribute("msg", "회의록 등록에 실패하였습니다.");
        }
        return "redirect:/project/meeting/list";
    }
}
