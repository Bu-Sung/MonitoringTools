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
import org.springframework.data.domain.Page;
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
import pubilc.sw.monitoring.service.RequestService;
import pubilc.sw.monitoring.service.ScheduleService;

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
    private final ScheduleService scheduleService;
    private final RequestService requestService;
    private final SessionManager sessionManager;

    /**
     * 프로젝트 조회
     *
     * @param pid 선택한 프로젝트 아이디
     * @param model
     * @return project 프로젝트 리스트 조회 페이지
     */
    @GetMapping("/{pid}")
    public String project(@PathVariable Long pid, Model model, RedirectAttributes attrs) throws JsonProcessingException {
        ProjectDTO projectDTO = projectService.getProjectDetails(pid);
        int hasRight = projectService.hasRight(sessionManager.getUserId(), pid);
        if (projectDTO != null && hasRight != -1) {
            sessionManager.setProjectInfo(projectDTO, projectService.hasRight(sessionManager.getUserId(), pid));
            model.addAttribute("project", projectDTO);

            ObjectMapper objectMapper = new ObjectMapper();
            model.addAttribute("allData", objectMapper.writeValueAsString(graphService.getData(pid)));  // 전체 요구사항 데이터 
            model.addAttribute("memberData", objectMapper.writeValueAsString(graphService.getMemberData(pid)));  // 멤버 요구사항 데이터 
            model.addAttribute("burnData", objectMapper.writeValueAsString(graphService.burnMemberData(pid)));  // 번다운 데이터
            model.addAttribute("projectDate", graphService.getProjectDate(pid));  // 프로젝트 시작, 마감 날짜 

            model.addAttribute("todaySchedule", scheduleService.findSchedules(pid, sessionManager.getUserId()));// 금일 일정
            model.addAttribute("userSprint", requestService.getUserSprintList(pid, sessionManager.getUserId())); // 사용자의 스프린트 내역
            Map<String, Object> rate = requestService.getRequestCounts(pid);
            int num = 0;
            if (rate.get("total") instanceof Number && ((Number) rate.get("total")).doubleValue() != 0) {
                double clear = ((Number) rate.get("clear")).doubleValue();
                double total = ((Number) rate.get("total")).doubleValue();
                num = (int) (clear / total * 100);
            }
            model.addAttribute("num", num);// 달성률
            model.addAttribute("rate", requestService.getRequestCounts(pid));// 달성률
            model.addAttribute("endDay", projectService.getDaysUntilProjectEnd(pid));
            return "project/project";
        } else {
            attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
            return "redirect:/project/list";
        }

    }

    @GetMapping("/invite/{pid}")
    public String invite(@PathVariable Long pid, Model model, RedirectAttributes attrs) {
        if (projectService.checkInvite(pid, sessionManager.getUserId())) {
            model.addAttribute("pid", pid);  // 프로젝트 아이디 
            model.addAttribute("inviteUserName", projectService.getInviteUserName(pid));  // 프로젝트 초대한사람 이름 
            model.addAttribute("pName", projectService.getInviteName(pid));  // 초대받은 프로젝트 이름 
            return "project/invite";
        }else{
            attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
            return "redirect:/project/list";
        }
    }

    /**
     * 로그인한 사용자가 속한 프로젝트 목록을 보여준다.
     *
     * @param model 아이디에 해당하는 프로젝트 아이디 값을 보내기 위한 모델
     * @return 프로젝트 리스트 페이지
     */
    @GetMapping("/list")
    public String getAllProject(@RequestParam(value = "page", defaultValue = "1") int nowPage, @RequestParam(value = "name", defaultValue = "") String name, Model model) {
        Page<ProjectDTO> projects = projectService.getProjectsByUserId(sessionManager.getUserId(), nowPage, name);
        model.addAttribute("list", projects);

        // 초대 받은 목록 리스트
        List<ProjectDTO> invitedProjects = projectService.getInvitedProjects(sessionManager.getUserId());
        model.addAttribute("invitedProjects", invitedProjects);
        return "project/list";
    }

    /**
     * 프로젝트 추가를 위한 정보 입력 페이지로 이동
     *
     * @return projectSave 프로젝트 정보 입력 페이지
     */
    @GetMapping("/save")
    public String projectSave() {
        return "project/save";
    }

    /**
     * 프로젝트 초대 수락
     *
     * @param selectedPid 선택된 프로젝트 아이디
     * @param attrs
     * @return
     */
    @PostMapping("/acceptInvite/{pid}")
    public String acceptInvite(@PathVariable Long pid, RedirectAttributes attrs) {
        if (projectService.checkInvite(pid, sessionManager.getUserId())) {
            attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
            return "redirect:/project/list";
        }
        if (projectService.acceptInvite(pid, sessionManager.getUserId())) {
            attrs.addFlashAttribute("msg", "프로젝트 초대 수락하였습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 초대 수락 실패하였습니다.");
        }

        return "redirect:/project/list";
    }

    // 프로젝트 초대 거절 ㅓ 
    @PostMapping("/refuseInvite/{pid}")
    public String refuseInvite(@PathVariable Long pid, RedirectAttributes attrs) {
        if (projectService.checkInvite(pid, sessionManager.getUserId())) {
            attrs.addFlashAttribute("msg", "잘못된 접근입니다.");
            return "redirect:/project/list";
        }
        if (projectService.refuseInvite(pid, sessionManager.getUserId())) {
            attrs.addFlashAttribute("msg", "프로젝트 초대 거절하였습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 초대 거절 실패하였습니다.");
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
        return "redirect:/project/list";
    }

    /**
     * 프로젝트 정보수정을 위한 상세정보 조회
     *
     * @param pid 상세 정보를 조회할 프로젝트 아이디
     * @param model
     * @return projectDetails 프로젝트 상세 정보 페이지
     */
    @GetMapping("/update")
    public String projectDetails(Model model) {
        ProjectDTO projectDTO = projectService.getProjectDetails(sessionManager.getProjectId());
        int hasRight = projectService.hasRight(sessionManager.getUserId(), sessionManager.getProjectId());
        if (projectDTO != null && hasRight != -1) {
            model.addAttribute("project", projectDTO);
            model.addAttribute("right", hasRight);
            return "project/details";
        }
        return "redirect:/project/" + sessionManager.getProjectId();

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
     * 프로젝트 카테고리 수정
     */
    @PostMapping("/updateCategory")
    public @ResponseBody
    boolean updateCategory(@RequestBody Map<String, String> request) {
        projectService.updateCartegory(request.get("str"), sessionManager.getProjectId());
        return true;
    }

    /**
     * 프로젝트 삭제
     *
     * @param pid 삭제할 프로젝트 아이디
     * @param attrs
     * @return project 프로젝트 삭제 후 프로젝트 리스트 조회 페이지로 이동
     */
    @GetMapping("/delete")
    public String deleteProject(RedirectAttributes attrs) {
        if (projectService.deleteProject(sessionManager.getProjectId())) {
            attrs.addFlashAttribute("msg", "프로젝트 삭제 성공했습니다.");
        } else {
            attrs.addFlashAttribute("msg", "프로젝트 삭제 실패했습니다.");
        }
        return "redirect:/project/list";
    }

    /**
     * 프로젝트 멤버 정보 조회
     *
     *
     * @return 멤버 리스트
     */
    @GetMapping("/getMember")
    public @ResponseBody
    List<MemberDTO> manageMember() {
        return projectService.getMember(sessionManager.getProjectId());
    }

    @GetMapping("/getAllMemberInfo")
    public @ResponseBody
    List<UserDTO> getAllMemberInfo() {
        List<UserDTO> list = projectService.searchAllMembers(sessionManager.getProjectId());
        return list;
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
    @PostMapping("/addMember")
    public @ResponseBody
    boolean addMember(@RequestBody MemberDTO memberDTO) {
        return projectService.addMember(memberDTO.getUid(), sessionManager.getProjectId());
    }

    /**
     * 멤버 초대 시 아이디 찾기
     *
     * @param uid 입력한 아이디
     * @return
     */
    @GetMapping("/searchUsers")
    public @ResponseBody
    List<String> searchUsers(@RequestParam String uid) {
        return projectService.searchUsers(uid, sessionManager.getProjectId());
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
    @PostMapping("/updateRight")
    public @ResponseBody
    boolean updateRight(@RequestBody MemberDTO memberDTO) {
        return projectService.updateMemberRight(memberDTO, sessionManager.getProjectId());
    }

    /**
     * 프로젝트 팀원 삭제
     *
     * @param uids 삭제할 팀원 리스트
     * @return
     */
    @PostMapping("/deleteMember")
    public @ResponseBody
    boolean removeMember(@RequestBody List<String> uids) {
        projectService.deleteMember(uids, sessionManager.getProjectId());
        return true;
    }

    /**
     * 일정에 대하여 이미 초대된 멤버를 제외한 멤버들 아이디 찾기
     *
     * @param uid 입력한 아이디
     * @return
     */
    @PostMapping("/searchMembers")
    public @ResponseBody
    List<UserDTO> searchMembers(@RequestBody List<String> memberList) {
        return projectService.searchMembers(sessionManager.getProjectId(), memberList);
    }

    /**
     * 프로젝트에 소속된 멤버가 맞는 지 확인
     *
     * @param uid 멤버인지 검색할 아이디
     * @return 멤버가 맞으면 멤버의 정보 값을 반환하고 아니면 null을 반환
     */
    @GetMapping("/hasMember")
    public @ResponseBody
    UserDTO hasMember(@RequestParam("uid") String uid) {
        return projectService.hasMember(sessionManager.getProjectId(), uid);
    }

    @GetMapping("/kanban")
    public String kanban(Model model) {
        model.addAttribute("request", requestService.getRequests(sessionManager.getProjectId()));
        return "/project/kanban";
    }

    @PostMapping("/changeSprint")
    public String chageSprint(@RequestBody Map<String, Object> request) {
        Long frid = Long.parseLong((String) request.get("frid"));
        String stage = request.get("stage").toString();
        requestService.changeSprint(frid, stage);
        return "redirect:/project/kanban";
    }

    @GetMapping("/sprint")
    public String sprint(Model model) {
        model.addAttribute("requestMap", requestService.getTrueTarget(sessionManager.getProjectId()));
        model.addAttribute("excelNames", requestService.getExcelNames(sessionManager.getProjectId()));// 엑셀 파일 리스트 
        return "/project/sprintList";
    }

    // 카테고리 목록 
    @GetMapping("/getCategory")
    public @ResponseBody
    List<String> getCategory() {
        return projectService.getProjectCategory(sessionManager.getProjectId());
    }

    // 카테고리 삭제 
    @PostMapping("/deleteCategory")
    public @ResponseBody
    boolean deleteCategory(@RequestBody List<String> cats) {
        projectService.deleteCategory(cats, sessionManager.getProjectId());
        return true;
    }

    // 카테고리 추가 
    @PostMapping("/addCategory")
    public @ResponseBody
    boolean addCategory(@RequestBody String addCat) {
        return projectService.addCategory(addCat, sessionManager.getProjectId());
    }
}
