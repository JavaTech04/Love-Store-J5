package vunh.lovestore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import vunh.lovestore.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService service;

    String setup(Model model, String layout) {
        model.addAttribute("layout", layout);
        return "index";
    }

    @GetMapping
    public String index(Model model) {
        return setup(model, "home.jsp");
    }

    @GetMapping("/product")
    public String product(Model model) {
        model.addAttribute("products", this.service.getAllProducts());
        return setup(model, "product/index.jsp");
    }

    @GetMapping("/product/add")
    public String productCreate(Model model) {
        return setup(model, "product/product_add.jsp");
    }

    @GetMapping("/account")
    public String account(Model model) {
        return setup(model, "account/index.jsp");
    }

    @GetMapping("/account/add")
    public String accountCreate(Model model) {
        return setup(model, "account/account_add.jsp");
    }
}
