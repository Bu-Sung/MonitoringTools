/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import java.util.Set;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.ScheduleEntity;

/**
 *
 * @author qntjd
 */
@Repository
public interface ScheduleRepository extends JpaRepository<ScheduleEntity, Long> {

    List<ScheduleEntity> findByPid(Long pid);

    @Query(value = "SELECT * FROM schedule WHERE project_id = :projectId AND (NOW() BETWEEN schedule_start AND schedule_end) OR (DATE(schedule_start) = CURDATE() OR DATE(schedule_end) = CURDATE())", nativeQuery = true)
    List<ScheduleEntity> findSchedules(@Param("projectId") Long projectId);

    List<ScheduleEntity> findByMid(Long mid);
    
    boolean existsByMid(Long mid);
    
    void deleteByMid(Long mid);
    
    @Modifying 
    @Transactional
    @Query("DELETE FROM ScheduleEntity s WHERE s.sid NOT IN :ids AND s.mid = :mid")
    void deleteAllExceptIds(@Param("ids") Set<Long> ids, @Param("mid") Long mid);
}
