package com.campify.backend.controller;

import com.campify.backend.model.User;
import com.campify.backend.payload.ApiResponse;
import com.campify.backend.payload.AuthDtos;
import com.campify.backend.repository.UserRepository;
import com.campify.backend.security.JwtTokenProvider;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

        private final AuthenticationManager authenticationManager;
        private final UserRepository userRepository;
        private final PasswordEncoder passwordEncoder;
        private final JwtTokenProvider jwtTokenProvider;

        @PostMapping("/login")
        public ResponseEntity<ApiResponse<AuthDtos.JwtAuthResponse>> authenticateUser(
                        @Valid @RequestBody AuthDtos.LoginRequest loginRequest) {
                Authentication authentication = authenticationManager.authenticate(
                                new UsernamePasswordAuthenticationToken(loginRequest.getEmail(),
                                                loginRequest.getPassword()));

                SecurityContextHolder.getContext().setAuthentication(authentication);
                String jwt = jwtTokenProvider.generateToken(authentication);

                User user = userRepository.findByEmail(loginRequest.getEmail()).orElseThrow();
                AuthDtos.UserDto userDto = new AuthDtos.UserDto(user.getId(), user.getEmail(), user.getFirstName(),
                                user.getLastName(), user.getAvatarUrl(), user.getRole(), user.getPhoneNumber());

                return ResponseEntity
                                .ok(new ApiResponse<>(true, "Login Successful",
                                                new AuthDtos.JwtAuthResponse(jwt, userDto)));
        }

        @PostMapping("/register")
        public ResponseEntity<ApiResponse<String>> registerUser(
                        @Valid @RequestBody AuthDtos.RegisterRequest registerRequest) {
                if (userRepository.existsByEmail(registerRequest.getEmail())) {
                        return new ResponseEntity<>(new ApiResponse<>(false, "Email is already taken!"),
                                        HttpStatus.BAD_REQUEST);
                }

                User user = User.builder()
                                .firstName(registerRequest.getFirstName())
                                .lastName(registerRequest.getLastName())
                                .email(registerRequest.getEmail())
                                .password(passwordEncoder.encode(registerRequest.getPassword()))
                                .role(registerRequest.getRole() != null ? registerRequest.getRole() : User.Role.USER)
                                .build();

                userRepository.save(user);

                return new ResponseEntity<>(new ApiResponse<>(true, "User registered successfully"),
                                HttpStatus.CREATED);
        }

        @GetMapping("/profile")
        public ResponseEntity<ApiResponse<AuthDtos.UserDto>> getProfile() {
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                User user = userRepository.findByEmail(auth.getName())
                                .orElseThrow(() -> new RuntimeException("User not found"));

                AuthDtos.UserDto userDto = new AuthDtos.UserDto(
                                user.getId(),
                                user.getEmail(),
                                user.getFirstName(),
                                user.getLastName(),
                                user.getAvatarUrl(),
                                user.getRole(),
                                user.getPhoneNumber());

                return ResponseEntity.ok(new ApiResponse<>(true, "Profile fetched successfully", userDto));
        }

        @PutMapping("/profile")
        public ResponseEntity<ApiResponse<AuthDtos.UserDto>> updateProfile(
                        @Valid @RequestBody AuthDtos.ProfileUpdateRequest request) {
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                User user = userRepository.findByEmail(auth.getName())
                                .orElseThrow(() -> new RuntimeException("User not found"));

                // Handle name field (if provided, split into firstName/lastName)
                if (request.getName() != null && !request.getName().isEmpty()) {
                        String[] nameParts = request.getName().trim().split("\\s+", 2);
                        user.setFirstName(nameParts[0]);
                        if (nameParts.length > 1) {
                                user.setLastName(nameParts[1]);
                        } else {
                                user.setLastName("");
                        }
                }

                // Override with explicit firstName/lastName if provided
                if (request.getFirstName() != null) {
                        user.setFirstName(request.getFirstName());
                }
                if (request.getLastName() != null) {
                        user.setLastName(request.getLastName());
                }
                if (request.getPhoneNumber() != null) {
                        user.setPhoneNumber(request.getPhoneNumber());
                }
                if (request.getAvatarUrl() != null) {
                        user.setAvatarUrl(request.getAvatarUrl());
                }

                userRepository.save(user);

                AuthDtos.UserDto userDto = new AuthDtos.UserDto(
                                user.getId(),
                                user.getEmail(),
                                user.getFirstName(),
                                user.getLastName(),
                                user.getAvatarUrl(),
                                user.getRole(),
                                user.getPhoneNumber());

                return ResponseEntity.ok(new ApiResponse<>(true, "Profile updated successfully", userDto));
        }

        @PostMapping("/reset-password")
        public ResponseEntity<ApiResponse<String>> resetPassword(
                        @Valid @RequestBody AuthDtos.PasswordResetRequest request) {
                // In a real app, this would send a password reset email
                // For demo purposes, we just verify the email exists
                Optional<User> user = userRepository.findByEmail(request.getEmail());

                // Always return success to not reveal if email exists
                return ResponseEntity.ok(new ApiResponse<>(true,
                                "If the email exists, a password reset link has been sent"));
        }
}
