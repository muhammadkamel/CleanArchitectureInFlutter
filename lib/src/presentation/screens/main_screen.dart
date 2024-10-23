import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oth_app/src/presentation/blocs/cart/cart_bloc.dart';
import 'package:oth_app/src/presentation/blocs/manage_bottom_nav/manage_bottom_nav_bloc.dart';
import 'package:oth_app/src/presentation/screens/cart_screen.dart';
import 'package:oth_app/src/presentation/screens/products_screen.dart';

import 'internet_status_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routePath = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    const screens = [
      ProductsScreen(),
      CartScreen(),
    ];
    return BlocBuilder<ManageBottomNavBloc, ManageBottomNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Oth App"),
            actions: [
              InternetStatusWidget(),
            ],
          ),
          body: IndexedStack(
            index: state.index,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              context.read<ManageBottomNavBloc>().add(
                    UpdateIndexEvent(index),
                  );
            },
            currentIndex: state.index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.laptop_20_regular),
                activeIcon: Icon(FluentIcons.laptop_20_filled),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                activeIcon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Badge.count(
                      count: state.cart?.products.length ?? 0,
                      child: Icon(FluentIcons.cart_20_filled),
                    );
                  },
                ),
                icon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Badge.count(
                      count: state.cart?.products.length ?? 0,
                      child: Icon(FluentIcons.cart_20_regular),
                    );
                  },
                ),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
