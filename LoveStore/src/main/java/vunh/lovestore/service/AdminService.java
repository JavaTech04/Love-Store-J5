package vunh.lovestore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vunh.lovestore.entity.Product;
import vunh.lovestore.repository.ProductRepository;

import java.util.List;

@Service
public class AdminService {
    @Autowired
    private ProductRepository productRepository;

    public List<Product> getAllProducts() {
        return this.productRepository.findAll();
    }
}
