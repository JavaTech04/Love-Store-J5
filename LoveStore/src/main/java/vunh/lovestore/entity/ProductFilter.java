package vunh.lovestore.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class ProductFilter {
    private String productName;
    private Double minPrice;
    private Double maxPrice;
}
