import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'reservation_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Dismissible(
                        key: ValueKey(item.hashCode),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => cart.removeAt(index),
                        child: ListTile(
                          title: Text(item.name),
                          subtitle: Text(
                            'Qty: ${item.quantity}'
                            '${item.size != null ? ', Size: ${item.size}' : ''}',
                          ),
                          trailing: Text('₱${(item.price * item.quantity).toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: ₱${cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: cart.items.isEmpty
                      ? null
                      : () {
                          final reserved = List<CartItem>.from(cart.items);
                          final total = cart.total;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ReservationScreen(reserved: reserved, total: total),
                            ),
                          );
                          cart.clear();
                        },
                  child: const Text('Reserve'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}