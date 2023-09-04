/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pubilc.sw.monitoring.SessionManager;
import pubilc.sw.monitoring.dto.ScheduleDTO;
import pubilc.sw.monitoring.service.ScheduleService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/project/schedule")
@RequiredArgsConstructor
public class ScheduleController {
    
    private final SessionManager sessionManager;
    private final ScheduleService scheduleService;
    
    @GetMapping("")
    public String getCalendar(){
        return "/project/schedule/calendar";
    }
    
    @PostMapping("/addSchedule")
    public @ResponseBody boolean addCaledar(@RequestBody ScheduleDTO scheduleDTO){
        System.out.println(scheduleDTO);
        if(!scheduleDTO.getStart().contains("T") && !scheduleDTO.getEnd().contains("T")){
            scheduleDTO.setStart(scheduleDTO.getStart() + "T00:00");
            scheduleDTO.setEnd(scheduleDTO.getEnd() + "T00:00");
        }
        System.out.println(scheduleDTO.getStart());
        System.out.println(scheduleDTO.getEnd());
        return scheduleService.addSchedule(scheduleDTO, sessionManager.getProjectId());
    }
    
    @GetMapping("/getScheduleList")
    public @ResponseBody List<ScheduleDTO> getScheduleList(){
        return scheduleService.getScheduleList(sessionManager.getProjectId());
    }
}
