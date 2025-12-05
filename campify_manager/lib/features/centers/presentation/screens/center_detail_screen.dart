import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../config/router.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/domain/entities/entities.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/centers_provider.dart';

/// Detail screen for a camping center.
class CenterDetailScreen extends ConsumerStatefulWidget {
  final String centerId;

  const CenterDetailScreen({super.key, required this.centerId});

  @override
  ConsumerState<CenterDetailScreen> createState() => _CenterDetailScreenState();
}

class _CenterDetailScreenState extends ConsumerState<CenterDetailScreen> {
  int _currentPhotoIndex = 0;
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final centerAsync = ref.watch(centerByIdProvider(widget.centerId));
    final reviewsAsync = ref.watch(centerReviewsProvider(widget.centerId));
    final currentUser = ref.watch(currentUserProvider);

    return centerAsync.when(
      data: (center) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // Photo carousel
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (center.photos.isNotEmpty)
                      PageView.builder(
                        controller: _pageController,
                        itemCount: center.photos.length,
                        onPageChanged: (index) {
                          setState(() => _currentPhotoIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: center.photos[index],
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              color: theme.colorScheme.surfaceContainerHighest,
                              child: const Icon(Icons.image_not_supported),
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        color: theme.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.forest,
                          size: 100,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    // Photo indicators
                    if (center.photos.length > 1)
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            center.photos.length,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPhotoIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    // Gradient overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                if (center.ownerId == currentUser?.id)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        context.push('${AppRoutes.centerForm}?id=${center.id}'),
                  ),
              ],
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (center.isInteresting)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '⭐ Featured',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme
                                          .colorScheme
                                          .onSecondaryContainer,
                                    ),
                                  ),
                                ),
                              Text(
                                center.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    center.location,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  center.averageRating.toStringAsFixed(1),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${center.reviewCount} reviews',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Price range
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(
                          0.3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price per night',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            '\$${center.priceMin.toInt()} - \$${center.priceMax.toInt()}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'About',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(center.description, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 24),

                    // Amenities
                    if (center.amenities.isNotEmpty) ...[
                      Text(
                        'Amenities',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: center.amenities.map((amenity) {
                          return Chip(
                            avatar: Icon(_getAmenityIcon(amenity), size: 18),
                            label: Text(CenterAmenities.displayName(amenity)),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Tags
                    if (center.tags.isNotEmpty) ...[
                      Text(
                        'Tags',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: center.tags.map((tag) {
                          return Chip(
                            backgroundColor:
                                theme.colorScheme.secondaryContainer,
                            label: Text(
                              CenterTags.displayName(tag),
                              style: TextStyle(
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Reviews section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (currentUser?.role == UserRole.camper)
                          TextButton.icon(
                            onPressed: () => _showReviewDialog(context, null),
                            icon: const Icon(Icons.rate_review_outlined),
                            label: const Text('Write a review'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    reviewsAsync.when(
                      data: (reviews) {
                        if (reviews.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.reviews_outlined,
                                    size: 48,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No reviews yet',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: reviews.map((review) {
                            return _ReviewCard(
                              review: review,
                              isOwner: review.userId == currentUser?.id,
                              onEdit: () => _showReviewDialog(context, review),
                              onDelete: () => _deleteReview(review),
                            );
                          }).toList(),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (_, __) => const Text('Error loading reviews'),
                    ),

                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: currentUser?.role == UserRole.camper
            ? FloatingActionButton.extended(
                onPressed: () =>
                    context.push(AppRoutes.reservationCalendarPath(center.id)),
                icon: const Icon(Icons.calendar_today),
                label: const Text('Book Now'),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(centerByIdProvider(widget.centerId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity) {
      case 'wifi':
        return Icons.wifi;
      case 'shower':
        return Icons.shower;
      case 'toilet':
        return Icons.wc;
      case 'electricity':
        return Icons.electrical_services;
      case 'water':
        return Icons.water_drop;
      case 'parking':
        return Icons.local_parking;
      case 'bbq':
        return Icons.outdoor_grill;
      case 'playground':
        return Icons.child_care;
      case 'store':
        return Icons.store;
      case 'laundry':
        return Icons.local_laundry_service;
      default:
        return Icons.check_circle;
    }
  }

  void _showReviewDialog(BuildContext context, Review? existingReview) {
    int rating = existingReview?.rating ?? 5;
    final commentController = TextEditingController(
      text: existingReview?.comment ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            existingReview == null ? 'Write a Review' : 'Edit Review',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () => setState(() => rating = index + 1),
                  );
                }),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'Your review (optional)',
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                maxLength: 500,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                Navigator.pop(context);
                final review = Review(
                  id: existingReview?.id ?? '',
                  userId: '',
                  userName: '',
                  centerId: widget.centerId,
                  rating: rating,
                  comment: commentController.text.isEmpty
                      ? null
                      : commentController.text,
                );

                if (existingReview == null) {
                  await ref
                      .read(centersNotifierProvider.notifier)
                      .createReview(review);
                }
                // Note: Update review would need similar implementation
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteReview(Review review) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Review'),
        content: const Text('Are you sure you want to delete this review?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref
          .read(centersNotifierProvider.notifier)
          .deleteReview(review.id, review.centerId);
    }
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;
  final bool isOwner;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ReviewCard({
    required this.review,
    required this.isOwner,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    review.userName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < review.rating
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 16,
                              color: Colors.amber,
                            );
                          }),
                          if (review.createdAt != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              '${review.createdAt!.day}/${review.createdAt!.month}/${review.createdAt!.year}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                if (isOwner)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit();
                      } else if (value == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (review.comment != null) ...[
              const SizedBox(height: 12),
              Text(review.comment!),
            ],
          ],
        ),
      ),
    );
  }
}
