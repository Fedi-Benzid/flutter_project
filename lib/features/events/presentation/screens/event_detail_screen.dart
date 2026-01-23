import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/events_provider.dart';

/// Event detail screen.
class EventDetailScreen extends ConsumerWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final eventAsync = ref.watch(eventByIdProvider(eventId));
    final participationsAsync = ref.watch(eventParticipationsProvider(eventId));
    final currentUser = ref.watch(currentUserProvider);
    final isOwner = ref.watch(isOwnerProvider);
    final myParticipationAsync =
        ref.watch(myParticipationForEventProvider(eventId));

    return eventAsync.when(
      data: (event) {
        final isPast = event.date.isBefore(DateTime.now());
        final isFull = event.currentParticipants >= event.maxParticipants;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Image header
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: event.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: event.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: theme.colorScheme.primaryContainer,
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: theme.colorScheme.primaryContainer,
                            child: Icon(
                              Icons.event,
                              size: 64,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        )
                      : Container(
                          color: theme.colorScheme.primaryContainer,
                          child: Icon(
                            Icons.event,
                            size: 64,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        event.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price banner
                      if (event.price > 0)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.attach_money,
                                  color: theme.colorScheme.onPrimaryContainer),
                              const SizedBox(width: 8),
                              Text(
                                '${event.price.toStringAsFixed(2)} TND / person',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Date and time
                      _InfoRow(
                        icon: Icons.calendar_today,
                        label: 'Start Date',
                        value:
                            '${event.date.day}/${event.date.month}/${event.date.year}',
                      ),
                      const SizedBox(height: 8),
                      if (event.endDate != null)
                        _InfoRow(
                          icon: Icons.event,
                          label: 'End Date',
                          value:
                              '${event.endDate!.day}/${event.endDate!.month}/${event.endDate!.year}',
                        ),
                      if (event.endDate != null) const SizedBox(height: 8),
                      _InfoRow(
                        icon: Icons.access_time,
                        label: 'Time',
                        value:
                            '${event.date.hour.toString().padLeft(2, '0')}:${event.date.minute.toString().padLeft(2, '0')}',
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        icon: Icons.timer_outlined,
                        label: 'Duration',
                        value: '${event.durationHours} hours',
                      ),
                      const SizedBox(height: 8),

                      // Location
                      if (event.location != null && event.location!.isNotEmpty)
                        _InfoRow(
                          icon: Icons.location_on,
                          label: 'Location',
                          value: event.location!,
                        ),
                      if (event.location != null && event.location!.isNotEmpty)
                        const SizedBox(height: 8),

                      // Participants info
                      _InfoRow(
                        icon: Icons.people,
                        label: 'Max Participants',
                        value: '${event.maxParticipants}',
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        icon: Icons.person_add,
                        label: 'Current',
                        value: '${event.currentParticipants}',
                      ),
                      const SizedBox(height: 8),
                      _InfoRow(
                        icon: Icons.event_available,
                        label: 'Remaining Places',
                        value: '${event.spotsRemaining}',
                        valueColor:
                            isFull ? theme.colorScheme.error : Colors.green,
                      ),
                      const SizedBox(height: 8),

                      // Creator phone
                      if (event.creatorPhone != null &&
                          event.creatorPhone!.isNotEmpty)
                        _InfoRow(
                          icon: Icons.phone,
                          label: 'Contact',
                          value: event.creatorPhone!,
                        ),
                      if (event.creatorPhone != null &&
                          event.creatorPhone!.isNotEmpty)
                        const SizedBox(height: 16),

                      // Activities
                      if (event.activities.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Activities',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: event.activities.map((activity) {
                            return Chip(
                              avatar: const Icon(Icons.sports, size: 18),
                              label: Text(activity),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Description
                      Text(
                        'About this event',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(event.description),
                      const SizedBox(height: 24),

                      // Camper participation status banner
                      if (currentUser?.role == UserRole.camper)
                        myParticipationAsync.when(
                          data: (participation) {
                            if (participation == null) {
                              return const SizedBox.shrink();
                            }
                            return _CamperParticipationStatusBanner(
                              participation: participation,
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),

                      // Status banner
                      if (isPast)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'This event has already taken place',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (isFull)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: theme.colorScheme.onErrorContainer,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'This event is fully booked',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onErrorContainer,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Participations (for owner or event creator)
                      if (isOwner || event.creatorId == currentUser?.id) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Participation Requests',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        participationsAsync.when(
                          data: (participations) {
                            if (participations.isEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.colorScheme.outline
                                        .withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text('No participation requests'),
                                ),
                              );
                            }

                            return Column(
                              children: participations.map((p) {
                                return _ParticipationCard(
                                  participation: p,
                                  eventId: eventId,
                                );
                              }).toList(),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (_, __) => const Text('Error loading'),
                        ),
                      ],

                      const SizedBox(height: 100), // Space for FAB
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: _buildFloatingActionButton(
            context: context,
            ref: ref,
            eventId: eventId,
            isPast: isPast,
            isFull: isFull,
            currentUser: currentUser,
            myParticipationAsync: myParticipationAsync,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _ParticipationCard extends ConsumerWidget {
  final EventParticipation participation;
  final String eventId;

  const _ParticipationCard({
    required this.participation,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Build subtitle with date and phone number
    final dateStr = _formatDate(participation.requestedAt);
    final phoneStr = participation.phoneNumber;
    final subtitleText = phoneStr != null && phoneStr.isNotEmpty
        ? '$dateStr • 📞 $phoneStr'
        : dateStr;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            participation.userName.isNotEmpty
                ? participation.userName.substring(0, 1).toUpperCase()
                : '?',
          ),
        ),
        title: Text(participation.userName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitleText),
            if (phoneStr != null && phoneStr.isNotEmpty)
              GestureDetector(
                onTap: () {
                  // Could launch phone dialer here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contact: $phoneStr')),
                  );
                },
                child: Text(
                  'Tap to call',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
        isThreeLine: phoneStr != null && phoneStr.isNotEmpty,
        trailing: participation.status == ParticipationStatus.pending
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(eventsNotifierProvider.notifier)
                          .updateParticipationStatus(
                            participation.id,
                            eventId,
                            ParticipationStatus.declined,
                          );
                    },
                    icon: Icon(Icons.close, color: theme.colorScheme.error),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(eventsNotifierProvider.notifier)
                          .updateParticipationStatus(
                            participation.id,
                            eventId,
                            ParticipationStatus.approved,
                          );
                    },
                    icon: Icon(Icons.check, color: Colors.green),
                  ),
                ],
              )
            : Chip(
                label: Text(
                  participation.status.displayName,
                  style: theme.textTheme.labelSmall,
                ),
                backgroundColor:
                    participation.status == ParticipationStatus.approved
                        ? Colors.green.shade100
                        : Colors.red.shade100,
              ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Helper function to build the floating action button based on participation status.
Widget? _buildFloatingActionButton({
  required BuildContext context,
  required WidgetRef ref,
  required String eventId,
  required bool isPast,
  required bool isFull,
  required User? currentUser,
  required AsyncValue<EventParticipation?> myParticipationAsync,
}) {
  // Only show FAB for campers
  if (currentUser?.role != UserRole.camper) return null;
  if (isPast || isFull) return null;

  // Check if user already has a participation request
  final hasExistingRequest = myParticipationAsync.when(
    data: (participation) => participation != null,
    loading: () => true, // Hide while loading to prevent double requests
    error: (_, __) => false,
  );

  if (hasExistingRequest) return null;

  return FloatingActionButton.extended(
    onPressed: () async {
      final result = await ref
          .read(eventsNotifierProvider.notifier)
          .requestParticipation(eventId);

      if (result != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Participation request sent!'),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    },
    icon: const Icon(Icons.how_to_reg),
    label: const Text('Request to Join'),
  );
}

/// Professional glassmorphism status banner showing camper's participation status.
class _CamperParticipationStatusBanner extends StatelessWidget {
  final EventParticipation participation;

  const _CamperParticipationStatusBanner({
    required this.participation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = participation.status;

    // Define colors and content based on status
    final (
      Color gradientStart,
      Color gradientEnd,
      IconData icon,
      String title,
      String subtitle
    ) = switch (status) {
      ParticipationStatus.pending => (
          const Color(0xFFFFA726),
          const Color(0xFFFF9800),
          Icons.schedule_rounded,
          'Request Pending',
          'Your participation request is awaiting approval from the event organizer.',
        ),
      ParticipationStatus.approved => (
          const Color(0xFF66BB6A),
          const Color(0xFF4CAF50),
          Icons.check_circle_rounded,
          'You\'re Approved!',
          'Congratulations! Your participation has been confirmed.',
        ),
      ParticipationStatus.declined => (
          const Color(0xFFEF5350),
          const Color(0xFFF44336),
          Icons.cancel_rounded,
          'Request Declined',
          'Unfortunately, your participation request was not approved.',
        ),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gradientStart.withOpacity(0.9),
            gradientEnd.withOpacity(0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientEnd.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Decorative circle pattern
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -30,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon container with glassmorphism effect
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        if (participation.requestedAt != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Requested on ${participation.requestedAt!.day}/${participation.requestedAt!.month}/${participation.requestedAt!.year}',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
