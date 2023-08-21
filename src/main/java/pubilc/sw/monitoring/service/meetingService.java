/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pubilc.sw.monitoring.dto.MeetingDTO;
import pubilc.sw.monitoring.entity.MeetingEntity;
import pubilc.sw.monitoring.repsitory.MeetingRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class meetingService {
    
    private final MeetingRepository meetingRepository;
    private final FileService fileService;
    
    @Value("${meeting.folder}")
    private String meetingFolderPath; // meeting폴더
    @Value("${meeting.attachment.folder}")
    private String attachmentFolderPath; // meeting안 회의록 첨부 파일 폴더 명
    @Value("${date.input.format}")
    private String dateFormatter;
    
    public boolean addMeeting(MeetingDTO meetingDTO, List<MultipartFile> files){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateFormatter);
        
        MeetingEntity newEntity = meetingRepository.save(MeetingEntity.builder()
                .projectId(1)
                //.projectId(meetingDTO.getProjectId())
                .title(meetingDTO.getTitle())
                .writer("asd")
                //.writer(meetingDTO.getWriter())
                .start(LocalDateTime.parse(meetingDTO.getStart(),formatter))
                .end(LocalDateTime.parse(meetingDTO.getEnd(),formatter))
                .place(meetingDTO.getPlace())
                .content(meetingDTO.getContent())
                .filecheck(files.get(0).isEmpty() ? 0 : 1)
                .build());
        if(newEntity !=  null){
            if(newEntity.getFilecheck() == 1){
                for(MultipartFile file : files){
                    fileService.saveFile(attachmentFolderPath, Integer.toString(newEntity.getId()), file);
                }
            }
        }
        return true;
    }
}
