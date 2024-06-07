package vunh.lovestore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vunh.lovestore.entity.Orderdetail;
import vunh.lovestore.entity.Product;
import vunh.lovestore.repository.OrderdetailRepository;

import java.util.ArrayList;
import java.util.List;

@Service
public class CartService {
    @Autowired
    private OrderdetailRepository repo;

    @Autowired
    private ProductService productService;

    private List<Orderdetail> orderdetails;

    public CartService() {
        this.orderdetails = new ArrayList<>();
    }

    public List<Orderdetail> getItems() {
        return this.orderdetails;
    }

    public void addToCart(Integer id) {
        Product product = this.productService.getProduct(id);
        Orderdetail orderdetail = new Orderdetail();
        orderdetail.setProductid(product);
        orderdetail.setPrice(product.getPrice());
        orderdetail.setQuantity(1);
        System.out.println(orderdetail);
        this.orderdetails.add(orderdetail);
    }

    public void removeFromCart(Orderdetail orderdetail) {
        this.orderdetails.remove(orderdetail);
    }

    public void clearCart() {
        this.orderdetails.clear();
    }
}
