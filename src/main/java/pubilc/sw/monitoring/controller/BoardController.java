/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pubilc.sw.monitoring.dto.BoardDTO;
import pubilc.sw.monitoring.dto.UserDTO;
import pubilc.sw.monitoring.service.BoardService;
import pubilc.sw.monitoring.service.ProjectService;

/**
 *
 * @author qntjd
 */
@Controller
@RequestMapping("/project/board")
@RequiredArgsConstructor
public class BoardController {
    
    @Autowired
    private HttpSession session;
    
    private final ProjectService projectService;
    private final BoardService boardService;
    
    @GetMapping("/list")
    public String getProjectAllBoard(@RequestParam(value = "page", defaultValue = "1") int nowPage,Model model){
        //Long pid = (Long)session.getAttribute("pid");
        model.addAttribute("category", projectService.getProjectCategory((Long)session.getAttribute("pid")));
        //model.addAttribute("boardList",boardService.getProjectAllBoard(pid, nowPage));
        return "/project/board/list";
    }
    
    @PostMapping("/boards")
    public @ResponseBody List<BoardDTO> getProjectCategoryBoards(@RequestBody Map<Object, Object> request) {
        return boardService.getProjectCategoryBoards((Long)session.getAttribute("pid"),(String) request.get("category"), (int) request.get("page"));
    }
    
    @GetMapping("/save")
    public String addBoard(Model model){
        model.addAttribute("category", projectService.getProjectCategory((Long)session.getAttribute("pid")));
        return "/project/board/save";
    }
    
    @PostMapping("/addBoard")
    public String addBoard(@ModelAttribute BoardDTO boardDTO, @RequestParam(name="file", required=false) List<MultipartFile> file, RedirectAttributes attrs){
        Long pid = (Long)session.getAttribute("pid");
        UserDTO user = (UserDTO) session.getAttribute("user");
        boardDTO.setPid(pid.intValue());
        boardDTO.setWriter(user.getName());
        if(boardService.addBoard(boardDTO, file)){
            attrs.addFlashAttribute("msg", "게시물이 등록되었습니다.");
        }else{
            attrs.addFlashAttribute("msg", "게시물 등록에 실패하였습니다.");
        }
        return "redirect:/project/board/list";
    }
    
    @GetMapping("/{bid}")
    public String getBoard(@PathVariable Long bid, Model model, RedirectAttributes attrs){
        BoardDTO board = boardService.getBoard(bid);
        if(board != null){
            model.addAttribute("board",board);
            UserDTO user = (UserDTO) session.getAttribute("user"); 
            model.addAttribute("editRight", projectService.hasRight(user.getId(), (Long) session.getAttribute("pid"))); 
            return "/project/board/board";
        }else{
            attrs.addFlashAttribute("msg", "게시물이 존재하지 않습니다.");
            return "redirect:/project/board/list";
        }
    }
    
    @GetMapping("/delete/{bid}")
    public String deleteBoard(@PathVariable Long bid, RedirectAttributes attrs){
        if(boardService.deleteBoard(bid)){
            attrs.addFlashAttribute("msg", "게시물이 삭제되었습니다.");
            return "redirect:/project/board/list";
        }else{
            attrs.addFlashAttribute("msg", "게시물 삭제에 실패하였습니다.");
            return "/project/board/" + bid;
        }
    }
    
    @GetMapping("/update/{bid}")
    public String boardDetails(@PathVariable Long bid,Model model, RedirectAttributes attrs){
        BoardDTO board = boardService.getBoard(bid);
        if(board != null){
            model.addAttribute("board",board);
            model.addAttribute("category", projectService.getProjectCategory((Long)session.getAttribute("pid")));
            return "/project/board/details";
        }else{
            attrs.addFlashAttribute("msg", "게시물이 존재하지 않습니다.");
            return "redirect:/project/board/list";
        }
    }
    
    @PostMapping("/update/update")
    public String updateBoard(@ModelAttribute BoardDTO boardDTO, @RequestParam(name="file", required=false) List<MultipartFile> files, HttpServletRequest request, Model model){
        UserDTO user = (UserDTO) session.getAttribute("user");
        boardDTO.setWriter(user.getName());
        BoardDTO board = boardService.updateBoard(boardDTO, files, request.getParameter("dellist"), Integer.parseInt((String)request.getParameter("fileExist")));
        model.addAttribute("board", board);
        return "redirect:/project/board/"+ boardDTO.getBid();
    }
    
    @GetMapping("/download")
    public ResponseEntity<Resource> download(HttpServletRequest request){
        return boardService.downloadFile(request.getParameter("filename"), request.getParameter("mid"));
    }
    
}
