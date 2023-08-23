/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pubilc.sw.monitoring.dto.MeetingDTO;
import pubilc.sw.monitoring.entity.MeetingEntity;
import pubilc.sw.monitoring.repository.MeetingRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class meetingService {
    
    private final MeetingRepository meetingRepository;
    private final FileService fileService;
    
    @Value("${meeting.attachment.folder}")
    private String attachmentFolderPath; // meeting안 회의록 첨부 파일 폴더 명
    @Value("${date.input.format}")
    private String dateInputFormatter;
    @Value("${date.output.format}")
    private String dateOutFormatter;
     @Value("${page.limit}")
    private int pageLimit;
    
    public boolean addMeeting(MeetingDTO meetingDTO, List<MultipartFile> files){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateInputFormatter);
        
        MeetingEntity newEntity = meetingRepository.save(MeetingEntity.builder()
                .projectId(meetingDTO.getProjectId())
                .title(meetingDTO.getTitle())
                .writer(meetingDTO.getWriter())
                .start(LocalDateTime.parse(meetingDTO.getStart(),formatter))
                .end(LocalDateTime.parse(meetingDTO.getEnd(),formatter))
                .place(meetingDTO.getPlace())
                .content(meetingDTO.getContent())
                .filecheck(files.get(0).isEmpty() ? 0 : 1)
                .build());
        if(newEntity !=  null){
            if(newEntity.getFilecheck() == 1){
                for(MultipartFile file : files){
                    fileService.saveFile(attachmentFolderPath, Long.toString(newEntity.getId()), file);
                }
            }
        }
        return true;
    }
    
    public List<MeetingDTO> getMeetingList(Long pid, int nowPage){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutFormatter);
        List<MeetingDTO> meetingDTO = new ArrayList();
        
        List<MeetingEntity> meetingEntity = meetingRepository.findByProjectId(pid.intValue(), PageRequest.of(nowPage - 1, pageLimit, Sort.by(Sort.Direction.DESC, "date")));
        for(MeetingEntity entity : meetingEntity){
            meetingDTO.add(MeetingDTO.builder()
                    .id(entity.getId())
                    .projectId(entity.getProjectId())
                    .title(entity.getTitle())
                    .writer(entity.getWriter())
                    .date(entity.getDate().format(formatter))
                    .build());
        }
        return meetingDTO;
    }
    
    public MeetingDTO getMeeting(Long id){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutFormatter);
        Optional<MeetingEntity> meetingEntity = meetingRepository.findById(id);
        if(meetingEntity != null){
            return MeetingDTO.builder()
                    .id(meetingEntity.get().getId())
                    .projectId(meetingEntity.get().getProjectId())
                    .title(meetingEntity.get().getTitle())
                    .writer(meetingEntity.get().getWriter())
                    .start(meetingEntity.get().getStart().format(formatter))
                    .end(meetingEntity.get().getEnd().format(formatter))
                    .content(meetingEntity.get().getContent())
                    .place(meetingEntity.get().getPlace())
                    .files(meetingEntity.get().getFilecheck() == 1? fileService.searchFile(attachmentFolderPath, Long.toString(meetingEntity.get().getId())): null)
                    .date(meetingEntity.get().getDate().format(formatter))
                    .build();
        }else{
            return null;
        }
    }
}
