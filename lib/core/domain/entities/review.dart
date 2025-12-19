import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

/// Review entity for center ratings and feedback.
///
/// Campers can leave reviews for centers they've visited.
/// Reviews include a numeric rating (1-5) and optional text comment.
@freezed
class Review with _$Review {
  const factory Review({
    /// Unique identifier
    required String id,

    /// ID of the user who wrote the review
    required String userId,

    /// Name of the user (denormalized for display)
    required String userName,

    /// ID of the camping center being reviewed
    required String centerId,

    /// Rating from 1-5 stars
    required int rating,

    /// Optional text comment
    String? comment,

    /// When the review was posted
    DateTime? createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
