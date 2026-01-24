package com.campify.backend.repository;

import com.campify.backend.model.EventRating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EventRatingRepository extends JpaRepository<EventRating, Long> {

    List<EventRating> findByEventId(Long eventId);

    Optional<EventRating> findByEventIdAndUserId(Long eventId, Long userId);

    @Query("SELECT AVG(r.rating) FROM EventRating r WHERE r.eventId = :eventId")
    Double getAverageRatingByEventId(@Param("eventId") Long eventId);

    long countByEventId(Long eventId);
}
