package com.store.electro.Controllers;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Services.DashboardService;
import com.store.electro.Utils.ApiResponse;

/**
 * Admin Dashboard Controller
 * Provides API endpoints for admin dashboard functionality
 */
@RestController
@RequestMapping("${api.prefix}/admin")
public class AdminDashboardController {

    private final DashboardService dashboardService;

    public AdminDashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    /**
     * Get dashboard summary (total users, products, orders, revenue)
     * GET /api/v1/admin/dashboard/summary
     */
    @GetMapping("/dashboard/summary")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getDashboardSummary() {
        Map<String, Object> summary = dashboardService.getSummary();
        return ResponseEntity.ok(ApiResponse.success("Dashboard summary retrieved successfully", summary));
    }

    /**
     * Get recent orders
     * GET /api/v1/admin/dashboard/recent-orders?limit=5
     */
    @GetMapping("/dashboard/recent-orders")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> getRecentOrders(
            @RequestParam(defaultValue = "5") int limit) {
        List<Map<String, Object>> recentOrders = dashboardService.getRecentOrders(limit);
        return ResponseEntity.ok(ApiResponse.success("Recent orders retrieved successfully", recentOrders));
    }

    /**
     * Get top selling products
     * GET /api/v1/admin/dashboard/top-products?limit=5
     */
    @GetMapping("/dashboard/top-products")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> getTopProducts(
            @RequestParam(defaultValue = "5") int limit) {
        List<Map<String, Object>> topProducts = dashboardService.getTopProducts(limit);
        return ResponseEntity.ok(ApiResponse.success("Top products retrieved successfully", topProducts));
    }

    /**
     * Get statistics summary (revenue, cost, profit, profit rate)
     * GET /api/v1/admin/statistics/summary
     */
    @GetMapping("/statistics/summary")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getStatisticsSummary() {
        Map<String, Object> stats = dashboardService.getStatisticsSummary();
        return ResponseEntity.ok(ApiResponse.success("Statistics summary retrieved successfully", stats));
    }

    /**
     * Get revenue by month (last 6 months)
     * GET /api/v1/admin/statistics/revenue-by-month
     */
    @GetMapping("/statistics/revenue-by-month")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> getRevenueByMonth() {
        List<Map<String, Object>> revenueByMonth = dashboardService.getRevenueByMonth();
        return ResponseEntity.ok(ApiResponse.success("Revenue by month retrieved successfully", revenueByMonth));
    }

    /**
     * Get order status distribution
     * GET /api/v1/admin/statistics/order-status-distribution
     */
    @GetMapping("/statistics/order-status-distribution")
    public ResponseEntity<ApiResponse<Map<String, Long>>> getOrderStatusDistribution() {
        Map<String, Long> distribution = dashboardService.getOrderStatusDistribution();
        return ResponseEntity.ok(ApiResponse.success("Order status distribution retrieved successfully", distribution));
    }

    /**
     * Get profit details by month
     * GET /api/v1/admin/statistics/profit-details
     */
    @GetMapping("/statistics/profit-details")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> getProfitDetails() {
        List<Map<String, Object>> profitDetails = dashboardService.getProfitDetailsByMonth();
        return ResponseEntity.ok(ApiResponse.success("Profit details retrieved successfully", profitDetails));
    }
}
