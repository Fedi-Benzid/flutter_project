package com.campify.backend.payload;

import com.campify.backend.model.User;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class AuthDtos {

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class LoginRequest {
        @NotBlank
        @Email
        private String email;
        @NotBlank
        private String password;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class RegisterRequest {
        @NotBlank
        private String firstName;

        private String lastName;
        @NotBlank
        @Email
        private String email;
        @NotBlank
        private String password;
        private User.Role role; // Optional, default to USER if null
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class JwtAuthResponse {
        private String accessToken;
        private String tokenType = "Bearer";
        private UserDto user;

        public JwtAuthResponse(String accessToken, UserDto user) {
            this.accessToken = accessToken;
            this.user = user;
        }
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserDto {
        private Long id;
        private String email;
        private String firstName;
        private String lastName;
        private String avatarUrl;
        private User.Role role;
        private String phoneNumber;

        // Computed field for Flutter compatibility (combines firstName + lastName)
        public String getName() {
            if (firstName == null && lastName == null)
                return null;
            if (firstName == null)
                return lastName;
            if (lastName == null)
                return firstName;
            return firstName + " " + lastName;
        }
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ProfileUpdateRequest {
        private String name; // Can be split into firstName/lastName
        private String firstName;
        private String lastName;
        private String phoneNumber;
        private String avatarUrl;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class PasswordResetRequest {
        @NotBlank
        @Email
        private String email;
    }
}
