/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.SessionManager;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.service.UserService;

/**
 *
 * @author qntjd
 */
@Controller
@RequiredArgsConstructor
public class UserController {
    
    private final UserService userService; // UserService 클래스 사용을 위한 변수
    private final SessionManager sessionManager;
    
    @GetMapping("/register")
    public String register(){
        return "register";
    }
    
    @GetMapping("/findUser")
    public String findUser(){
        return "findUser";
    }
    
    @GetMapping("/login")
    public String login(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.invalidate();
        return "login";
    }
    
    @GetMapping("/update")
    public String updateUser(Model model){
        model.addAttribute("user", userService.getUserInfo(sessionManager.getUserId()));
        return "details";
    }
    
    @GetMapping("/changePwSuccess")
    public String changePwSuccess(){
        return "changePwSuccess";
    }
    
    /**
     * 로그인을 진행하는 함수
     * @param userDTO 로그인을 원하는 사용자의 입력
     * @param attrs
     * @return 로그인 성공 여부에 따른 URL 전송
     */
    @PostMapping("/login")
    public String login(@ModelAttribute UserDTO userDTO, RedirectAttributes attrs){
        UserDTO userInfo = userService.login(userDTO);
        if(userInfo != null){
            sessionManager.setUserInfo(userInfo);
            return "redirect:/project/main";
        }else{
            attrs.addFlashAttribute("msg", "로그인에 실패하였습니다.");
            return "redirect:/login";
        }
    }
    
    /**
     * 회원가입을 진행하는 함수
     * @param userDTO 회원 가입을 원하는 사용자의 입력
     * @param attrs
     * @return 회원가입 성공 여부에 따른 URL 전송
     */
    @PostMapping("/register")
    public String signUp(@ModelAttribute UserDTO userDTO, RedirectAttributes attrs){
        if(userService.register(userDTO)){
            attrs.addFlashAttribute("msg", "회원가입에 성공하였습니다.");
            return "registerSuccess";
        }else{
            attrs.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
            return "redirect:/register";
        }
    }
    
    @PostMapping("/findId")
    public String findIdSuccess(@ModelAttribute UserDTO userDTO, Model model, RedirectAttributes attrs){
        String id = userService.findId(userDTO);
        if(id == null){
            attrs.addFlashAttribute("msg", "정보와 일치하는 아이디가 존재하지 않습니다.");
            return "redirect:/findUser";
        }else{
            model.addAttribute("userId", id);
        return "findIdSuccess";
        }
    }
    
   @PostMapping("/findPw")
    public String findPwSuccess(@ModelAttribute UserDTO userDTO){
        if(userService.findPw(userDTO)){
            sessionManager.setUserInfo(userDTO);
            return "findPwSuccess";
        }else{
            return "findUser";
        }
    }
    
    /**
     * 비밀번호를 변경하는 컨트롤러
     * @param pw2
     * @return 변경에 성공여부에 따른 url
     */
    @PostMapping("/chagePw")
    public String chagePw(@RequestParam("pw2") String pw2){
        if(userService.changPw(sessionManager.getUserId(), pw2)){
            return "changePwSuccess";
        }else{
            return "findPwSuccess";
        }
    }
    
    /**
     * 기존 아이디를 확인하는 함수
     * @param id 아이디 중복 검사를 위해 사용자가 입력한 정보
     * @return 아이디의 존재 여부 아이디가 존재하면 true, 없으면 false
     */
    @PostMapping("/idcheck/{id}")
    public @ResponseBody boolean idCheck(@PathVariable String id){
        return userService.idExists(id);
    }
    
    /**
     * 비밀번호 확인 함수
     * @param id
     * @param pw
     * @return 
     */
    @PostMapping("/pwcheck")
    public String pwCheck(@ModelAttribute UserDTO userDTO, RedirectAttributes attrs){
        if(userService.pwCheck(sessionManager.getUserId(), userDTO.getPw())){
            return "redirect:/update";
        }else{
            attrs.addFlashAttribute("msg", "비밀번호를 다시 확인해주세요!");
            return "redirect:/checkPassword";
        }
    }
    
    /**
     * 사용자 기본 정보 변경
     * @param userDTO
     * @param attrs
     * @return 
     */
    @PostMapping("/update/{id}")
    public String updateUser(@ModelAttribute UserDTO userDTO, RedirectAttributes attrs){
        if(userService.updateUserInfo(userDTO)){
            attrs.addFlashAttribute("msg","정보 수정을 완료하였습니다.");
        }else{
            attrs.addFlashAttribute("msg","정보 수정에 실패하였습니다.");
        }
        return "redirect:/";
    }
    
    /**
     * 사용자 정보 삭제
     * @param id
     * @param request
     * @return 
     */
    @PostMapping("/deleteUser")
    public @ResponseBody boolean deleteUser(RedirectAttributes attrs){
        return userService.deleteUser(sessionManager.getUserId()); 
    }
    
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, RedirectAttributes attrs){
        HttpSession session = request.getSession();
        session.invalidate();
        attrs.addFlashAttribute("msg","로그아웃 하였습니다.");
        return "redirect:/login";
    }
    
    @GetMapping("/checkPassword")
    public String checkPassword(){
        return "checkPassword";
    }
}
