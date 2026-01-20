package com.store.electro.Models.Enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum ProductStatus {
    ACTIVE("active"),                   // Sản phẩm đang bán, hiển thị trên website
    INACTIVE("inactive"),               // Sản phẩm tạm ngưng bán, không hiển thị
    OUT_OF_STOCK("out of stock"),       // Hết hàng
    DISCONTINUED("discontinued");       // Sản phẩm ngừng kinh doanh hoàn toàn

    private final String value;

    private ProductStatus(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }
}
