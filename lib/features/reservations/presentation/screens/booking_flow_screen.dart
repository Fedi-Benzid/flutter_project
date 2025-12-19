import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router.dart';
import '../../../../core/domain/entities/entities.dart';
import '../../../centers/presentation/providers/centers_provider.dart';
import '../../../marketplace/presentation/providers/marketplace_provider.dart';
import '../providers/reservations_provider.dart';

/// Booking flow screen for completing a reservation.
class BookingFlowScreen extends ConsumerStatefulWidget {
  final String centerId;
  final DateTime? startDate;
  final DateTime? endDate;

  const BookingFlowScreen({
    super.key,
    required this.centerId,
    this.startDate,
    this.endDate,
  });

  @override
  ConsumerState<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends ConsumerState<BookingFlowScreen> {
  int _guestCount = 2;
  final _notesController = TextEditingController();
  final Map<String, int> _selectedItems = {};
  bool _isSubmitting = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final centerAsync = ref.watch(centerByIdProvider(widget.centerId));
    final itemsAsync = ref.watch(itemsByCenterProvider(widget.centerId));

    final startDate = widget.startDate ?? DateTime.now();
    final endDate = widget.endDate ?? startDate.add(const Duration(days: 1));
    final nights = endDate.difference(startDate).inDays;

    return Scaffold(
      appBar: AppBar(title: const Text('Complete Booking')),
      body: centerAsync.when(
        data: (center) {
          final basePrice = nights * (center.priceMin + center.priceMax) / 2;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Center summary
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: center.photos.isNotEmpty
                              ? Image.network(
                                  center.photos.first,
                                  width: 80,
                                  height: 80,
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
                              const SizedBox(height: 4),
                              Text(
                                '${_formatDate(startDate)} - ${_formatDate(endDate)}',
                                style: theme.textTheme.bodyMedium,
                              ),
                              Text(
                                '$nights night${nights > 1 ? 's' : ''}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Guest count
                Text(
                  'Number of Guests',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      onPressed: _guestCount > 1
                          ? () => setState(() => _guestCount--)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '$_guestCount guest${_guestCount > 1 ? 's' : ''}',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: _guestCount < 10
                          ? () => setState(() => _guestCount++)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Optional items
                Text(
                  'Add Equipment (Optional)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                itemsAsync.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'No equipment available at this center',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: items.map((item) {
                        final isSelected = _selectedItems.containsKey(item.id);
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: CheckboxListTile(
                            value: isSelected,
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selectedItems[item.id] = 1;
                                } else {
                                  _selectedItems.remove(item.id);
                                }
                              });
                            },
                            title: Text(item.name),
                            subtitle: Text(
                              '${item.rentPricePerDay.toStringAsFixed(2)} TND/day × $nights days',
                            ),
                            secondary: isSelected
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: (_selectedItems[item.id] ??
                                                    1) >
                                                1
                                            ? () => setState(() {
                                                  _selectedItems[item.id] =
                                                      _selectedItems[item.id]! -
                                                          1;
                                                })
                                            : null,
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 20,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          '${_selectedItems[item.id]}',
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => setState(() {
                                          _selectedItems[item.id] =
                                              (_selectedItems[item.id] ?? 1) +
                                                  1;
                                        }),
                                        icon: const Icon(Icons.add, size: 20),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ],
                                  )
                                : Text(
                                    '${(item.rentPricePerDay * nights).toStringAsFixed(2)} TND',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, __) => const Text('Error loading items'),
                ),
                const SizedBox(height: 24),

                // Notes
                Text(
                  'Special Requests',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    hintText: 'Any special requests or notes...',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),

                // Price summary
                Card(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: itemsAsync.when(
                      data: (items) {
                        double itemsTotal = 0;
                        for (final entry in _selectedItems.entries) {
                          final item = items.firstWhere(
                            (i) => i.id == entry.key,
                            orElse: () => items.first,
                          );
                          itemsTotal +=
                              item.rentPricePerDay * nights * entry.value;
                        }
                        final total = basePrice + itemsTotal;

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Stay ($nights nights)',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  '${basePrice.toStringAsFixed(2)} TND',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            if (itemsTotal > 0) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Equipment',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${itemsTotal.toStringAsFixed(2)} TND',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${total.toStringAsFixed(2)} TND',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => const Text('Error'),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Submit button
                FilledButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => _submitReservation(center, nights),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Request Reservation'),
                ),
                const SizedBox(height: 8),
                Text(
                  'The owner will review and approve your request',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      width: 80,
      height: 80,
      color: theme.colorScheme.primaryContainer,
      child: Icon(Icons.forest, color: theme.colorScheme.primary),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _submitReservation(CampingCenter center, int nights) async {
    setState(() => _isSubmitting = true);

    try {
      final startDate = widget.startDate ?? DateTime.now();
      final endDate = widget.endDate ?? startDate.add(const Duration(days: 1));
      final basePrice = nights * (center.priceMin + center.priceMax) / 2;

      // Build reservation items
      final items = <ReservationItem>[];
      final allItems = await ref.read(
        itemsByCenterProvider(widget.centerId).future,
      );
      double itemsTotal = 0;

      for (final entry in _selectedItems.entries) {
        final item = allItems.firstWhere((i) => i.id == entry.key);
        final itemTotal = item.rentPricePerDay * nights * entry.value;
        itemsTotal += itemTotal;
        items.add(
          ReservationItem(
            itemId: item.id,
            itemName: item.name,
            quantity: entry.value,
            pricePerDay: item.rentPricePerDay,
            totalPrice: itemTotal,
          ),
        );
      }

      final reservation = Reservation(
        id: '',
        userId: '',
        centerId: widget.centerId,
        startDate: startDate,
        endDate: endDate,
        guestCount: _guestCount,
        items: items,
        basePrice: basePrice,
        totalPrice: basePrice + itemsTotal,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      final created = await ref
          .read(reservationsNotifierProvider.notifier)
          .createReservation(reservation);

      if (created != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reservation request submitted!')),
        );
        context.go(AppRoutes.reservations);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
