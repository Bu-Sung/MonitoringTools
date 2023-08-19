/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pubilc.sw.monitoring.repository;

import javax.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pubilc.sw.monitoring.entity.UserEntity;

/**
 *
 * @author qntjd
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity, String>{
    @Override
    boolean existsById(String id);
    
    @Transactional
    @Modifying
    @Query(value="update UserEntity u set u.name=:name, u.phone= :phone, u.email=:email, u.birth=:birth where u.id=:id")
    int updateUserInfo(@Param("id") String id, @Param("name") String name, @Param("email") String email, @Param("phone") String phone, @Param("birth") String birth);
    
    @Transactional
    @Modifying
    @Query(value="update UserEntity u set u.state=1 where u.id=:id")
    int deleteUser(@Param("id") String id);
}
