/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.dto.ScheduleDTO;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.entity.ScheduleEntity;
import pubilc.sw.monitoring.repository.ScheduleRepository;
import pubilc.sw.monitoring.repository.UserRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;
    private final UserRepository userRepository;

    @Value("${date.input.format}")
    private String dateInputFormatter;
    @Value("${date.output.format}")
    private String dateOutputFormatter;
    @Value("${date.none.time.format}")
    private String dateFormatter;

    public boolean addSchedule(ScheduleDTO scheduleDTO, Long pid) {

        DateTimeFormatter InputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);
        if (!scheduleDTO.getStart().contains("T") && !scheduleDTO.getEnd().contains("T")) {
            scheduleDTO.setStart(scheduleDTO.getStart() + "T00:00");
            scheduleDTO.setEnd(scheduleDTO.getEnd() + "T00:00");
        }
        ScheduleEntity newEntity = scheduleRepository.save(ScheduleEntity.builder()
                .pid(pid)
                .title(scheduleDTO.getTitle())
                .allTime(scheduleDTO.getAllTime())
                .content(scheduleDTO.getContent())
                .color(scheduleDTO.getColor())
                .start(LocalDateTime.parse(scheduleDTO.getStart(), InputFormatter))
                .end(LocalDateTime.parse(scheduleDTO.getEnd(), InputFormatter))
                .member(scheduleDTO.getMemberList().isEmpty() ? "" : String.join(",", scheduleDTO.getMemberList()))
                .mid(0L)
                .msid(-1L)
                .build());
        return newEntity != null;
    }

    public List<ScheduleDTO> getScheduleList(Long pid) {

        List<ScheduleDTO> scheduleDTOList = new ArrayList();
        List<ScheduleEntity> scheduleEntitList = scheduleRepository.findByPid(pid);
        for (ScheduleEntity entity : scheduleEntitList) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateInputFormatter);
            if (entity.getAllTime() == 0) {
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
                    .mid(entity.getMid())
                    .msid(entity.getMsid())
                    .build());
        }
        return scheduleDTOList;
    }

    public boolean updateSchedule(ScheduleDTO scheduleDTO, Long pid) {

        DateTimeFormatter InputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);

        ScheduleEntity newEntity = scheduleRepository.save(ScheduleEntity.builder()
                .sid(scheduleDTO.getSid())
                .pid(pid)
                .title(scheduleDTO.getTitle())
                .allTime(scheduleDTO.getAllTime())
                .content(scheduleDTO.getContent())
                .color(scheduleDTO.getColor())
                .start(LocalDateTime.parse(scheduleDTO.getStart(), InputFormatter))
                .end(LocalDateTime.parse(scheduleDTO.getEnd(), InputFormatter))
                .member(scheduleDTO.getMemberList().isEmpty() ? "" : String.join(",", scheduleDTO.getMemberList()))
                .msid(scheduleDTO.getMsid())
                .mid(scheduleDTO.getMid())
                .build());
        return newEntity != null;
    }

    public boolean deleteSchedule(Long sid) {
        if (scheduleRepository.existsById(sid)) {
            scheduleRepository.deleteById(sid);
            return true;
        }
        return false;
    }

    public List<UserDTO> getScheduleMembers(Long sid) {
        List<Map<String, Object>> members = userRepository.findUsersBySid(sid);

        List<UserDTO> uidList = new ArrayList<>();

        for (Map<String, Object> user : members) {
            uidList.add(UserDTO.builder()
                    .id(user.get("id").toString())
                    .name(user.get("name").toString())
                    .build());
        }
        return uidList;
    }

    /**
     * 자신이 관련된 오늘 일정을 가져온다.
     *
     * @param pid 프로젝트 아이디
     * @param uid 사용자 아이디
     * @return 자신이 태그된 일정 목록
     */
    public List<ScheduleDTO> findSchedules(Long pid, String uid) {
        List<ScheduleEntity> entityList = scheduleRepository.findSchedules(pid);
        List<ScheduleDTO> dtoList = new ArrayList();

        for (ScheduleEntity entity : entityList) {
            if (entity.getMember().contains(uid)) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
                if (entity.getAllTime() == 0) {
                    formatter = DateTimeFormatter.ofPattern(dateFormatter);
                }
                dtoList.add(ScheduleDTO.builder()
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
        }
        return dtoList;
    }

    public boolean addScheduleList(List<ScheduleDTO> scheduleDTOS, Long id, Long pid) {
        DateTimeFormatter InputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);
        List<ScheduleEntity> scheduleEntitys = new ArrayList();
        List<ScheduleEntity> newEntitys;
        try {
            for (ScheduleDTO s : scheduleDTOS) {
                if (!s.getStart().contains("T") && !s.getEnd().contains("T")) {
                    s.setStart(s.getStart() + "T00:00");
                    s.setEnd(s.getEnd() + "T00:00");
                }
                scheduleEntitys.add(ScheduleEntity.builder()
                        .pid(pid)
                        .title(s.getTitle())
                        .allTime(s.getAllTime())
                        .content(s.getContent())
                        .color(s.getColor())
                        .start(LocalDateTime.parse(s.getStart(), InputFormatter))
                        .end(LocalDateTime.parse(s.getEnd(), InputFormatter))
                        .member(s.getMemberList().isEmpty() ? "" : String.join(",", s.getMemberList()))
                        .mid(id)
                        .msid(s.getMsid())
                        .build());
            }

            newEntitys = (List<ScheduleEntity>) scheduleRepository.saveAll(scheduleEntitys);
        } catch (Exception e) {
            newEntitys = new ArrayList();
        }

        return !newEntitys.isEmpty();
    }

    /**
     * 페이지 내에 있는 일정을 모두 가져온다.
     *
     * @param id 페이지 번호
     * @return 페이지 내 일정 리스트
     */
    public List<ScheduleDTO> getPageScheduleList(Long id) {
        List<ScheduleDTO> scheduleDTOS = new ArrayList();
        List<ScheduleEntity> scheduleEntitys = scheduleRepository.findByMid(id);
        DateTimeFormatter formatter;
        for (ScheduleEntity s : scheduleEntitys) {
            formatter = DateTimeFormatter.ofPattern(dateInputFormatter);
            if (s.getAllTime() == 0) {
                formatter = DateTimeFormatter.ofPattern(dateFormatter);
            }
            scheduleDTOS.add(ScheduleDTO.builder()
                    .sid(s.getSid())
                    .title((s.getTitle().isEmpty()) ? "" : s.getTitle())
                    .color(s.getColor())
                    .content((s.getContent().isEmpty()) ? "" : s.getContent())
                    .allTime(s.getAllTime())
                    .start(s.getStart().format(formatter))
                    .end(s.getEnd().format(formatter))
                    .memberList(Arrays.asList(s.getMember().split(",")))
                    .mid(s.getMid())
                    .msid(s.getMsid())
                    .build());
        }
        return scheduleDTOS;
    }

    public boolean deletePageSchedule(Long mid) {
        if (scheduleRepository.existsByMid(mid)) {
            scheduleRepository.deleteByMid(mid);
            return true;
        } else {
            return false;
        }
    }

    public boolean updatePageSchdule(Long id, List<ScheduleDTO> scheduleDTOS, Long pid) {
        DateTimeFormatter InputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);
        List<ScheduleEntity> scheduleEntitys = new ArrayList();
        List<ScheduleEntity> newEntitys;
        try {
            for (ScheduleDTO s : scheduleDTOS) {
                if (!s.getStart().contains("T") && !s.getEnd().contains("T")) {
                    s.setStart(s.getStart() + "T00:00");
                    s.setEnd(s.getEnd() + "T00:00");
                }
                scheduleEntitys.add(ScheduleEntity.builder()
                        .sid(s.getSid() == 0 ? null : s.getSid())
                        .pid(pid)
                        .title(s.getTitle())
                        .allTime(s.getAllTime())
                        .content(s.getContent())
                        .color(s.getColor())
                        .start(LocalDateTime.parse(s.getStart(), InputFormatter))
                        .end(LocalDateTime.parse(s.getEnd(), InputFormatter))
                        .member((!s.getMemberList().isEmpty() && s.getMemberList().get(0) != null) ? String.join(",", s.getMemberList()) : "")
                        .mid(id)
                        .msid(s.getMsid())
                        .build());
            }
            newEntitys = (List<ScheduleEntity>) scheduleRepository.saveAll(scheduleEntitys);
        } catch (Exception e) {
            newEntitys = new ArrayList();
        }
        if (!newEntitys.isEmpty()) {
            Set<Long> updatedIds = newEntitys.stream()
                    .map(ScheduleEntity::getSid)
                    .collect(Collectors.toSet());
            scheduleRepository.deleteAllExceptIds(updatedIds, id);
        }
        return !newEntitys.isEmpty();
    }
}
