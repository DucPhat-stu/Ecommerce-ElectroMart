package com.store.electro.Services;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.DTO.LoginRequest;
import com.store.electro.Models.DTO.LoginResponse;
import com.store.electro.Models.DTO.RegisterRequest;
import com.store.electro.Models.DTO.UserRequest;
import com.store.electro.Models.Entity.User;
import com.store.electro.Repositories.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    // ==================== AUTH SERVICES ====================

    @Transactional
    public User register(RegisterRequest request) {
        // Validate input
        if (request.getUsername() == null || request.getUsername().trim().isEmpty()) {
            throw new RuntimeException("Username is required");
        }
        if (request.getEmail() == null || request.getEmail().trim().isEmpty()) {
            throw new RuntimeException("Email is required");
        }
        if (request.getPassword() == null || request.getPassword().length() < 6) {
            throw new RuntimeException("Password must be at least 6 characters");
        }

        // Check if username already exists
        Optional<User> existingUsername = userRepository.findByUsername(request.getUsername());
        if (existingUsername.isPresent()) {
            throw new RuntimeException("Username already exists");
        }

        // Check if email already exists
        Optional<User> existingEmail = userRepository.findByEmail(request.getEmail());
        if (existingEmail.isPresent()) {
            throw new RuntimeException("Email already exists");
        }

        // Create new user
        User user = new User();
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        user.setPasswordHash(passwordEncoder.encode(request.getPassword()));
        user.setFullName(request.getFullName());
        user.setPhone(request.getPhone());
        user.setRoleId(1); // Default: USER role
        user.setStatus("ACTIVE");
        user.setEmailVerified(false);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());

        return userRepository.save(user);
    }

    @Transactional
    public LoginResponse login(LoginRequest request) {
        // Find user by username
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new RuntimeException("Invalid username or password"));

        // Validate password
        if (!passwordEncoder.matches(request.getPassword(), user.getPasswordHash())) {
            throw new RuntimeException("Invalid username or password");
        }

        // Check if user is active
        if (!"ACTIVE".equals(user.getStatus())) {
            throw new RuntimeException("User account is inactive");
        }

        // Update last login
        user.setLastLogin(LocalDateTime.now());
        userRepository.save(user);

        // Generate JWT token (simplified - in production use JWT library)
        String token = generateToken(user);
        long expiresIn = 86400; // 24 hours in seconds

        return new LoginResponse(token, "Bearer", expiresIn, user.getId(), user.getUsername(),
                user.getEmail());
    }

    // ==================== USER CRUD SERVICES ====================

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
    }

    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found with username: " + username));
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found with email: " + email));
    }

    @Transactional
    public User updateUser(Long id, UserRequest request) {
        User user = getUserById(id);

        // Validate email uniqueness if email is being changed
        if (request.getEmail() != null && !request.getEmail().equals(user.getEmail())) {
            Optional<User> existingEmail = userRepository.findByEmail(request.getEmail());
            if (existingEmail.isPresent()) {
                throw new RuntimeException("Email already exists");
            }
        }

        // Update fields
        if (request.getEmail() != null) {
            user.setEmail(request.getEmail());
        }
        if (request.getFullName() != null) {
            user.setFullName(request.getFullName());
        }
        if (request.getPhone() != null) {
            user.setPhone(request.getPhone());
        }
        if (request.getAddress() != null) {
            user.setAddress(request.getAddress());
        }
        if (request.getStatus() != null) {
            user.setStatus(request.getStatus());
        }
        if (request.getRoleId() != null) {
            user.setRoleId(request.getRoleId());
        }

        user.setUpdatedAt(LocalDateTime.now());
        return userRepository.save(user);
    }

    @Transactional
    public void deleteUser(Long id) {
        User user = getUserById(id);
        userRepository.delete(user);
    }

    @Transactional
    public User changePassword(Long userId, String oldPassword, String newPassword) {
        User user = getUserById(userId);

        // Validate old password
        if (!passwordEncoder.matches(oldPassword, user.getPasswordHash())) {
            throw new RuntimeException("Old password is incorrect");
        }

        // Validate new password
        if (newPassword == null || newPassword.length() < 6) {
            throw new RuntimeException("New password must be at least 6 characters");
        }

        // Update password
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        user.setUpdatedAt(LocalDateTime.now());
        return userRepository.save(user);
    }

    // ==================== HELPER METHODS ====================

    private String generateToken(User user) {
        // Simplified token generation - in production use JWT (io.jsonwebtoken)
        // This is just a placeholder implementation
        return "token_" + user.getId() + "_" + System.currentTimeMillis();
    }

    public boolean validateToken(String token) {
        // Simplified token validation - in production use JWT library
        return token != null && token.startsWith("token_");
    }

    public Long extractUserIdFromToken(String token) {
        // Simplified user ID extraction - in production use JWT library
        if (token != null && token.startsWith("token_")) {
            String[] parts = token.split("_");
            if (parts.length > 1) {
                try {
                    return Long.parseLong(parts[1]);
                } catch (NumberFormatException e) {
                    return null;
                }
            }
        }
        return null;
    }
}
