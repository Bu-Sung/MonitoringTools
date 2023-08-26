/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
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

    @Value("${meeting.folder}")
    private String meetingFolderPath; // meeting안 회의록 첨부 파일 폴더 명
    @Value("${date.input.format}")
    private String dateInputFormatter;
    @Value("${date.output.format}")
    private String dateOutputFormatter;
    @Value("${page.limit}")
    private int pageLimit;

    public boolean addMeeting(MeetingDTO meetingDTO, List<MultipartFile> files) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateInputFormatter);

        MeetingEntity newEntity = meetingRepository.save(MeetingEntity.builder()
                .projectId(meetingDTO.getProjectId())
                .title(meetingDTO.getTitle())
                .writer(meetingDTO.getWriter())
                .start(LocalDateTime.parse(meetingDTO.getStart(), formatter))
                .end(LocalDateTime.parse(meetingDTO.getEnd(), formatter))
                .place(meetingDTO.getPlace())
                .content(meetingDTO.getContent())
                .fileCheck(files.get(0).isEmpty() ? 0 : 1)
                .build());
        if (newEntity != null) {
            if (newEntity.getFileCheck() == 1) {
                fileService.saveFile(meetingFolderPath, Long.toString(newEntity.getId()), files);
            }
        }
        return true;
    }

    public List<MeetingDTO> getMeetingList(Long pid, int nowPage) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
        List<MeetingDTO> meetingDTO = new ArrayList();

        List<MeetingEntity> meetingEntity = meetingRepository.findByProjectId(pid.intValue(), PageRequest.of(nowPage - 1, pageLimit, Sort.by(Sort.Direction.DESC, "date")));
        for (MeetingEntity entity : meetingEntity) {
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

    public MeetingDTO getMeeting(Long id) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
        Optional<MeetingEntity> meetingEntity = meetingRepository.findById(id);
        if (meetingEntity != null) {
            return MeetingDTO.builder()
                    .id(meetingEntity.get().getId())
                    .projectId(meetingEntity.get().getProjectId())
                    .title(meetingEntity.get().getTitle())
                    .writer(meetingEntity.get().getWriter())
                    .start(meetingEntity.get().getStart().format(formatter))
                    .end(meetingEntity.get().getEnd().format(formatter))
                    .content(meetingEntity.get().getContent())
                    .place(meetingEntity.get().getPlace())
                    .files(meetingEntity.get().getFileCheck() == 1 ? fileService.searchFile(meetingFolderPath, Long.toString(meetingEntity.get().getId())) : null)
                    .date(meetingEntity.get().getDate().format(formatter))
                    .build();
        } else {
            return null;
        }
    }

    public ResponseEntity<Resource> downloadFile(String filename, String mid) {
        return fileService.downloadFile(meetingFolderPath + File.separator + mid, filename);
    }

    public MeetingDTO updateMeeting(MeetingDTO meetingDTO, List<MultipartFile> files, String dellist, int fileExist) {
        // 날짜 출력을 위한 포맷
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(dateInputFormatter);
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(dateOutputFormatter);

        MeetingEntity oldMeeting = meetingRepository.findById(meetingDTO.getId()).get();
        oldMeeting.setTitle(meetingDTO.getTitle());
        oldMeeting.setWriter(meetingDTO.getWriter());
        oldMeeting.setStart(LocalDateTime.parse(meetingDTO.getStart(), inputFormatter));
        oldMeeting.setEnd(LocalDateTime.parse(meetingDTO.getEnd(), inputFormatter));
        oldMeeting.setPlace(meetingDTO.getPlace());
        oldMeeting.setContent(meetingDTO.getContent());
        oldMeeting.setFileCheck(files != null ? 1 : fileExist);
        
        MeetingEntity newEntity = meetingRepository.save(oldMeeting);

        // 첨부파일에 대한 수정 진행
        if (newEntity.getFileCheck() == 1) {
            if (!dellist.equals("")) { // 삭제할 파일이 있으면 삭제를 진행
                fileService.deleteFile(meetingFolderPath, meetingDTO.getId().toString(), dellist);
            }
            if (files != null) { // 새로 추가할 파일이 있다면 추가
                fileService.saveFile(meetingFolderPath, Long.toString(newEntity.getId()), files);
            }
        }

        //파일 저장
        if (newEntity.getFileCheck() == 1) {
            //파일 저장 로직

        }

        return MeetingDTO.builder()
                .id(newEntity.getId())
                .projectId(newEntity.getProjectId())
                .title(newEntity.getTitle())
                .writer(newEntity.getWriter())
                .start(newEntity.getStart().format(outputFormatter))
                .end(newEntity.getEnd().format(outputFormatter))
                .content(newEntity.getContent())
                .place(newEntity.getPlace())
                .files(newEntity.getFileCheck() == 1 ? fileService.searchFile(meetingFolderPath, Long.toString(newEntity.getId())) : null)
                .date(newEntity.getDate().format(outputFormatter))
                .build();
    }
}
