import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/entities.dart';
import '../providers/marketplace_provider.dart';

/// Product form screen for owners to create/edit products.
class ProductFormScreen extends ConsumerStatefulWidget {
  final MarketplaceItem? product; // null for creating, non-null for editing

  const ProductFormScreen({super.key, this.product});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  String _selectedCategory = 'CAMPING_GEAR';
  bool _isLoading = false;

  final List<String> _categories = [
    'CAMPING_GEAR',
    'FOOD_BEVERAGES',
    'OUTDOOR_EQUIPMENT',
    'ACCESSORIES',
    'OTHER',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController = TextEditingController(
        text: widget.product?.rentPricePerDay.toString() ?? '');
    _stockController = TextEditingController(
        text: widget.product?.quantity.toString() ?? '10');
    if (widget.product != null) {
      // Set category from product if available - map ItemCategory to String
      _selectedCategory = _categoryEnumToString(widget.product!.category);
    }
  }

  String _categoryEnumToString(ItemCategory category) {
    switch (category) {
      case ItemCategory.tent:
        return 'CAMPING_GEAR';
      case ItemCategory.sleeping:
        return 'CAMPING_GEAR';
      case ItemCategory.cooking:
        return 'FOOD_BEVERAGES';
      case ItemCategory.lighting:
        return 'OUTDOOR_EQUIPMENT';
      case ItemCategory.furniture:
        return 'OUTDOOR_EQUIPMENT';
      case ItemCategory.accessories:
        return 'ACCESSORIES';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final productData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
        'stock': int.tryParse(_stockController.text) ?? 10,
      };

      if (widget.product != null) {
        await ref
            .read(marketplaceNotifierProvider.notifier)
            .updateProduct(widget.product!.id, productData);
      } else {
        await ref
            .read(marketplaceNotifierProvider.notifier)
            .createProduct(productData);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.product != null
                ? 'Product updated successfully'
                : 'Product created successfully'),
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Product' : 'New Product'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                hintText: 'Enter product name',
                prefixIcon: Icon(Icons.inventory_2),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a product name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter product description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Category dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(_formatCategory(category)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Price and stock fields in a row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price (TND)',
                      hintText: '0.00',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final price = double.tryParse(value);
                      if (price == null || price < 0) {
                        return 'Invalid price';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                      hintText: '10',
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProduct,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(isEditing ? 'Update Product' : 'Create Product'),
              ),
            ),

            // Delete button for editing
            if (isEditing) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _confirmDelete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                  child: const Text('Delete Product'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatCategory(String category) {
    return category.replaceAll('_', ' ').split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _isLoading = true);
      try {
        await ref
            .read(marketplaceNotifierProvider.notifier)
            .deleteProduct(widget.product!.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product deleted')),
          );
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }
}
