import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../../centers/presentation/providers/centers_provider.dart';
import '../providers/events_provider.dart';

/// Form screen for creating/editing events.
class EventFormScreen extends ConsumerStatefulWidget {
  final String? eventId;

  const EventFormScreen({super.key, this.eventId});

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _isEdit = false;
  Event? _existingEvent;
  DateTime _selectedStartDate = DateTime.now().add(const Duration(days: 7));
  DateTime _selectedEndDate = DateTime.now().add(const Duration(days: 8));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  List<String> _activities = [];
  final TextEditingController _activityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isEdit = widget.eventId != null;
    if (_isEdit) {
      _loadExistingEvent();
    }
  }

  @override
  void dispose() {
    _activityController.dispose();
    super.dispose();
  }

  Future<void> _loadExistingEvent() async {
    setState(() => _isLoading = true);
    try {
      final event = await ref
          .read(eventsRepositoryProvider)
          .getEvent(widget.eventId!);
      setState(() {
        _existingEvent = event;
        _selectedStartDate = event.date;
        _selectedEndDate = event.endDate ?? event.date.add(Duration(hours: event.durationHours));
        _selectedTime = TimeOfDay(
          hour: event.date.hour,
          minute: event.date.minute,
        );
        _activities = List.from(event.activities);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _addActivity() {
    if (_activityController.text.isNotEmpty) {
      setState(() {
        _activities.add(_activityController.text.trim());
        _activityController.clear();
      });
    }
  }

  void _removeActivity(int index) {
    setState(() {
      _activities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ownedCentersAsync = ref.watch(ownedCentersProvider);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(_isEdit ? 'Edit Event' : 'New Event')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Event' : 'New Event'),
        actions: [TextButton(onPressed: _saveEvent, child: const Text('Save'))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Center selection
              ownedCentersAsync.when(
                data: (centers) {
                  if (centers.isEmpty) {
                    return Card(
                      color: theme.colorScheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'You need to create a center first before you can create events.',
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    );
                  }

                  return FormBuilderDropdown<String>(
                    name: 'centerId',
                    initialValue: _existingEvent?.centerId ?? centers.first.id,
                    decoration: const InputDecoration(
                      labelText: 'Center *',
                      prefixIcon: Icon(Icons.business),
                    ),
                    items: centers.map((center) {
                      return DropdownMenuItem(
                        value: center.id,
                        child: Text(center.name),
                      );
                    }).toList(),
                    validator: FormBuilderValidators.required(),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('Error loading centers'),
              ),
              const SizedBox(height: 16),

              // Title
              FormBuilderTextField(
                name: 'title',
                initialValue: _existingEvent?.title,
                decoration: const InputDecoration(
                  labelText: 'Event Title *',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                ]),
              ),
              const SizedBox(height: 16),

              // Description
              FormBuilderTextField(
                name: 'description',
                initialValue: _existingEvent?.description,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(20),
                ]),
              ),
              const SizedBox(height: 16),

              // Location
              FormBuilderTextField(
                name: 'location',
                initialValue: _existingEvent?.location,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                  helperText: 'Specific location or address',
                ),
              ),
              const SizedBox(height: 24),

              // Date and time section
              Text(
                'Date & Time',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Start date
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _selectedStartDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          setState(() {
                            _selectedStartDate = date;
                            if (_selectedEndDate.isBefore(_selectedStartDate)) {
                              _selectedEndDate = _selectedStartDate.add(const Duration(days: 1));
                            }
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        'Start: ${_selectedStartDate.day}/${_selectedStartDate.month}/${_selectedStartDate.year}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (time != null) {
                          setState(() => _selectedTime = time);
                        }
                      },
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // End date
              OutlinedButton.icon(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedEndDate,
                    firstDate: _selectedStartDate,
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                  );
                  if (date != null) {
                    setState(() => _selectedEndDate = date);
                  }
                },
                icon: const Icon(Icons.event),
                label: Text(
                  'End: ${_selectedEndDate.day}/${_selectedEndDate.month}/${_selectedEndDate.year}',
                ),
              ),
              const SizedBox(height: 16),

              // Max participants
              FormBuilderTextField(
                name: 'maxParticipants',
                initialValue:
                    _existingEvent?.maxParticipants.toString() ?? '20',
                decoration: const InputDecoration(
                  labelText: 'Max Participants *',
                  prefixIcon: Icon(Icons.people),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(1),
                ]),
              ),
              const SizedBox(height: 16),

              // Price
              FormBuilderTextField(
                name: 'price',
                initialValue: _existingEvent != null && _existingEvent!.price > 0
                    ? _existingEvent!.price.toString()
                    : '',
                decoration: const InputDecoration(
                  labelText: 'Price per person (TND)',
                  prefixIcon: Icon(Icons.attach_money),
                  helperText: 'Leave empty for free events',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(height: 24),

              // Activities section
              Text(
                'Activities',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _activityController,
                      decoration: const InputDecoration(
                        labelText: 'Add activity',
                        hintText: 'e.g., Hiking, Swimming',
                        prefixIcon: Icon(Icons.sports),
                      ),
                      onSubmitted: (_) => _addActivity(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _addActivity,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_activities.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _activities.asMap().entries.map((entry) {
                    return Chip(
                      label: Text(entry.value),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () => _removeActivity(entry.key),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 16),

              // Image URL (optional)
              FormBuilderTextField(
                name: 'imageUrl',
                initialValue: _existingEvent?.imageUrl,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  prefixIcon: Icon(Icons.image),
                  helperText: 'Enter a URL for the event cover image',
                ),
              ),
              const SizedBox(height: 32),

              // Submit
              FilledButton(
                onPressed: _saveEvent,
                child: Text(_isEdit ? 'Update Event' : 'Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveEvent() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final values = _formKey.currentState!.value;

      final eventDate = DateTime(
        _selectedStartDate.year,
        _selectedStartDate.month,
        _selectedStartDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final endDate = DateTime(
        _selectedEndDate.year,
        _selectedEndDate.month,
        _selectedEndDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final durationHours = endDate.difference(eventDate).inHours;

      final priceStr = values['price'] as String?;
      final price = priceStr != null && priceStr.isNotEmpty
          ? double.tryParse(priceStr) ?? 0.0
          : 0.0;

      final event = Event(
        id: _existingEvent?.id ?? '',
        centerId: values['centerId'] as String,
        title: values['title'] as String,
        description: values['description'] as String,
        date: eventDate,
        endDate: endDate,
        durationHours: durationHours > 0 ? durationHours : 2,
        maxParticipants: int.parse(values['maxParticipants'] as String),
        imageUrl: (values['imageUrl'] as String?)?.isEmpty ?? true
            ? null
            : values['imageUrl'] as String,
        location: (values['location'] as String?)?.isEmpty ?? true
            ? null
            : values['location'] as String,
        price: price,
        activities: _activities,
        isClosed: _existingEvent?.isClosed ?? false,
      );

      final notifier = ref.read(eventsNotifierProvider.notifier);

      if (_isEdit) {
        await notifier.updateEvent(widget.eventId!, event);
      } else {
        await notifier.createEvent(event);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isEdit ? 'Event updated' : 'Event created')),
        );
        context.pop();
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
