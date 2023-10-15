/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import pubilc.sw.monitoring.dto.ProjectDTO;
import pubilc.sw.monitoring.dto.SessionDTO;
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

    private final String sessionName = "myInfo";

    /* 로그인 시 해당 유저의 정보를 저장하는 session을 생성 */
    public void setUserInfo(UserDTO userDTO) {
        session.setAttribute(sessionName, SessionDTO.builder()
                .uid(userDTO.getId())
                .uname(userDTO.getName())
                .build());
        session.setMaxInactiveInterval(sessionTimeout);
    }

    public String getUserId() { // 사용자 아이디 반환
        SessionDTO infoSession = (SessionDTO) session.getAttribute(sessionName);
        return infoSession.getUid();
    }

    public String getUserName() { // 사용자 이름 반환
        SessionDTO infoSession = (SessionDTO) session.getAttribute(sessionName);
        return infoSession.getUname();
    }

    public void setProjectInfo(ProjectDTO projectDTO, int hasRight) {
        SessionDTO sessionDTO = (SessionDTO) session.getAttribute(sessionName);
        sessionDTO.setPid(projectDTO.getPid());
        sessionDTO.setPname(projectDTO.getName());
        sessionDTO.setHasRight(hasRight);
        session.setAttribute(sessionName, sessionDTO);
        session.setMaxInactiveInterval(sessionTimeout);
    }

    public Long getProjectId() {
        SessionDTO infoSession = (SessionDTO) session.getAttribute(sessionName);
        return infoSession.getPid();
    }

    /* 타인이 사용자의 */
    public void setProjectRight(int hasRight) {
        SessionDTO sessionDTO = (SessionDTO) session.getAttribute(sessionName);
        if (sessionDTO.getHasRight() != hasRight) {
            sessionDTO.setHasRight(hasRight);
            session.setAttribute(sessionName, sessionDTO);
            session.setMaxInactiveInterval(sessionTimeout);
        }
    }

    public int getProjectRight() {
        SessionDTO infoSession = (SessionDTO) session.getAttribute(sessionName);
        return infoSession.getHasRight();
    }
}
