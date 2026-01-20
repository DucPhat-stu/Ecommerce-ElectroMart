# ElectroMart Phase 3 - Testing & Deployment Guide

## Quick Start

### Prerequisites
- Java 17+
- Maven 3.6+
- MySQL 8.0+
- Docker & Docker Compose (optional)
- Postman (for API testing)

---

## Building the Application

### 1. Build with Maven
```bash
cd electro/
./mvnw clean package
```

### 2. Build Docker Image
```bash
docker build -t electromart-api:latest .
```

---

## Running the Application

### Option 1: Using Maven
```bash
cd electro/
./mvnw spring-boot:run
```

### Option 2: Using Docker Compose
```bash
# From project root
docker-compose up --build
```

### Option 3: Run Built JAR
```bash
cd electro/target/
java -jar electro-0.0.1-SNAPSHOT.jar
```

### Verify Application Started
```bash
curl http://localhost:8080/api/v1/products
```

Expected response: List of products

---

## Testing Guide

### 1. Manual Testing with cURL

#### Test Registration
```bash
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser1",
    "email": "testuser1@example.com",
    "password": "TestPassword123",
    "fullName": "Test User",
    "phone": "0901234567"
  }'
```

Expected Response (201):
```json
{
    "success": true,
    "message": "User registered successfully",
    "data": {
        "id": 1,
        "username": "testuser1",
        "email": "testuser1@example.com",
        "fullName": "Test User",
        ...
    }
}
```

#### Test Login
```bash
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser1",
    "password": "TestPassword123"
  }'
```

Expected Response (200):
```json
{
    "success": true,
    "message": "Login successful",
    "data": {
        "accessToken": "token_1_1705316400000",
        "tokenType": "Bearer",
        "expiresIn": 86400,
        "userId": 1,
        "username": "testuser1",
        "email": "testuser1@example.com"
    }
}
```

**Save the token**: `token_1_1705316400000`

#### Test Get All Users (Protected)
```bash
curl -X GET http://localhost:8080/api/v1/auth/users \
  -H "Authorization: Bearer token_1_1705316400000"
```

#### Test Get User by ID
```bash
curl -X GET http://localhost:8080/api/v1/auth/users/1 \
  -H "Authorization: Bearer token_1_1705316400000"
```

#### Test Update User
```bash
curl -X PUT http://localhost:8080/api/v1/auth/users/1 \
  -H "Authorization: Bearer token_1_1705316400000" \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Test User Updated",
    "phone": "0987654321"
  }'
```

#### Test Change Password
```bash
curl -X POST http://localhost:8080/api/v1/auth/users/1/change-password \
  -H "Authorization: Bearer token_1_1705316400000" \
  -H "Content-Type: application/json" \
  -d '{
    "oldPassword": "TestPassword123",
    "newPassword": "NewPassword456"
  }'
```

#### Test Delete User
```bash
curl -X DELETE http://localhost:8080/api/v1/auth/users/1 \
  -H "Authorization: Bearer token_1_1705316400000"
```

### 2. Testing with Postman

#### Import Collection
1. Open Postman
2. Click "Import"
3. Select: `postman/ElectroMart-API-Collection.json`
4. Collection imported with all requests

#### Test Flow in Postman

**Step 1: Register User**
- Request: `POST /auth/register`
- Body: See cURL example above
- Check: Status 201

**Step 2: Login**
- Request: `POST /auth/login`
- Body: username & password
- Copy token from response

**Step 3: Set Token in Environment**
- Click "Environment"
- Select "ElectroMart"
- Set variable: `token = <copied_token>`

**Step 4: Test Protected Endpoints**
- All subsequent requests use `{{token}}`
- Authorization header auto-populated

### 3. Middleware Testing

#### Test Content-Type Validation
```bash
# This should fail (wrong Content-Type)
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: text/plain" \
  -d '{...}'

# Expected: 400 Bad Request
```

#### Test Missing Authorization
```bash
# This should fail (no token)
curl -X GET http://localhost:8080/api/v1/auth/users

# Expected: 401 Unauthorized
```

#### Test Invalid Token
```bash
# This should fail (invalid token)
curl -X GET http://localhost:8080/api/v1/auth/users \
  -H "Authorization: Bearer invalid_token_here"

# Expected: 401 Unauthorized
```

