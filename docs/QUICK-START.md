# 🚀 Quick Start Guide - ElectroMart API

## Prerequisites Check
```powershell
# Check Docker
docker --version

# Check Maven
cd electro
.\mvnw.cmd --version
cd ..
```

---

## ⚡ Start Everything (3 Commands)

### 1. Start Docker Desktop
- Open Docker Desktop app and wait until running

### 2. Start all services
```powershell
docker compose up -d
```

### 3. Check if everything is running
```powershell
docker compose ps
```

You should see 3 services: `mysql`, `backend`, `nginx-service`

---

## 🧪 Test the APIs (PowerShell)

### Register a user
```powershell
$registerData = @{
    username = "admin"
    email = "admin@electromart.com"
    password = "admin123"
    fullName = "Administrator"
    phone = "0901234567"
    address = "123 Ho Chi Minh City"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/auth/register" `
    -Method POST `
    -ContentType "application/json" `
    -Body $registerData
```

### Login
```powershell
$loginData = @{
    email = "admin@electromart.com"
    password = "admin123"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://localhost:8080/api/v1/auth/login" `
    -Method POST `
    -ContentType "application/json" `
    -Body $loginData

# Save token
$token = $loginResponse.data.token
Write-Host "Token: $token"
```

### Get Products (with authentication)
```powershell
$headers = @{
    "Authorization" = "Bearer $token"
}

Invoke-RestMethod -Uri "http://localhost:8080/api/v1/products" `
    -Method GET `
    -Headers $headers
```

---

## 🔍 Check Logs

```powershell
# All services
docker compose logs -f

# Backend only
docker compose logs -f be

# Database only
docker compose logs -f db
```

Press `Ctrl + C` to stop viewing logs

---

## 🛑 Stop Everything

```powershell
# Stop all services
docker compose down

# Stop and remove database (clean slate)
docker compose down -v
```

---

## ✅ Success Indicators

**Database is ready when you see:**
```
mysql  | ready for connections. Version: '8.0.x'
```

**Backend is ready when you see:**
```
backend | Started ElectroApplication in X.XXX seconds
```

**Test with browser:**
- Frontend: http://localhost
- Backend health: http://localhost:8080 (should see error page or Whitelabel - that's normal)

---

## ❌ Common Issues

### Docker not running
```
Error: Cannot connect to Docker daemon
```
**Fix**: Start Docker Desktop

### Port already in use
```
Error: port is already allocated
```
**Fix**: 
```powershell
# For port 3307 (MySQL)
netstat -ano | findstr :3307
# For port 8080 (Backend)
netstat -ano | findstr :8080
# Kill the process: taskkill /PID <PID> /F
```

### Backend can't connect to DB
**Fix**: Wait 30 seconds after starting, database needs time to initialize

---

## 📊 Database Access

```powershell
# Connect to database
docker exec -it mysql mysql -uuser -p123123 ElectroStore

# Then run SQL:
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM products;
```

Type `exit` to quit MySQL shell

---

## 📚 Full Documentation

- **Complete Guide**: [MEMBER1-BACKEND-SETUP-GUIDE.md](./MEMBER1-BACKEND-SETUP-GUIDE.md)
- **Docker Guide**: [Docker-README.md](./Docker-README.md)
- **API Documentation**: [docs/API-Documentation.md](./docs/API-Documentation.md)
- **Testing Guide**: [docs/TESTING-GUIDE.md](./docs/TESTING-GUIDE.md)
