package vunh.lovestore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vunh.lovestore.entity.Product;
import vunh.lovestore.service.AdminService;
import vunh.lovestore.utils.HandleImages;

import java.io.IOException;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService service;

    String setup(Model model, String layout) {
        model.addAttribute("layout", layout);
        return "index";
    }

    void productSetup(Model model, Product product) {
        model.addAttribute("category", this.service.getAllCategories());
        model.addAttribute("product", product);
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
        productSetup(model, new Product());
        return setup(model, "product/product_add.jsp");
    }

    @PostMapping("/product/add")
    String add(
            @Validated
            @ModelAttribute("product") Product product,
            BindingResult bindingResult, Model model,
            @RequestParam("__") MultipartFile image
    ) throws IOException {
        if (image.isEmpty()) {
            bindingResult.rejectValue("image", "error", "Please select an image file");
        }
        if (product.getCategoryid() == null) {
            bindingResult.rejectValue("categoryid", "error", "Please select a category");
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("error", true);
            productSetup(model, product);
            return setup(model, "product/product_add.jsp");
        }
        product.setImage(HandleImages.handleMultipartFile(image));
        this.service.saveProduct(product);
        return "redirect:/admin/product?new_success";
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
