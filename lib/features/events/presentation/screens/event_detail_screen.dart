import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router.dart';
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
        final isPast = event.endDate != null
            ? event.endDate!.isBefore(DateTime.now())
            : event.date.isBefore(DateTime.now());
        final isFull = event.currentParticipants >= event.maxParticipants;
        final isClosed = event.isClosed;

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
                actions: [
                  // Owner actions
                  if (isOwner || event.creatorId == currentUser?.id)
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'edit') {
                          context.push('${AppRoutes.eventForm}?id=${event.id}');
                        } else if (value == 'close') {
                          await _showCloseEventDialog(context, ref, event);
                        } else if (value == 'delete') {
                          await _showDeleteEventDialog(context, ref, event);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit Event'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        if (!event.isClosed)
                          const PopupMenuItem(
                            value: 'close',
                            child: ListTile(
                              leading: Icon(Icons.lock),
                              title: Text('Close Event'),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Delete Event'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
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
                      // Title
                      Text(
                        event.title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Closed banner
                      if (isClosed)
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lock,
                                  color: theme.colorScheme.onErrorContainer),
                              const SizedBox(width: 12),
                              Text(
                                'This event is closed for new requests',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onErrorContainer,
                                ),
                              ),
                            ],
                          ),
                        ),

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

                      // Center information
                      if (event.centerName != null && event.centerName!.isNotEmpty) ...[
                        _InfoRow(
                          icon: Icons.business,
                          label: 'Center',
                          value: event.centerName ?? 'Unknown',
                        ),
                        const SizedBox(height: 8),
                      ],

                      // Event organizer information
                      if (event.ownerFirstName != null || event.ownerLastName != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outline.withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Event Organizer',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: theme.colorScheme.primary,
                                    child: Text(
                                      ((event.ownerFirstName?.isNotEmpty ?? false)
                                              ? event.ownerFirstName![0].toUpperCase()
                                              : 'O')
                                          .toString(),
                                      style: TextStyle(
                                        color: theme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${event.ownerFirstName ?? ''} ${event.ownerLastName ?? ''}'
                                              .trim(),
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        if (event.ownerPhoneNumber != null &&
                                            event.ownerPhoneNumber!.isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Contact: ${event.ownerPhoneNumber}',
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                event.ownerPhoneNumber ?? '',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: theme
                                                      .colorScheme.primary,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],

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

                      // Creator phone (keep for backward compatibility)
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
                              eventId: eventId,
                              event: event,
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),

                      // Status banner for past/full events
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
                      else if (isFull && !isClosed)
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

                      // Rating section for completed events
                      if (isPast) ...[
                        const SizedBox(height: 24),
                        _RatingSection(eventId: eventId, currentUser: currentUser),
                      ],

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
            event: event,
            isPast: isPast,
            isFull: isFull,
            isClosed: isClosed,
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

  Future<void> _showCloseEventDialog(BuildContext context, WidgetRef ref, Event event) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Close Event'),
        content: const Text(
          'Are you sure you want to close this event? No new participation requests will be accepted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Close Event'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(eventsNotifierProvider.notifier).closeEvent(event.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event closed successfully')),
        );
      }
    }
  }

  Future<void> _showDeleteEventDialog(BuildContext context, WidgetRef ref, Event event) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Event'),
        content: const Text(
          'Are you sure you want to delete this event? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref.read(eventsNotifierProvider.notifier).deleteEvent(event.id);
      if (success && context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event deleted successfully')),
        );
      }
    }
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

    // Build contact information
    final dateStr = _formatDate(participation.requestedAt);
    final phoneStr = participation.phoneNumber;
    final emailStr = participation.userEmail;
    final personsStr = '${participation.numberOfPersons} person${participation.numberOfPersons > 1 ? 's' : ''}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name, status, and persons
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getStatusColor(participation.status),
                  child: Text(
                    participation.userName.isNotEmpty
                        ? participation.userName.substring(0, 1).toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        participation.userName,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        personsStr,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (participation.status == ParticipationStatus.pending)
                  Row(
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
                        icon: Icon(
                          Icons.close,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.zero,
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
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 20,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  )
                else
                  Chip(
                    label: Text(
                      participation.status.displayName,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getStatusColor(participation.status),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            // Date and request info
            Text(
              'Requested: $dateStr',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            // Contact information section
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (phoneStr != null && phoneStr.isNotEmpty) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Phone: $phoneStr'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Text(
                              phoneStr,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (emailStr != null && emailStr.isNotEmpty)
                      const SizedBox(height: 8),
                  ],
                  if (emailStr != null && emailStr.isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Email: $emailStr'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Text(
                              emailStr,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(ParticipationStatus status) {
    switch (status) {
      case ParticipationStatus.approved:
        return Colors.green;
      case ParticipationStatus.declined:
        return Colors.red;
      case ParticipationStatus.pending:
        return Colors.orange;
    }
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
  required Event event,
  required bool isPast,
  required bool isFull,
  required bool isClosed,
  required User? currentUser,
  required AsyncValue<EventParticipation?> myParticipationAsync,
}) {
  // Only show FAB for campers
  if (currentUser?.role != UserRole.camper) return null;
  if (isPast) return null;

  // Check if user already has a participation request
  final existingParticipation = myParticipationAsync.when(
    data: (participation) => participation,
    loading: () => null,
    error: (_, __) => null,
  );

  if (existingParticipation != null) return null;

  // Don't show if event is full or closed
  if (isFull || isClosed) return null;

  return FloatingActionButton.extended(
    onPressed: () => _showParticipationDialog(context, ref, eventId, event),
    icon: const Icon(Icons.how_to_reg),
    label: const Text('Request to Join'),
  );
}

Future<void> _showParticipationDialog(
    BuildContext context, WidgetRef ref, String eventId, Event event) async {
  int numberOfPersons = 1;
  
  final result = await showDialog<int>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final totalPrice = event.price * numberOfPersons;
          
          return AlertDialog(
            title: const Text('Request to Join'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('How many people will be joining?'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: numberOfPersons > 1
                          ? () => setState(() => numberOfPersons--)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$numberOfPersons',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: numberOfPersons < event.spotsRemaining
                          ? () => setState(() => numberOfPersons++)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                if (event.price > 0) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Price:'),
                        Text(
                          '${totalPrice.toStringAsFixed(2)} TND',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  '${event.spotsRemaining} spots remaining',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, numberOfPersons),
                child: const Text('Submit Request'),
              ),
            ],
          );
        },
      );
    },
  );

  if (result != null && context.mounted) {
    final participation = await ref
        .read(eventsNotifierProvider.notifier)
        .requestParticipation(eventId, numberOfPersons: result);

    if (participation != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Participation request sent for $result person${result > 1 ? 's' : ''}!'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

/// Professional glassmorphism status banner showing camper's participation status.
class _CamperParticipationStatusBanner extends ConsumerWidget {
  final EventParticipation participation;
  final String eventId;
  final Event event;

  const _CamperParticipationStatusBanner({
    required this.participation,
    required this.eventId,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          'Your participation request for ${participation.numberOfPersons} person${participation.numberOfPersons > 1 ? 's' : ''} is awaiting approval.',
        ),
      ParticipationStatus.approved => (
          const Color(0xFF66BB6A),
          const Color(0xFF4CAF50),
          Icons.check_circle_rounded,
          'You\'re Approved!',
          'Congratulations! Your participation for ${participation.numberOfPersons} person${participation.numberOfPersons > 1 ? 's' : ''} has been confirmed.',
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
              child: Column(
                children: [
                  Row(
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
                            if (event.price > 0 && status != ParticipationStatus.declined) ...[
                              const SizedBox(height: 8),
                              Text(
                                'Total: ${(event.price * participation.numberOfPersons).toStringAsFixed(2)} TND',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
                  // Action buttons for pending requests
                  if (status == ParticipationStatus.pending) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showUpdateDialog(context, ref),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.white.withOpacity(0.5)),
                            ),
                            icon: const Icon(Icons.edit, size: 18),
                            label: const Text('Update'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showCancelDialog(context, ref),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.white.withOpacity(0.5)),
                            ),
                            icon: const Icon(Icons.cancel, size: 18),
                            label: const Text('Cancel'),
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
    );
  }

  Future<void> _showUpdateDialog(BuildContext context, WidgetRef ref) async {
    int numberOfPersons = participation.numberOfPersons;
    
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final totalPrice = event.price * numberOfPersons;
            
            return AlertDialog(
              title: const Text('Update Request'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Update number of people:'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: numberOfPersons > 1
                            ? () => setState(() => numberOfPersons--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$numberOfPersons',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: numberOfPersons < (event.spotsRemaining + participation.numberOfPersons)
                            ? () => setState(() => numberOfPersons++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  if (event.price > 0) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price:'),
                          Text(
                            '${totalPrice.toStringAsFixed(2)} TND',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, numberOfPersons),
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null && result != participation.numberOfPersons && context.mounted) {
      await ref.read(eventsNotifierProvider.notifier).updateMyParticipation(
        participation.id,
        eventId,
        result,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request updated successfully')),
        );
      }
    }
  }

  Future<void> _showCancelDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Request'),
        content: const Text('Are you sure you want to cancel your participation request?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(eventsNotifierProvider.notifier).cancelParticipation(
        participation.id,
        eventId,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request cancelled')),
        );
      }
    }
  }
}

/// Rating section for completed events
class _RatingSection extends ConsumerStatefulWidget {
  final String eventId;
  final User? currentUser;

  const _RatingSection({
    required this.eventId,
    required this.currentUser,
  });

  @override
  ConsumerState<_RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends ConsumerState<_RatingSection> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _hasSubmitted = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratingsAsync = ref.watch(eventRatingsProvider(widget.eventId));
    final averageAsync = ref.watch(eventAverageRatingProvider(widget.eventId));
    final myParticipationAsync = ref.watch(myParticipationForEventProvider(widget.eventId));

    // Check if user can rate
    final canRate = myParticipationAsync.when(
      data: (p) => p != null && p.status == ParticipationStatus.approved,
      loading: () => false,
      error: (_, __) => false,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ratings & Reviews',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            averageAsync.when(
              data: (avg) => avg != null
                  ? Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          avg.toStringAsFixed(1),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Rating input for approved participants
        if (canRate && widget.currentUser?.role == UserRole.camper && !_hasSubmitted) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rate this event:'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () => setState(() => _rating = index + 1),
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Comment (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _rating > 0 ? _submitRating : null,
                      child: const Text('Submit Rating'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Existing ratings
        ratingsAsync.when(
          data: (ratings) {
            if (ratings.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text('No ratings yet')),
              );
            }

            return Column(
              children: ratings.map((rating) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        rating.userName?.isNotEmpty == true
                            ? rating.userName!.substring(0, 1).toUpperCase()
                            : '?',
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(rating.userName ?? 'Anonymous'),
                        const Spacer(),
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating.rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ],
                    ),
                    subtitle: rating.comment != null && rating.comment!.isNotEmpty
                        ? Text(rating.comment!)
                        : null,
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Text('Error loading ratings'),
        ),
      ],
    );
  }

  Future<void> _submitRating() async {
    final result = await ref.read(eventsNotifierProvider.notifier).rateEvent(
      widget.eventId,
      _rating,
      _commentController.text.isEmpty ? null : _commentController.text,
    );

    if (result != null && mounted) {
      setState(() => _hasSubmitted = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thank you for your rating!')),
      );
    }
  }
}
