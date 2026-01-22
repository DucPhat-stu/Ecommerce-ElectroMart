# 🛒 ElectroMart - E-Commerce Platform

Modern e-commerce platform built with Spring Boot backend, MySQL database, and static HTML/CSS/JS frontend.

## 🏗️ Architecture

```
Client (Browser) → Nginx (Port 80) → Spring Boot Backend (Port 8080) → MySQL Database (Port 3307)
```

## 📦 Tech Stack

### Backend
- **Framework**: Spring Boot 4.0.1
- **Language**: Java 17
- **ORM**: Spring Data JPA (Hibernate)
- **Security**: Spring Security + JWT
- **Build Tool**: Maven
- **Database**: MySQL 8.0

### Frontend
- HTML5, CSS3, JavaScript
- Bootstrap 3
- jQuery, Slick Carousel

### DevOps
- **Containerization**: Docker & Docker Compose
- **Web Server**: Nginx (reverse proxy + static files)

## 🚀 Quick Start

### Prerequisites
- Docker Desktop installed and running
- Java 17 (for local development)
- Maven (included via Maven Wrapper)

### Start the Application

```powershell
# 1. Start Docker Desktop (wait until running)

# 2. Start all services
docker compose up -d

# 3. Check status
docker compose ps

# 4. View logs
docker compose logs -f be
```

### Access the Application

- **Frontend**: http://localhost
- **Backend API**: http://localhost:8080/api/v1/...
- **Database**: localhost:3307 (user: user, password: 123123)

## 📖 Documentation

### Getting Started
- [**Quick Start Guide**](./QUICK-START.md) - Get up and running in minutes
- [**Member 1 Backend Setup**](./MEMBER1-BACKEND-SETUP-GUIDE.md) - Complete backend configuration guide
- [**Docker Guide**](./Docker-README.md) - Detailed Docker setup and commands

### API Documentation
- [**API Documentation**](./docs/API-Documentation.md) - Complete API reference
- [**API Specification**](./docs/API-Specification.md) - API design and standards
- [**Testing Guide**](./docs/TESTING-GUIDE.md) - How to test the APIs

### Database & Architecture
- [**Database Mapping**](./docs/Database-Mapping.md) - Database schema documentation
- [**Middleware Documentation**](./docs/Middleware-Documentation.md) - Authentication, logging, validation

### Postman Collection
Import the collection for easy API testing:
- **File**: `postman/ElectroMart-API-Collection.json`
- **Base URL**: http://localhost:8080

## 🧪 Testing APIs

### Register a User
```powershell
$body = @{
    username = "testuser"
    email = "test@electromart.com"
    password = "password123"
    fullName = "Test User"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/auth/register" `
    -Method POST -ContentType "application/json" -Body $body
```

### Login
```powershell
$loginBody = @{
    email = "test@electromart.com"
    password = "password123"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/auth/login" `
    -Method POST -ContentType "application/json" -Body $loginBody
```

## 📁 Project Structure

```
Ecommerce-ElectroMart/
├── electro/                    # Spring Boot Backend
│   ├── src/main/java/
│   │   └── com/store/electro/
│   │       ├── Config/         # Security, Web configuration
│   │       ├── Controllers/    # REST API endpoints
│   │       ├── Models/         # Entity, DTO, Enums
│   │       ├── Repositories/   # JPA Repositories
│   │       ├── Services/       # Business logic
│   │       ├── Middleware/     # Filters, Interceptors
│   │       └── Utils/          # JWT, ApiResponse utilities
│   ├── src/main/resources/
│   │   ├── application.properties
│   │   └── db/
│   │       ├── init.sql        # Database schema
│   │       └── sampledata.sql  # Sample data
│   └── pom.xml                 # Maven dependencies
├── fe/                         # Frontend (HTML/CSS/JS)
├── nginx/                      # Nginx configuration
├── docs/                       # Documentation
├── postman/                    # Postman collection
├── docker-compose.yml          # Docker orchestration
├── .env                        # Environment variables (local)
└── .env.example                # Environment template
```

## 🛠️ Development

### Running Backend Locally (with Docker DB)

```powershell
# Start database only
docker compose up -d db

# Run backend with Maven
cd electro
.\mvnw.cmd spring-boot:run
```

### Environment Variables

Copy `.env.example` to `.env` and configure:

```env
SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3307/ElectroStore...
SPRING_DATASOURCE_USERNAME=user
SPRING_DATASOURCE_PASSWORD=123123
JWT_SECRET=your-secret-key-here
SERVER_PORT=8080
```

### Database Access

```powershell
# Via Docker
docker exec -it mysql mysql -uuser -p123123 ElectroStore

# Via MySQL Workbench
Host: localhost
Port: 3307
User: user
Password: 123123
Database: ElectroStore
```

## 🔧 Common Commands

```powershell
# Start all services
docker compose up -d

# Stop all services
docker compose down

# Rebuild and start
docker compose up -d --build

# View logs
docker compose logs -f

# Remove volumes (fresh database)
docker compose down -v

# Check service status
docker compose ps
```

## 🎯 Team Tasks

### ✅ Member 1 - Backend Developer
- [x] Complete CRUD REST APIs
- [x] Standardize JSON response format
- [x] Configure environment variables (.env)
- [x] Prepare database migration scripts
- [x] Testing and documentation

### Member 2 - Database Engineer
- Design & implement database schema
- Write migration scripts (SQL)
- Seed sample data
- Verify database connectivity

### Member 3 - Frontend Developer
- Complete frontend structure (routing, layout)
- Fix localhost connectivity issues
- Integrate with backend APIs
- Setup environment variables for FE

### Member 4 - DevOps / Integration
- Create & configure docker-compose.yml
- Setup port mapping and networking
- Test container startup
- Write deployment documentation

## 📝 API Response Format

All APIs follow a standardized response format:

### Success Response
```json
{
  "success": true,
  "message": "Operation successful",
  "data": { ... },
  "timestamp": "2026-01-20T09:00:00"
}
```

### Error Response
```json
{
  "success": false,
  "message": "Operation failed",
  "error": {
    "code": "ERROR_CODE",
    "details": "Error description"
  },
  "timestamp": "2026-01-20T09:00:00"
}
```

## 🔐 Authentication

The API uses JWT (JSON Web Tokens) for authentication:

1. Register or login to get a JWT token
2. Include token in subsequent requests:
   ```
   Authorization: Bearer <your-jwt-token>
   ```

## 🐛 Troubleshooting

See [QUICK-START.md](./QUICK-START.md) for common issues and solutions.

## 📄 License

Educational project for learning purposes.

## 👥 Contributors

- **Member 1**: Backend API Development
- **Member 2**: Database Design & Implementation
- **Member 3**: Frontend Development
- **Member 4**: DevOps & Integration

## 🔗 Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Docker Documentation](https://docs.docker.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [JWT.io](https://jwt.io/) - Learn about JSON Web Tokens
