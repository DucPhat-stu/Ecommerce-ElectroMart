package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTO.OrderRequest;
import com.store.electro.Models.DTO.OrderStatusRequest;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Services.OrderService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("/api/v1/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Order>> createOrder(@RequestBody OrderRequest request) {
        try {
            Order order = orderService.createOrder(request);
            return ResponseEntity.status(201).body(ApiResponse.success("Order created successfully", order));
        } catch (RuntimeException e) {
            if (e.getMessage().contains("Cart is empty")) {
                return ResponseEntity.status(400)
                        .body(ApiResponse.error("Cart is empty", "EMPTY_CART", e.getMessage()));
            } else if (e.getMessage().contains("Insufficient stock")) {
                return ResponseEntity.status(400)
                        .body(ApiResponse.error("Insufficient stock", "INSUFFICIENT_STOCK", e.getMessage()));
            }
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to create order", "ORDER_ERROR", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to create order", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<List<Order>>> getUserOrders(@PathVariable Long userId) {
        try {
            List<Order> orders = orderService.getUserOrders(userId);
            return ResponseEntity.ok(ApiResponse.success("Orders retrieved successfully", orders));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve orders", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<ApiResponse<Order>> getOrderById(@PathVariable Long orderId) {
        try {
            Order order = orderService.getOrderById(orderId);
            return ResponseEntity.ok(ApiResponse.success("Order found", order));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("Order not found", "ORDER_NOT_FOUND", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve order", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @PutMapping("/{orderId}/status")
    public ResponseEntity<ApiResponse<Order>> updateOrderStatus(@PathVariable Long orderId,
            @RequestBody OrderStatusRequest request) {
        try {
            Order order = orderService.updateOrderStatus(orderId, request);
            return ResponseEntity.ok(ApiResponse.success("Order status updated successfully", order));
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                return ResponseEntity.status(404)
                        .body(ApiResponse.error("Order not found", "ORDER_NOT_FOUND", e.getMessage()));
            }
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to update order status", "INVALID_STATUS", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to update order status", "INTERNAL_ERROR", e.getMessage()));
        }
    }
}