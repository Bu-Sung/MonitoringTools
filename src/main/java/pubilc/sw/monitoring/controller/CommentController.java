/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pubilc.sw.monitoring.SessionManager;
import pubilc.sw.monitoring.dto.CommentDTO;
import pubilc.sw.monitoring.service.CommentService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {
    
    private final SessionManager sessionManager;
    private final CommentService commentService;
    
    @GetMapping("/comments")
    public @ResponseBody List<CommentDTO> getCommentList(@RequestParam("sort") String sort, @RequestParam("sid") int sid){
        return commentService.getCommentList(sort, sid);
    }
    
    @PostMapping("/addComment")
    public @ResponseBody boolean addComment(@RequestBody CommentDTO commentDTO){
        commentDTO.setWriter(sessionManager.getUserName());
        return commentService.addComment(commentDTO);
    }
    
    @PostMapping("/deleteComment")
    public @ResponseBody boolean deleteComment(@RequestBody CommentDTO commentDTO){
        return commentService.deleteComment(commentDTO.getCid());
    }
    
}
