/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.dto.ScheduleDTO;
import pubilc.sw.monitoring.entity.ScheduleEntity;
import pubilc.sw.monitoring.repository.ScheduleRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class ScheduleService {
    
    private final ScheduleRepository scheduleRepository;
    
    @Value("${date.input.format}")
    private String dateInputFormatter;
    @Value("${date.none.time.format}")
    private String dateFormatter;
    
    public boolean addSchedule(ScheduleDTO scheduleDTO, Long pid){

        DateTimeFormatter InputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);

        ScheduleEntity newEntity = scheduleRepository.save(ScheduleEntity.builder()
                .pid(pid)
                .title(scheduleDTO.getTitle())
                .allTime(scheduleDTO.getAllTime())
                .content(scheduleDTO.getContent())
                .color(scheduleDTO.getColor())
                .start(LocalDateTime.parse(scheduleDTO.getStart(), InputFormatter))
                .end(LocalDateTime.parse(scheduleDTO.getEnd(),InputFormatter))
                .member(scheduleDTO.getMemberList().isEmpty()? "" : String.join(",", scheduleDTO.getMemberList()))
                .build());
        return newEntity != null;
    }
    
    public List<ScheduleDTO> getScheduleList(Long pid){
        
        List<ScheduleDTO> scheduleDTOList = new ArrayList();
        List<ScheduleEntity> scheduleEntitList =  scheduleRepository.findByPid(pid);
        for(ScheduleEntity entity : scheduleEntitList){
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateInputFormatter);
            if(entity.getAllTime() == 0){
                formatter = DateTimeFormatter.ofPattern(dateFormatter);
            }
            scheduleDTOList.add(ScheduleDTO.builder()
                    .sid(entity.getSid())
                    .title(entity.getTitle())
                    .color(entity.getColor())
                    .content(entity.getContent())
                    .allTime(entity.getAllTime())
                    .start(entity.getStart().format(formatter))
                    .end(entity.getEnd().format(formatter))
                    .memberList(Arrays.asList(entity.getMember().split(",")))
                    .build());
        }
        return scheduleDTOList; 
    }
    
    public boolean updateSchedule(ScheduleDTO scheduleDTO, Long pid){

        DateTimeFormatter InputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);

        ScheduleEntity newEntity = scheduleRepository.save(ScheduleEntity.builder()
                .sid(scheduleDTO.getSid())
                .pid(pid)
                .title(scheduleDTO.getTitle())
                .allTime(scheduleDTO.getAllTime())
                .content(scheduleDTO.getContent())
                .color(scheduleDTO.getColor())
                .start(LocalDateTime.parse(scheduleDTO.getStart(), InputFormatter))
                .end(LocalDateTime.parse(scheduleDTO.getEnd(),InputFormatter))
                .member(scheduleDTO.getMemberList().isEmpty()? "" : String.join(",", scheduleDTO.getMemberList()))
                .build());
        return newEntity != null;
    }
    
    public boolean deleteSchedule(Long sid){
        if(scheduleRepository.existsById(sid)){
            scheduleRepository.deleteById(sid);
            return true;
        }
        return false;
    }
}
