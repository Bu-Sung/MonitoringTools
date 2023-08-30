/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.dto.CommentDTO;
import pubilc.sw.monitoring.entity.CommentEntity;
import pubilc.sw.monitoring.repository.CommentRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class CommentService {
    
    private final CommentRepository commentRepository;
    
    @Value("${date.output.format}")
    private String dateOutputFormatter;
    
    public List<CommentDTO> getCommentList(String sort, int sid){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
        List<CommentDTO> commentDTOList = new ArrayList();
        List<CommentEntity> commentEntityList = commentRepository.findBySortAndSidOrderByDateDesc(sort,sid);
        for(CommentEntity entity : commentEntityList){
            commentDTOList.add(CommentDTO.builder()
                    .cid(entity.getCid())
                    .parent(entity.getParent())
                    .content(entity.getContent())
                    .writer(entity.getWriter())
                    .date(entity.getDate().format(formatter))
                    .build());
        }
        return commentDTOList;
    }
    
    public boolean addComment(CommentDTO commentDTO){
        return commentRepository.save(CommentEntity.builder()
                .sid(commentDTO.getSid())
                .parent(commentDTO.getParent())
                .content(commentDTO.getContent())
                .sort(commentDTO.getSort())
                .writer(commentDTO.getWriter())
                .build()) != null;
    }
}
