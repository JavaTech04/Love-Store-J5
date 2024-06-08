package vunh.lovestore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import vunh.lovestore.entity.Category;
import vunh.lovestore.entity.Product;
import vunh.lovestore.dto.ProductFilter;
import vunh.lovestore.repository.CategoriesRepository;
import vunh.lovestore.repository.ProductRepository;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoriesRepository categoriesRepository;

    public Page<Product> getAllProducts(Pageable pageable, String q) {
        return this.productRepository.findAll(pageable, q.trim());
    }

    public Page<Product> getAllProducts(Pageable pageable, ProductFilter productFilter, String category) {
        String type = category == null || category.isEmpty() ? null : category;
        return this.productRepository.findAll(pageable, productFilter.getProductName(), productFilter.getMinPrice(), productFilter.getMaxPrice(), type);
    }

    public List<Category> getAllCategories() {
        return this.categoriesRepository.findAll();
    }

    public void saveProduct(Product product) {
        this.productRepository.save(product);
    }

    public void deleteProduct(Integer id) {
        this.productRepository.deleteById(id);
    }

    public Product getProduct(Integer id) {
        return this.productRepository.findById(id).orElse(null);
    }
}
