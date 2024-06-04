//package vunh.lovestore.security;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.stereotype.Service;
//import vunh.lovestore.entity.Account;
//import vunh.lovestore.repository.AccountRepository;
//
//@Service
//public class UserService {
//    @Autowired
//    private AccountRepository accountRepository;
//
//    public void save(Account user) {
//        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
//        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
//        accountRepository.save(user);
//    }
//}