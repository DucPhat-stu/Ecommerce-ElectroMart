package com.store.electro.Models.Enums;

import com.fasterxml.jackson.annotation.JsonValue;

public enum PaymentMethod {
    COD("cod"),
    VNPAY("vnpay"),
    MOMO("momo");

    private final String value;

    private PaymentMethod(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue(){
        return value;
    }
}
