import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/theme.dart';
import 'config/router.dart';
import 'mock/mock_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize mock server with seed data
  await MockServer.instance.initialize();

  runApp(const ProviderScope(child: CampifyManagerApp()));
}

/// Main application widget.
class CampifyManagerApp extends ConsumerWidget {
  const CampifyManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Campify Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
