package com.store.electro.Models.Enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum CategoryStatus {
    ACTIVE("active"),                   // Category đang hiển thị, có thể thêm sản phẩm
    INACTIVE("hidden"),                 // Category tạm ẩn, không hiển thị trên website
    ARCHIVED("archived");                // Category đã ngừng sử dụng, không dùng nữa

    private final String value;

    private CategoryStatus(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }
}
