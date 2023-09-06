/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import java.util.Map;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.RequestEntity;

/**
 *
 * @author parkchaebin
 */
@Repository
public interface RequestRepository extends JpaRepository<RequestEntity, Long> {

    List<RequestEntity> findByPid(Long pid);

    @Transactional
    void deleteByFrid(Long frid);

    void deleteByFridIn(List<Long> frids);
    
    // 사용자의 현재 스프린트 내역
    @Query(value = "SELECT * FROM request WHERE project_id = :pid AND request_target = 'true' AND user_id=:uid", nativeQuery = true)
    List<RequestEntity> findUserRequests(@Param("pid") Long pid, @Param("uid") String uid);

    // 프로젝트의 요구사할 달성률
    @Query(value = "SELECT COUNT(*) as total, SUM(CASE WHEN request_stage != '완료' THEN 0 ELSE 1 END) as clear, SUM(CASE WHEN request_stage != '대기' THEN 0 ELSE 1 END) as standBy FROM request WHERE project_id = :pid AND request_date != -1", nativeQuery = true)
    Map<String, Object> countRequests(@Param("pid") Long pid);
    
}
