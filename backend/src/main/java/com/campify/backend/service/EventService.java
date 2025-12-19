package com.campify.backend.service;

import com.campify.backend.exception.ResourceNotFoundException;
import com.campify.backend.model.Event;
import com.campify.backend.model.EventParticipation;
import com.campify.backend.repository.EventParticipationRepository;
import com.campify.backend.repository.EventRepository;
import com.campify.backend.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepository;
    private final EventParticipationRepository participationRepository;
    private final UserRepository userRepository;

    public List<Event> getAllEvents(Long centerId) {
        if (centerId != null) {
            return eventRepository.findByCenterId(centerId);
        }
        return eventRepository.findAll();
    }

    public Event getEventById(Long id) {
        return eventRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Event not found"));
    }

    public Event createEvent(Event event, String ownerEmail) {
        Long ownerId = getUserIdFromEmail(ownerEmail);
        event.setOwnerId(ownerId);
        return eventRepository.save(event);
    }

    public Event updateEvent(Long id, Event updatedEvent, String ownerEmail) {
        Event event = getEventById(id);
        Long ownerId = getUserIdFromEmail(ownerEmail);

        // Verify owner
        if (!event.getOwnerId().equals(ownerId)) {
            throw new RuntimeException("Only the event owner can update this event");
        }

        if (updatedEvent.getTitle() != null) {
            event.setTitle(updatedEvent.getTitle());
        }
        if (updatedEvent.getDescription() != null) {
            event.setDescription(updatedEvent.getDescription());
        }
        if (updatedEvent.getStartDate() != null) {
            event.setStartDate(updatedEvent.getStartDate());
        }
        if (updatedEvent.getEndDate() != null) {
            event.setEndDate(updatedEvent.getEndDate());
        }
        if (updatedEvent.getMaxParticipants() != null) {
            event.setMaxParticipants(updatedEvent.getMaxParticipants());
        }
        if (updatedEvent.getImageUrl() != null) {
            event.setImageUrl(updatedEvent.getImageUrl());
        }

        return eventRepository.save(event);
    }

    @Transactional
    public void deleteEvent(Long id, String ownerEmail) {
        Event event = getEventById(id);
        Long ownerId = getUserIdFromEmail(ownerEmail);

        // Verify owner
        if (!event.getOwnerId().equals(ownerId)) {
            throw new RuntimeException("Only the event owner can delete this event");
        }

        eventRepository.delete(event);
    }

    public List<EventParticipation> getEventParticipations(Long eventId) {
        // Verify event exists
        getEventById(eventId);
        return participationRepository.findByEventId(eventId);
    }

    @Transactional
    public EventParticipation requestParticipation(Long eventId, String userEmail) {
        Event event = getEventById(eventId);
        Long userId = getUserIdFromEmail(userEmail);

        // Check if already requested
        var existing = participationRepository.findByEventIdAndUserId(eventId, userId);
        if (existing.isPresent()) {
            return existing.get();
        }

        // Check if event is full
        long approvedCount = participationRepository.countByEventIdAndStatus(
                eventId, EventParticipation.ParticipationStatus.APPROVED);

        if (event.getMaxParticipants() != null && approvedCount >= event.getMaxParticipants()) {
            throw new RuntimeException("Event is full");
        }

        EventParticipation participation = EventParticipation.builder()
                .eventId(eventId)
                .userId(userId)
                .status(EventParticipation.ParticipationStatus.PENDING)
                .build();

        return participationRepository.save(participation);
    }

    @Transactional
    public EventParticipation updateParticipationStatus(
            Long participationId, Long eventId, EventParticipation.ParticipationStatus status, String ownerEmail) {
        Event event = getEventById(eventId);
        Long ownerId = getUserIdFromEmail(ownerEmail);

        // Verify owner
        if (!event.getOwnerId().equals(ownerId)) {
            throw new RuntimeException("Only the event owner can update participation status");
        }

        EventParticipation participation = participationRepository.findById(participationId)
                .orElseThrow(() -> new ResourceNotFoundException("Participation not found"));

        if (!participation.getEventId().equals(eventId)) {
            throw new RuntimeException("Participation does not belong to this event");
        }

        participation.setStatus(status);
        return participationRepository.save(participation);
    }

    public List<EventParticipation> getUserParticipations(String userEmail) {
        Long userId = getUserIdFromEmail(userEmail);
        return participationRepository.findByUserId(userId);
    }

    private Long getUserIdFromEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"))
                .getId();
    }
}
