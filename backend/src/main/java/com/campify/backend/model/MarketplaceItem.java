package com.campify.backend.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "marketplace_items")
public class MarketplaceItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    private String description;

    @NotNull
    @Min(0)
    private Double price;

    @Enumerated(EnumType.STRING)
    @NotNull
    private ItemCategory category;

    private Long centerId; // Optional: link to a specific center

    @ElementCollection
    @CollectionTable(name = "marketplace_item_images", joinColumns = @JoinColumn(name = "item_id"))
    @Column(name = "image_url")
    private List<String> imageUrls = new ArrayList<>();

    @Min(0)
    private Integer stock;

    public enum ItemCategory {
        CAMPING_GEAR,
        FOOD_BEVERAGES,
        OUTDOOR_EQUIPMENT,
        ACCESSORIES,
        OTHER
    }
}
