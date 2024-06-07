package vunh.lovestore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vunh.lovestore.entity.Account;
import vunh.lovestore.entity.Product;
import vunh.lovestore.service.AccountService;
import vunh.lovestore.service.ProductService;
import vunh.lovestore.utils.HandleImages;

import java.io.IOException;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
class AdminController {
    @Autowired
    private ProductService productService;

    @Autowired
    private AccountService accountService;

    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    String setup(Model model, String layout) {
        model.addAttribute("layout", layout);
        return "index";
    }

    void setupAccount(Model model, Account account, String action, String title, Boolean type) {
        model.addAttribute("user", account);
        model.addAttribute("action", action);
        model.addAttribute("title", title);
        model.addAttribute("type", type);
    }

    void productSetup(Model model, Product product) {
        model.addAttribute("category", this.productService.getAllCategories());
        model.addAttribute("product", product);
    }

    void handleHoldData(Model model, Optional<String> q, Optional<Integer> page) {
        if (q.isPresent()) {
            model.addAttribute("url", "&q=" + q.orElse(""));
        }
        model.addAttribute("q", q.orElse(""));
    }

    @GetMapping
    String index(Model model) {
        return setup(model, "home.jsp");
    }

    @GetMapping("/product")
    String product(Model model, @RequestParam("q") Optional<String> q, @RequestParam("page") Optional<Integer> page) {
        Pageable pageable = PageRequest.of(page.orElse(0), 5, Sort.Direction.ASC, "createdate");
        handleHoldData(model, q, page);
        model.addAttribute("products", this.productService.getAllProducts(pageable, q.orElse("")));
        return setup(model, "product/index.jsp");
    }

    @GetMapping("/product/add")
    String productCreate(Model model) {
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
        this.productService.saveProduct(product);
        return "redirect:/admin/product?new_success";
    }

    @GetMapping("/product/{id}")
    String delete(@PathVariable("id") Integer id, RedirectAttributes model) {
        try {
            this.productService.deleteProduct(id);
            model.addAttribute("deleteSuccessfully", true);
            return "redirect:/admin/product";
        } catch (Exception _) {
            model.addAttribute("deleteFailed", true);
            return "redirect:/admin/product";
        }
    }

    @GetMapping("/product/edit/{id}")
    String editProduct(Model model, @PathVariable("id") Integer id) {
        productSetup(model, this.productService.getProduct(id));
        return setup(model, "product/product_edit.jsp");
    }

    @PostMapping("/product/edit")
    String updateProduct(@Validated @ModelAttribute("product") Product product,
                         BindingResult bindingResult, Model model,
                         @RequestParam("__") MultipartFile image
    ) throws IOException {
        Product dataOld = this.productService.getProduct(product.getId());
        if (image.isEmpty()) {
            product.setImage(dataOld.getImage());
        } else {
            product.setImage(HandleImages.handleMultipartFile(image));
        }
        if (product.getCategoryid() == null) {
            bindingResult.rejectValue("categoryid", "error", "Please select a category");
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("error", true);
            productSetup(model, product);
            return setup(model, "product/product_edit.jsp");
        }
        product.setCreatedate(dataOld.getCreatedate());
        this.productService.saveProduct(product);
        return "redirect:/admin/product?update_success";
    }

    @GetMapping("/account")
    String account(Model model, @RequestParam("q") Optional<String> q, @RequestParam("page") Optional<Integer> page) {
        Pageable pageable = PageRequest.of(page.orElse(0), 5, Sort.Direction.ASC, "username");
        handleHoldData(model, q, page);
        model.addAttribute("users", this.accountService.getAccounts(pageable, q.orElse("")));
        return setup(model, "account/index.jsp");
    }

    @GetMapping("/account/add")
    String accountCreate(Model model) {
        setupAccount(model, new Account(), "/admin/account/add", "New", false);
        return setup(model, "account/user_action.jsp");
    }

    @GetMapping("/account/{username}")
    String deleteAccount(@PathVariable("username") String username, RedirectAttributes model) {
        try {
            this.accountService.deleteAccount(username);
            model.addAttribute("deleteSuccessfully", true);
            return "redirect:/admin/account";
        } catch (Exception _) {
            model.addAttribute("deleteFailed", true);
            return "redirect:/admin/account";
        }
    }

    @PostMapping("/account/add")
    String storeAccount(@Validated @ModelAttribute("user") Account account, BindingResult bindingResult, Model model, @RequestParam("__") MultipartFile image) throws IOException {
        if (this.accountService.existsByUsername(account.getUsername())) {
            bindingResult.rejectValue("username", "error", "Username already exists");
        }
        if (account.getPassword().length() < 6) {
            bindingResult.rejectValue("password", "error", "Passwords must be at least 6 characters");
        }
        if (bindingResult.hasErrors()) {
            setupAccount(model, account, "/admin/account/add", "New", false);
            return setup(model, "account/user_action.jsp");
        }
        account.setAdmin((byte) (account.getAdmin() == null ? 0 : 1));
        account.setActivated((byte) (account.getActivated() == null ? 0 : 1));
        account.setPassword(this.passwordEncoder.encode(account.getPassword()));
        if (!image.isEmpty()) {
            account.setPhoto(HandleImages.handleMultipartFile(image));
        }
        this.accountService.saveAccount(account);
        return "redirect:/admin/account?new_success";
    }

    @GetMapping("/account/edit/{username}")
    String editAccount(Model model, @PathVariable("username") String username) {
        Account account = this.accountService.getAccountByUsername(username);
        account.setPassword("");
        setupAccount(model, account, "/admin/account/edit", "Update", true);
        return setup(model, "account/user_action.jsp");
    }

    @PostMapping("/account/edit")
    String updateAccount(@Validated @ModelAttribute("user") Account account, BindingResult bindingResult, Model model, @RequestParam("__") MultipartFile image) throws IOException {
        if (account.getPassword().isEmpty()) {
            account.setPassword(this.accountService.getAccountByUsername(account.getUsername()).getPassword());
        } else {
            if (account.getPassword().length() < 6) {
                bindingResult.rejectValue("password", "error", "Passwords must be at least 6 characters");
            }
            account.setPassword(this.passwordEncoder.encode(account.getPassword()));
        }
        if (image.isEmpty()) {
            account.setPhoto(this.accountService.getAccountByUsername(account.getUsername()).getPhoto());
        } else {
            account.setPhoto(HandleImages.handleMultipartFile(image));
        }
        if (bindingResult.hasErrors()) {
            setupAccount(model, account, "/admin/account/edit", "Update", true);
            return setup(model, "account/user_action.jsp");
        }
        account.setAdmin((byte) (account.getAdmin() == null ? 0 : 1));
        account.setActivated((byte) (account.getActivated() == null ? 0 : 1));
        this.accountService.saveAccount(account);
        return "redirect:/admin/account?update_successfully";
    }
}
