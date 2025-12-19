package com.campify.backend.repository;

import com.campify.backend.model.MarketplaceItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MarketplaceRepository extends JpaRepository<MarketplaceItem, Long> {

    List<MarketplaceItem> findByCenterId(Long centerId);

    List<MarketplaceItem> findByCategory(MarketplaceItem.ItemCategory category);

    List<MarketplaceItem> findByCenterIdAndCategory(Long centerId, MarketplaceItem.ItemCategory category);
}
