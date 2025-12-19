package com.campify.backend.service;

import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class MockPaymentService {

    public boolean processPayment(double amount) {
        // Simulate latency
        try {
            Thread.sleep(1500L);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        // Simulate 90% success rate
        return new Random().nextInt(10) != 0;
    }
}
