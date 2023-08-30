/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.dto.RequestDTO;
import pubilc.sw.monitoring.service.RequestService;

/**
 *
 * @author parkchaebin
 */
@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/project/request")
public class RequestController {

    private final RequestService requestService;

    @Autowired
    private HttpSession session;

    
    @GetMapping("/request")
    public String request(Model model) {
        
        List<RequestDTO> requestDTOs = requestService.getRequests((Long) session.getAttribute("pid"));
        model.addAttribute("requestDTOs", requestDTOs);

        return "project/request/request";
    }
    
    
    // 해당 프로젝트의 모든 요구사항 
    @GetMapping("/getRequests")   
    public @ResponseBody List<RequestDTO> getRequests() {
        return requestService.getRequests((Long) session.getAttribute("pid"));
    }
    
    
    // 요구사항 저장 및 수정 
    @PostMapping("/save")
    public @ResponseBody String saveRequests(@RequestBody List<RequestDTO> requestDTOList, RedirectAttributes attrs) {
        
        for (RequestDTO requestDTO : requestDTOList) {
            requestDTO.setPid((Long) session.getAttribute("pid"));
        }
        
        if(requestService.saveRequests(requestDTOList)){
            attrs.addFlashAttribute("msg", "요구사항 저장 성공하였습니다.");
        } else{
            attrs.addFlashAttribute("msg", "요구사항 저장 실패하였습니다.");
        }

        return "redirect:/project/request/request";
    }
    
    
    // 요구사항 삭제 
    @PostMapping("/delete")
    public @ResponseBody String deleteRequest(@RequestParam("frid") Long frid, RedirectAttributes attrs) {

        if (requestService.deleteRequestByFrid(frid)) {
            attrs.addFlashAttribute("msg", "요구사항 삭제 성공하였습니다.");
        } else {
            attrs.addFlashAttribute("msg", "요구사항 삭제 실패하였습니다.");
        }
        
        return "redirect:/project/request/request";
    }
    
    
    // 해당 프로젝트의 모든 요구사항 삭제 
    @PostMapping("/deleteAll")
    public @ResponseBody String deleteRequestsByPid(RedirectAttributes attrs) {

        if (requestService.deleteRequestsByPid((Long) session.getAttribute("pid"))) {
            attrs.addFlashAttribute("msg", "요구사항 전체 삭제 성공하였습니다.");
        } else {
            attrs.addFlashAttribute("msg", "요구사항 전체 삭제 실패하였습니다.");
        }
        
        return "redirect:/project/request/request";
    }


}
