package vunh.lovestore.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vunh.lovestore.entity.Category;
import vunh.lovestore.dto.ProductFilter;
import vunh.lovestore.service.CartService;
import vunh.lovestore.service.ProductService;

import java.util.List;
import java.util.Optional;

import static java.lang.StringTemplate.STR;

@Controller
public class AppController {
    @Autowired
    private ProductService productService;

    @Autowired
    private CartService cartService;

    @Autowired
    private HttpSession session;

    @ModelAttribute("carts")
    CartService cartService() {
        return this.cartService;
    }

    @ModelAttribute("productFilter")
    public ProductFilter productFilter() {
        return new ProductFilter();
    }

    @ModelAttribute("categories")
    public List<Category> getCategories() {
        return this.productService.getAllCategories();
    }

    void handleFilterAndPagination(Model model, ProductFilter productFilter, Optional<String> category) {
        model.addAttribute("url", STR."&productName=\{productFilter.getProductName() == null ? "" : productFilter.getProductName()}&product-category=\{category.orElse("")}&minPrice=\{productFilter.getMinPrice() == null ? "" : productFilter.getMinPrice()}&maxPrice=\{productFilter.getMaxPrice() == null ? "" : productFilter.getMaxPrice()}");
    }

    @GetMapping
    public String index(
            Model model,
            @RequestParam("p") Optional<Integer> p,
            @ModelAttribute("productFilter") ProductFilter data,
            @RequestParam("product-category") Optional<String> category
    ) {
        Pageable pageable = PageRequest.of(p.orElse(0), 8, Sort.Direction.ASC, "createdate");
        model.addAttribute("products", this.productService.getAllProducts(pageable, data, category.orElse(null)));
        model.addAttribute("productCategory", category.orElse(""));
        model.addAttribute("views", "overview.jsp");
        handleFilterAndPagination(model, data, category);
        return "index";
    }

    @GetMapping("/view/{id}")
    public String detail(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("product", this.productService.getProduct(id));
        model.addAttribute("views", "view.jsp");
        return "index";
    }

    @GetMapping("/cart")
    public String cart(Model model) {
        if(cartService.getTotal() == 0){
            return "redirect:/";
        }
        model.addAttribute("views", "cart.jsp");
        return "index";
    }

    @GetMapping("/add-to-cart/{id}")
    public String addToCart(@PathVariable("id") Integer id, Model model) {
        this.cartService.addToCart(id);
        return STR."redirect:/view/\{id}?add_success";
    }

    @GetMapping("/remove-item/{index}")
    public String removeItem(@PathVariable("index") Integer index) {
        this.cartService.removeFromCart(index);
        return "redirect:/cart";
    }

    @PostMapping("/update-item/{product}")
    public String updateItem(@PathVariable("product") Integer productId, @RequestParam("quantity") Integer quantity) {
        try {
            this.cartService.updateCart(productId, quantity);
            return "redirect:/cart";
        } catch (Exception _) {
            return "redirect:/cart?error";
        }
    }

    @GetMapping("/checkout")
    public String openCheckout(Model model) {
        if (session.getAttribute("username") == null) {
            return "redirect:/login?checkout";
        }
        if(cartService.getTotal() == 0){
            return "redirect:/";
        }
        model.addAttribute("views", "checkout.jsp");
        return "index";
    }

    @PostMapping("/checkout")
    public String checkout(@RequestParam("address") String address) {
        this.cartService.store(address, (String) this.session.getAttribute("username"));
        this.cartService.clearCart();
        return "redirect:/?checkout_successfully";
    }
}
