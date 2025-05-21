import 'package:flutter/material.dart';
import 'package:yummy/components/custom_text_field.dart';
import 'package:yummy/components/order_summary_item.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({
    super.key,
    required this.cartManager,
    required this.orderManager,
  });
  final CartManager cartManager;
  final OrderManager orderManager;

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? contactName;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DeliveryMode deliveryMode = DeliveryMode.delivery;

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.cartManager.setTime(picked);
      });
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell (
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_rounded),
            ),

            const SizedBox(height: 20),
            Text('Order Details', style: TextStyle(fontSize: 23)),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              deliveryMode = DeliveryMode.delivery;
                            });
                            print(deliveryMode);
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color:
                                  deliveryMode == DeliveryMode.delivery
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer
                                      : Theme.of(
                                        context,
                                      ).appBarTheme.backgroundColor,

                              border: Border.all(
                                width: 0.9,

                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                              ),

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delivery_dining_rounded, size: 20),
                                Text("  Delivery"),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              deliveryMode = DeliveryMode.pickup;
                            });
                            print(deliveryMode);
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.9,
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                              ),

                              color:
                                  deliveryMode == DeliveryMode.pickup
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer
                                      : Theme.of(
                                        context,
                                      ).appBarTheme.backgroundColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(Icons.shopping_bag_rounded, size: 20),
                                Text("  Pickup"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    onSaved: (value) => contactName = value,
                    hint: 'Contact Name',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Spacer(flex: 5),

                      GestureDetector(
                        onTap: pickDate,
                        child: Text(
                          selectedDate != null
                              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                              : "Select Date",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Spacer(flex: 5),
                      GestureDetector(
                        onTap: pickTime,
                        child: Text(
                          selectedTime != null
                              ? "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                              : "Select Time",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Spacer(flex: 30),
                    ],
                  ),
                ],
              ),
            ),
            //// Cart items here
            const SizedBox(height: 25),

            const Text("Order Summary"),

            Expanded(
              child: ListView.builder(
                itemCount: widget.cartManager.items.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final cartItem = widget.cartManager.itemAt(index);
                  return OrderSummaryItem(cartItem: cartItem);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (selectedDate == null || selectedTime == null) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:  Text(
                            "Please select both date and time!",
                          ),
                        ),
                      );
                    } else {
                      Order order = Order(
                        selectedSegment: {deliveryMode},
                        selectedTime: selectedTime,
                        selectedDate: selectedDate,
                        name: contactName!,
                        items: widget.cartManager.items,
                      );
                      widget.orderManager.addOrder(order);
                      Navigator.pop(context);
                      print(widget.orderManager.orders.length);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),

                child: Text(
                  "Submit order - \$${widget.cartManager.totalCost.toStringAsFixed(2)}",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
