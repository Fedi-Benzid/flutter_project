package com.campify.backend.service;

import com.campify.backend.exception.ResourceNotFoundException;
import com.campify.backend.model.CampingCenter;
import com.campify.backend.model.Reservation;
import com.campify.backend.model.User;
import com.campify.backend.repository.CampingCenterRepository;
import com.campify.backend.repository.ReservationRepository;
import com.campify.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservationService {

    private final ReservationRepository reservationRepository;
    private final UserRepository userRepository;
    private final CampingCenterRepository centerRepository;
    private final MockPaymentService paymentService;

    public List<Reservation> getUserReservations(String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        return reservationRepository.findByUserId(user.getId());
    }

    public Reservation createReservation(String userEmail, Long centerId, LocalDate checkIn, LocalDate checkOut,
            int guests) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        CampingCenter center = centerRepository.findById(centerId)
                .orElseThrow(() -> new ResourceNotFoundException("Center not found"));

        // Calculate price (very reliable parsing here lol)
        double pricePerNight = 0.0;
        try {
            String priceStr = center.getPrice().replaceAll("[^0-9.]", "");
            pricePerNight = Double.parseDouble(priceStr);
        } catch (Exception e) {
            pricePerNight = 50.0; // Fallback
        }

        long nights = java.time.temporal.ChronoUnit.DAYS.between(checkIn, checkOut);
        if (nights < 1)
            nights = 1;

        double totalPrice = pricePerNight * nights * guests;

        // Simulate Payment
        boolean paymentSuccess = paymentService.processPayment(totalPrice);
        if (!paymentSuccess) {
            throw new RuntimeException("Payment Failed! Please try again.");
        }

        Reservation reservation = Reservation.builder()
                .user(user)
                .center(center)
                .checkInDate(checkIn)
                .checkOutDate(checkOut)
                .guests(guests)
                .totalPrice(totalPrice)
                .status(Reservation.ReservationStatus.CONFIRMED)
                .build();

        return reservationRepository.save(reservation);
    }

    public Reservation getReservationById(Long id, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));

        // Verify user owns the reservation or owns the center
        boolean isOwner = reservation.getUser().getId().equals(user.getId());
        boolean isCenterOwner = reservation.getCenter().getOwnerId() != null &&
                reservation.getCenter().getOwnerId().equals(user.getId());

        if (!isOwner && !isCenterOwner) {
            throw new RuntimeException("Not authorized to view this reservation");
        }

        return reservation;
    }

    public List<Reservation> getOwnerReservations(String ownerEmail) {
        User owner = userRepository.findByEmail(ownerEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        // Get all centers owned by this user
        List<CampingCenter> ownedCenters = centerRepository.findAll().stream()
                .filter(c -> c.getOwnerId() != null && c.getOwnerId().equals(owner.getId()))
                .toList();

        // Get all reservations for these centers
        return reservationRepository.findAll().stream()
                .filter(r -> ownedCenters.stream()
                        .anyMatch(c -> c.getId().equals(r.getCenter().getId())))
                .toList();
    }

    public Reservation updateStatus(Long id, Reservation.ReservationStatus status, String ownerEmail) {
        User owner = userRepository.findByEmail(ownerEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));

        // Verify owner owns the center
        if (reservation.getCenter().getOwnerId() == null ||
                !reservation.getCenter().getOwnerId().equals(owner.getId())) {
            throw new RuntimeException("Only the center owner can update reservation status");
        }

        reservation.setStatus(status);
        return reservationRepository.save(reservation);
    }

    public void cancelReservation(Long id, String userEmail) {
        User user = userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Reservation not found"));

        // Verify user owns the reservation
        if (!reservation.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Only the reservation owner can cancel");
        }

        reservation.setStatus(Reservation.ReservationStatus.CANCELLED);
        reservationRepository.save(reservation);
    }
}
