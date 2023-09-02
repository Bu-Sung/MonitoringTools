/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
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

}
