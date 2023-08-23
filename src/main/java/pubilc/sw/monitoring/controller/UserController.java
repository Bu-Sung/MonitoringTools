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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
    
    @GetMapping("/register")
    public String register(){
        return "register";
    }
    
    @GetMapping("/login")
    public String login(){
        return "login";
    }
    
    @GetMapping("/update")
    public String updateUser(Model model){
        model.addAttribute("user", userService.getUserInfo());
        return "update";
    }
    
    
    /**
     * 로그인을 진행하는 함수
     * @param userDTO 로그인을 원하는 사용자의 입력
     * @param attrs
     * @return 로그인 성공 여부에 따른 URL 전송
     */
    @PostMapping("/login")
    public String signIn(@ModelAttribute UserDTO userDTO, RedirectAttributes attrs){
        if(userService.login(userDTO)){
            attrs.addFlashAttribute("msg", "로그인에 성공하였습니다.");
            return "redirect:/";
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
        }else{
            attrs.addFlashAttribute("msg", "회원가입에 실패하였습니다.");
        }
        return "redirect:/";
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
    @PostMapping("/pwcheck/{id}/{pw}")
    public @ResponseBody boolean pwCheck(@PathVariable String id, @PathVariable String pw){
        return userService.pwCheck(id, pw);
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
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable String id, HttpServletRequest request){
        userService.deleteUser(id, request.getParameter("pw"));
        return "redirect:/login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpServletRequest request, RedirectAttributes attrs){
        HttpSession session = request.getSession();
        session.invalidate();
        attrs.addFlashAttribute("msg","로그아웃 하였습니다.");
        return "redirect:/login";
    }
}
