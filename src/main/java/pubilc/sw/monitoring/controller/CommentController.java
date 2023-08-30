/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pubilc.sw.monitoring.dto.CommentDTO;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.service.CommentService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {
    
    @Autowired
    private HttpSession session;
    
    private final CommentService commentService;
    
    @GetMapping("/comments")
    public @ResponseBody List<CommentDTO> getCommentList(@RequestParam("sort") String sort, @RequestParam("sid") int sid){
        return commentService.getCommentList(sort, sid);
    }
    
    @PostMapping("/addComment")
    public @ResponseBody boolean addComment(@RequestBody CommentDTO commentDTO){
        UserDTO user = (UserDTO) session.getAttribute("user");
        commentDTO.setWriter(user.getName());
        return commentService.addComment(commentDTO);
    }
}
