package com.store.electro.Controllers;

import java.util.List;

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

import com.store.electro.Models.DTOs.Request.OrderStatusRequest;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Entity.OrderDetail;
import com.store.electro.Models.Entity.ProductVariant;
import com.store.electro.Models.Entity.User;
import com.store.electro.Models.Enums.OrderStatus;
import com.store.electro.Repositories.OrderRepository;
import com.store.electro.Repositories.ProductVariantRepository;
import com.store.electro.Repositories.UserRepository;
import com.store.electro.Services.OrderService;
import com.store.electro.Utils.ApiResponse;

import jakarta.persistence.EntityNotFoundException;

@RestController
@RequestMapping("/api")
public class OrderController {

    private final OrderRepository orderRepo;
    private final UserRepository userRepo;
    private final ProductVariantRepository productVariantRepo;
    private final OrderService orderService;

    public OrderController(OrderRepository orderRepo, UserRepository userRepo,
            ProductVariantRepository productVariantRepo, OrderService orderService) {
        this.orderRepo = orderRepo;
        this.userRepo = userRepo;
        this.productVariantRepo = productVariantRepo;
        this.orderService = orderService;
    }

    // Get all orders (admin dashboard)
    @GetMapping("/v1/orders")
    public ResponseEntity<ApiResponse<List<Order>>> getAllOrders(
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
        return ResponseEntity.ok(ApiResponse.success("Orders retrieved successfully", orders));
    }

    @GetMapping("/v1/orders/{id}")
    public ResponseEntity<Order> getOrder(@PathVariable Long id) {
        Order order = orderRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Order not found with id: " + id));
        return ResponseEntity.ok(order);
    }

    // Update order status (admin dashboard)
    @PutMapping("/v1/orders/{id}/status")
    public ResponseEntity<ApiResponse<Order>> updateOrderStatus(
            @PathVariable Long id,
            @RequestBody OrderStatusRequest request) {
        Order updated = orderService.updateOrderStatus(id, request.getStatus());
        return ResponseEntity.ok(ApiResponse.success("Order status updated", updated));
    }

    // Delete order (admin dashboard)
    @DeleteMapping("/v1/orders/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteOrder(@PathVariable Long id) {
        orderService.deleteOrder(id);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Order deleted successfully", null));
    }

    @PostMapping("/v1/orders")
    public Order createOrder() {
        Order order = new Order();

        User user = userRepo.findById(1L)
                .orElseThrow(() -> new EntityNotFoundException("Not found!"));

        ProductVariant productVariant1 = productVariantRepo.findById(1L)
                .orElseThrow(() -> new EntityNotFoundException("Not found!"));

        ProductVariant productVariant2 = productVariantRepo.findById(2L)
                .orElseThrow(() -> new EntityNotFoundException("Not found!"));

        order.setUser(user);
        order.setShippingAddress("Test address");
        order.setShippingPhone("0909000000");
        order.setShippingName("Test User");

        OrderDetail d1 = new OrderDetail();
        d1.setOrder(order); // 🔥 FK
        d1.setProduct(productVariant1); // FK
        d1.setProductName(productVariant1.getProduct().getName());
        d1.setProductPrice(productVariant1.getFinalPrice());
        d1.setQuantity(2);

        OrderDetail d2 = new OrderDetail();
        d2.setOrder(order);
        d2.setProduct(productVariant2);
        d2.setProductName(productVariant2.getProduct().getName());
        d2.setProductPrice(productVariant2.getFinalPrice());
        d2.setQuantity(1);

        order.getOrderDetails().add(d1);
        order.getOrderDetails().add(d2);

        // 7. Total (test nhanh)
        order.setTotalPrice(
                d1.getSubtotal().add(d2.getSubtotal()));

        return orderRepo.save(order);
    }

}
