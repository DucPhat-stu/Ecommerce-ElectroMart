# Third API Specification - REST Standard

## Overview

This document describes the RESTful API specification for the ElectroMart authentication and user management module, ensuring consistency, security, and best practices.

---

## 1. API Base URL

```
http://localhost:8080/api/v1
https://api.electromart.com/api/v1  (Production)
```

---

## 2. Authentication

### 2.1 Token Type
- **Type**: Bearer Token (JWT-compatible)
- **Format**: `Authorization: Bearer <token>`
- **Expiration**: 24 hours (86400 seconds)

### 2.2 Public Endpoints (No Auth Required)
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `GET /products` - List all products
- `GET /products/{id}` - Get product details
- `GET /reviews/product/{productId}` - Get product reviews

### 2.3 Protected Endpoints (Auth Required)
- All other endpoints require valid Bearer token

---

## 3. Request/Response Format

### 3.1 Standard Response Format

#### Success Response (HTTP 2xx)
```json
{
    "success": true,
    "message": "Operation successful",
    "data": {
        ...
    },
    "timestamp": "2024-01-15T10:30:00"
}
```

#### Error Response (HTTP 4xx, 5xx)
```json
{
    "success": false,
    "message": "Error description",
    "error": {
        "code": "ERROR_CODE",
        "details": "Detailed error message"
    },
    "timestamp": "2024-01-15T10:30:00"
}
```

### 3.2 Content-Type
- **Request**: `Content-Type: application/json` (for POST/PUT)
- **Response**: `Content-Type: application/json`

### 3.3 HTTP Status Codes

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Successful GET/PUT/DELETE |
| 201 | Created | Successful POST |
| 204 | No Content | Successful DELETE with no response body |
| 400 | Bad Request | Invalid request body/parameters |
| 401 | Unauthorized | Missing or invalid authentication token |
| 403 | Forbidden | Authenticated but not authorized |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Resource already exists (duplicate) |
| 422 | Unprocessable Entity | Validation error |
| 500 | Internal Server Error | Server error |

---

## 4. Authentication Endpoints

### 4.1 User Registration
```
POST /auth/register
Content-Type: application/json

Request Body:
{
    "username": "john_doe",
    "email": "john@example.com",
    "password": "Password123",
    "fullName": "John Doe",
    "phone": "0901234567"
}

Response (201):
{
    "success": true,
    "message": "User registered successfully",
    "data": {
        "id": 1,
        "username": "john_doe",
        "email": "john@example.com",
        "fullName": "John Doe",
        "phone": "0901234567",
        "roleId": 1,
        "status": "ACTIVE",
        "createdAt": "2024-01-15T10:30:00"
    }
}

Error Response (400):
{
    "success": false,
    "message": "Registration failed",
    "error": {
        "code": "REGISTRATION_ERROR",
        "details": "Username already exists"
    }
}
```

**Validation Rules:**
- `username`: Required, unique, 3-50 characters
- `email`: Required, unique, valid email format
- `password`: Required, minimum 6 characters
- `fullName`: Optional, max 255 characters
- `phone`: Optional, max 20 characters

---

### 4.2 User Login
```
POST /auth/login
Content-Type: application/json

Request Body:
{
    "username": "john_doe",
    "password": "Password123"
}

Response (200):
{
    "success": true,
    "message": "Login successful",
    "data": {
        "accessToken": "token_1_1705316400000",
        "tokenType": "Bearer",
        "expiresIn": 86400,
        "userId": 1,
        "username": "john_doe",
        "email": "john@example.com"
    }
}

Error Response (401):
{
    "success": false,
    "message": "Login failed",
    "error": {
        "code": "INVALID_CREDENTIALS",
        "details": "Invalid username or password"
    }
}
```

---

## 5. User Management Endpoints

### 5.1 Get All Users
```
GET /auth/users
Authorization: Bearer <token>

Response (200):
{
    "success": true,
    "message": "Users retrieved successfully",
    "data": [
        {
            "id": 1,
            "username": "john_doe",
            "email": "john@example.com",
            "fullName": "John Doe",
            "phone": "0901234567",
            "roleId": 1,
            "status": "ACTIVE",
            "createdAt": "2024-01-15T10:30:00"
        }
    ]
}
```

---

### 5.2 Get User by ID
```
GET /auth/users/{id}
Authorization: Bearer <token>

Response (200):
{
    "success": true,
    "message": "User found",
    "data": {
        "id": 1,
        "username": "john_doe",
        "email": "john@example.com",
        "fullName": "John Doe",
        "phone": "0901234567",
        "address": "123 Main St, City",
        "roleId": 1,
        "status": "ACTIVE",
        "emailVerified": false,
        "createdAt": "2024-01-15T10:30:00",
        "updatedAt": "2024-01-15T10:30:00",
        "lastLogin": "2024-01-15T14:22:00"
    }
}
```

---

### 5.3 Get User by Username
```
GET /auth/users/username/{username}
Authorization: Bearer <token>

Example: GET /auth/users/username/john_doe
```

---

### 5.4 Get User by Email
```
GET /auth/users/email/{email}
Authorization: Bearer <token>

Example: GET /auth/users/email/john@example.com
```

---

