/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.SessionManager;
import pubilc.sw.monitoring.dto.MemberDTO;
import pubilc.sw.monitoring.dto.ProjectDTO;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.service.GraphService;
import pubilc.sw.monitoring.service.ProjectService;

/**
 *
 * @author parkchaebin
 */
@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/project")
public class ProjectController {

    private final ProjectService projectService;
    private final GraphService graphService;
    private final SessionManager sessionManager;

    /**
     * 프로젝트 조회
     * 
     * @param pid 선택한 프로젝트 아이디
     * @param model
     * @return project 프로젝트 리스트 조회 페이지 
     */
    @GetMapping("/{pid}")
    public String project(@PathVariable Long pid, Model model) {
        
        ProjectDTO projectDTO = projectService.getProjectDetails(pid);
        sessionManager.setProjectId(pid);
        sessionManager.setProjectRight(projectService.hasRight(sessionManager.getUserId(), pid));
        model.addAttribute("project", projectDTO); 
        return "project/project";
    }
    
    @GetMapping("/invite")
    public String invite(@RequestParam("pid") Long pid, Model model) {
        
        model.addAttribute("pid", pid);  // 프로젝트 아이디 
        model.addAttribute("inviteUserName", projectService.getInviteUserName(pid));  // 프로젝트 초대한사람 이름 
        model.addAttribute("pName", projectService.getInviteName(pid));  // 초대받은 프로젝트 이름 

        return "project/invite";
    }
    
    
    /**
     * 로그인한 사용자가 속한 프로젝트 목록을 보여준다.
     * @param model 아이디에 해당하는 프로젝트 아이디 값을 보내기 위한 모델
     * @return 프로젝트 리스트 페이지
     */
    @GetMapping("/main")
    public String getAllProject(Model model){
        List<ProjectDTO> projects = projectService.getProjectsByUserId(sessionManager.getUserId());
        model.addAttribute("projects", projects);

        // 초대 받은 목록 리스트
        List<ProjectDTO> invitedProjects = projectService.getInvitedProjects(sessionManager.getUserId());
        model.addAttribute("invitedProjects", invitedProjects);
        return "project/main";
    }
    
    /**
     * 프로젝트 추가를 위한 정보 입력 페이지로 이동 
     * 
     * @return projectSave 프로젝트 정보 입력 페이지 
     */
    @GetMapping("/save")
    public String projectSave(){
        return "project/save";
    }
    
    /**
     * 프로젝트 초대 수락 
     * 
     * @param selectedPid 선택된 프로젝트 아이디 
     * @param attrs
     * @return 
     */
    @PostMapping("/acceptInvite")
    public String acceptInvite(@RequestParam(value = "selectedPid", required = false) List<Long> selectedPid, RedirectAttributes attrs) {
        if (selectedPid != null && !selectedPid.isEmpty()) {
            if (projectService.acceptInvite(selectedPid, sessionManager.getUserId())) {
                attrs.addFlashAttribute("msg", "프로젝트 초대 수락하였습니다.");
            } else {
                attrs.addFlashAttribute("msg", "프로젝트 초대 수락 실패하였습니다.");
            }
        } else {
            attrs.addFlashAttribute("msg", "선택된 수락이 없습니다.");
        }
        
        return "redirect:/project/list";
    }
    
    
    // 프로젝트 초대 거절 ㅓ 
    @PostMapping("/refuseInvite")
    public String refuseInvite(@RequestParam(value = "selectedPid", required = false) List<Long> selectedPid, RedirectAttributes attrs) {
        if (selectedPid != null && !selectedPid.isEmpty()) {
            if (projectService.refuseInvite(selectedPid, sessionManager.getUserId())) {
                attrs.addFlashAttribute("msg", "프로젝트 초대 거절하였습니다.");
            } else {
                attrs.addFlashAttribute("msg", "프로젝트 초대 거절 실패하였습니다.");
            }
        } else {
            attrs.addFlashAttribute("msg", "선택된 초대 거절이 없습니다.");
        }
        
        return "redirect:/project/list";
    }
    
    
    /**
     * 프로젝트 추가
     * 
     * @param projectDTO 프로젝트 정보 객체 
     * @param attrs
     * @return project 프로젝트 추가 후 프로젝트 리스트 조회 페이지로 이동 
     */
    @PostMapping("/addProject")
    public String addProject(@ModelAttribute ProjectDTO projectDTO, RedirectAttributes attrs) {
        if (projectService.addProject(projectDTO, sessionManager.getUserId())) {
            attrs.addFlashAttribute("msg", "프로젝트 등록 성공했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 등록 실패했습니다.");
        }
        return "redirect:/project/main";
    }

