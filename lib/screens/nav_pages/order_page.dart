import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key, required this.orderManager});

  final OrderManager orderManager;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // final Order order;
  final Order order = Order(
    selectedSegment: {DeliveryMode.delivery},
    selectedTime: TimeOfDay.now(),
    selectedDate: DateTime.now(),
    name: "No Order",
    items: [],
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("My Orders", style: TextStyle(fontSize: 28)),
          OrderItem(
            order:
                widget.orderManager.orders.isNotEmpty
                    ? widget.orderManager.orders.last
                    : order,
          ),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Image.asset(
              "assets/food/burger.webp",
              height: 65,
              width: 65,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Scaduled"),
              Text(
                "${order.name} Date: ${order.selectedDate?.day}/${order.selectedDate?.month}, Time: ${order.selectedTime?.hour}:${order.selectedTime?.minute}, ",
              ),
              Text(order.selectedSegment.first.formattedText),
              Text("items: ${order.items.length}"),
            ],
          ),
        ],
      ),
    );
  }
}
