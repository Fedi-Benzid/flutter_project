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
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  void initState() {
    super.initState();
    _isEdit = widget.eventId != null;
    if (_isEdit) {
      _loadExistingEvent();
    }
  }

  Future<void> _loadExistingEvent() async {
    setState(() => _isLoading = true);
    try {
      final event = await ref
          .read(eventsRepositoryProvider)
          .getEvent(widget.eventId!);
      setState(() {
        _existingEvent = event;
        _selectedDate = event.date;
        _selectedTime = TimeOfDay(
          hour: event.date.hour,
          minute: event.date.minute,
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
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
              const SizedBox(height: 24),

              // Date and time
              Text(
                'Date & Time',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          setState(() => _selectedDate = date);
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
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
              const SizedBox(height: 16),

              // Duration
              FormBuilderTextField(
                name: 'duration',
                initialValue: _existingEvent?.durationHours.toString() ?? '2',
                decoration: const InputDecoration(
                  labelText: 'Duration (hours) *',
                  prefixIcon: Icon(Icons.timer),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(1),
                ]),
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
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final event = Event(
        id: _existingEvent?.id ?? '',
        centerId: values['centerId'] as String,
        title: values['title'] as String,
        description: values['description'] as String,
        date: eventDate,
        durationHours: int.parse(values['duration'] as String),
        maxParticipants: int.parse(values['maxParticipants'] as String),
        imageUrl: (values['imageUrl'] as String?)?.isEmpty ?? true
            ? null
            : values['imageUrl'] as String,
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
