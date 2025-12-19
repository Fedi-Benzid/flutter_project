import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/domain/entities/entities.dart';
import '../providers/centers_provider.dart';

/// Form screen for creating or editing a center.
class CenterFormScreen extends ConsumerStatefulWidget {
  final String? centerId;

  const CenterFormScreen({super.key, this.centerId});

  @override
  ConsumerState<CenterFormScreen> createState() => _CenterFormScreenState();
}

class _CenterFormScreenState extends ConsumerState<CenterFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  bool _isEdit = false;
  CampingCenter? _existingCenter;
  List<String> _selectedTags = [];
  List<String> _selectedAmenities = [];
  bool _isInteresting = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.centerId != null;
    if (_isEdit) {
      _loadExistingCenter();
    }
  }

  Future<void> _loadExistingCenter() async {
    setState(() => _isLoading = true);
    try {
      final center =
          await ref.read(centersRepositoryProvider).getCenter(widget.centerId!);
      setState(() {
        _existingCenter = center;
        _selectedTags = List.from(center.tags);
        _selectedAmenities = List.from(center.amenities);
        _isInteresting = center.isInteresting;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading center: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(_isEdit ? 'Edit Center' : 'New Center')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Center' : 'New Center'),
        actions: [
          TextButton(onPressed: _saveCenter, child: const Text('Save')),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Basic Info Section
              Text(
                'Basic Information',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'name',
                initialValue: _existingCenter?.name,
                decoration: const InputDecoration(
                  labelText: 'Center Name *',
                  hintText: 'e.g., Pine Valley Retreat',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                ]),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'location',
                initialValue: _existingCenter?.location,
                decoration: const InputDecoration(
                  labelText: 'Location *',
                  hintText: 'e.g., Blue Ridge Mountains, NC',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'description',
                initialValue: _existingCenter?.description,
                decoration: const InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Describe your camping center...',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(50),
                ]),
              ),
              const SizedBox(height: 24),

              // Pricing Section
              Text(
                'Pricing',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'priceMin',
                      initialValue: _existingCenter?.priceMin.toString() ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Min Price *',
                        suffixText: ' TND',
                      ),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'priceMax',
                      initialValue: _existingCenter?.priceMax.toString() ?? '',
                      decoration: const InputDecoration(
                        labelText: 'Max Price *',
                        suffixText: ' TND',
                      ),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Tags Section
              Text(
                'Tags',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select tags that describe your center',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: CenterTags.all.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(CenterTags.displayName(tag)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Amenities Section
              Text(
                'Amenities',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select available amenities',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: CenterAmenities.all.map((amenity) {
                  final isSelected = _selectedAmenities.contains(amenity);
                  return FilterChip(
                    label: Text(CenterAmenities.displayName(amenity)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedAmenities.add(amenity);
                        } else {
                          _selectedAmenities.remove(amenity);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Featured toggle
              SwitchListTile(
                title: const Text('Featured Center'),
                subtitle: const Text('Display in Featured section'),
                value: _isInteresting,
                onChanged: (value) {
                  setState(() => _isInteresting = value);
                },
              ),
              const SizedBox(height: 32),

              // Photo URLs (simplified for demo)
              Text(
                'Photos',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter photo URLs (one per line)',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),

              FormBuilderTextField(
                name: 'photos',
                initialValue: _existingCenter?.photos.join('\n') ?? '',
                decoration: const InputDecoration(
                  hintText:
                      'https://example.com/photo1.jpg\nhttps://example.com/photo2.jpg',
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 32),

              // Submit button
              FilledButton(
                onPressed: _saveCenter,
                child: Text(_isEdit ? 'Update Center' : 'Create Center'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveCenter() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final values = _formKey.currentState!.value;

      // Parse photos from textarea
      final photosText = values['photos'] as String? ?? '';
      final photos = photosText
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final center = CampingCenter(
        id: _existingCenter?.id ?? '',
        ownerId: _existingCenter?.ownerId ?? '',
        name: values['name'] as String,
        description: values['description'] as String,
        location: values['location'] as String,
        priceMin: double.parse(values['priceMin'] as String),
        priceMax: double.parse(values['priceMax'] as String),
        tags: _selectedTags,
        amenities: _selectedAmenities,
        photos: photos,
        isInteresting: _isInteresting,
      );

      final notifier = ref.read(centersNotifierProvider.notifier);

      if (_isEdit) {
        await notifier.updateCenter(widget.centerId!, center);
      } else {
        await notifier.createCenter(center);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEdit
                  ? 'Center updated successfully'
                  : 'Center created successfully',
            ),
          ),
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
