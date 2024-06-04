package vunh.lovestore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vunh.lovestore.entity.Category;
import vunh.lovestore.entity.Product;
import vunh.lovestore.repository.CategoriesRepository;
import vunh.lovestore.repository.ProductRepository;

import java.util.List;

@Service
public class AdminService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoriesRepository categoriesRepository;

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }

    public List<Category> getAllCategories() {
        return this.categoriesRepository.findAll();
    }

    public void saveProduct(Product product) {
        this.productRepository.save(product);
    }
}
