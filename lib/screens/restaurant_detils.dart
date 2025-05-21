import 'package:flutter/material.dart';
import 'package:yummy/components/menu_card.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';
import 'package:yummy/models/restaurant.dart';
import 'package:yummy/screens/drawer_body.dart';

class RestaurantDetils extends StatefulWidget {
  RestaurantDetils({super.key, required this.restaurant});
  final Restaurant restaurant;

  @override
  State<RestaurantDetils> createState() => _RestaurantDetilsState();
}

class _RestaurantDetilsState extends State<RestaurantDetils> {
  final cartManager = CartManager();
  final ordermanager = OrderManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: DrawerBody(cartManager: cartManager, orderManager: ordermanager),
      ),
      floatingActionButton: Builder(
        builder:
            (context) => SizedBox(
              width: 180,
              child: FloatingActionButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart_rounded),
                      const SizedBox(width: 20),
                      Text("${cartManager.items.length} Items in cart"),
                    ],
                  ),
                ),
              ),
            ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
                  right: 20,
                  left: 20,
                  bottom: 30,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.restaurant.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: -5,
                      bottom: -10,

                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color.fromARGB(255, 226, 196, 194),
                        ),
                        child: const Icon(Icons.maps_home_work_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant.name,
                    style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.restaurant.address),
                  Text(
                    "Rating ${widget.restaurant.rating.toString()} ☻ | Distance: ${widget.restaurant.distance}",
                  ),
                  Text(widget.restaurant.attributes),
                  const SizedBox(height: 10),
                  const Text(
                    "Menu",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = widget.restaurant.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: MenuCard(
                  item: item,
                  cartManager: cartManager,
                  onUpdate: () => setState(() {}),
                ),
              );
            }, childCount: widget.restaurant.items.length),
          ),
        ],
      ),
    );
  }
}
