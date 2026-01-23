package com.campify.backend.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
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
@Table(name = "event_participations")
public class EventParticipation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private Long eventId;

    @NotNull
    @Column(name = "user_id")
    private Long userId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", referencedColumnName = "id", insertable = false, updatable = false)
    @JsonIgnoreProperties({ "password", "resetCode", "resetCodeExpiration", "authorities", "accountNonExpired",
            "accountNonLocked", "credentialsNonExpired", "enabled", "username" })
    private User user;

    @Enumerated(EnumType.STRING)
    @NotNull
    @Builder.Default
    private ParticipationStatus status = ParticipationStatus.PENDING;

    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();

    public enum ParticipationStatus {
        PENDING,
        APPROVED,
        REJECTED
    }
}
