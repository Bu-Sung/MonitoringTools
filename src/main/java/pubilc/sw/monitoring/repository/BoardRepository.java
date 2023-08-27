/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.BoardEntity;

/**
 *
 * @author qntjd
 */
@Repository
public interface BoardRepository extends JpaRepository<BoardEntity, Long>{
    List<BoardEntity> findByPidAndCategory(int num, String category, Pageable pageable );
}
