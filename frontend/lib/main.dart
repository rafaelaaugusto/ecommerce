import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme_provider.dart';
import 'theme/styles_theme.dart';
import 'views/home_view.dart';
import 'views/product_details_view.dart';
import 'views/shopping_cart_view.dart';

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

    return FutureBuilder(
      future: downloadGoogleFonts(),
      builder: (context, snapshot) => MaterialApp(
        theme: defaultProvider.theme,
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeView(),
          '/product-details': (context) => const ProductDetailsView(),
          '/shopping-cart': (context) => const ShoppingCartView(),
        },
      ),
    );
  }
}
