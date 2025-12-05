import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/domain/entities/entities.dart';
import '../../../../shared/widgets/center_card.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/centers_provider.dart';

/// Home screen displaying center listings with search and filters.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(currentUserProvider);
    final centersAsync = ref.watch(filteredCentersProvider);
    final selectedTags = ref.watch(centersSelectedTagsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with search
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Hello, ${user?.name.split(' ').first ?? 'Camper'}!',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (user?.role == UserRole.owner)
                          IconButton(
                            icon: const Icon(Icons.dashboard_outlined),
                            onPressed: () =>
                                context.push(AppRoutes.ownerDashboard),
                            tooltip: 'Owner Dashboard',
                          ),
                      ],
                    ),
                    Text(
                      'Find your perfect camping spot',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search camping centers...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                    .read(centersSearchQueryProvider.notifier)
                                    .state =
                                '';
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  ref.read(centersSearchQueryProvider.notifier).state = value;
                },
              ),
            ),
          ),

          // Tag filters
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: CenterTags.all.length,
                itemBuilder: (context, index) {
                  final tag = CenterTags.all[index];
                  final isSelected = selectedTags.contains(tag);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(CenterTags.displayName(tag)),
                      selected: isSelected,
                      onSelected: (selected) {
                        final currentTags = List<String>.from(selectedTags);
                        if (selected) {
                          currentTags.add(tag);
                        } else {
                          currentTags.remove(tag);
                        }
                        ref.read(centersSelectedTagsProvider.notifier).state =
                            currentTags;
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Featured section header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTags.isEmpty && _searchController.text.isEmpty
                        ? 'Featured Camps'
                        : 'Results',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (selectedTags.isNotEmpty ||
                      _searchController.text.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        ref.read(centersSearchQueryProvider.notifier).state =
                            '';
                        ref.read(centersSelectedTagsProvider.notifier).state =
                            [];
                      },
                      child: const Text('Clear filters'),
                    ),
                ],
              ),
            ),
          ),

          // Centers list
          centersAsync.when(
            data: (centers) {
              if (centers.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No camping centers found',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final center = centers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CenterCard(
                        center: center,
                        onTap: () =>
                            context.push(AppRoutes.centerDetailPath(center.id)),
                      ),
                    );
                  }, childCount: centers.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: theme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading centers',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(filteredCentersProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
