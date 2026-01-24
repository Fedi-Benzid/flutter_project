import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/entities.dart';
import '../providers/marketplace_provider.dart';

/// Owner screen for managing marketplace products.
class OwnerMarketplaceScreen extends ConsumerWidget {
  const OwnerMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ownedItemsAsync = ref.watch(ownedItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Product',
            onPressed: () => _showItemForm(context, ref, null),
          ),
        ],
      ),
      body: ownedItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No products yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () => _showItemForm(context, ref, null),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Your First Product'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _ProductCard(
                item: item,
                onEdit: () => _showItemForm(context, ref, item),
                onDelete: () => _confirmDelete(context, ref, item),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemForm(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showItemForm(
      BuildContext context, WidgetRef ref, MarketplaceItem? item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ItemFormSheet(item: item),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, MarketplaceItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref
          .read(marketplaceNotifierProvider.notifier)
          .deleteProduct(item.id);
    }
  }
}

class _ProductCard extends StatelessWidget {
  final MarketplaceItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProductCard({
    required this.item,
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
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(theme),
                    )
                  : _buildPlaceholder(theme),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.rentPricePerDay.toStringAsFixed(2)} TND/day',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.category.displayName,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Stock: ${item.quantity}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: onEdit,
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline,
                      color: theme.colorScheme.error),
                  onPressed: onDelete,
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      width: 80,
      height: 80,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(Icons.inventory_2, color: theme.colorScheme.onSurfaceVariant),
    );
  }
}

class _ItemFormSheet extends ConsumerStatefulWidget {
  final MarketplaceItem? item;

  const _ItemFormSheet({this.item});

  @override
  ConsumerState<_ItemFormSheet> createState() => _ItemFormSheetState();
}

class _ItemFormSheetState extends ConsumerState<_ItemFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _imageUrlController;
  late ItemCategory _selectedCategory;
  bool _isSubmitting = false;

  bool get _isEdit => widget.item != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.item?.description ?? '');
    _priceController = TextEditingController(
        text: widget.item?.rentPricePerDay.toString() ?? '');
    _stockController =
        TextEditingController(text: widget.item?.quantity.toString() ?? '1');
    _imageUrlController =
        TextEditingController(text: widget.item?.imageUrl ?? '');
    _selectedCategory = widget.item?.category ?? ItemCategory.accessories;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _isEdit ? 'Edit Product' : 'Add Product',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name *',
                    prefixIcon: Icon(Icons.inventory_2),
                  ),
                  validator: (v) =>
                      v?.isEmpty == true ? 'Name is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<ItemCategory>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category *',
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: ItemCategory.values.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text('${cat.icon} ${cat.displayName}'),
                    );
                  }).toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedCategory = v);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price/Day *',
                          prefixIcon: Icon(Icons.attach_money),
                          suffixText: 'TND',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v?.isEmpty == true) return 'Required';
                          if (double.tryParse(v!) == null) return 'Invalid';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _stockController,
                        decoration: const InputDecoration(
                          labelText: 'Stock *',
                          prefixIcon: Icon(Icons.inventory),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v?.isEmpty == true) return 'Required';
                          if (int.tryParse(v!) == null) return 'Invalid';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL (optional)',
                    prefixIcon: Icon(Icons.image),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(_isEdit ? 'Update Product' : 'Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final productData = {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'price': double.parse(_priceController.text),
      'category': _selectedCategory.name.toUpperCase(),
      'stock': int.parse(_stockController.text),
      'imageUrls':
          _imageUrlController.text.isNotEmpty ? [_imageUrlController.text] : [],
    };

    final notifier = ref.read(marketplaceNotifierProvider.notifier);

    if (_isEdit) {
      await notifier.updateProduct(widget.item!.id, productData);
    } else {
      await notifier.createProduct(productData);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
