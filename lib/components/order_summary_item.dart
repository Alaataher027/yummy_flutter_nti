import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';

class OrderSummaryItem extends StatelessWidget {
  const OrderSummaryItem({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 1.7,
              ),
            ),
            height: 37,
            width: 36,
            child: Center(
              child: Text(
                "x${cartItem.quantity}",
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem.name),
              Text(
                "Price: \$ ${cartItem.price} ",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
