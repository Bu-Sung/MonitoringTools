/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import pubilc.sw.monitoring.dto.UserDTO;

/**
 *
 * @author qntjd
 */
@Component
public class SessionManager {
    
    @Autowired
    private HttpSession session;
    @Value("${server.servlet.session.timeout}")
    private int sessionTimeout;
    
    private final String userSession = "user";
    private final String projectIdSession = "pid";
    private final String hasRightSession = "hasRight";
    
    public void setUserSession(UserDTO userDTO){
        session.setAttribute(userSession, userDTO);
        session.setMaxInactiveInterval(-1);
    }
    
    public UserDTO getUserSession(){ // 사용자 세션 반환
        return (UserDTO) session.getAttribute(userSession);
    }
    
    public String getUserId(){ // 사용자 아이디 반환
        UserDTO user = (UserDTO) session.getAttribute(userSession);
        return user.getId();
    }
    
    public String getUserName(){ // 사용자 이름 반환
        UserDTO user = (UserDTO) session.getAttribute(userSession);
        return user.getName();
    }
    
    public void setProjectId(Long pid){
        session.setAttribute(projectIdSession, pid);
        session.setMaxInactiveInterval(-1);
    }
    
    public Long getProjectId(){
        return (Long) session.getAttribute(projectIdSession);
    }
    
    public void setProjectRight(int right){
        session.setAttribute(hasRightSession, right);
        session.setMaxInactiveInterval(-1);
    }
    
    public int getProjectRight(){
        return (int) session.getAttribute(hasRightSession);
    }
}
