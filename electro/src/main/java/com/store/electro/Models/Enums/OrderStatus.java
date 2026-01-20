package com.store.electro.Models.Enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum OrderStatus {
    PENDING("PENDING"),             // Đơn hàng mới tạo, chờ xác nhận
    CONFIRMED("CONFIRMED"),         // Đã xác nhận đơn hàng
    PROCESSING("PROCESSING"),       // Đang chuẩn bị hàng
    SHIPPED("SHIPPED"),             // Đã giao cho đơn vị vận chuyển
    DELIVERED("DELIVERED"),         // Đã giao hàng thành công
    CANCELLED("CANCELLED"),         // Đã hủy
    REFUNDED("REFUNDED");           // Đã hoàn tiền

    private final String value;

    private OrderStatus(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }
}