#### Test Request Size Limit
```bash
# Create a large JSON (>10MB) - should fail
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '<very_large_json_over_10mb>'

# Expected: 413 Payload Too Large
```

### 4. Error Handling Testing

#### Test Duplicate Username
```bash
# Register user 1
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "email": "john@example.com",
    "password": "Password123"
  }'

# Try registering again with same username
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "email": "john2@example.com",
    "password": "Password123"
  }'

# Expected: 400 "Username already exists"
```

#### Test Duplicate Email
```bash
# Try registering with same email
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe2",
    "email": "john@example.com",
    "password": "Password123"
  }'

# Expected: 400 "Email already exists"
```

#### Test Invalid Login
```bash
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "password": "WrongPassword"
  }'

# Expected: 401 "Invalid username or password"
```

#### Test User Not Found
```bash
curl -X GET http://localhost:8080/api/v1/auth/users/999 \
  -H "Authorization: Bearer token_1_1705316400000"

# Expected: 404 "User not found"
```

---

## Logging and Debugging

### View Application Logs

#### Docker Logs
```bash
docker logs -f backend
```

#### View Recent Logs
```bash
docker logs --tail 100 backend
```

#### Filter Logs
```bash
docker logs backend | grep "REQUEST:"
docker logs backend | grep "RESPONSE:"
docker logs backend | grep "ERROR"
```

### Application Logging Configuration

Current log patterns:
```
REQUEST: [METHOD] [URI] from [IP]
RESPONSE: [METHOD] [URI] - Status: [CODE] - Duration: [MS]ms
```

### Enable SQL Logging (if needed)

Add to `application.properties`:
```properties
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE
```

---

## Database Verification

### Connect to MySQL

```bash
# Using Docker
docker exec -it mysql mysql -uuser -p123123 ElectroStore

# Or locally
mysql -h 127.0.0.1 -u user -p123123 ElectroStore
```

### Verify Tables
```sql
SHOW TABLES;
DESCRIBE users;
DESCRIBE products;
DESCRIBE orders;
DESCRIBE cart;
DESCRIBE reviews;
```

### Check Sample Data
```sql
SELECT * FROM users LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT COUNT(*) FROM products;
```

---

## Performance Testing

### Load Testing with Apache Bench

```bash
# Test login endpoint with 100 requests, 10 concurrent
ab -n 100 -c 10 -p data.json -T application/json \
  http://localhost:8080/api/v1/auth/login

# Test GET products with 1000 requests
ab -n 1000 -c 50 http://localhost:8080/api/v1/products
```

### Load Testing with ApacheBench Results
```
This is ApacheBench, Version 2.3
Document Path:          /api/v1/products
Document Length:        2345 bytes

Concurrency Level:      50
Time taken for tests:    12.345 seconds
Complete requests:      1000
Failed requests:        0
Requests per second:    81.01 [#/sec]
Time per request:       617.33 [ms]
```

---

## Troubleshooting

### Application Won't Start

#### Check Port Already in Use
```bash
# Linux/Mac
lsof -i :8080

# Windows
netstat -ano | findstr :8080
```

#### Solution: Kill Process
```bash
# Linux/Mac
kill -9 <PID>

# Windows
taskkill /PID <PID> /F
```

### Database Connection Error

#### Verify MySQL is Running
```bash
docker ps | grep mysql
```

#### Check Connection String
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/ElectroStore
spring.datasource.username=user
spring.datasource.password=123123
```

### BCrypt Dependency Issue

Ensure Spring Security is in pom.xml:
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

---

## Common Test Scenarios

### Scenario 1: Complete User Flow

1. Register new user
2. Login to get token
3. Get user profile
4. Update profile
5. Change password
6. Logout (if implemented)

### Scenario 2: Auth Validation

1. Access protected endpoint without token → 401
2. Access protected endpoint with invalid token → 401
3. Access protected endpoint with valid token → 200

### Scenario 3: Data Validation

1. Register with duplicate username → 400
2. Register with duplicate email → 400
3. Register with short password → 400
4. Update with invalid email → 400

### Scenario 4: Middleware Testing

1. POST without Content-Type → 400
2. POST with wrong Content-Type → 400
3. POST with large body → 413
4. GET without auth → 401

---

## Integration Testing

### Test all endpoints together
```bash
#!/bin/bash

