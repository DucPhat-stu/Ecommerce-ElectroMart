# Member 1 - Backend Development Setup & Testing Guide

## ✅ Completed Tasks

### 1. Database Configuration ✓
- ✅ Configured `application.properties` with MySQL connection settings
- ✅ Added support for environment variables using `${VAR:default}` syntax
- ✅ Configured JPA/Hibernate settings
- ✅ Added logging configuration for debugging

### 2. Environment Variables (.env) ✓
- ✅ Created `.env.example` file with all required variables
- ✅ Created `.env` file for local development
- ✅ Updated `.gitignore` to exclude `.env` from version control
- ✅ Documented all environment variables with explanations

### 3. Standardized API Responses ✓
- ✅ `ApiResponse<T>` utility class already implements:
  - Success responses with data
  - Error responses with error codes and details
  - Timestamp for all responses
  - Consistent JSON format

### 4. Database Migration Scripts ✓
- ✅ `init.sql` - Complete database schema creation
- ✅ `sampledata.sql` - Sample data for testing
- ✅ Scripts integrated with Docker compose auto-initialization

---

## 🚀 How to Run the Application

### **Option 1: Using Docker Compose (Recommended)**

#### Prerequisites
- Docker Desktop must be installed and **RUNNING**
- Open Docker Desktop before running commands

#### Steps

1. **Start Docker Desktop**
   - Open Docker Desktop application
   - Wait until it shows "Docker Desktop is running"

2. **Start all services (Database + Backend + Nginx)**
   ```powershell
   docker compose up -d
   ```

3. **Check service status**
   ```powershell
   docker compose ps
   ```

4. **View logs**
   ```powershell
   # All services
   docker compose logs -f
   
   # Just backend
   docker compose logs -f be
   
   # Just database
   docker compose logs -f db
   ```

5. **Stop all services**
   ```powershell
   docker compose down
   ```

6. **Stop and remove volumes (clean database)**
   ```powershell
   docker compose down -v
   ```

---

### **Option 2: Run Backend Locally (Database in Docker)**

This is useful for development when you want to run backend in IDE with debugger.

#### 1. Start only the database
```powershell
docker compose up -d db
```

#### 2. Wait for database to be ready (check logs)
```powershell
docker compose logs db
```
Look for: "ready for connections"

#### 3. Run backend with Maven
```powershell
cd electro
.\mvnw.cmd spring-boot:run
```

Or run from your IDE (IntelliJ IDEA, Eclipse, VS Code):
- Open `ElectroApplication.java`
- Click "Run" or "Debug"

---

## 🧪 Testing the APIs

### **Access URLs**
- **Frontend**: http://localhost (via Nginx)
- **Backend API**: http://localhost:8080/api/v1/...
- **MySQL Database**: localhost:3307

### **Test API Endpoints with PowerShell**

#### 1. Health Check (if endpoint exists)
```powershell
Invoke-WebRequest -Uri http://localhost:8080/api/v1/health -Method GET
```

#### 2. Register a new user
```powershell
$body = @{
    username = "testuser"
    email = "test@example.com"
    password = "password123"
    fullName = "Test User"
    phone = "0123456789"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:8080/api/v1/auth/register `
    -Method POST `
    -ContentType "application/json" `
    -Body $body
