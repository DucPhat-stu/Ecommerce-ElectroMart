# Middleware Documentation

## Overview

Middleware in this application consists of filters and interceptors that process HTTP requests and responses. These components are responsible for authentication, validation, logging, and error handling.

---

## 1. Middleware Architecture

```
HTTP Request
    ↓
ValidationFilter (Check Content-Type, Body Size)
    ↓
AuthenticationFilter (Verify Bearer Token)
    ↓
RequestLoggingInterceptor (Log Request)
    ↓
Controller Handler
    ↓
Response Processing
    ↓
RequestLoggingInterceptor (Log Response)
    ↓
HTTP Response
```

---

## 2. ValidationFilter

### Purpose
Validates all incoming HTTP requests before they reach the controller.

### Location
`com.store.electro.Middleware.ValidationFilter`

### Responsibilities

#### 2.1 Content-Type Validation
- **Applies to**: POST, PUT requests
- **Required**: `Content-Type: application/json`
- **Error Response** (400 Bad Request):
```json
{
    "success": false,
    "message": "Content-Type must be application/json"
}
```

#### 2.2 Request Size Validation
- **Applies to**: All requests
- **Limit**: 10 MB (10,485,760 bytes)
- **Error Response** (400 Bad Request):
```json
{
    "success": false,
    "message": "Request body too large (max 10MB)"
}
```

### Implementation
```java
@Component
public class ValidationFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, 
                                   HttpServletResponse response,
                                   FilterChain filterChain) throws ServletException, IOException {
        // Validate method-specific headers
        // Validate request size
        // Pass to next filter
    }
}
```

### Filter Order
**Order: 1** (Runs first)

---

## 3. AuthenticationFilter

### Purpose
Verifies the authentication token for protected endpoints.

### Location
`com.store.electro.Middleware.AuthenticationFilter`

### Responsibilities

#### 3.1 Token Extraction
- Reads `Authorization` header
- Expected format: `Bearer <token>`

#### 3.2 Token Validation
- Calls `UserService.validateToken(token)`
- Validates token format and expiration

#### 3.3 Public Endpoint Handling
Allows requests to public endpoints without authentication:
- `POST /auth/login`
- `POST /auth/register`
- `GET /products`
- `GET /products/{id}`
- `GET /reviews/product/{productId}`

#### 3.4 Error Handling
```json
{
    "success": false,
    "message": "Missing or invalid token",
    "code": 401
}
```

### Implementation
```java
@Component
public class AuthenticationFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, 
                                   HttpServletResponse response,
                                   FilterChain filterChain) throws ServletException, IOException {
        // Check if endpoint is public
        if (isPublicEndpoint(request.getRequestURI())) {
            filterChain.doFilter(request, response);
            return;
        }
        
        // Extract and validate token
        String token = extractToken(request);
        if (!isValidToken(token)) {
            sendUnauthorizedResponse(response);
            return;
        }
        
        // Extract user ID and attach to request
        Long userId = extractUserIdFromToken(token);
        request.setAttribute("userId", userId);
        
        filterChain.doFilter(request, response);
    }
}
```

### Filter Order
**Order: 2** (Runs after ValidationFilter)

### Public Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/auth/login` | POST | User login |
| `/api/v1/auth/register` | POST | User registration |
| `/api/v1/products` | GET | List all products |
| `/api/v1/products/{id}` | GET | Get product details |
| `/api/v1/reviews/product/{productId}` | GET | Get product reviews |

### Protected Endpoints
All other endpoints require valid Bearer token:
- `/api/v1/auth/users/**`
- `/api/v1/cart/**`
- `/api/v1/orders/**`
- `/api/v1/reviews` (create/update/delete)

---

## 4. RequestLoggingInterceptor

### Purpose
Logs all HTTP requests and responses for monitoring and debugging.

### Location
`com.store.electro.Middleware.RequestLoggingInterceptor`

### Features

#### 4.1 Pre-Request Logging
- Log method and URL
- Log client IP address
- Record start time

```
REQUEST: POST /api/v1/auth/login from 192.168.1.100
REQUEST: GET /api/v1/products from 192.168.1.100
```

#### 4.2 Post-Response Logging
- Log response status code
- Log request duration
- Identify slow requests

```
RESPONSE: POST /api/v1/auth/login - Status: 200 - Duration: 125ms
RESPONSE: GET /api/v1/products - Status: 200 - Duration: 85ms
```

