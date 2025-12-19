package com.campify.backend.service;

import com.campify.backend.exception.ResourceNotFoundException;
import com.campify.backend.model.CampingCenter;
import com.campify.backend.model.Review;
import com.campify.backend.repository.CampingCenterRepository;
import com.campify.backend.repository.ReviewRepository;
import com.campify.backend.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CampingCenterService {

    private final CampingCenterRepository campingCenterRepository;
    private final FileStorageService fileStorageService;
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;

    public List<CampingCenter> getAllCenters() {
        return campingCenterRepository.findAll();
    }

    public CampingCenter getCenterById(Long id) {
        return campingCenterRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("CampingCenter", "id", id));
    }

    public CampingCenter createCenter(CampingCenter center, List<MultipartFile> images, String ownerEmail) {
        Long ownerId = getUserIdFromEmail(ownerEmail);
        center.setOwnerId(ownerId);

        List<String> imageUrls = new ArrayList<>();
        if (images != null && !images.isEmpty()) {
            for (MultipartFile file : images) {
                imageUrls.add(fileStorageService.storeFile(file));
            }
        }
        center.setImages(imageUrls);
        return campingCenterRepository.save(center);
    }

    public void deleteCenter(Long id, String ownerEmail) {
        CampingCenter center = getCenterById(id);
        Long ownerId = getUserIdFromEmail(ownerEmail);

        // Verify owner
        if (center.getOwnerId() != null && !center.getOwnerId().equals(ownerId)) {
            throw new RuntimeException("Only the center owner can delete this center");
        }

        campingCenterRepository.delete(center);
    }

    public List<CampingCenter> getOwnedCenters(String ownerEmail) {
        Long ownerId = getUserIdFromEmail(ownerEmail);
        return campingCenterRepository.findAll().stream()
                .filter(c -> c.getOwnerId() != null && c.getOwnerId().equals(ownerId))
                .toList();
    }

    // Review methods
    public List<Review> getCenterReviews(Long centerId) {
        getCenterById(centerId); // Verify center exists
        return reviewRepository.findByCenterId(centerId);
    }

    public Review createReview(Long centerId, Review review, String userEmail) {
        getCenterById(centerId); // Verify center exists
        Long userId = getUserIdFromEmail(userEmail);

        review.setCenterId(centerId);
        review.setUserId(userId);
        return reviewRepository.save(review);
    }

    public Review updateReview(Long reviewId, Review updatedReview, String userEmail) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found"));

        Long userId = getUserIdFromEmail(userEmail);

        // Verify owner
        if (!review.getUserId().equals(userId)) {
            throw new RuntimeException("Only the review author can update this review");
        }

        if (updatedReview.getRating() != null) {
            review.setRating(updatedReview.getRating());
        }
        if (updatedReview.getComment() != null) {
            review.setComment(updatedReview.getComment());
        }

        return reviewRepository.save(review);
    }

    public void deleteReview(Long reviewId, String userEmail) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found"));

        Long userId = getUserIdFromEmail(userEmail);

        // Verify owner
        if (!review.getUserId().equals(userId)) {
            throw new RuntimeException("Only the review author can delete this review");
        }

        reviewRepository.delete(review);
    }

    private Long getUserIdFromEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"))
                .getId();
    }
}