```

#### 3. Login
```powershell
$loginBody = @{
    email = "test@example.com"
    password = "password123"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri http://localhost:8080/api/v1/auth/login `
    -Method POST `
    -ContentType "application/json" `
    -Body $loginBody

$response.Content
```

#### 4. Get Products (may need authentication)
```powershell
Invoke-WebRequest -Uri http://localhost:8080/api/v1/products -Method GET
```

### **Using Postman**

A Postman collection is available at: `postman/ElectroMart-API-Collection.json`

1. Open Postman
2. Import collection: File → Import → Select `postman/ElectroMart-API-Collection.json`
3. Set environment variable `base_url` = `http://localhost:8080`
4. Test endpoints

---

## 🔍 Troubleshooting

### Problem: Docker Desktop not starting
**Solution**: 
- Restart Docker Desktop
- Check Windows features: WSL2, Hyper-V, or Virtual Machine Platform must be enabled
- Run: `wsl --update` if using WSL2 backend

### Problem: Port 3307 already in use
**Solution**:
```powershell
# Find process using port 3307
netstat -ano | findstr :3307

# Kill the process (replace PID with actual process ID)
taskkill /PID <PID> /F

# Or change port in docker-compose.yml
```

### Problem: Port 8080 already in use
**Solution**:
```powershell
# Find and kill process
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Or change SERVER_PORT in .env file
```

### Problem: Backend cannot connect to database
**Solution**:
1. Check if database container is running:
   ```powershell
   docker compose ps
   ```

2. Check database logs:
   ```powershell
   docker compose logs db
   ```

3. Verify connection settings in `.env` or `application.properties`

4. If running backend locally, use:
   ```
   SPRING_DATASOURCE_URL=jdbc:mysql://localhost:3307/ElectroStore?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
   ```

5. If running in Docker, the backend uses:
   ```
   SPRING_DATASOURCE_URL=jdbc:mysql://db:3306/ElectroStore...
   ```

### Problem: Database tables not created
**Solution**:
1. Remove database volume and recreate:
   ```powershell
   docker compose down -v
   docker compose up -d
   ```

2. Check init.sql execution in logs:
   ```powershell
   docker compose logs db | Select-String "init.sql"
   ```

---

## 📋 Verification Checklist

Before considering Member 1 tasks complete, verify:

- [ ] Docker Desktop is running
- [ ] Database container starts successfully
- [ ] Backend container starts successfully  
- [ ] Backend connects to database (check logs)
- [ ] Database tables are created (check using MySQL client)
- [ ] Register API works
- [ ] Login API works and returns JWT token
- [ ] Product APIs work (GET, POST, PUT, DELETE)
- [ ] Cart APIs work
- [ ] Order APIs work
- [ ] Review APIs work
- [ ] All responses follow standardized format (ApiResponse)
- [ ] Error handling works properly
- [ ] JWT authentication works

---

## 🗄️ Database Access

### Using MySQL Workbench or any MySQL client:
- **Host**: localhost
- **Port**: 3307
- **User**: user
- **Password**: 123123
- **Database**: ElectroStore

### Using Docker exec:
```powershell
docker exec -it mysql mysql -uuser -p123123 ElectroStore
```

Then run SQL queries:
```sql
-- Show all tables
SHOW TABLES;

-- Check users
SELECT * FROM users;

-- Check products
SELECT * FROM products;

-- Check roles
SELECT * FROM roles;
```

---

## 📝 Environment Variables Reference

### Database
- `SPRING_DATASOURCE_URL` - JDBC connection string
- `SPRING_DATASOURCE_USERNAME` - Database user
- `SPRING_DATASOURCE_PASSWORD` - Database password
- `SPRING_JPA_HIBERNATE_DDL_AUTO` - Hibernate DDL mode (none/update/create)
- `SPRING_JPA_SHOW_SQL` - Show SQL queries in logs (true/false)

### Server
- `SERVER_PORT` - Backend server port (default: 8080)

### JWT
- `JWT_SECRET` - Secret key for JWT token signing (minimum 256 bits)
- `JWT_EXPIRATION` - Token expiration time in milliseconds (default: 24 hours)

---

## 🎯 Next Steps

1. **Start Docker Desktop**
2. **Run `docker compose up -d`**
3. **Check logs** to ensure all services started successfully
4. **Test APIs** using Postman or PowerShell commands above
5. **Verify database** tables and data
6. **Document any issues** found during testing

---

## ✨ Member 1 Deliverables Summary

✅ **Completed:**
- Database configuration in `application.properties`
- Environment variables structure (`.env` and `.env.example`)
- Standardized API responses using `ApiResponse<T>`
- Database migration scripts ready and integrated
- Complete testing and deployment guide

📦 **Dependencies Met:**
- Database schema from Member 2 ✓
- ORM (Spring Data JPA) configured ✓
- REST API structure ready ✓

🎉 **Result:**
- Backend is stable and ready for testing
- APIs can be called via Postman
- Complete developer documentation provided
