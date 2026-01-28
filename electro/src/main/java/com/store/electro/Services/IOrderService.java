package com.store.electro.Services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.DTOs.Request.OrderRequest;
import com.store.electro.Models.DTOs.Response.OrderResponse;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Enums.OrderStatus;

public interface IOrderService {

    List<Order> getAllOrders();

    List<Order> getOrdersByStatus(OrderStatus status);

    Order getOrderById(Long id);

    @Transactional
    Order createOrderFromCart(OrderRequest orderRequest);

    @Transactional
    Order updateOrderStatus(Long id, String status);

    @Transactional
    void deleteOrder(Long id);

    /**
     * Convert Order entity to OrderResponse DTO with variant options included
     */
    OrderResponse convertToOrderResponse(Order order);
}
