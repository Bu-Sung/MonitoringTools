package pubilc.sw.monitoring;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author qntjd
 */
@Configuration
public class Config implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new Interceptor())
                .addPathPatterns("/**") // 모든 경로에 대해 인터셉터 적용
                .excludePathPatterns("/","/login", "/findUser", "/register", "/registerSuccess", "/findPwSuccess", "/findIdSuccess", "/idcheck/*", "/findId", "/findPw") // 로그인 이전 기능들 제외
                .excludePathPatterns("/css/**", "/js/**", "/asset/**"); // 리소스 경로도 제외 (예: 정적 파일, 스타일시트, 이미지 등)
    }
}
