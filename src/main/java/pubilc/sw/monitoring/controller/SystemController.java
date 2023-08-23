/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import pubilc.sw.monitoring.service.ProjectService;

/**
 *
 * @author qntjd
 */
@Controller
@RequiredArgsConstructor
@Slf4j
public class SystemController {

    @GetMapping("/")
    public String index(Model model) {
        return "login";
       
    }
}
