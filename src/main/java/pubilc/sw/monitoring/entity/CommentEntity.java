/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.entity;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

/**
 *
 * @author qntjd
 */
@Data
@Entity
@Table(name="comment")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CommentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="comment_id")
    private Long cid; // 댓글 구분 아이디
    
    @Column(name="sort_id")
    private int sid; // 게시물 또는 일정 번호
    
    @Column(name="comment_sort")
    private String sort; // 댓글이 달린 게시물 종류
    
    @Column(name="comment_parent")
    private int parent; // 대댓글을 위한 상위 댓글 id
    
    @Column(name="comment_content")
    private String content; // 내용
    
    @Column(name="user_id")
    private String writer; // 작성자
    
    @Column(name="comment_date")
    @CreationTimestamp
    private LocalDateTime date; // 작성 날짜
    
    @Column(name="comment_delete")
    private int delete;
}
