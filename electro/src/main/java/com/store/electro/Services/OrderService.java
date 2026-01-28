package com.store.electro.Services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Exceptions.ResourceNotFoundException;
import com.store.electro.Models.DTOs.Request.OrderRequest;
import com.store.electro.Models.DTOs.Response.OrderDetailResponse;
import com.store.electro.Models.DTOs.Response.OrderResponse;
import com.store.electro.Models.Entity.Cart;
import com.store.electro.Models.Entity.Inventory;
import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Entity.OrderDetail;
import com.store.electro.Models.Entity.Product.VariantOption;
import com.store.electro.Models.Entity.User;
import com.store.electro.Models.Enums.OrderStatus;
import com.store.electro.Repositories.CartRepository;
import com.store.electro.Repositories.InventoryRepository;
import com.store.electro.Repositories.OrderRepository;
import com.store.electro.Repositories.UserRepository;

import jakarta.persistence.EntityNotFoundException;

@Service
public class OrderService implements IOrderService {

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final CartRepository cartRepository;
    private final InventoryRepository inventoryRepository;

    public OrderService(OrderRepository orderRepository, UserRepository userRepository,
            CartRepository cartRepository, InventoryRepository inventoryRepository) {
        this.orderRepository = orderRepository;
        this.userRepository = userRepository;
        this.cartRepository = cartRepository;
        this.inventoryRepository = inventoryRepository;
    }

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public List<Order> getOrdersByStatus(OrderStatus status) {
        return orderRepository.findByStatus(status);
    }

    @Override
    public Order getOrderById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Order not found with id: " + id));
    }

    @Transactional
    @Override
    public Order createOrderFromCart(OrderRequest orderRequest) {
        // Validate request
        if (orderRequest.getUserId() == null) {
            throw new IllegalArgumentException("User ID is required");
        }
        if (orderRequest.getShippingName() == null || orderRequest.getShippingName().isBlank()) {
            throw new IllegalArgumentException("Shipping name is required");
        }
        if (orderRequest.getShippingPhone() == null || orderRequest.getShippingPhone().isBlank()) {
            throw new IllegalArgumentException("Shipping phone is required");
        }
        if (orderRequest.getShippingAddress() == null || orderRequest.getShippingAddress().isBlank()) {
            throw new IllegalArgumentException("Shipping address is required");
        }

        // Get user
        User user = userRepository.findById(orderRequest.getUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User not found with id: " + orderRequest.getUserId()));

        // Get user's cart items
        List<Cart> cartItems = cartRepository.findByUserId(orderRequest.getUserId());
        
        if (cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("Cart is empty. Cannot create order");
        }

        // Create order
        Order order = new Order();
        order.setUser(user);
        order.setShippingName(orderRequest.getShippingName());
        order.setShippingPhone(orderRequest.getShippingPhone());
        order.setShippingAddress(orderRequest.getShippingAddress());
        order.setStatus(OrderStatus.PENDING);

        // Create order details from cart items
        BigDecimal totalPrice = BigDecimal.ZERO;
        
        for (Cart cartItem : cartItems) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(cartItem.getProduct());
            orderDetail.setProductName(cartItem.getProduct().getProduct().getName());
            orderDetail.setProductPrice(cartItem.getProduct().calculatePrice());
            orderDetail.setQuantity(cartItem.getQuantity());
            // Subtotal is calculated in OrderDetail.calculateSubtotal()
            
            order.getOrderDetails().add(orderDetail);
            totalPrice = totalPrice.add(orderDetail.getSubtotal());

            // Reserve inventory for this order
            Inventory inventory = inventoryRepository.findByProductVariantId(cartItem.getProduct().getId())
                    .orElseThrow(() -> new ResourceNotFoundException(
                            "Inventory not found for variant: " + cartItem.getProduct().getId()));
            inventory.reserve(cartItem.getQuantity());
            inventoryRepository.save(inventory);
        }

        order.setTotalPrice(totalPrice);

        // Save order
        Order savedOrder = orderRepository.save(order);

        // Clear user's cart
        cartRepository.deleteByUserId(orderRequest.getUserId());

        return savedOrder;
    }

    @Transactional
    @Override
    public Order updateOrderStatus(Long id, String status) {
        Order order = getOrderById(id);
        try {
            OrderStatus orderStatus = OrderStatus.valueOf(status.toUpperCase());
            order.setStatus(orderStatus);
            return orderRepository.save(order);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid order status: " + status);
        }
    }

    @Transactional
    @Override
    public void deleteOrder(Long id) {
        Order order = getOrderById(id);
        orderRepository.delete(order);
    }

    /**
     * Convert Order entity to OrderResponse DTO with variant options included
     */
    @Override
    public OrderResponse convertToOrderResponse(Order order) {
        OrderResponse response = new OrderResponse();
        response.setId(order.getId());
        response.setUserId(order.getUser() != null ? order.getUser().getId() : null);
        response.setTotalPrice(order.getTotalPrice());
        response.setStatus(order.getStatus() != null ? order.getStatus().name().toLowerCase() : null);
        response.setShippingAddress(order.getShippingAddress());
        response.setShippingPhone(order.getShippingPhone());
        response.setShippingName(order.getShippingName());
        response.setCreatedAt(order.getCreatedAt());
        response.setUpdatedAt(order.getUpdatedAt());

        // Convert order details with variant options
        List<OrderDetailResponse> detailResponses = order.getOrderDetails()
                .stream()
                .map(this::convertToOrderDetailResponse)
                .collect(Collectors.toList());
        response.setOrderDetails(detailResponses);

        return response;
    }

    /**
     * Convert OrderDetail entity to OrderDetailResponse DTO with variant options
     */
    private OrderDetailResponse convertToOrderDetailResponse(OrderDetail detail) {
        OrderDetailResponse response = new OrderDetailResponse();
        response.setId(detail.getId());
        response.setProductId(detail.getProductId());
        response.setProductName(detail.getProductName());
        response.setProductPrice(detail.getProductPrice());
        response.setDiscountPercent(detail.getDiscountPercent());
        response.setQuantity(detail.getQuantity());
        response.setSubtotal(detail.getSubtotal());
        response.setCreatedAt(detail.getCreatedAt());

        // Extract variant options if product exists
        if (detail.getProduct() != null && detail.getProduct().getOptions() != null) {
            List<OrderDetailResponse.VariantOptionInfo> optionInfos = detail.getProduct()
                    .getOptions()
                    .stream()
                    .map(this::convertToVariantOptionInfo)
                    .collect(Collectors.toList());
            response.setOptions(optionInfos);
        } else {
            response.setOptions(new ArrayList<>());
        }

        return response;
    }

    /**
     * Convert VariantOption entity to VariantOptionInfo DTO
     */
    private OrderDetailResponse.VariantOptionInfo convertToVariantOptionInfo(VariantOption option) {
        String optionName = option.getOption() != null ? option.getOption().getCode() : "Unknown";
        String optionValue = option.getValue();
        BigDecimal extraPrice = option.getExtraPrice() != null ? option.getExtraPrice() : BigDecimal.ZERO;

        return new OrderDetailResponse.VariantOptionInfo(optionName, optionValue, extraPrice);
    }
}
