import 'package:flutter/material.dart';
import 'package:yummy/models/order_manager.dart';
import 'package:yummy/screens/nav_pages/account_page.dart';
import 'package:yummy/screens/nav_pages/explore_page.dart';
import 'package:yummy/screens/nav_pages/order_page.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/models/food_category.dart';
import 'package:yummy/models/post.dart';

class HomeView extends StatefulWidget {
  // final VoidCallback changeCallBack;
  final void Function()? onPressed;
  final ColorSelection colorSelected;
  final void Function(int)? onTapColor;
  final FoodCategory foodCategory;
  final Post post;
  final OrderManager orderManager;

  const HomeView({
    super.key,
    required this.onPressed,
    required this.colorSelected,
    required this.onTapColor,
    required this.foodCategory,
    required this.post,
    required this.orderManager,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentTap = 0;

  void _changeCurrentTap(int index) {
    setState(() {
      _currentTap = index;
    });
  }

  final List<NavigationDestination> _destinations = const [
    NavigationDestination (
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      selectedIcon: Icon(Icons.home),
    ),
    NavigationDestination(
      icon: Icon(Icons.list_outlined),
      label: 'Orders',
      selectedIcon: Icon(Icons.list),
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      label: 'Account',
      selectedIcon: Icon(Icons.person),
    ),
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ExplorePage(),
      // HomePage(foodCategory: FoodCategory("d", 5, "assets/food/burger.webp")),
      OrderPage(orderManager: OrderManager()),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yummy'),
        actions: [
          IconButton(
            onPressed: widget.onPressed,
            icon: Icon(Icons.nightlight_outlined, size: 28),
          ),
          PopupMenuButton(
            onSelected: widget.onTapColor,
            icon: Icon(Icons.color_lens),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            itemBuilder: (context) {
              return List.generate(ColorSelection.values.length, (index) {
                final currentColor = ColorSelection.values[index];
                return PopupMenuItem(
                  value: index,
                  enabled: currentColor != widget.colorSelected,
                  child: Row(
                    spacing: 20,
                    children: [
                      Icon(Icons.opacity_outlined, color: currentColor.color),
                      Text(currentColor.label),
                    ],
                  ),
                );
              });
            },
          ),
          // IconButton(onPressed: () {}, icon: Icon(Icons.dock_sharp, size: 28)),
        ],
      ),
      body: IndexedStack(index: _currentTap, children: _pages),

      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: _currentTap,
        onDestinationSelected: _changeCurrentTap,
      ),
    );
  }
}
