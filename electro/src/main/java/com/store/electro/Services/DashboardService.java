package com.store.electro.Services;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Entity.OrderDetail;
import com.store.electro.Repositories.OrderRepository;
import com.store.electro.Repositories.ProductRepository;
import com.store.electro.Repositories.UserRepository;

@Service
public class DashboardService {

    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public DashboardService(UserRepository userRepository, ProductRepository productRepository,
            OrderRepository orderRepository) {
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
    }

    public Map<String, Object> getSummary() {
        long totalUsers = userRepository.count();
        long totalProducts = productRepository.count();
        List<Order> allOrders = orderRepository.findAll();
        long totalOrders = allOrders.size();
        BigDecimal totalRevenue = allOrders.stream()
                .map(Order::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Map<String, Object> m = new LinkedHashMap<>();
        m.put("totalUsers", totalUsers);
        m.put("totalProducts", totalProducts);
        m.put("totalOrders", totalOrders);
        m.put("totalRevenue", totalRevenue);
        return m;
    }

    public List<Map<String, Object>> getRecentOrders(int limit) {
        List<Order> orders = orderRepository.findAll().stream()
                .sorted(Comparator.comparing(Order::getCreatedAt, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(limit)
                .toList();

        List<Map<String, Object>> result = new ArrayList<>();
        for (Order o : orders) {
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("id", o.getId());
            row.put("customer", o.getUser() != null ? o.getUser().getFullName() : o.getShippingName());
            row.put("total", o.getTotalPrice());
            row.put("status", o.getStatus() != null ? o.getStatus().getValue() : null);
            result.add(row);
        }
        return result;
    }

    public List<Map<String, Object>> getTopProducts(int limit) {
        Map<String, BigDecimal[]> byName = new LinkedHashMap<>();
        for (Order o : orderRepository.findAll()) {
            for (OrderDetail d : o.getOrderDetails()) {
                String name = d.getProductName();
                byName.computeIfAbsent(name, k -> new BigDecimal[] { BigDecimal.ZERO, BigDecimal.ZERO });
                BigDecimal[] arr = byName.get(name);
                arr[0] = arr[0].add(BigDecimal.valueOf(d.getQuantity()));
                arr[1] = arr[1].add(d.getSubtotal() != null ? d.getSubtotal() : BigDecimal.ZERO);
            }
        }
        return byName.entrySet().stream()
                .sorted(Comparator.<Map.Entry<String, BigDecimal[]>>comparing(e -> e.getValue()[0], BigDecimal::compareTo).reversed())
                .limit(limit)
                .map(e -> {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("productName", e.getKey());
                    row.put("sold", e.getValue()[0].longValue());
                    row.put("revenue", e.getValue()[1]);
                    return row;
                })
                .toList();
    }
}
