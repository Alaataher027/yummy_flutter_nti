import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/restaurant.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({
    super.key,
    required this.item,
    required this.cartManager,
    this.onUpdate,
  });
  final Item item;
  final CartManager cartManager;
  final VoidCallback? onUpdate;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "${widget.item.price.toString()} ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.library_add_check_rounded,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),

                  child: Image.network(
                    widget.item.imageUrl,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  bottom: -5,
                  right: -5,
                  child: GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Container(
                      height: 25,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                      ),
                      child: const Center(child: Text("Add")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    int quantity = 0;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              width: MediaQuery.of(context).size.width, // full width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.item.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(widget.item.price.toString()),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(widget.item.description),
                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.item.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setModalState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(child: Icon(Icons.add, size: 25)),
                        ),
                      ),
                      const SizedBox(width: 5),

                      Text(quantity.toString(), style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 5),

                      InkWell(
                        onTap: () {
                          setModalState(() {
                            quantity--;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.minimize_rounded, size: 25),
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          print("add..");

                          final uuid = Uuid();

                          final newItem = CartItem(
                            id: uuid.v4(),
                            name: widget.item.name,
                            price: widget.item.price,
                            quantity: quantity,
                          );
                          setModalState(() {
                            widget.cartManager.addItem(newItem);
                            widget.onUpdate?.call();
                          });

                          for (var item in widget.cartManager.items) {
                            print(
                              "==> ${item.name} : ${item.quantity} : ${item.id}",
                            );
                          }
                          print("length: ${widget.cartManager.items.length}");
                          Navigator.pop(context);
                        },
                        child: const Text("Add Item!"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
