/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.ScheduleEntity;

/**
 *
 * @author qntjd
 */
@Repository
public interface ScheduleRepository extends JpaRepository<ScheduleEntity, Long>{
    List<ScheduleEntity> findByPid(Long num);
}
