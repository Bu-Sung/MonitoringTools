/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;

/**
 *
 * @author qntjd
 */
@Data
@Entity
@Table(name="user")// 필수는 X, DB에 테이블 설정 가능
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserEntity {

    @Id
    @Column(name="user_id")
    private String id; // 사용자 아이디
    
    @Column(name="user_pw")
    private String pw; // 사용자 비밀번호
    
    @Column(name="user_name")
    private String name; // 사용자 이름
    
    @Column(name="user_email")
    private String email; // 사용자 전화번호
    
    @Column(name="user_phone")
    private String phone; // 사용자 전화번호
    
    @Column(name="user_birth")
    private String birth; // 사용자 생년월일
    
    @Column(name="user_state")
    @ColumnDefault("0")
    private int state; // 사용자 삭제 여부
}