### Implementation
```java
public class RequestLoggingInterceptor implements HandlerInterceptor {
    private static final Logger logger = LoggerFactory.getLogger(...);
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        long startTime = System.currentTimeMillis();
        request.setAttribute("startTime", startTime);
        
        logger.info("REQUEST: {} {} from {}", 
                   request.getMethod(), 
                   request.getRequestURI(),
                   request.getRemoteAddr());
        return true;
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
                               Object handler, Exception ex) {
        long startTime = (Long) request.getAttribute("startTime");
        long duration = System.currentTimeMillis() - startTime;
        
        logger.info("RESPONSE: {} {} - Status: {} - Duration: {}ms", 
                   request.getMethod(), 
                   request.getRequestURI(),
                   response.getStatus(), 
                   duration);
    }
}
```

### Configuration
```java
@Configuration
public class FilterConfiguration implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new RequestLoggingInterceptor())
                .addPathPatterns("/api/**");
    }
}
```

### Log Output Examples

#### Successful Request
```
2024-01-15 14:30:00 INFO - REQUEST: POST /api/v1/auth/login from 192.168.1.100
2024-01-15 14:30:00 INFO - RESPONSE: POST /api/v1/auth/login - Status: 200 - Duration: 145ms
```

#### Validation Error
```
2024-01-15 14:31:00 INFO - REQUEST: POST /api/v1/cart from 192.168.1.101
2024-01-15 14:31:00 INFO - RESPONSE: POST /api/v1/cart - Status: 400 - Duration: 23ms
```

#### Authentication Error
```
2024-01-15 14:32:00 INFO - REQUEST: GET /api/v1/auth/users from 192.168.1.102
2024-01-15 14:32:00 INFO - RESPONSE: GET /api/v1/auth/users - Status: 401 - Duration: 5ms
```

---

## 5. Filter Registration

### Configuration File
`com.store.electro.Config.WebFilterConfiguration`

### Registration Order
```java
@Configuration
public class WebFilterConfiguration {
    
    @Bean
    public FilterRegistrationBean<ValidationFilter> validationFilter() {
        FilterRegistrationBean<ValidationFilter> bean = new FilterRegistrationBean<>();
        bean.setFilter(new ValidationFilter());
        bean.addUrlPatterns("/api/*");
        bean.setOrder(1);  // Runs first
        return bean;
    }
    
    @Bean
    public FilterRegistrationBean<AuthenticationFilter> authenticationFilter() {
        FilterRegistrationBean<AuthenticationFilter> bean = new FilterRegistrationBean<>();
        bean.setFilter(new AuthenticationFilter(userService));
        bean.addUrlPatterns("/api/*");
        bean.setOrder(2);  // Runs after ValidationFilter
        return bean;
    }
}
```

---

## 6. Error Handling in Middleware

### 6.1 Validation Errors (400)
```json
{
    "success": false,
    "message": "Content-Type must be application/json",
    "error": {
        "code": "VALIDATION_ERROR"
    }
}
```

### 6.2 Authentication Errors (401)
```json
{
    "success": false,
    "message": "Missing or invalid token",
    "error": {
        "code": "UNAUTHORIZED"
    }
}
```

### 6.3 Size Limit Errors (413)
```json
{
    "success": false,
    "message": "Request body too large (max 10MB)",
    "error": {
        "code": "PAYLOAD_TOO_LARGE"
    }
}
```

---

## 7. Token Validation Flow

```
1. Extract token from Authorization header
   ↓
2. Check token format (Bearer <token>)
   ↓
3. Validate token using UserService.validateToken()
   ↓
4. Extract user ID from token
   ↓
5. Attach userId to request attributes
   ↓
6. Allow request to proceed
```

### Token Structure (Current Implementation)
Format: `token_<userId>_<timestamp>`

Example: `token_1_1705316400000`

**Note**: In production, replace with JWT tokens using libraries like `io.jsonwebtoken`.

---

## 8. Adding Custom Middleware

### Example: Rate Limiting Middleware
```java
@Component
public class RateLimitingFilter extends OncePerRequestFilter {
    private final RateLimitService rateLimitService;
    
    @Override
    protected void doFilterInternal(HttpServletRequest request, 
                                   HttpServletResponse response,
                                   FilterChain filterChain) throws ServletException, IOException {
        String clientIp = request.getRemoteAddr();
        
        if (!rateLimitService.allowRequest(clientIp)) {
            response.setStatus(HttpServletResponse.SC_TOO_MANY_REQUESTS);
            response.getWriter().write("{\"error\": \"Rate limit exceeded\"}");
            return;
        }
        
        filterChain.doFilter(request, response);
    }
}
```

