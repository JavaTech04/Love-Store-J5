package vunh.lovestore.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "accounts")
public class Account {
    @Id
    @NotBlank
    @Column(name = "username", nullable = false, length = 100)
    private String username;

    @Size(max = 100)
    @Column(name = "password", nullable = false, length = 100)
    private String password;

    @Size(max = 100)
    @NotBlank
    @Column(name = "fullname", nullable = false, length = 100)
    private String fullName;

    @Size(max = 100)
    @NotBlank
    @Email
    @Column(name = "email", nullable = false, length = 100)
    private String email;

    @Column(name = "photo", length = 500)
    private String photo;

    @Column(name = "activated")
    private Byte activated;

    @Column(name = "admin")
    private Byte admin;

}