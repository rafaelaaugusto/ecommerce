import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme_provider.dart';
import 'theme/styles_theme.dart';
import 'views/checkout_view.dart';
import 'views/order_details_view.dart';
import 'views/product_details_view.dart';
import 'views/register_user_view.dart';
import 'views/shopping_cart_view.dart';
import 'views/successful_purchase_view.dart';
import 'views/tabs_view.dart';

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
          '/': (context) => const TabsView(),
          '/product-details': (context) => const ProductDetailsView(),
          '/shopping-cart': (context) => const ShoppingCartView(),
          '/register-user': (context) => const RegisterUserView(),
          '/checkout': (context) => const CheckoutView(),
          '/sucessful-purchase': (context) => const SuccessfulPurchaseView(),
          '/order-details': (context) => const OrderDetailsView(),
        },
      ),
    );
  }
}
