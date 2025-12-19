package com.campify.backend.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "camping_centers")
public class CampingCenter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    @NotBlank
    @Column(length = 1000)
    private String description;

    @NotBlank
    private String location; // Simplification: Just a string address

    @NotBlank
    private String price; // Storing as string to match mock for now, e.g. "250 TND"

    private Long ownerId; // Owner of the center

    @ElementCollection
    @CollectionTable(name = "center_images", joinColumns = @JoinColumn(name = "center_id"))
    @Column(name = "image_url")
    private List<String> images;
}
