import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme_provider.dart';
import 'views/home_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final defaultProvider = ref.read(themeProvider);

    return MaterialApp(
      theme: defaultProvider.theme,
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
