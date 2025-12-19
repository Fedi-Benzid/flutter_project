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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.MediaType;
import com.campify.backend.service.FileStorageService;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;

import com.campify.backend.service.EmailService;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

        private final AuthenticationManager authenticationManager;
        private final UserRepository userRepository;
        private final PasswordEncoder passwordEncoder;
        private final JwtTokenProvider jwtTokenProvider;
        private final EmailService emailService;
        private final FileStorageService fileStorageService;

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
                                user.getLastName(), user.getAvatarUrl(), user.getRole(), user.getPhoneNumber(),
                                user.getCreatedAt());

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
                                user.getPhoneNumber(),
                                user.getCreatedAt());

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
                if (request.getCreatedAt() != null) {
                        user.setCreatedAt(request.getCreatedAt());
                }

                userRepository.save(user);

                AuthDtos.UserDto userDto = new AuthDtos.UserDto(
                                user.getId(),
                                user.getEmail(),
                                user.getFirstName(),
                                user.getLastName(),
                                user.getAvatarUrl(),
                                user.getRole(),
                                user.getPhoneNumber(),
                                user.getCreatedAt());

                return ResponseEntity.ok(new ApiResponse<>(true, "Profile updated successfully", userDto));
        }

        @PostMapping("/reset-password-request")
        public ResponseEntity<ApiResponse<String>> requestPasswordReset(
                        @Valid @RequestBody AuthDtos.PasswordResetRequest request) {
                Optional<User> userOptional = userRepository.findByEmail(request.getEmail());

                if (userOptional.isPresent()) {
                        User user = userOptional.get();
                        String code = String.format("%04d", new Random().nextInt(10000));
                        user.setResetCode(code);
                        user.setResetCodeExpiration(LocalDateTime.now().plusMinutes(15));
                        userRepository.save(user);

                        emailService.sendResetCode(user.getEmail(), code);
                }

                // Always return success to not reveal if email exists
                return ResponseEntity.ok(new ApiResponse<>(true,
                                "If the email exists, a 4-digit code has been sent to your email"));
        }

        @PostMapping("/verify-reset-code")
        public ResponseEntity<ApiResponse<String>> verifyResetCode(
                        @Valid @RequestBody AuthDtos.VerifyCodeRequest request) {
                Optional<User> userOptional = userRepository.findByEmail(request.getEmail());

                if (userOptional.isPresent()) {
                        User user = userOptional.get();
                        if (user.getResetCode() != null &&
                                        user.getResetCode().equals(request.getCode()) &&
                                        user.getResetCodeExpiration() != null &&
                                        user.getResetCodeExpiration().isAfter(LocalDateTime.now())) {
                                return ResponseEntity.ok(new ApiResponse<>(true, "Code verified successfully"));
                        }
                }

                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                .body(new ApiResponse<>(false, "Invalid or expired reset code"));
        }

        @PostMapping("/reset-password")
        public ResponseEntity<ApiResponse<String>> resetPassword(
                        @Valid @RequestBody AuthDtos.CompletePasswordResetRequest request) {
                Optional<User> userOptional = userRepository.findByEmail(request.getEmail());

                if (userOptional.isPresent()) {
                        User user = userOptional.get();
                        if (user.getResetCode() != null &&
                                        user.getResetCode().equals(request.getCode()) &&
                                        user.getResetCodeExpiration() != null &&
                                        user.getResetCodeExpiration().isAfter(LocalDateTime.now())) {

                                user.setPassword(passwordEncoder.encode(request.getNewPassword()));
                                user.setResetCode(null);
                                user.setResetCodeExpiration(null);
                                userRepository.save(user);

                                return ResponseEntity.ok(new ApiResponse<>(true, "Password reset successfully"));
                        }
                }

                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                .body(new ApiResponse<>(false, "Invalid or expired reset code"));
        }

        @PostMapping(value = "/profile/image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
        public ResponseEntity<ApiResponse<AuthDtos.UserDto>> uploadProfileImage(
                        @RequestParam("image") MultipartFile image) {
                try {
                        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                        if (auth == null || !auth.isAuthenticated() || "anonymousUser".equals(auth.getName())) {
                                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                                .body(new ApiResponse<>(false, "User not authenticated"));
                        }

                        User user = userRepository.findByEmail(auth.getName())
                                        .orElseThrow(() -> new RuntimeException("User not found: " + auth.getName()));

                        if (image == null || image.isEmpty()) {
                                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                                .body(new ApiResponse<>(false, "Image file is missing or empty"));
                        }

                        String imageUrl = fileStorageService.storeFile(image);
                        user.setAvatarUrl(imageUrl);
                        userRepository.save(user);

                        AuthDtos.UserDto userDto = new AuthDtos.UserDto(
                                        user.getId(),
                                        user.getEmail(),
                                        user.getFirstName(),
                                        user.getLastName(),
                                        user.getAvatarUrl(),
                                        user.getRole(),
                                        user.getPhoneNumber(),
                                        user.getCreatedAt());

                        return ResponseEntity
                                        .ok(new ApiResponse<>(true, "Profile image updated successfully", userDto));
                } catch (Exception e) {
                        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                        .body(new ApiResponse<>(false, "Failed to upload image: " + e.getMessage()));
                }
        }

        @PostMapping("/change-password")
        public ResponseEntity<ApiResponse<String>> changePassword(
                        @Valid @RequestBody AuthDtos.ChangePasswordRequest request) {
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                User user = userRepository.findByEmail(auth.getName())
                                .orElseThrow(() -> new RuntimeException("User not found"));

                if (!passwordEncoder.matches(request.getOldPassword(), user.getPassword())) {
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                        .body(new ApiResponse<>(false, "Invalid current password"));
                }

                user.setPassword(passwordEncoder.encode(request.getNewPassword()));
                userRepository.save(user);

                return ResponseEntity.ok(new ApiResponse<>(true, "Password changed successfully"));
        }
}
