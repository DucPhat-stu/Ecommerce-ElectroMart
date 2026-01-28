package com.store.electro.Models.Enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum PaymentStatus {
    INITIATED("initiated"),   // vừa tạo
    SUCCESS("success"),     // thành công
    FAILED("failed");       // thất bại

    private final String value;

    private PaymentStatus(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue(){
        return value;
    }
}
