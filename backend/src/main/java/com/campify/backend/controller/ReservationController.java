package com.campify.backend.controller;

import com.campify.backend.model.Reservation;
import com.campify.backend.payload.ApiResponse;
import com.campify.backend.service.ReservationService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/reservations")
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService reservationService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Reservation>>> getMyReservations() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<Reservation> reservations = reservationService.getUserReservations(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Reservations fetched", reservations));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Reservation>> createReservation(@Valid @RequestBody ReservationRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Reservation reservation = reservationService.createReservation(
                auth.getName(),
                request.getCenterId(),
                request.getCheckInDate(),
                request.getCheckOutDate(),
                request.getGuests());
        return ResponseEntity.ok(new ApiResponse<>(true, "Reservation created successfully", reservation));
    }

    @GetMapping("/owner")
    public ResponseEntity<ApiResponse<List<Reservation>>> getOwnerReservations() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<Reservation> reservations = reservationService.getOwnerReservations(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Owner reservations fetched", reservations));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Reservation>> getReservationById(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Reservation reservation = reservationService.getReservationById(id, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Reservation fetched", reservation));
    }

    @PutMapping("/{id}/status")
    public ResponseEntity<ApiResponse<Reservation>> updateStatus(
            @PathVariable Long id,
            @Valid @RequestBody StatusUpdateRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Reservation reservation = reservationService.updateStatus(id, request.getStatus(), auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Reservation status updated", reservation));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> cancelReservation(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        reservationService.cancelReservation(id, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Reservation cancelled", null));
    }

    @Data
    public static class StatusUpdateRequest {
        @NotNull
        private Reservation.ReservationStatus status;
    }

    @Data
    public static class ReservationRequest {
        @NotNull
        private Long centerId;
        @NotNull
        @Future
        private LocalDate checkInDate;
        @NotNull
        @Future
        private LocalDate checkOutDate;
        @Min(1)
        private int guests;
    }
}
