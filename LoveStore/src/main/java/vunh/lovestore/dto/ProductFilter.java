package vunh.lovestore.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductFilter {
    private String productName;
    private Double minPrice;
    private Double maxPrice;
}
