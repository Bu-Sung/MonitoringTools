/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
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

    List<ScheduleEntity> findByPid(Long num);

    @Query(value = "SELECT * FROM schedule WHERE project_id = :projectId AND (NOW() BETWEEN schedule_start AND schedule_end) AND FIND_IN_SET(:uid, schedule_member) > 0", nativeQuery = true)
    List<ScheduleEntity> findSchedules(@Param("projectId") Long projectId, @Param("uid") String uid);
}
