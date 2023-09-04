/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring;

import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 *
 * @author qntjd
 */
@Component
public class Interceptor implements HandlerInterceptor {
    
    @Value("${server.servlet.session.timeout}")
    private int sessionTimeout;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");
        if (user == null) {
            // 세션에 'user' 속성이 없는 경우 로그인 페이지로 리다이렉트
            response.sendRedirect("/monitoring/login");
            session.invalidate();
            return false;
        } else {
            session.setMaxInactiveInterval(sessionTimeout); // 세션의 만료 시간을 30분(1800초)으로 설정
            return true; // 세션에 'user' 속성이 있는 경우 요청 처리 계속 진행
        }
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,Object object, Exception ex
        ) throws Exception {
        PrintWriter out = response.getWriter();
        out.println("<script> <c:if test='${!empty msg}'>alert('${msg}');</c:if></script>");
        out.flush();
    }
}