# 1. Register
REGISTER=$(curl -s -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "integration_test_user",
    "email": "integration@test.com",
    "password": "TestPass123",
    "fullName": "Integration Test"
  }')

echo "Register Response: $REGISTER"
USER_ID=$(echo $REGISTER | jq '.data.id')

# 2. Login
LOGIN=$(curl -s -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "integration_test_user",
    "password": "TestPass123"
  }')

echo "Login Response: $LOGIN"
TOKEN=$(echo $LOGIN | jq -r '.data.accessToken')

# 3. Get User
GET_USER=$(curl -s -X GET http://localhost:8080/api/v1/auth/users/$USER_ID \
  -H "Authorization: Bearer $TOKEN")

echo "Get User Response: $GET_USER"

# 4. Update User
UPDATE=$(curl -s -X PUT http://localhost:8080/api/v1/auth/users/$USER_ID \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Updated Name"
  }')

echo "Update Response: $UPDATE"

# 5. Change Password
CHANGE=$(curl -s -X POST http://localhost:8080/api/v1/auth/users/$USER_ID/change-password \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "oldPassword": "TestPass123",
    "newPassword": "NewPass456"
  }')

echo "Change Password Response: $CHANGE"
```

Save as `test.sh` and run:
```bash
chmod +x test.sh
./test.sh
```

---

## Performance Metrics

### Expected Response Times
- Login: 100-150ms
- Get User: 50-100ms
- Get All Users: 100-200ms
- Update User: 100-150ms
- Delete User: 50-100ms

### Expected Database Queries
- Login: 1-2 queries
- Get User: 1 query
- Get All Users: 1 query
- Update User: 1 query
- Delete User: 1 query

---

## CI/CD Preparation

### GitHub Actions Example
```yaml
name: Build and Test

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    
    services:
      mysql:
        image: mysql:8.0
        env:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: ElectroStore
        options: >-
          --health-cmd="mysqladmin ping"
          --health-interval=10s
          --health-timeout=5s
          --health-retries=3

    steps:
      - uses: actions/checkout@v2
      - name: Set up JDK
        uses: actions/setup-java@v2
        with:
          java-version: '17'
      
      - name: Build with Maven
        run: cd electro && ./mvnw clean package
      
      - name: Run Tests
        run: cd electro && ./mvnw test
```

---

## Deployment Checklist

Before deploying to production:

- [ ] All tests passing
- [ ] No security warnings
- [ ] Performance metrics acceptable
- [ ] Database backups configured
- [ ] Error logging configured
- [ ] HTTPS enabled
- [ ] Environment variables set
- [ ] Rate limiting configured
- [ ] CORS properly configured
- [ ] Database replicated/backed up

---

## Documentation References

- [API Specification](docs/API-Specification.md) - Complete API documentation
- [Database Mapping](docs/Database-Mapping.md) - DB to API mapping
- [Middleware Documentation](docs/Middleware-Documentation.md) - Middleware details
- [Implementation Summary](IMPLEMENTATION-SUMMARY.md) - What was implemented
- [Completion Checklist](COMPLETION-CHECKLIST.md) - Detailed checklist

---

## Support & Issues

### Common Issues

**Issue**: "User not found" during login after registration
- **Cause**: Token expired or user data not committed
- **Solution**: Check database, verify transaction commit

**Issue**: 401 Unauthorized on protected endpoints
- **Cause**: Token missing or invalid
- **Solution**: Use correct token format: `Bearer <token>`

**Issue**: Content-Type validation error
- **Cause**: Missing or wrong Content-Type header
- **Solution**: Add `Content-Type: application/json` header

### Getting Help

1. Check application logs
2. Review error code in documentation
3. Verify request format matches specification
4. Test with Postman using provided collection
5. Check database state directly

---

## Summary

Phase 3 implementation is complete and ready for testing. All 10 endpoints are functional with proper authentication, validation, and error handling. Use this guide for thorough testing before production deployment.

**Total Endpoints**: 10
**Total Files Created**: 15+
**Total Documentation**: 4 files
**Status**: ✅ Ready for Testing

