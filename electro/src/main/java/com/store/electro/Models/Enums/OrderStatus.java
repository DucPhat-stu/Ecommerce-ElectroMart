package com.store.electro.Models.Enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum OrderStatus {
    PENDING("pending"),             // Đang chờ xử lý
    CONFIRMED("confirmed"),         // Đã xác nhận
    PROCESSING("processing"),       // Đang xử lý
    SHIPPED("shipped"),             // Đã giao hàng
    DELIVERED("delivered"),         // Đã nhận hàng
    CANCELED("canceled");           // Đã hủy

    private final String value;

    private OrderStatus(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue(){
        return value;
    }
}
