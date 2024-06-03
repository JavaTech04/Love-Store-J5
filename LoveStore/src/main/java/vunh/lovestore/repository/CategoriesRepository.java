package vunh.lovestore.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vunh.lovestore.entity.Category;
@Repository
public interface CategoriesRepository extends JpaRepository<Category, String> {
}
