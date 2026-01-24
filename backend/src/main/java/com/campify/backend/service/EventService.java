package com.campify.backend.service;

import com.campify.backend.exception.ResourceNotFoundException;
import com.campify.backend.model.Event;
import com.campify.backend.model.EventParticipation;
import com.campify.backend.model.EventRating;
import com.campify.backend.model.User;
import com.campify.backend.model.CampingCenter;
import com.campify.backend.payload.EventDTO;
import com.campify.backend.repository.EventParticipationRepository;
import com.campify.backend.repository.EventRatingRepository;
import com.campify.backend.repository.EventRepository;
import com.campify.backend.repository.UserRepository;
import com.campify.backend.repository.CampingCenterRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepository;
    private final EventParticipationRepository participationRepository;
    private final EventRatingRepository ratingRepository;
    private final UserRepository userRepository;
    private final CampingCenterRepository campingCenterRepository;

    public List<Event> getAllEvents(Long centerId) {
        List<Event> events;
        if (centerId != null) {
            events = eventRepository.findByCenterId(centerId);
        } else {
            events = eventRepository.findAll();
        }
        // Populate current participants count
        events.forEach(this::populateParticipantCount);
        return events;
    }

    public Event getEventById(Long id) {
        Event event = eventRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Event not found"));
        populateParticipantCount(event);
        return event;
    }

    private void populateParticipantCount(Event event) {
        // Sum the numberOfPersons for all approved participations
        Integer sum = participationRepository.sumNumberOfPersonsByEventIdAndStatus(
                event.getId(), EventParticipation.ParticipationStatus.APPROVED);
        event.setCurrentParticipants(sum != null ? sum : 0);
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
        if (updatedEvent.getPrice() != null) {
            event.setPrice(updatedEvent.getPrice());
        }
        if (updatedEvent.getActivities() != null) {
            event.setActivities(updatedEvent.getActivities());
        }
        if (updatedEvent.getLocation() != null) {
            event.setLocation(updatedEvent.getLocation());
        }
        if (updatedEvent.getIsClosed() != null) {
            event.setIsClosed(updatedEvent.getIsClosed());
        }

        return eventRepository.save(event);
    }

    @Transactional
    public Event closeEvent(Long id, String ownerEmail) {
        Event event = getEventById(id);
        Long ownerId = getUserIdFromEmail(ownerEmail);

        // Verify owner
        if (!event.getOwnerId().equals(ownerId)) {
            throw new RuntimeException("Only the event owner can close this event");
        }

        event.setIsClosed(true);
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
    public EventParticipation requestParticipation(Long eventId, String userEmail, Integer numberOfPersons) {
        Event event = getEventById(eventId);
        Long userId = getUserIdFromEmail(userEmail);

        // Check if event is closed
        if (Boolean.TRUE.equals(event.getIsClosed())) {
            throw new RuntimeException("Event is closed for new participation requests");
        }

        // Check if already requested
        var existing = participationRepository.findByEventIdAndUserId(eventId, userId);
        if (existing.isPresent()) {
            return existing.get();
        }

        // Check if event is full
        Integer approvedCount = participationRepository.sumNumberOfPersonsByEventIdAndStatus(
                eventId, EventParticipation.ParticipationStatus.APPROVED);
        int currentTotal = (approvedCount != null ? approvedCount : 0);

        if (event.getMaxParticipants() != null && (currentTotal + numberOfPersons) > event.getMaxParticipants()) {
            throw new RuntimeException("Event does not have enough spots for " + numberOfPersons + " persons");
        }

        EventParticipation participation = EventParticipation.builder()
                .eventId(eventId)
                .userId(userId)
                .status(EventParticipation.ParticipationStatus.PENDING)
                .numberOfPersons(numberOfPersons)
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

        // Check capacity before approving
        if (status == EventParticipation.ParticipationStatus.APPROVED) {
            Integer approvedCount = participationRepository.sumNumberOfPersonsByEventIdAndStatus(
                    eventId, EventParticipation.ParticipationStatus.APPROVED);
            int currentTotal = (approvedCount != null ? approvedCount : 0);

            if (event.getMaxParticipants() != null &&
                    (currentTotal + participation.getNumberOfPersons()) > event.getMaxParticipants()) {
                throw new RuntimeException(
                        "Cannot approve: not enough spots for " + participation.getNumberOfPersons() + " persons");
            }
        }

        participation.setStatus(status);
        return participationRepository.save(participation);
    }

    @Transactional
    public EventParticipation updateMyParticipation(Long participationId, Long eventId, Integer numberOfPersons,
            String userEmail) {
        Long userId = getUserIdFromEmail(userEmail);

        EventParticipation participation = participationRepository.findById(participationId)
                .orElseThrow(() -> new ResourceNotFoundException("Participation not found"));

        // Verify ownership
        if (!participation.getUserId().equals(userId)) {
            throw new RuntimeException("You can only update your own participation request");
        }

        if (!participation.getEventId().equals(eventId)) {
            throw new RuntimeException("Participation does not belong to this event");
        }

        // Can only update pending requests
        if (participation.getStatus() != EventParticipation.ParticipationStatus.PENDING) {
            throw new RuntimeException("Cannot update participation that is already " + participation.getStatus());
        }

        participation.setNumberOfPersons(numberOfPersons);
        return participationRepository.save(participation);
    }

    @Transactional
    public void cancelParticipation(Long participationId, Long eventId, String userEmail) {
        Long userId = getUserIdFromEmail(userEmail);

        EventParticipation participation = participationRepository.findById(participationId)
                .orElseThrow(() -> new ResourceNotFoundException("Participation not found"));

        // Verify ownership
        if (!participation.getUserId().equals(userId)) {
            throw new RuntimeException("You can only cancel your own participation request");
        }

        if (!participation.getEventId().equals(eventId)) {
            throw new RuntimeException("Participation does not belong to this event");
        }

        participationRepository.delete(participation);
    }

    public List<EventParticipation> getUserParticipations(String userEmail) {
        Long userId = getUserIdFromEmail(userEmail);
        return participationRepository.findByUserId(userId);
    }

    // Rating methods
    @Transactional
    public EventRating rateEvent(Long eventId, String userEmail, Integer rating, String comment) {
        Event event = getEventById(eventId);
        Long userId = getUserIdFromEmail(userEmail);

        // Check if event has ended
        if (event.getEndDate() != null && event.getEndDate().isAfter(LocalDateTime.now())) {
            throw new RuntimeException("Cannot rate an event that hasn't ended yet");
        }

        // Check if user participated and was approved
        var participation = participationRepository.findByEventIdAndUserId(eventId, userId);
        if (participation.isEmpty()
                || participation.get().getStatus() != EventParticipation.ParticipationStatus.APPROVED) {
            throw new RuntimeException("Only approved participants can rate this event");
        }

        // Check if already rated
        var existingRating = ratingRepository.findByEventIdAndUserId(eventId, userId);
        if (existingRating.isPresent()) {
            // Update existing rating
            EventRating ratingEntity = existingRating.get();
            ratingEntity.setRating(rating);
            ratingEntity.setComment(comment);
            return ratingRepository.save(ratingEntity);
        }

        // Create new rating
        EventRating eventRating = EventRating.builder()
                .eventId(eventId)
                .userId(userId)
                .rating(rating)
                .comment(comment)
                .build();

        return ratingRepository.save(eventRating);
    }

    public List<EventRating> getEventRatings(Long eventId) {
        // Verify event exists
        getEventById(eventId);
        return ratingRepository.findByEventId(eventId);
    }

    public Double getAverageRating(Long eventId) {
        return ratingRepository.getAverageRatingByEventId(eventId);
    }

    private Long getUserIdFromEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"))
                .getId();
    }

    /**
     * Converts an Event entity to EventDTO with enriched owner and center information.
     */
    public EventDTO convertToDTO(Event event) {
        // Get owner information
        User owner = null;
        if (event.getOwnerId() != null) {
            owner = userRepository.findById(event.getOwnerId()).orElse(null);
        }

        // Get center information
        CampingCenter center = null;
        if (event.getCenterId() != null) {
            center = campingCenterRepository.findById(event.getCenterId()).orElse(null);
        }

        return EventDTO.builder()
                .id(event.getId())
                .title(event.getTitle())
                .description(event.getDescription())
                .centerId(event.getCenterId())
                .centerName(center != null ? center.getName() : "Unknown Center")
                .ownerId(event.getOwnerId())
                .ownerFirstName(owner != null ? owner.getFirstName() : null)
                .ownerLastName(owner != null ? owner.getLastName() : null)
                .ownerPhoneNumber(owner != null ? owner.getPhoneNumber() : null)
                .startDate(event.getStartDate())
                .endDate(event.getEndDate())
                .maxParticipants(event.getMaxParticipants())
                .currentParticipants(event.getCurrentParticipants())
                .imageUrl(event.getImageUrl())
                .location(event.getLocation())
                .price(event.getPrice())
                .activities(event.getActivities())
                .isClosed(event.getIsClosed())
                .createdAt(event.getCreatedAt())
                .build();
    }

    /**
     * Converts a list of Event entities to EventDTOs.
     */
    public java.util.List<EventDTO> convertToDTOs(java.util.List<Event> events) {
        return events.stream()
                .map(this::convertToDTO)
                .toList();
    }
}
