package com.campify.backend.controller;

import com.campify.backend.model.Event;
import com.campify.backend.model.EventParticipation;
import com.campify.backend.model.EventRating;
import com.campify.backend.payload.ApiResponse;
import com.campify.backend.payload.EventDTO;
import com.campify.backend.service.EventService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<EventDTO>>> getAllEvents(
            @RequestParam(required = false) Long centerId) {
        List<Event> events = eventService.getAllEvents(centerId);
        List<EventDTO> eventDTOs = eventService.convertToDTOs(events);
        return ResponseEntity.ok(new ApiResponse<>(true, "Events fetched successfully", eventDTOs));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<EventDTO>> getEventById(@PathVariable Long id) {
        Event event = eventService.getEventById(id);
        EventDTO eventDTO = eventService.convertToDTO(event);
        return ResponseEntity.ok(new ApiResponse<>(true, "Event fetched successfully", eventDTO));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<EventDTO>> createEvent(@Valid @RequestBody Event event) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Event createdEvent = eventService.createEvent(event, auth.getName());
        EventDTO eventDTO = eventService.convertToDTO(createdEvent);
        return new ResponseEntity<>(new ApiResponse<>(true, "Event created successfully", eventDTO),
                HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<EventDTO>> updateEvent(
            @PathVariable Long id,
            @Valid @RequestBody Event event) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Event updatedEvent = eventService.updateEvent(id, event, auth.getName());
        EventDTO eventDTO = eventService.convertToDTO(updatedEvent);
        return ResponseEntity.ok(new ApiResponse<>(true, "Event updated successfully", eventDTO));
    }

    @PutMapping("/{id}/close")
    public ResponseEntity<ApiResponse<EventDTO>> closeEvent(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Event closedEvent = eventService.closeEvent(id, auth.getName());
        EventDTO eventDTO = eventService.convertToDTO(closedEvent);
        return ResponseEntity.ok(new ApiResponse<>(true, "Event closed successfully", eventDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteEvent(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        eventService.deleteEvent(id, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Event deleted successfully", null));
    }

    @GetMapping("/{id}/participations")
    public ResponseEntity<ApiResponse<List<EventParticipation>>> getEventParticipations(@PathVariable Long id) {
        List<EventParticipation> participations = eventService.getEventParticipations(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Participations fetched successfully", participations));
    }

    @PostMapping("/{id}/participate")
    public ResponseEntity<ApiResponse<EventParticipation>> requestParticipation(
            @PathVariable Long id,
            @RequestBody(required = false) ParticipationRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        int numberOfPersons = (request != null && request.getNumberOfPersons() != null)
                ? request.getNumberOfPersons()
                : 1;
        EventParticipation participation = eventService.requestParticipation(id, auth.getName(), numberOfPersons);
        return ResponseEntity.ok(new ApiResponse<>(true, "Participation requested successfully", participation));
    }

    @PutMapping("/{eventId}/participations/{id}")
    public ResponseEntity<ApiResponse<EventParticipation>> updateParticipationStatus(
            @PathVariable Long eventId,
            @PathVariable Long id,
            @Valid @RequestBody UpdateParticipationRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        EventParticipation participation = eventService.updateParticipationStatus(
                id, eventId, request.getStatus(), auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Participation status updated", participation));
    }

    @PutMapping("/{eventId}/participations/{id}/update")
    public ResponseEntity<ApiResponse<EventParticipation>> updateMyParticipation(
            @PathVariable Long eventId,
            @PathVariable Long id,
            @Valid @RequestBody ParticipationRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        EventParticipation participation = eventService.updateMyParticipation(
                id, eventId, request.getNumberOfPersons(), auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Participation updated successfully", participation));
    }

    @DeleteMapping("/{eventId}/participations/{id}")
    public ResponseEntity<ApiResponse<Void>> cancelParticipation(
            @PathVariable Long eventId,
            @PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        eventService.cancelParticipation(id, eventId, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Participation cancelled successfully", null));
    }

    @GetMapping("/my-participations")
    public ResponseEntity<ApiResponse<List<EventParticipation>>> getMyParticipations() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<EventParticipation> participations = eventService.getUserParticipations(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Participations fetched successfully", participations));
    }

    // Rating endpoints
    @PostMapping("/{id}/rate")
    public ResponseEntity<ApiResponse<EventRating>> rateEvent(
            @PathVariable Long id,
            @Valid @RequestBody RatingRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        EventRating rating = eventService.rateEvent(id, auth.getName(), request.getRating(), request.getComment());
        return ResponseEntity.ok(new ApiResponse<>(true, "Event rated successfully", rating));
    }

    @GetMapping("/{id}/ratings")
    public ResponseEntity<ApiResponse<List<EventRating>>> getEventRatings(@PathVariable Long id) {
        List<EventRating> ratings = eventService.getEventRatings(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Ratings fetched successfully", ratings));
    }

    @GetMapping("/{id}/average-rating")
    public ResponseEntity<ApiResponse<Double>> getAverageRating(@PathVariable Long id) {
        Double average = eventService.getAverageRating(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Average rating fetched successfully", average));
    }

    // Request DTOs
    @Data
    public static class UpdateParticipationRequest {
        private EventParticipation.ParticipationStatus status;
    }

    @Data
    public static class ParticipationRequest {
        @Min(1)
        private Integer numberOfPersons = 1;
    }

    @Data
    public static class RatingRequest {
        @Min(1)
        @Max(5)
        private Integer rating;
        private String comment;
    }
}
