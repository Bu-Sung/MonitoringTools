/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.CommentEntity;

/**
 *
 * @author qntjd
 */
@Repository
public interface CommentRepository extends JpaRepository<CommentEntity, Long>{
    List<CommentEntity> findBySortAndSidOrderByDateAsc(String sort, int sid);
    
    @Transactional
    @Modifying
    @Query(value="update CommentEntity c set c.delete=1 where c.cid=:cid")
    int deleteComment(Long cid);
}
