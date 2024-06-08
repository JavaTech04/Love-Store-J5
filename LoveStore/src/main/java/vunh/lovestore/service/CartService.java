package vunh.lovestore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vunh.lovestore.entity.Order;
import vunh.lovestore.entity.Orderdetail;
import vunh.lovestore.entity.Product;
import vunh.lovestore.repository.AccountRepository;
import vunh.lovestore.repository.OderRepository;
import vunh.lovestore.repository.OrderdetailRepository;

import java.util.*;

@Service
public class CartService {
    @Autowired
    private OrderdetailRepository orderdetailRepository;

    @Autowired
    private OderRepository oderRepository;

    @Autowired
    private ProductService productService;

    @Autowired
    private AccountRepository accountRepository;

    private List<Orderdetail> orderdetails;

    public CartService() {
        this.orderdetails = new ArrayList<>();
    }

    public List<Orderdetail> getItems() {
        return this.orderdetails;
    }

    public void addToCart(Integer id) {
        this.orderdetails.stream()
                .filter(o -> Objects.equals(o.getProductid().getId(), id))
                .findFirst()
                .ifPresentOrElse(
                        u -> u.setQuantity(u.getQuantity() + 1),
                        () -> {
                            Product product = this.productService.getProduct(id);
                            Orderdetail orderdetail = new Orderdetail();
                            orderdetail.setProductid(product);
                            orderdetail.setPrice(product.getPrice());
                            orderdetail.setQuantity(1);
                            this.orderdetails.add(orderdetail);
                        }
                );
    }


    public void updateCart(Integer id, Integer quantity) {
        this.orderdetails.stream().filter(o -> Objects.equals(o.getProductid().getId(), id)).findFirst().ifPresent(o -> o.setQuantity(quantity));
    }

    public void removeFromCart(int index) {
        this.orderdetails.remove(index);
    }

    public void clearCart() {
        this.orderdetails.clear();
    }

    public int getTotal() {
        return this.getItems().size();
    }

    public Double getTotalMoney() {
        double total = 0;
        for (Orderdetail orderdetail : this.orderdetails) {
            total += (int) (orderdetail.getQuantity() * orderdetail.getPrice());
        }
        return total;
    }

    @Transactional
    public void store(String address, String username) {
        Order order = new Order();
        order.setUsername(this.accountRepository.findByUsername(username).orElse(null));
        order.setAddress(address);
        order.setCreatedate(new Date());
        Order orderSave = this.oderRepository.save(order);
        this.orderdetails.forEach(od -> {
            {
                od.setOrderid(orderSave);
                od.setPrice(od.getPrice() * od.getQuantity());
            }
        });
        this.orderdetailRepository.saveAll(this.orderdetails);
    }
}
