package com.campify.backend.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "events")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String title;

    private String description;

    @NotNull
    private Long centerId;

    // ownerId is set automatically from JWT - no validation needed
    private Long ownerId;

    @NotNull
    @Future
    private LocalDateTime startDate;

    @NotNull
    @Future
    private LocalDateTime endDate;

    @Min(1)
    private Integer maxParticipants;

    private String imageUrl;

   // @Column(precision = 10, scale = 2)
    private Double price;

    @Column(columnDefinition = "TEXT")
    private String activities; // JSON array stored as string

    private String location;

    @Builder.Default
    private Boolean isClosed = false;

    @Transient
    private Integer currentParticipants;

    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();
}
