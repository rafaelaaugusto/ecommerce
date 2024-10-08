import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/shopping_cart_icon_component.dart';
import '../viewmodels/shopping_cart_view_model.dart';
import 'home_view.dart';
import 'orders_view.dart';
import 'profile_view.dart';

class TabsView extends ConsumerStatefulWidget {
  const TabsView({super.key});

  @override
  ConsumerState<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends ConsumerState<TabsView> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeView(),
    OrdersView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = ref.watch(shoppingCartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopWorld'),
        automaticallyImplyLeading: false,
        actions: [
          ShoppingCartIcon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/shopping-cart',
              );
            },
            productCount: cartViewModel.productCount,
          ),
        ],
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
