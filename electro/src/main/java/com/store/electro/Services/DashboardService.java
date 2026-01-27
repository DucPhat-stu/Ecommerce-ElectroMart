package com.store.electro.Services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
                .sorted(Comparator.<Map.Entry<String, BigDecimal[]>, BigDecimal>comparing(
                        e -> e.getValue()[0], BigDecimal::compareTo).reversed())
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

    /**
     * Get statistics summary (revenue, cost, profit, profit rate)
     */
    public Map<String, Object> getStatisticsSummary() {
        List<Order> allOrders = orderRepository.findAll();
        
        BigDecimal totalRevenue = allOrders.stream()
                .map(Order::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // Cost is assumed to be 60% of revenue
        BigDecimal totalCost = totalRevenue.multiply(BigDecimal.valueOf(0.6))
                .setScale(2, RoundingMode.HALF_UP);
        
        BigDecimal totalProfit = totalRevenue.subtract(totalCost);
        
        BigDecimal profitRate = BigDecimal.ZERO;
        if (totalRevenue.compareTo(BigDecimal.ZERO) > 0) {
            profitRate = totalProfit.divide(totalRevenue, 4, RoundingMode.HALF_UP)
                    .multiply(BigDecimal.valueOf(100))
                    .setScale(2, RoundingMode.HALF_UP);
        }

        Map<String, Object> stats = new LinkedHashMap<>();
        stats.put("totalRevenue", totalRevenue);
        stats.put("totalCost", totalCost);
        stats.put("totalProfit", totalProfit);
        stats.put("profitRate", profitRate);
        
        return stats;
    }

    /**
     * Get revenue by month for the last 6 months
     */
    public List<Map<String, Object>> getRevenueByMonth() {
        List<Order> allOrders = orderRepository.findAll();
        LocalDate now = LocalDate.now();
        
        Map<YearMonth, BigDecimal> revenueByMonth = new LinkedHashMap<>();
        
        // Initialize last 6 months
        for (int i = 5; i >= 0; i--) {
            YearMonth month = YearMonth.from(now.minusMonths(i));
            revenueByMonth.put(month, BigDecimal.ZERO);
        }
        
        // Calculate revenue for each month
        for (Order order : allOrders) {
            if (order.getCreatedAt() != null) {
                YearMonth orderMonth = YearMonth.from(order.getCreatedAt());
                if (revenueByMonth.containsKey(orderMonth)) {
                    BigDecimal current = revenueByMonth.get(orderMonth);
                    revenueByMonth.put(orderMonth, current.add(order.getTotalPrice()));
                }
            }
        }
        
        return revenueByMonth.entrySet().stream()
                .map(entry -> {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("month", entry.getKey().toString());
                    row.put("revenue", entry.getValue());
                    return row;
                })
                .collect(Collectors.toList());
    }

    /**
     * Get order status distribution
     */
    public Map<String, Long> getOrderStatusDistribution() {
        List<Order> allOrders = orderRepository.findAll();
        
        Map<String, Long> distribution = new LinkedHashMap<>();
        distribution.put("PENDING", 0L);
        distribution.put("CONFIRMED", 0L);
        distribution.put("SHIPPED", 0L);
        distribution.put("DELIVERED", 0L);
        distribution.put("CANCELLED", 0L);
        
        for (Order order : allOrders) {
            if (order.getStatus() != null) {
                String status = order.getStatus().name();
                distribution.put(status, distribution.getOrDefault(status, 0L) + 1);
            }
        }
        
        return distribution;
    }

    /**
     * Get profit details by month
     */
    public List<Map<String, Object>> getProfitDetailsByMonth() {
        List<Order> allOrders = orderRepository.findAll();
        LocalDate now = LocalDate.now();
        
        Map<YearMonth, BigDecimal[]> profitByMonth = new LinkedHashMap<>();
        
        // Initialize last 6 months
        for (int i = 5; i >= 0; i--) {
            YearMonth month = YearMonth.from(now.minusMonths(i));
            profitByMonth.put(month, new BigDecimal[] { BigDecimal.ZERO, BigDecimal.ZERO });
        }
        
        // Calculate revenue and cost for each month
        for (Order order : allOrders) {
            if (order.getCreatedAt() != null) {
                YearMonth orderMonth = YearMonth.from(order.getCreatedAt());
                if (profitByMonth.containsKey(orderMonth)) {
                    BigDecimal[] arr = profitByMonth.get(orderMonth);
                    arr[0] = arr[0].add(order.getTotalPrice()); // revenue
                    arr[1] = arr[1].add(order.getTotalPrice().multiply(BigDecimal.valueOf(0.6))); // cost
                }
            }
        }
        
        return profitByMonth.entrySet().stream()
                .map(entry -> {
                    BigDecimal revenue = entry.getValue()[0];
                    BigDecimal cost = entry.getValue()[1];
                    BigDecimal profit = revenue.subtract(cost);
                    BigDecimal rate = BigDecimal.ZERO;
                    if (revenue.compareTo(BigDecimal.ZERO) > 0) {
                        rate = profit.divide(revenue, 4, RoundingMode.HALF_UP)
                                .multiply(BigDecimal.valueOf(100))
                                .setScale(2, RoundingMode.HALF_UP);
                    }
                    
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("month", entry.getKey().toString());
                    row.put("revenue", revenue.setScale(2, RoundingMode.HALF_UP));
                    row.put("cost", cost.setScale(2, RoundingMode.HALF_UP));
                    row.put("profit", profit.setScale(2, RoundingMode.HALF_UP));
                    row.put("rate", rate);
                    return row;
                })
                .collect(Collectors.toList());
    }
}