    /**
     * 프로젝트 정보수정을 위한 상세정보 조회
     * 
     * @param pid 상세 정보를 조회할 프로젝트 아이디 
     * @param model
     * @return projectDetails 프로젝트 상세 정보 페이지 
     */
    @GetMapping("/update/{pid}")
    public String projectDetails(@PathVariable Long pid, Model model) {
        ProjectDTO projectDTO = projectService.getProjectDetails(sessionManager.getProjectId());
        model.addAttribute("project", projectDTO);
        
        int right = projectService.hasRight(sessionManager.getUserId(), sessionManager.getProjectId());  // 권한 확인 
        model.addAttribute("right", right); 
    
        List<MemberDTO> memberDetails = projectService.getMember(sessionManager.getProjectId());  // 멤버 상세 정보 가져오기
        model.addAttribute("memberDetails", memberDetails);

        return "project/details";
    }

    /**
     * 프로젝트 정보 수정 
     * 
     * @param projectDTO 수정할 프로젝트 정보 객체 
     * @param attrs
     * @return 수정된 프로젝트 상세 정보 페이지 
     */
    @PostMapping("/updateProject")
    public String updateProject(@ModelAttribute ProjectDTO projectDTO, RedirectAttributes attrs) {

        if (projectService.updateProject(projectDTO)) {
            attrs.addFlashAttribute("msg", "프로젝트 수정 성공했습니다.");
        } else if (projectService.updateProject(projectDTO)) {
            attrs.addFlashAttribute("msg", "프로젝트 수정 실패했습니다.");
        }

        return "redirect:/project/" + projectDTO.getPid();
    }

