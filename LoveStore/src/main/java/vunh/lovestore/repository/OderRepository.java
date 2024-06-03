package vunh.lovestore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vunh.lovestore.entity.Order;

@Repository
public interface OderRepository extends JpaRepository<Order, Integer> {
}
