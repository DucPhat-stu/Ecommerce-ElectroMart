package com.store.electro.Services;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.DTO.OrderRequest;
import com.store.electro.Models.DTO.OrderStatusRequest;
import com.store.electro.Models.Entity.Cart;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Entity.OrderItem;
import com.store.electro.Models.Entity.Product;
import com.store.electro.Models.Enums.OrderStatus;
import com.store.electro.Repositories.CartRepository;
import com.store.electro.Repositories.OrderRepository;
import com.store.electro.Repositories.ProductRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    public OrderService(OrderRepository orderRepository, CartRepository cartRepository,
            ProductRepository productRepository) {
        this.orderRepository = orderRepository;
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
    }

    @Transactional
    public Order createOrder(OrderRequest request) {
        // Get cart items
        List<Cart> cartItems = cartRepository.findByUserId(request.getUserId());

        if (cartItems.isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        // Validate stock for all products
        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();
            if (product.getStockQuantity() < cartItem.getQuantity()) {
                throw new RuntimeException(
                        "Insufficient stock for product: " + product.getName() + ". Available: "
                                + product.getStockQuantity());
            }
        }

        // Create order
        Order order = new Order();
        order.setOrderNumber(generateOrderNumber());
        order.setUserId(request.getUserId());
        order.setShippingName(request.getShippingName());
        order.setShippingPhone(request.getShippingPhone());
        order.setShippingAddress(request.getShippingAddress());
        order.setNotes(request.getNotes());
        order.setStatus(OrderStatus.PENDING);

        // Calculate amounts
        BigDecimal totalAmount = BigDecimal.ZERO;
        BigDecimal discountAmount = BigDecimal.ZERO;

        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();

            // Calculate price
            BigDecimal itemPrice = product.getPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity()));
            BigDecimal itemDiscount = BigDecimal.ZERO;

            if (product.getDiscountPercent() != null && product.getDiscountPercent() > 0) {
                itemDiscount = itemPrice.multiply(BigDecimal.valueOf(product.getDiscountPercent()))
                        .divide(BigDecimal.valueOf(100));
            }

            BigDecimal itemSubtotal = itemPrice.subtract(itemDiscount);

            totalAmount = totalAmount.add(itemPrice);
            discountAmount = discountAmount.add(itemDiscount);

            // Create order item
            OrderItem orderItem = new OrderItem(
                    product.getId(),
                    product.getName(),
                    product.getPrice(),
                    product.getDiscountPercent(),
                    cartItem.getQuantity(),
                    itemSubtotal);

            order.addOrderItem(orderItem);

            // Update stock
            product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
            productRepository.save(product);
        }

        // Set shipping fee (fixed for now, can be dynamic)
        BigDecimal shippingFee = BigDecimal.valueOf(20.00);
        order.setShippingFee(shippingFee);

        // Calculate final amount
        BigDecimal finalAmount = totalAmount.subtract(discountAmount).add(shippingFee);

        order.setTotalAmount(totalAmount);
        order.setDiscountAmount(discountAmount);
        order.setFinalAmount(finalAmount);

        // Save order
        order = orderRepository.save(order);

        // Clear cart
        cartRepository.deleteByUserId(request.getUserId());

        return order;
    }

    public List<Order> getUserOrders(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    @Transactional
    public Order getOrderById(Long orderId) {
        return orderRepository.findByIdWithItems(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found with id: " + orderId));
    }

    @Transactional
    public Order updateOrderStatus(Long orderId, OrderStatusRequest request) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found with id: " + orderId));

        OrderStatus newStatus = OrderStatus.valueOf(request.getStatus());
        order.setStatus(newStatus);

        if (request.getAdminNotes() != null) {
            order.setAdminNotes(request.getAdminNotes());
        }

        // Update timestamp based on status
        LocalDateTime now = LocalDateTime.now();
        switch (newStatus) {
            case CONFIRMED:
                order.setConfirmedAt(now);
                break;
            case SHIPPED:
                order.setShippedAt(now);
                break;
            case DELIVERED:
                order.setDeliveredAt(now);
                break;
            case CANCELLED:
                order.setCancelledAt(now);
                // Restore stock
                restoreStock(order);
                break;
            default:
                break;
        }

        return orderRepository.save(order);
    }

    private void restoreStock(Order order) {
        for (OrderItem item : order.getOrderItems()) {
            Product product = productRepository.findById(item.getProductId()).orElse(null);
            if (product != null) {
                product.setStockQuantity(product.getStockQuantity() + item.getQuantity());
                productRepository.save(product);
            }
        }
    }

    private String generateOrderNumber() {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        return "ORD" + timestamp;
    }
}