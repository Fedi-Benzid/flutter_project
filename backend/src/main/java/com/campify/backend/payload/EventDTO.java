package com.campify.backend.payload;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Data Transfer Object for Event with enriched owner and center information.
 * Used for API responses to provide complete event details including owner and center info.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventDTO {
    private Long id;
    private String title;
    private String description;
    private Long centerId;
    private String centerName;
    private Long ownerId;
    private String ownerFirstName;
    private String ownerLastName;
    private String ownerPhoneNumber;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private Integer maxParticipants;
    private Integer currentParticipants;
    private String imageUrl;
    private String location;
    private Double price;
    private String activities; // JSON array stored as string
    private Boolean isClosed;
    private LocalDateTime createdAt;
}
