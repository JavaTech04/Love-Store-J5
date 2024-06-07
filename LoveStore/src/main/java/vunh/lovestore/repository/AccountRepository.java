package vunh.lovestore.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vunh.lovestore.entity.Account;

import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    @Query("FROM Account WHERE username LIKE :username")
    Optional<Account> findByUsername(@Param("username") String username);

    @Query("FROM Account WHERE username LIKE %:q% OR email LIKE %:q%")
    Page<Account> findAll(Pageable pageable, @Param("q") String q);
}
