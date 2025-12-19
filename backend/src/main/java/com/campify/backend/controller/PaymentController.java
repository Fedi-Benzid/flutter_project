package com.campify.backend.controller;

import com.campify.backend.payload.ApiResponse;
import com.campify.backend.service.MockPaymentService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/payments")
@RequiredArgsConstructor
public class PaymentController {

    private final MockPaymentService paymentService;

    @PostMapping("/pay")
    public ResponseEntity<ApiResponse<Boolean>> processDirectPayment(@RequestBody PaymentRequest request) {
        boolean success = paymentService.processPayment(request.getAmount());
        if (success) {
            return ResponseEntity.ok(new ApiResponse<>(true, "Payment processed successfully", true));
        } else {
            return ResponseEntity.badRequest().body(new ApiResponse<>(false, "Payment failed", false));
        }
    }

    @Data
    public static class PaymentRequest {
        private double amount;
        private String currency; // Ignored in mock
    }
}
