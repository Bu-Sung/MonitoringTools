/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.util.Optional;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.SessionManager;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.entity.UserEntity;
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
    public UserDTO login(UserDTO userDTO){
        UserEntity userEntity = userRepository.findUserById(userDTO.getId());
        if(userEntity == null || !userDTO.getPw().equals(userEntity.getPw()) || userEntity.getState() != 0){
            return null;
        }else{
            return UserDTO.builder()
                    .id(userEntity.getId())
                    .name(userEntity.getName())
                    .build();
        }
    }
    
    /**
     * 
     * @param userDTO 회원 가입을 원하는 사용자의 입력
     * @return 회원가입 성공 여부 - 성공하면 true, 실패하면 false
     */
    public boolean register(UserDTO userDTO){
        if(idExists(userDTO.getId())){
            return false;
        }else{
            return userRepository.save(UserEntity.builder()
                    .id(userDTO.getId())
                    .pw(userDTO.getPw())
                    .name(userDTO.getName())
                    .email(userDTO.getEmail())
                    .phone(userDTO.getPhone())
                    .birth(userDTO.getBirth())
                    .state(0)
                    .build()) != null;
        }
    }
    
    /**
     * 
     * @param id 아이디 중복 검사를 위해 사용자가 입력한 정보
     * @return 아이디의 존재 여부 - 아이디가 존재하면 true, 없으면 false
     */
    public boolean idExists(String id){
        return userRepository.existsById(id);
    }
    
    public boolean pwCheck(String id, String pw){
        Optional<UserEntity> userEntity = userRepository.findById(id);
        return userEntity.isPresent() && pw.equals(userEntity.get().getPw());
    }
    
    public boolean changPw(String id, String pw){
        if(userRepository.updatePasswordById(id, pw) > 0){
            return true;
        }else{
            return false;
        }
    }
    
    public UserDTO getUserInfo(String uid){
        Optional<UserEntity> userEntity = userRepository.findById(uid);
        return UserDTO.builder()
                    .id(userEntity.get().getId())
                    .name(userEntity.get().getName())
                    .email(userEntity.get().getEmail())
                    .phone(userEntity.get().getPhone())
                    .birth(userEntity.get().getBirth())
                    .build();
    }
    
    public boolean updateUserInfo(UserDTO userDTO){
        return userRepository.updateUserInfo(userDTO.getId(), userDTO.getName(), userDTO.getEmail(), userDTO.getPhone(), userDTO.getBirth()) >=0;
    }
    
    public boolean deleteUser(String id){
        Optional<UserEntity> userEntity = userRepository.findById(id);
        if(userEntity.isPresent()){
            return userRepository.deleteUser(userEntity.get().getId()) > 0;
        }else {
            return false;
        }
    }
    
    public String findId(UserDTO userDTO){
        String id = userRepository.findIdByNameAndPhoneAndState(userDTO.getName(), userDTO.getPhone());
        if(id == null){
            return null;
        }else{
            return id.replaceAll("^(.{5}).*", "$1" + "*".repeat(id.length() - 5));
        }
        
    }
    
    public boolean findPw(UserDTO userDTO){
        if(userRepository.findNameByNameAndPhoneAndState(userDTO.getId(), userDTO.getName(), userDTO.getPhone()) == null){
            return false;
        }else{
            return true;
        }
    }
}
