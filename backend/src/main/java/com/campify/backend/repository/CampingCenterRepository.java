package com.campify.backend.repository;

import com.campify.backend.model.CampingCenter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CampingCenterRepository extends JpaRepository<CampingCenter, Long> {
}
