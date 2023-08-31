/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.MemberEntity;

/**
 *
 * @author parkchaebin
 */
@Repository
public interface MemberRepository extends JpaRepository<MemberEntity, Long> {

    @Query("SELECT m FROM MemberEntity m WHERE m.uid = :uid")
    List<MemberEntity> findByUid(String uid);
    
    MemberEntity findByUidAndPid(String uid, Long pid);
    
    List<MemberEntity> findByPid(Long pid);
   
    boolean existsByUidAndPid(String uid, Long pid);
    
    @Query("SELECT m.pid FROM MemberEntity m WHERE m.uid = :uid AND m.state = :state")
    List<Long> findPidByUidAndState(String uid, int state);
    
}