### 5.5 Update User
```
PUT /auth/users/{id}
Authorization: Bearer <token>
Content-Type: application/json

Request Body (all fields optional):
{
    "email": "newemail@example.com",
    "fullName": "John Updated",
    "phone": "0987654321",
    "address": "456 New St, City",
    "status": "ACTIVE",
    "roleId": 1
}

Response (200):
{
    "success": true,
    "message": "User updated successfully",
    "data": {
        "id": 1,
        "username": "john_doe",
        "email": "newemail@example.com",
        "fullName": "John Updated",
        ...
    }
}
```

---

### 5.6 Delete User
```
DELETE /auth/users/{id}
Authorization: Bearer <token>

Response (200):
{
    "success": true,
    "message": "User deleted successfully",
    "data": null
}

Error Response (404):
{
    "success": false,
    "message": "User not found",
    "error": {
        "code": "USER_NOT_FOUND",
        "details": "User with id 999 does not exist"
    }
}
```

---

### 5.7 Change Password
```
POST /auth/users/{id}/change-password
Authorization: Bearer <token>
Content-Type: application/json

Request Body:
{
    "oldPassword": "OldPassword123",
    "newPassword": "NewPassword456"
}

Response (200):
{
    "success": true,
    "message": "Password changed successfully",
    "data": {
        "id": 1,
        "username": "john_doe",
        "email": "john@example.com",
        ...
    }
}

Error Response (400):
{
    "success": false,
    "message": "Failed to change password",
    "error": {
        "code": "PASSWORD_ERROR",
        "details": "Old password is incorrect"
    }
}
```

---

## 6. Error Codes Reference

| Code | Description | HTTP Status |
|------|-------------|-------------|
| REGISTRATION_ERROR | Registration validation failed | 400 |
| INVALID_CREDENTIALS | Login credentials are incorrect | 401 |
| USER_NOT_FOUND | User does not exist | 404 |
| DUPLICATE_USERNAME | Username already exists | 400 |
| DUPLICATE_EMAIL | Email already exists | 400 |
| PASSWORD_ERROR | Password change failed | 400 |
| INVALID_TOKEN | Token is invalid or expired | 401 |
| UNAUTHORIZED | Missing authentication token | 401 |
| VALIDATION_ERROR | Request validation failed | 422 |
| INTERNAL_ERROR | Server error | 500 |

---

## 7. Request Validation

### 7.1 Pre-Request Validation (Middleware)
- Content-Type validation (must be `application/json` for POST/PUT)
- Request body size limit (max 10MB)
- Token format validation

### 7.2 Field Validation Rules

#### Username
- Required for registration and login
- 3-50 characters
- Alphanumeric and underscore only
- Unique in database

#### Email
- Required for registration
- Valid email format
- Unique in database
- Maximum 255 characters

#### Password
- Required
- Minimum 6 characters
- Must contain letters and numbers (recommended)
- Encrypted using BCrypt (not transmitted in responses)

#### Phone
- Optional
- Format: 10-20 digits
- International format supported

#### Address
- Optional
- Maximum 1000 characters
- Supports special characters

---

## 8. Rate Limiting (Future Enhancement)

```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1705316400
```

- **Limit**: 100 requests per hour
- **Window**: 1 hour rolling window

---

## 9. Pagination (Future Enhancement)

For list endpoints:
```
GET /auth/users?page=1&limit=10&sort=createdAt:desc

Response:
{
    "success": true,
    "data": [...],
    "pagination": {
        "page": 1,
        "limit": 10,
        "total": 150,
        "totalPages": 15
    }
}
```

---

## 10. API Documentation Endpoints

- **Swagger UI**: `http://localhost:8080/swagger-ui.html`
- **API Docs JSON**: `http://localhost:8080/v3/api-docs`
- **Postman Collection**: Available in `/postman` folder

---

## 11. Security Best Practices

1. **HTTPS Only** (Production)
   - All API calls must use HTTPS
   - Redirect HTTP to HTTPS

2. **CORS Configuration**
   - Allow specific origins only
   - Restrict methods to necessary ones
   - Include credentials when needed

3. **Rate Limiting**
   - Protect against brute force attacks
   - Implement on login and registration endpoints

4. **Token Security**
   - Never expose tokens in logs
   - Use HTTPS for token transmission
   - Implement token refresh mechanism

5. **Password Security**
   - Never return password hash in responses
   - Use BCrypt for hashing
   - Minimum 6 characters (recommend 8+)

6. **Data Validation**
   - Validate all inputs
   - Sanitize special characters
   - Prevent SQL injection

---

## 12. Testing

### Manual Testing with cURL

#### Register User
```bash
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "email": "john@example.com",
    "password": "Password123",
    "fullName": "John Doe"
  }'
```

#### Login
```bash
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "john_doe",
    "password": "Password123"
  }'
```

#### Get User (with token)
```bash
curl -X GET http://localhost:8080/api/v1/auth/users/1 \
  -H "Authorization: Bearer token_1_1705316400000"
```

---

## 13. Changelog

### Version 1.0 (2024-01-15)
- Initial API specification
- Authentication endpoints (login, register)
- User management CRUD
- Middleware for validation and authentication
- Error handling and response format standardization

---

## Support

For API issues or questions:
1. Check the documentation
2. Review error messages and error codes
3. Check application logs
4. Contact development team
