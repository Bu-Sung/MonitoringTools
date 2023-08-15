/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.entity;

import java.util.Date;
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

/**
 *
 * @author parkchaebin
 */
@Data
@Entity
@Table(name="member")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberEntity {
    @Id // Primary Key 지정
    @GeneratedValue(strategy = GenerationType.IDENTITY) // 자동 증가
    @Column(name="member_id")
    private Long mid; // 멤버 아이디
    @Column(name="user_id")
    private String uid;  // 팀원 아이디 
    @Column(name="project_id")
    private Long pid;  // 프로젝트 아이디 
    @Column(name="member_right")
    private int right;  // 권한 
}
