package com.store.electro.Controllers;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTOs.Request.OrderRequest;
import com.store.electro.Models.DTOs.Request.OrderStatusRequest;
import com.store.electro.Models.DTOs.Response.OrderResponse;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Enums.OrderStatus;
import com.store.electro.Repositories.OrderRepository;
import com.store.electro.Services.IOrderService;
import com.store.electro.Utils.ApiResponse;

import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;

@RestController
@RequestMapping("${api.prefix}")
public class OrderController {

    private final OrderRepository orderRepo;
    private final IOrderService orderService;

    public OrderController(OrderRepository orderRepo, IOrderService orderService) {
        this.orderRepo = orderRepo;
        this.orderService = orderService;
    }

    // Get all orders (admin dashboard)
    @GetMapping("/orders")
    public ResponseEntity<ApiResponse<List<OrderResponse>>> getAllOrders(
            @RequestParam(required = false) String status) {
        List<Order> orders;
        if (status != null && !status.isBlank()) {
            try {
                OrderStatus s = OrderStatus.valueOf(status.toUpperCase());
                orders = orderService.getOrdersByStatus(s);
            } catch (IllegalArgumentException e) {
                orders = orderService.getAllOrders();
            }
        } else {
            orders = orderService.getAllOrders();
        }
        // Convert to response DTOs with variant options
        List<OrderResponse> orderResponses = orders.stream()
                .map(orderService::convertToOrderResponse)
                .collect(Collectors.toList());
        return ResponseEntity.ok(ApiResponse.success("Orders retrieved successfully", orderResponses));
    }

    // Get order by ID
    @GetMapping("/orders/{id}")
    public ResponseEntity<OrderResponse> getOrder(@PathVariable Long id) {
        Order order = orderRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Order not found with id: " + id));
        // Convert to response DTO with variant options
        OrderResponse response = orderService.convertToOrderResponse(order);
        return ResponseEntity.ok(response);
    }

    // Create order from cart
    @PostMapping("/orders")
    public ResponseEntity<ApiResponse<OrderResponse>> createOrder(@Valid @RequestBody OrderRequest orderRequest) {
        try {
            Order createdOrder = orderService.createOrderFromCart(orderRequest);
            // Convert to response DTO with variant options
            OrderResponse response = orderService.convertToOrderResponse(createdOrder);
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(ApiResponse.success("Order created successfully", response));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(ApiResponse.error(e.getMessage()));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error("Error creating order: " + e.getMessage()));
        }
    }

    // Update order status (admin dashboard)
    @PutMapping("/orders/{id}/status")
    public ResponseEntity<ApiResponse<OrderResponse>> updateOrderStatus(
            @PathVariable Long id,
            @RequestBody OrderStatusRequest request) {
        Order updated = orderService.updateOrderStatus(id, request.getStatus());
        // Convert to response DTO with variant options
        OrderResponse response = orderService.convertToOrderResponse(updated);
        return ResponseEntity.ok(ApiResponse.success("Order status updated", response));
    }

    // Delete order (admin dashboard)
    @DeleteMapping("/orders/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteOrder(@PathVariable Long id) {
        orderService.deleteOrder(id);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Order deleted successfully", null));
    }

}
