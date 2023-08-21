/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import pubilc.sw.monitoring.dto.ProjectDTO;
import pubilc.sw.monitoring.entity.ProjectEntity;
import pubilc.sw.monitoring.repository.ProjectRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.dto.MemberDTO;
import pubilc.sw.monitoring.entity.MemberEntity;
import pubilc.sw.monitoring.entity.UserEntity;
import pubilc.sw.monitoring.repository.MemberRepository;
import pubilc.sw.monitoring.repository.UserRepository;

/**
 *
 * @author parkchaebin
 */
@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepository;
    private final MemberRepository memberRepository;
    private final UserRepository userRepository;

    /**
     * 프로젝트 추가 함수 (project 테이블 및 member 테이블에 정보 추가)
     * 
     * @param projectDTO 프로젝트 정보를 담은 ProjectDTO 객체
     * @param uid 사용자 아이디 
     * @return (0 : 날짜 비교 실패, 1 : 추가 성공, 2 : 추가 실패)
     */
    public int addProject(ProjectDTO projectDTO, String uid) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startDate = LocalDate.parse(projectDTO.getStart(), formatter);
        LocalDate endDate = LocalDate.parse(projectDTO.getEnd(), formatter);

        if (startDate.isBefore(endDate)) {
            ProjectEntity addEntity = ProjectEntity.builder()
                    .name(projectDTO.getName())
                    .content(projectDTO.getContent())
                    .start(java.sql.Date.valueOf(startDate))
                    .end(java.sql.Date.valueOf(endDate))
                    .category(projectDTO.getCategory())
                    .build();

            addEntity = projectRepository.save(addEntity);

            if (addEntity != null) {
                // member 테이블에 정보 추가
                MemberEntity memberEntity = MemberEntity.builder()
                        .uid(uid) 
                        .pid(addEntity.getId()) // 새로 추가된 프로젝트 아이디
                        .right(1) // 권한 정보 
                        .build();

                memberRepository.save(memberEntity);
                return 1; // 추가 성공
            } else {
                return 2; // 추가 실패
            }
        } else {
            return 0; // 날짜 비교 실패
        }
    }


    /**
     * 본인이 해당하는 프로젝트 얻기 위한 함수 
     * 
     * @param uid 본인이 해당하는 프로젝트를 얻기 위한 사용자 아이디 
     * @return 해당 사용자의 프로젝트 정보를 담은 DTO 리스트 
     */
    public List<ProjectDTO> getProjectsByUserId(String uid) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 사용자 아이디를 기반으로 프로젝트 멤버 조회 
        List<MemberEntity> memberEntities = memberRepository.findByUid(uid);
        List<ProjectDTO> projectDTOs = new ArrayList<>();  // 프로젝트 엔티티 리스트 

        for (MemberEntity memberEntity : memberEntities) {
            // 본인이 해당하는 프로젝트 아이디 
            long pid = memberEntity.getPid();
            ProjectEntity projectEntity = projectRepository.findById(pid);

            if (projectEntity != null) {
                // 프로젝트의 시작 및 종료 기간을 Instant 객체로 변환
                Instant startInstant = projectEntity.getStart().toInstant();
                Instant endInstant = projectEntity.getEnd().toInstant();
                // Instant 객체를 시스템 기본 시간대를 사용하여 LocalDate로 변환
                LocalDate startDate = startInstant.atZone(ZoneId.systemDefault()).toLocalDate();
                LocalDate endDate = endInstant.atZone(ZoneId.systemDefault()).toLocalDate();

                // 프로젝트 정보를 DTO로 변환하여 리스트에 추가
                ProjectDTO projectDTO = ProjectDTO.builder()
                        .pid(projectEntity.getId())
                        .name(projectEntity.getName())
                        .content(projectEntity.getContent())
                        .start(startDate.format(formatter))
                        .end(endDate.format(formatter))
                        .category(projectEntity.getCategory())
                        .build();

                projectDTOs.add(projectDTO);
            }
        }

        return projectDTOs;
    }

    
    /**
     * 프로젝트 상세 정보 얻기 위한 함수 
     * 
     * @param pid 상세 정보를 얻을 프로젝트 아이디 
     * @return 프로젝트 상세 정보를 담은 ProjectDTO 객체 
     */
    public ProjectDTO getProjectDetails(Long pid) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 프로젝트 아이디 기반으로 프로젝트 조회 
        Optional<ProjectEntity> projectEntityOptional = projectRepository.findById(pid);

        if (projectEntityOptional.isPresent()) {  // 조회한 엔티티 존재 여부 확인 
            ProjectEntity projectEntity = projectEntityOptional.get();
            
            // 프로젝트의 시작 및 종료 기를 Instant 객체로 변환
            Instant startInstant = projectEntity.getStart().toInstant();
            Instant endInstant = projectEntity.getEnd().toInstant();
            // Instant 객체를 시스템 기본 시간대를 사용하여 LocalDate로 변환
            LocalDate startDate = startInstant.atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate endDate = endInstant.atZone(ZoneId.systemDefault()).toLocalDate();

            // ProjectDTO 객체 생성
            ProjectDTO projectDTO = ProjectDTO.builder()
                    .pid(projectEntity.getId())
                    .name(projectEntity.getName())
                    .content(projectEntity.getContent())
                    .start(startDate.format(formatter))
                    .end(endDate.format(formatter))
                    .category(projectEntity.getCategory())
                    .build();

            return projectDTO;
        } else {
            return null;  // 해당 프로젝트가 존재하지 않는 경우
        }
    }

    /**
     * 프로젝트에 대한 수정 및 삭제에 대한 권한 확인 (member_right=1인 경우만 수정 및 삭제 가능) 
     * 
     * @param uid 사용자 아이디 
     * @param pid 프로젝트 아이디 
     * @return 수정 및 삭제 권한 여부 (true : 수정 및 삭제 가능, false : 수정 및 삭제 불가능) 
     */
    public boolean hasRight(String uid, Long pid) {
        MemberEntity memberEntity = memberRepository.findByUidAndPid(uid, pid);
        return memberEntity != null && memberEntity.getRight() == 1;
    }
    
    
    /**
     * 프로젝트 정보 수정 함수
     * 
     * @param projectDTO 수정할 프로젝트 정보를 담은 ProjectDTO 객체 
     * @return 수정 성공 여부 (0 : 날짜 비교 실패, 1 : 수정 성공, 2 : 수정 실패 또는 수정할 프로젝트가 존재하지 않음)
     */  
    public int updateProject(ProjectDTO projectDTO) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 프로젝트 아이디를 기반으로 프로젝트 조회 
        Optional<ProjectEntity> projectEntityOptional = projectRepository.findById(projectDTO.getPid());

        if (projectEntityOptional.isPresent()) {  // 조회한 엔티티 존재 여부 확인 
            ProjectEntity projectEntity = projectEntityOptional.get();
            LocalDate startDate = LocalDate.parse(projectDTO.getStart(), formatter);
            LocalDate endDate = LocalDate.parse(projectDTO.getEnd(), formatter);

            if (startDate.isBefore(endDate)) {  // 날짜 비교
                // 엔티티 정보를 업데이트하여 새로운 엔티티 생성
                ProjectEntity updateEntity = ProjectEntity.builder()
                        .id(projectEntity.getId())
                        .name(projectDTO.getName())
                        .content(projectDTO.getContent())
                        .start(java.sql.Date.valueOf(startDate))
                        .end(java.sql.Date.valueOf(endDate))
                        .category(projectDTO.getCategory())
                        .build();

                updateEntity = projectRepository.save(updateEntity);
                return updateEntity != null ? 1 : 2;  // 수정 성공 시 1, 실패 시 2 반환
            } else {
                return 0; // 날짜 비교 실패
            }
        } else {
            return 2; // 수정할 프로젝트가 존재하지 않는 경우
        }
    }
 
    
    /**
     * 프로젝트 삭제 함수 
     * 
     * @param pid 삭제할 프로젝트 아이디 
     * @return 삭제 성공 여부 (true : 삭제 성공, false : 삭제할 프로젝트가 존재하지 않음)
     */
    public boolean deleteProject(Long pid) {
        // 프로젝트 아이디를 기반으로 프로젝트 조회 
        Optional<ProjectEntity> projectEntityOptional = projectRepository.findById(pid);
        
        if (projectEntityOptional.isPresent()) { // 조회한 엔티티 존재 여부 확인 
            
            // 해당 프로젝트의 멤버 데이터 조회
            List<MemberEntity> members = memberRepository.findByPid(pid);
            // 조회한 멤버 삭제
            memberRepository.deleteAll(members);
        
            projectRepository.delete(projectEntityOptional.get());
            return true; // 삭제 성공
        } else {
            return false; // 삭제할 프로젝트가 존재하지 않는 경우
        }
    }
    
    
    /**
     * 해당 프로젝트에 대한 멤버 리스트 정보 얻기 위한 함수 
     * 
     * @param pid 프로젝트 아이디
     * @return 프로젝트 멤버 정보를 담은 MemberDTO 객체 리스트
     */
    public List<MemberDTO> getMember(Long pid) {
       List<MemberEntity> memberEntities = memberRepository.findByPid(pid);
       List<MemberDTO> memberDTOs = new ArrayList<>();

        for (MemberEntity memberEntity : memberEntities) {
            MemberDTO memberDTO = MemberDTO.builder()
                    .mid(memberEntity.getMid())
                    .uid(memberEntity.getUid())
                    .pid(memberEntity.getPid())
                    .right(memberEntity.getRight())
                    .build();

            memberDTOs.add(memberDTO);
        }
        return memberDTOs;
    }
    
    
    /**
     * 추가할 멤버가 회원가입 된 아이디인지 판별 
     * 
     * @param uid 추가할 멤버 아이디 
     * @return 회원가입 된 아이디인지 판별 여부 (true : 회원가입 된 아이디, false : 회원가입이 되지 않은 아이디) 
     */
    public boolean isRegisteredUser(String uid) {
        return userRepository.existsById(uid);
    }
    
    
    /**
     * 해당 프로젝트에 이미 참여중인 멤버인지 판별 
     * 
     * @param memberDTO 멤버 정보를 담은 MemberDTO 객체
     * @param addUid 참여중인지 판별할 유저 아이디 
     * @return 해당 프로젝트에 대한 참여 여부 (true : 이미 프로젝트에 참여 중인 아이디, false : 해당 프로젝트에 참여 중이 아닌 아이디)
     */
    public boolean isMember(MemberDTO memberDTO, String addUid) {
        return memberRepository.existsByUidAndPid(addUid, memberDTO.getPid());
    }
    
    
    /**
     * 프로젝트 멤버 추가 함수 
     * 
     * @param memberDTO 멤버 정보를 담은 MemberDTO 객체 
     * @param addUid 추가할 멤버 아이디
     * @param right 추가할 멤버의 권한 
     * @return 맴보 추가 성공 여부 (true : 멤버 추가 성공, false : 멤버 추가 실패)
     */
    public boolean addMember(MemberDTO memberDTO, String addUid, int right) {
         
        MemberEntity addEntity = MemberEntity.builder()
                .uid(addUid)
                .pid(memberDTO.getPid())
                .right(right)
                .build();

        addEntity = memberRepository.save(addEntity);
        
        return addEntity != null;
    }


    /**
     * 해당 프로젝트의 멤버 권한 수정 함수 
     * 
     * @param uid 권한 수정할 멤버 아이디 
     * @param pid 프로젝트 아이디 
     * @param right 수정할 권한 
     * @return 권한 수정 여부 (true : 권한 수정 성공, false : 권한 수정 실패) 
     */
    public boolean updateMemberRight( String uid, Long pid, int right) {
        // 프로젝트 아이디와 유저 아이디를 기반으로 멤버 엔티티 조회
        MemberEntity memberEntity = memberRepository.findByUidAndPid(uid, pid);

        if (memberEntity != null) { // 멤버 엔티티가 존재하는 경우
            // 새로운 멤버 엔티티 생성
            MemberEntity updatedMember = MemberEntity.builder()
                .mid(memberEntity.getMid())
                .uid(uid)
                .pid(pid)
                .right(right)
                .build();

            updatedMember = memberRepository.save(updatedMember);
            return updatedMember != null; // 권한 수정 성공 시 true, 실패 시 false 반환
        } else {
            return false; // 수정할 멤버가 존재하지 않는 경우
        }
    } 
    
  
    /**
     * 프로젝트 멤버 삭제 함수 
     * 
     * @param selectedMember 선택된 삭제 멤버 아이디 
     * @param pid 프로젝트 아이디 
     * @return 삭제 성공 여부 (true : 삭제 성공, false : 삭제 실패, 선택된 삭제 멤버가 없음) 
     */
    public boolean deleteMember(List<String> selectedMember, Long pid) {
        boolean delete = false;  // 삭제할 멤버 선택 여부 확인 

        for (String uid : selectedMember) {
            MemberEntity deleteMember = memberRepository.findByUidAndPid(uid, pid);
            if (deleteMember != null) {
                memberRepository.delete(deleteMember);
                delete = true;
            }
        }
        return delete; // 하나 이상의 멤버가 삭제된 경우 true 반환
    }

    
}
