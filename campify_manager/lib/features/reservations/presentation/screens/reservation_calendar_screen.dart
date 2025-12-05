import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../config/router.dart';
import '../../../centers/presentation/providers/centers_provider.dart';

/// Calendar screen for selecting reservation dates.
class ReservationCalendarScreen extends ConsumerStatefulWidget {
  final String centerId;

  const ReservationCalendarScreen({super.key, required this.centerId});

  @override
  ConsumerState<ReservationCalendarScreen> createState() =>
      _ReservationCalendarScreenState();
}

class _ReservationCalendarScreenState
    extends ConsumerState<ReservationCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final centerAsync = ref.watch(centerByIdProvider(widget.centerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Select Dates')),
      body: centerAsync.when(
        data: (center) => Column(
          children: [
            // Center info header
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: center.photos.isNotEmpty
                        ? Image.network(
                            center.photos.first,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _buildPlaceholder(theme),
                          )
                        : _buildPlaceholder(theme),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          center.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${center.priceMin.toInt()} - \$${center.priceMax.toInt()} / night',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Calendar
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(const Duration(days: 365)),
                      focusedDay: _focusedDay,
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      rangeSelectionMode: _rangeSelectionMode,
                      calendarFormat: CalendarFormat.month,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: theme.textTheme.titleMedium!,
                      ),
                      calendarStyle: CalendarStyle(
                        rangeHighlightColor: theme.colorScheme.primary
                            .withOpacity(0.2),
                        rangeStartDecoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        rangeEndDecoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        todayTextStyle: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      onRangeSelected: (start, end, focusedDay) {
                        setState(() {
                          _rangeStart = start;
                          _rangeEnd = end;
                          _focusedDay = focusedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),

                    // Selected dates summary
                    if (_rangeStart != null) ...[
                      const Divider(height: 32),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _DateCard(
                                    label: 'Check-in',
                                    date: _rangeStart!,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _DateCard(
                                    label: 'Check-out',
                                    date:
                                        _rangeEnd ??
                                        _rangeStart!.add(
                                          const Duration(days: 1),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_calculateNights()} night${_calculateNights() > 1 ? 's' : ''}',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  Text(
                                    '~\$${(_calculateNights() * (center.priceMin + center.priceMax) / 2).toStringAsFixed(0)}',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: _rangeStart != null
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: FilledButton(
                  onPressed: () {
                    final endDate =
                        _rangeEnd ?? _rangeStart!.add(const Duration(days: 1));
                    context.push(
                      '${AppRoutes.bookingFlowPath(widget.centerId)}'
                      '?start=${_rangeStart!.toIso8601String()}'
                      '&end=${endDate.toIso8601String()}',
                    );
                  },
                  child: const Text('Continue'),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      width: 60,
      height: 60,
      color: theme.colorScheme.primaryContainer,
      child: Icon(Icons.forest, color: theme.colorScheme.primary),
    );
  }

  int _calculateNights() {
    if (_rangeStart == null) return 0;
    final end = _rangeEnd ?? _rangeStart!.add(const Duration(days: 1));
    return end.difference(_rangeStart!).inDays;
  }
}

class _DateCard extends StatelessWidget {
  final String label;
  final DateTime date;

  const _DateCard({required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${date.day}/${date.month}/${date.year}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
