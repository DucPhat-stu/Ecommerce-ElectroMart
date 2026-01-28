package com.store.electro.Models.Entity.Payment;

import com.store.electro.Models.DTOs.Response.PaymentResult;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Enums.PaymentMethod;

public interface IPaymentStrategy {

    PaymentMethod getPaymentMethod();

    PaymentResult pay(Order order);
}
