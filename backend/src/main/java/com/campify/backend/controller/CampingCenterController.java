package com.campify.backend.controller;

import com.campify.backend.model.CampingCenter;
import com.campify.backend.model.Review;
import com.campify.backend.payload.ApiResponse;
import com.campify.backend.service.CampingCenterService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/centers")
@RequiredArgsConstructor
public class CampingCenterController {

    private final CampingCenterService campingCenterService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<CampingCenter>>> getAllCenters(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) List<String> tags) {
        List<CampingCenter> centers = campingCenterService.getCentersFiltered(
                name, location, minPrice, maxPrice, tags);
        return ResponseEntity.ok(new ApiResponse<>(true, "Centers fetched successfully", centers));
    }

    @GetMapping("/owned")
    public ResponseEntity<ApiResponse<List<CampingCenter>>> getOwnedCenters() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        List<CampingCenter> centers = campingCenterService.getOwnedCenters(auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Owned centers fetched successfully", centers));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<CampingCenter>> getCenterById(@PathVariable Long id) {
        CampingCenter center = campingCenterService.getCenterById(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Center fetched successfully", center));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<CampingCenter>> createCenter(@Valid @RequestBody CampingCenter center) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        CampingCenter createdCenter = campingCenterService.createCenter(center, null, auth.getName());
        return new ResponseEntity<>(new ApiResponse<>(true, "Center created successfully", createdCenter),
                HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<CampingCenter>> updateCenter(
            @PathVariable Long id,
            @Valid @RequestBody CampingCenter center) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        CampingCenter updatedCenter = campingCenterService.updateCenter(id, center, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Center updated successfully", updatedCenter));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteCenter(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        campingCenterService.deleteCenter(id, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Center deleted successfully", null));
    }

    // Review endpoints
    @GetMapping("/{id}/reviews")
    public ResponseEntity<ApiResponse<List<Review>>> getCenterReviews(@PathVariable Long id) {
        List<Review> reviews = campingCenterService.getCenterReviews(id);
        return ResponseEntity.ok(new ApiResponse<>(true, "Reviews fetched successfully", reviews));
    }

    @PostMapping("/{id}/reviews")
    public ResponseEntity<ApiResponse<Review>> createReview(
            @PathVariable Long id,
            @Valid @RequestBody Review review) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Review createdReview = campingCenterService.createReview(id, review, auth.getName());
        return new ResponseEntity<>(new ApiResponse<>(true, "Review created successfully", createdReview),
                HttpStatus.CREATED);
    }

    @PutMapping("/reviews/{id}")
    public ResponseEntity<ApiResponse<Review>> updateReview(
            @PathVariable Long id,
            @Valid @RequestBody Review review) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Review updatedReview = campingCenterService.updateReview(id, review, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Review updated successfully", updatedReview));
    }

    @DeleteMapping("/reviews/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteReview(@PathVariable Long id) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        campingCenterService.deleteReview(id, auth.getName());
        return ResponseEntity.ok(new ApiResponse<>(true, "Review deleted successfully", null));
    }
}
