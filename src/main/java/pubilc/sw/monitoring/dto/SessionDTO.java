/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * @author qntjd
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SessionDTO {
    private String uid;
    private String uname;
    private Long pid;
    private String pname;
    private int hasRight;
}
