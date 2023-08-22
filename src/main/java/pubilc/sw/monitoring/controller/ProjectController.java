/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.dto.MemberDTO;
import pubilc.sw.monitoring.dto.ProjectDTO;
import pubilc.sw.monitoring.service.ProjectService;

/**
 *
 * @author parkchaebin
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class ProjectController {

    private final ProjectService projectService;
    

    /**
     * 프로젝트 리스트 조회
     * 
     * @param projectDTO 프로젝트 정보 객체 
     * @param model
     * @return project 프로젝트 리스트 조회 페이지 
     */
    @GetMapping("project/project")
    public String project(@ModelAttribute ProjectDTO projectDTO, Model model) {
        
        // String uid = (String) session.getAttribute("uid"); 
        // userid 세션 값으로 변경 
        String uid = "user1";
        
        List<ProjectDTO> projects = projectService.getProjectsByUserId(uid);
        model.addAttribute("projects", projects);
        
        return "project/project";
    }
    
    /**
     * 프로젝트 추가를 위한 정보 입력 페이지로 이동 
     * 
     * @return projectSave 프로젝트 정보 입력 페이지 
     */
    @PostMapping("project/projectSave")
    public String projectSave(){
        return "project/projectSave";
    }
    
    /**
     * 프로젝트 추가
     * 
     * @param projectDTO 프로젝트 정보 객체 
     * @param attrs
     * @return project 프로젝트 추가 후 프로젝트 리스트 조회 페이지로 이동 
     */
    @PostMapping("project/addProject")
    public String addProject(@ModelAttribute ProjectDTO projectDTO, RedirectAttributes attrs) {

        // String uid = (String) session.getAttribute("uid"); 
        // userid 세션 값으로 변경 
        String uid = "user1";

        if (projectService.addProject(projectDTO, uid) == 1) {
            attrs.addFlashAttribute("msg", "프로젝트 등록 성공했습니다.");
        } else if (projectService.addProject(projectDTO, uid) == 0) {
            attrs.addFlashAttribute("msg", "시작 기간이 종료 기간보다 늦거나 같습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 등록 실패했습니다.");
        }
        return "redirect:/project/project";
    }

    /**
     * 프로젝트 상세 정보 조회
     * 
     * @param pid 상세 정보를 조회할 프로젝트 아이디 
     * @param model
     * @return projectDetails 프로젝트 상세 정보 페이지 
     */
    @GetMapping("project/projectDetails/{pid}")
    public String projectDetails(@PathVariable Long pid, Model model) {
        ProjectDTO projectDTO = projectService.getProjectDetails(pid);
        model.addAttribute("project", projectDTO);
        
        
        // String uid = (String) session.getAttribute("uid"); 
        String uid = "user1";
        boolean right = projectService.hasRight(uid, pid);  // 권한 확인 
        model.addAttribute("right", right); 
    
        List<MemberDTO> memberDetails = projectService.getMember(pid);  // 멤버 상세 정보 가져오기
        model.addAttribute("memberDetails", memberDetails);

        return "project/projectDetails";
    }

    /**
     * 프로젝트 정보 수정 
     * 
     * @param projectDTO 수정할 프로젝트 정보 객체 
     * @param attrs
     * @return 수정된 프로젝트 상세 정보 페이지 
     */
    @PostMapping("project/updateProject")
    public String updateProject(@ModelAttribute ProjectDTO projectDTO, RedirectAttributes attrs) {

        if (projectService.updateProject(projectDTO) == 1) {
            attrs.addFlashAttribute("msg", "프로젝트 수정 성공했습니다.");
        } else if (projectService.updateProject(projectDTO) == 2) {
            attrs.addFlashAttribute("msg", "프로젝트 수정 실패했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "시작 기간이 종료 기간보다 늦거나 같습니다.");
        }

        return "redirect:/project/projectDetails/" + projectDTO.getPid();
    }

    /**
     * 프로젝트 삭제 
     * 
     * @param pid 삭제할 프로젝트 아이디 
     * @param attrs
     * @return project 프로젝트 삭제 후 프로젝트 리스트 조회 페이지로 이동 
     */
    @PostMapping("project/deleteProject/{pid}")
    public String deleteProject(@PathVariable Long pid, RedirectAttributes attrs) {
        if (projectService.deleteProject(pid)) {
            attrs.addFlashAttribute("msg", "프로젝트 삭제 성공했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 삭제 실패했습니다.");
        }
        return "redirect:/project/project";
    }
    
    
    /**
     * 프로젝트 멤버 정보 조회 
     * 
     * @param pid 프로젝트 아이디 
     * @param model
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @GetMapping("/project/manageMember/{pid}")
    public String manageMember(@PathVariable Long pid, Model model) {
    
        List<MemberDTO> memberDTO = projectService.getMember(pid);
        model.addAttribute("memberDetails", memberDTO);
        
        // String uid = (String) session.getAttribute("uid"); 
        String uid = "user1";
        boolean editright = projectService.hasRight(uid, pid);  // 편집 권한 확인 
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
    @PostMapping("/project/addMember/{pid}")
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
     * 팀원 권한 수정 
     * 
     * @param uids 권한을 수정할 팀원 아이디 리스트 
     * @param pid 프로젝트 아이디 
     * @param rights 수정할 권한 리스트 
     * @param attrs
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @PostMapping("/project/updateRight/{pid}")
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
     * @param pids 프로젝트 아이디 
     * @param attrs
     * @return manageMember 프로젝트 멤버 관리 페이지 
     */
    @PostMapping("/project/deleteMember/{pid}")
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


}
