/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.repository.RequestRepository;
import pubilc.sw.monitoring.dto.RequestDTO;
import pubilc.sw.monitoring.entity.RequestEntity;

/**
 *
 * @author parkchaebin
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RequestService {
    
    private final RequestRepository requestRepository;
    
    /**
     * 해당 프로젝트의 모든 요구사항 
     * 
     * @param pid 해당 프로젝트 아이디 
     * @return 해당 프로젝트의 모든 요구사항 리스트 객체 
     */
    public List<RequestDTO> getRequests(Long pid) {
        List<RequestEntity> requestEntities = requestRepository.findByPid(pid);
        List<RequestDTO> requestDTOs = new ArrayList<>();

        for (RequestEntity requestEntity : requestEntities) {
            requestDTOs.add(RequestDTO.builder()
                    .frid(requestEntity.getFrid())
                    .pid(requestEntity.getPid())
                    .rid(requestEntity.getRid())
                    .name(requestEntity.getName())
                    .content(requestEntity.getContent())
                    .date(requestEntity.getDate())
                    .rank(requestEntity.getRank())
                    .stage(requestEntity.getStage())
                    .target(requestEntity.getTarget())
                    .uid(requestEntity.getUid())
                    .note(requestEntity.getNote())
                    .build());
        }

        return requestDTOs;
    }
    

    /**
     * 요구사항 저장 및 수정 
     * 
     * @param requestDTOList
     * @return 저장 성공 여부 
     */
    public boolean saveRequests(List<RequestDTO> requestDTOList) {
        List<RequestEntity> requestEntities = new ArrayList<>();
        
        for (RequestDTO requestDTO : requestDTOList) {
            RequestEntity requestEntity = RequestEntity.builder()
                .frid(requestDTO.getFrid())
                .pid(requestDTO.getPid())
                .rid(requestDTO.getRid())
                .name(requestDTO.getName())
                .content(requestDTO.getContent())
                .date(requestDTO.getDate())
                .rank(requestDTO.getRank())
                .stage(requestDTO.getStage())
                .target(requestDTO.getTarget())
                .uid(requestDTO.getUid())
                .note(requestDTO.getNote())
                .build();

            requestEntities.add(requestEntity);
        }

        List<RequestEntity> savedEntities = requestRepository.saveAll(requestEntities);
        return !savedEntities.isEmpty();
    }
    
    
    /**
     * 요구사항 삭제 
     * 
     * @param frid 
     * @return 삭제 성공 여부 
     */
    public boolean deleteRequestByFrid(Long frid) {
        try {
            requestRepository.deleteById(frid);
            return true;
        } catch (Exception ex) {
            log.error("deleteRequestByFrid() error: {} ", ex.getMessage());
            return false;
        }
    }
    

    /**
     * 해당 프로젝트 아이디에 대한 모든 요구사항 전체 삭제 
     * 
     * @param pid 
     * @return 전체 삭제 성공 여부 
     */
    public boolean deleteRequestsByPid(Long pid) {
        try {
            List<RequestEntity> requestsToDelete = requestRepository.findByPid(pid);
            requestRepository.deleteAllInBatch(requestsToDelete);
            return true;
        } catch (Exception ex) {
            log.error("deleteRequestsByPid() error: {} ", ex.getMessage());
            return false;
        }
    }

}
