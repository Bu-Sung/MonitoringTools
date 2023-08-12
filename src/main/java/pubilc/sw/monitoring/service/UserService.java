/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.repository.UserRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class UserService {
    
    private final UserRepository userRepository; // UserRepository 사용을 위한 변수
    
    
    /**
     * 
     * @param userDTO 로그인을 원하는 사용자의 입력
     * @return 로그인 성공 여부 - 성공하면 true, 실패하면 false
     */
    public boolean signIn(UserDTO userDTO){
        return true;
    }
    
    /**
     * 
     * @param userDTO 회원 가입을 원하는 사용자의 입력
     * @return 회원가입 성공 여부 - 성공하면 true, 실패하면 false
     */
    public boolean signUp(UserDTO userDTO){
        
        return true;
    }
    
    /**
     * 
     * @param id 아이디 중복 검사를 위해 사용자가 입력한 정보
     * @return 아이디의 존재 여부 - 아이디가 존재하면 true, 없으면 false
     */
    public boolean idExists(String id){
        
        return true;
    }
}
