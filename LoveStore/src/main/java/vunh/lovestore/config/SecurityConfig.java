package vunh.lovestore.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import vunh.lovestore.security.AdminRoleFilter;
import vunh.lovestore.security.CustomAuthenticationSuccessHandler;
import vunh.lovestore.security.CustomUserDetail;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Autowired
    private CustomUserDetail customUserDetail;

    @Autowired
    private AdminRoleFilter adminRoleFilter;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.addFilterBefore(this.adminRoleFilter, UsernamePasswordAuthenticationFilter.class)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/admin/**").hasRole("admin")
                        .anyRequest().permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                )
                .formLogin(login -> login
                        .loginPage("/login")
                        .defaultSuccessUrl("/")
                        .successHandler(new CustomAuthenticationSuccessHandler())
                )
                .rememberMe(rememberMe -> rememberMe
                        .key("AbcdEfghIjklmNopQrsTuvXyz_0123456789")
                        .tokenValiditySeconds(10000)
                )
                .exceptionHandling(ex -> ex.accessDeniedPage("/"))
                .userDetailsService(this.customUserDetail);
        http.csrf(csrf -> csrf.disable());
        return http.build();
    }

}