    /**
     * 프로젝트 삭제 
     * 
     * @param pid 삭제할 프로젝트 아이디 
     * @param attrs
     * @return project 프로젝트 삭제 후 프로젝트 리스트 조회 페이지로 이동 
     */
    @PostMapping("update/delete/{pid}")
    public String deleteProject(@PathVariable Long pid, RedirectAttributes attrs) {
        if (projectService.deleteProject(pid)) {
            attrs.addFlashAttribute("msg", "프로젝트 삭제 성공했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 삭제 실패했습니다.");
        }
        return "redirect:/project/list";
    }
    
    
    /**
     * 프로젝트 멤버 정보 조회 
     * 
     * @param pid 프로젝트 아이디 
     * @param model
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @GetMapping("/manageMember/{pid}")
    public String manageMember(@PathVariable Long pid, Model model) {
    
        List<MemberDTO> memberDTO = projectService.getMember(pid);
        model.addAttribute("memberDetails", memberDTO);
        
        int editright = projectService.hasRight(sessionManager.getUserId(), pid);  // 편집 권한 확인 
        model.addAttribute("editright", editright); 

        return "project/manageMember";
    }
    
    
    /**
     * 프로젝트 멤버 추가
     * 
     * @param memberDTO 
     * @param pid 프로젝트 아이디 
     * @param addUid 추가할 팀원의 아이디 
     * @param right 추가할 팀원의 권한 
     * @param attrs
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @PostMapping("/addMember/{pid}")
    public String addMember(@ModelAttribute MemberDTO memberDTO, @PathVariable Long pid, @RequestParam String addUid, @RequestParam int right, RedirectAttributes attrs) {

        if (!projectService.isRegisteredUser(addUid)) {
            attrs.addFlashAttribute("msg", "존재하지 않는 아이디입니다.");
        } else if (projectService.isMember(memberDTO, addUid)) {
            attrs.addFlashAttribute("msg", "이미 참여 중인 팀원입니다.");
        } else if (projectService.addMember(memberDTO, addUid, right)) {
            attrs.addFlashAttribute("msg", "팀원 추가 성공했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "팀원 추가 실패했습니다.");
        }

        return "redirect:/project/manageMember/" + pid;
    }

    /**
     * 멤버 초대 시 아이디 찾기
     * @param uid 입력한 아이디 
     * @return 
     */
    @GetMapping("/searchUsers")
    public @ResponseBody List<String> searchUsers(@RequestParam String uid) {
        return projectService.searchUsers(uid);
    }
    
    
    /**
     * 팀원 권한 수정 
     * 
     * @param uids 권한을 수정할 팀원 아이디 리스트 
     * @param pid 프로젝트 아이디 
     * @param rights 수정할 권한 리스트 
     * @param attrs
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @PostMapping("/updateRight/{pid}")
    public String updateRight(@RequestParam List<String> uids, @RequestParam Long pid, @RequestParam List<Integer> rights, RedirectAttributes attrs) {
        for (int i = 0; i < uids.size(); i++) {
            projectService.updateMemberRight(uids.get(i), pid, rights.get(i));
        }
        
        attrs.addFlashAttribute("msg", "권한 수정 성공했습니다.");
        
        return "redirect:/project/manageMember/" + pid;
    }
    

    /**
     * 프로젝트 팀원 삭제 
     * 
     * @param selectedMember 삭제할 팀원 리스트 
     * @param pid 프로젝트 아이디 
     * @param attrs
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @PostMapping("/deleteMember/{pid}")
    public String removeMember(@RequestParam(value = "selectedMember", required = false) List<String> selectedMember, @RequestParam Long pid, RedirectAttributes attrs) {
        if (selectedMember != null && !selectedMember.isEmpty()) {
            
            if (projectService.deleteMember(selectedMember, pid)) {
                attrs.addFlashAttribute("msg", "선택된 팀원 삭제 성공했습니다.");
            } else {
                attrs.addFlashAttribute("msg", "선택된 팀원 삭제 실패했습니다.");
            }
        } else {
            attrs.addFlashAttribute("msg", "선택된 팀원이 없습니다.");
        }

        return "redirect:/project/manageMember/" + pid;
    }


    /**
     * 초대된 멤버 중 아이디 찾기
     * @param uid 입력한 아이디 
     * @return 
     */
    @PostMapping("/searchMembers")
    public @ResponseBody List<UserDTO> searchMembers(@RequestBody Map<String, Object> request) {
        return projectService.searchMembers(sessionManager.getProjectId(),request.get("uid").toString(),(List<String>) request.get("memberList"));
    }
    
    /**
     * 프로젝트에 소속된 멤버가 맞는 지 확인
     * @param uid 멤버인지 검색할 아이디
     * @return 멤버가 맞으면 멤버의 정보 값을 반환하고 아니면 null을 반환
     */
    @GetMapping("/hasMember")
    public @ResponseBody UserDTO hasMember(@RequestParam("uid") String uid) {
        return projectService.hasMember(sessionManager.getProjectId(), uid);
    }
    

    @GetMapping("/graph")
    public String graph(Model model) throws JsonProcessingException {

        // JSON 문자열로 변환
        ObjectMapper objectMapper = new ObjectMapper();

        model.addAttribute("allData", objectMapper.writeValueAsString(graphService.getData(sessionManager.getProjectId())));  // 전체 요구사항 데이터 
        model.addAttribute("memberData", objectMapper.writeValueAsString(graphService.getMemberData(sessionManager.getProjectId())));  // 멤버 요구사항 데이터 
        
        model.addAttribute("burnData", objectMapper.writeValueAsString(graphService.burnMemberData(sessionManager.getProjectId())));  // 번다운 데이터

        model.addAttribute("projectDate", graphService.getProjectDate(sessionManager.getProjectId()));  // 프로젝트 시작, 마감 날짜 
        
        return "project/graph";
    }
    

}

