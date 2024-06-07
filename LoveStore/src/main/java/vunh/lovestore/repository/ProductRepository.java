package vunh.lovestore.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vunh.lovestore.entity.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    @Query("FROM Product WHERE (name LIKE %:q%) OR (categoryid.name LIKE %:q%)")
    Page<Product> findAll(Pageable pageable, @Param("q") String q);

    @Query("FROM Product WHERE ((name LIKE %:name% OR :name IS NULL ) AND ((:minPrice IS NULL OR price >= :minPrice) AND (:maxPrice IS NULL OR price <= :maxPrice))) AND (categoryid.name LIKE :type OR :type IS NULL)")
    Page<Product> findAll(Pageable pageable, @Param("name") String name, @Param("minPrice") Double minPrice, @Param("maxPrice") Double maxPrice,@Param("type") String category);

}