### Register in WebFilterConfiguration
```java
@Bean
public FilterRegistrationBean<RateLimitingFilter> rateLimitingFilter() {
    FilterRegistrationBean<RateLimitingFilter> bean = new FilterRegistrationBean<>();
    bean.setFilter(new RateLimitingFilter(rateLimitService));
    bean.addUrlPatterns("/api/*");
    bean.setOrder(0);  // Run before ValidationFilter
    return bean;
}
```

---

## 9. Middleware Configuration Best Practices

### 9.1 URL Patterns
```java
// Protect specific endpoints
bean.addUrlPatterns("/api/auth/users/*");
bean.addUrlPatterns("/api/cart/*");
bean.addUrlPatterns("/api/orders/*");

// OR use wildcards
bean.addUrlPatterns("/api/*");
```

### 9.2 Excluding Patterns
```java
// Note: addUrlPatterns doesn't support exclusions
// Use logic inside filters instead
if (isPublicEndpoint(request.getRequestURI())) {
    filterChain.doFilter(request, response);
    return;
}
```

### 9.3 Filter Order
```
Priority (Order value):
Order 0 → Rate limiting
Order 1 → Validation
Order 2 → Authentication
Order 3 → Custom logic
```

Lower order values execute first.

---

## 10. Testing Middleware

### 10.1 Unit Test Example
```java
@WebMvcTest(YourController.class)
public class MiddlewareTest {
    
    @Autowired
    private MockMvc mockMvc;
    
    @Test
    public void testMissingContentType() throws Exception {
        mockMvc.perform(post("/api/v1/auth/login")
                .contentType(MediaType.TEXT_PLAIN)
                .content("{}"))
            .andExpect(status().isBadRequest());
    }
    
    @Test
    public void testMissingAuthToken() throws Exception {
        mockMvc.perform(get("/api/v1/auth/users"))
            .andExpect(status().isUnauthorized());
    }
    
    @Test
    public void testValidAuthToken() throws Exception {
        mockMvc.perform(get("/api/v1/auth/users")
                .header("Authorization", "Bearer token_1_123456"))
            .andExpect(status().isOk());
    }
}
```

### 10.2 Integration Test Example
```bash
# Test with missing Content-Type
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: text/plain" \
  -d "{}"

# Test with missing token
curl -X GET http://localhost:8080/api/v1/auth/users

# Test with valid token
curl -X GET http://localhost:8080/api/v1/auth/users \
  -H "Authorization: Bearer token_1_123456"
```

---

## 11. Performance Considerations

### 11.1 Filter Overhead
- ValidationFilter: ~1-2ms (header checks)
- AuthenticationFilter: ~5-10ms (token validation)
- RequestLoggingInterceptor: ~2-3ms (logging)

### 11.2 Optimization Tips
1. Cache public endpoint list
2. Use request attributes instead of creating new objects
3. Minimize synchronous I/O in filters
4. Log only necessary information

---

## 12. Security Considerations

### 12.1 Token Security
- Never log tokens in full
- Use HTTPS in production
- Implement token rotation
- Add token expiration

### 12.2 Request Size
- Enforce reasonable limits (10MB current)
- Prevent denial-of-service attacks

### 12.3 Public Endpoints
- Review periodically
- Ensure sensitive operations are protected
- Consider IP whitelist for admin operations

---

## 13. Future Enhancements

### 13.1 JWT Integration
```java
// Replace simple token with JWT
String token = Jwts.builder()
    .setSubject(user.getId().toString())
    .setIssuedAt(new Date())
    .setExpiration(new Date(System.currentTimeMillis() + 86400000))
    .signWith(SignatureAlgorithm.HS512, SECRET_KEY)
    .compact();
```

### 13.2 Rate Limiting
```java
// Implement rate limiting per IP/user
if (rateLimitService.isRateLimited(clientIp)) {
    response.setStatus(429);
    return;
}
```

### 13.3 CORS Configuration
```java
@Configuration
public class CorsConfiguration implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
            .allowedOrigins("https://example.com")
            .allowedMethods("GET", "POST", "PUT", "DELETE");
    }
}
```

---

## Changelog

### Version 1.0 (2024-01-15)
- Initial middleware implementation
- ValidationFilter for request validation
- AuthenticationFilter for token verification
- RequestLoggingInterceptor for logging
- Filter registration and configuration

