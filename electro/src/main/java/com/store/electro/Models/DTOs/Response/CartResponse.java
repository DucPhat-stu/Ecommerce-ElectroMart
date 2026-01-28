package com.store.electro.Models.DTOs.Response;

import java.math.BigDecimal;
import java.util.List;

public class CartResponse {
    private Long userId;
    private List<CartItemDTO> items;
    private Integer totalItems;
    private BigDecimal totalAmount;

    public CartResponse() {
    }

    public CartResponse(Long userId, List<CartItemDTO> items, Integer totalItems, BigDecimal totalAmount) {
        this.userId = userId;
        this.items = items;
        this.totalItems = totalItems;
        this.totalAmount = totalAmount;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public List<CartItemDTO> getItems() {
        return items;
    }

    public void setItems(List<CartItemDTO> items) {
        this.items = items;
    }

    public Integer getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(Integer totalItems) {
        this.totalItems = totalItems;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public static class CartItemDTO {
        private Long id;
        private ProductInfo product;
        private Integer quantity;
        private BigDecimal subtotal;

        public CartItemDTO() {
        }

        public CartItemDTO(Long id, ProductInfo product, Integer quantity, BigDecimal subtotal) {
            this.id = id;
            this.product = product;
            this.quantity = quantity;
            this.subtotal = subtotal;
        }

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public ProductInfo getProduct() {
            return product;
        }

        public void setProduct(ProductInfo product) {
            this.product = product;
        }

        public Integer getQuantity() {
            return quantity;
        }

        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }

        public BigDecimal getSubtotal() {
            return subtotal;
        }

        public void setSubtotal(BigDecimal subtotal) {
            this.subtotal = subtotal;
        }
    }

    public static class ProductInfo {
        private Long id;
        private String name;
        private BigDecimal price;
        private Integer discountPercent;
        private BigDecimal finalPrice;
        private String imageUrl;
        private List<VariantOptionDTO> options;

        public ProductInfo() {
        }

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public BigDecimal getPrice() {
            return price;
        }

        public void setPrice(BigDecimal price) {
            this.price = price;
        }

        public Integer getDiscountPercent() {
            return discountPercent;
        }

        public void setDiscountPercent(Integer discountPercent) {
            this.discountPercent = discountPercent;
        }

        public BigDecimal getFinalPrice() {
            return finalPrice;
        }

        public void setFinalPrice(BigDecimal finalPrice) {
            this.finalPrice = finalPrice;
        }

        public String getImageUrl() {
            return imageUrl;
        }

        public void setImageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
        }

        public List<VariantOptionDTO> getOptions() {
            return options;
        }

        public void setOptions(List<VariantOptionDTO> options) {
            this.options = options;
        }
    }

    public static class VariantOptionDTO {
        private String optionCode;
        private String value;
        private BigDecimal extraPrice;

        public VariantOptionDTO() {
        }

        public VariantOptionDTO(String optionCode, String value, BigDecimal extraPrice) {
            this.optionCode = optionCode;
            this.value = value;
            this.extraPrice = extraPrice;
        }

        public String getOptionCode() {
            return optionCode;
        }

        public void setOptionCode(String optionCode) {
            this.optionCode = optionCode;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        public BigDecimal getExtraPrice() {
            return extraPrice;
        }

        public void setExtraPrice(BigDecimal extraPrice) {
            this.extraPrice = extraPrice;
        }
    }
}