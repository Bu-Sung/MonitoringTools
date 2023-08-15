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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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

        // userid 세션 값으로 변경 
        String uid = "user1";
        
        if (projectService.addProject(projectDTO, uid)) {
            attrs.addFlashAttribute("msg", "프로젝트 등록 성공했습니다.");
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
    @GetMapping("project/projectDetails/pid={pid}")
    public String projectDetails(@PathVariable Long pid, Model model) {
        ProjectDTO projectDTO = projectService.getProjectDetails(pid);
        model.addAttribute("project", projectDTO);
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

        if (projectService.updateProject(projectDTO)) {
            attrs.addFlashAttribute("msg", "프로젝트 수정 성공했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 수정 실패했습니다.");
        }

        // 업데이트된 프로젝트 정보 가져오기
        ProjectDTO updatedProject = projectService.getProjectDetails(projectDTO.getPid());

        // 수정된 프로젝트 정보 모델에 추가
        attrs.addFlashAttribute("updatedProject", updatedProject);

        return String.format("redirect:/project/projectDetails/pid=%d", projectDTO.getPid());
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

}
