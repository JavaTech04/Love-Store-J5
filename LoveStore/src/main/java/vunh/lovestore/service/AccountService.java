package vunh.lovestore.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import vunh.lovestore.entity.Account;
import vunh.lovestore.repository.AccountRepository;

import java.util.Objects;

@Service
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;

    public Page<Account> getAccounts(Pageable pageable, String query) {
        return accountRepository.findAll(pageable, query);
    }

    public void saveAccount(Account account) {
        this.accountRepository.save(account);
    }

    public void deleteAccount(String username) {
        this.accountRepository.delete(Objects.requireNonNull(this.accountRepository.findByUsername(username).orElse(null)));
    }

    public Account getAccountByUsername(String username) {
        return this.accountRepository.findByUsername(username).orElse(null);
    }

    public Boolean existsByUsername(String username) {
        return this.accountRepository.findByUsername(username).isPresent();
    }
}
