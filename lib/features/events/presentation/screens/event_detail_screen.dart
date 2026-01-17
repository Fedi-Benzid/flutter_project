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
          floatingActionButton:
              !isPast && !isFull && currentUser?.role == UserRole.camper
                  ? FloatingActionButton.extended(
                      onPressed: () async {
                        final result = await ref
                            .read(eventsNotifierProvider.notifier)
                            .requestParticipation(eventId);

                        if (result != null && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Participation request sent!'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.how_to_reg),
                      label: const Text('Request to Join'),
                    )
                  : null,
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

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(participation.userName.substring(0, 1).toUpperCase()),
        ),
        title: Text(participation.userName),
        subtitle: Text(_formatDate(participation.requestedAt)),
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
