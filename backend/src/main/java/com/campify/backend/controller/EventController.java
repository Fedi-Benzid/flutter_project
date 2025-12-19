package com.campify.backend.controller;

import com.campify.backend.model.Event;
import com.campify.backend.model.EventParticipation;
import com.campify.backend.payload.ApiResponse;
import com.campify.backend.service.EventService;
import jakarta.validation.Valid;
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
    public ResponseEntity<ApiResponse<List<Event>>> getAllEvents(
            @RequestParam(required = false) Long centerId) {
        List<Event> events = eventService.getAllEvents(centerId);
        return ResponseEntity.ok(new ApiResponse<>(true, "Events fetched successfully", events));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Event>> getEventById(@PathVariable Long id) {
        Event event = eventService.getEventById(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Event fetched successfully", event));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Event>> createEvent(@Valid @RequestBody Event event) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Event createdEvent = eventService.createEvent(event, auth.getName());
        return new ResponseEntity<>(new ApiResponse<>(true, "Event created successfully", createdEvent),
                HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<Event>> updateEvent(
            @PathVariable Long id,
            @Valid @RequestBody Event event) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Event updatedEvent = eventService.updateEvent(id, event, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Event updated successfully", updatedEvent));
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
    public ResponseEntity<ApiResponse<EventParticipation>> requestParticipation(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        EventParticipation participation = eventService.requestParticipation(id, auth.getName());
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

    @GetMapping("/my-participations")
    public ResponseEntity<ApiResponse<List<EventParticipation>>> getMyParticipations() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<EventParticipation> participations = eventService.getUserParticipations(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Participations fetched successfully", participations));
    }

    @Data
    public static class UpdateParticipationRequest {
        private EventParticipation.ParticipationStatus status;
    }
}
