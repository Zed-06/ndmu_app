import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String category;
  final double price;
  int quantity;
  final String? size;

  CartItem({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    this.size,
  });
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  double get total => _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void add(CartItem item) {
    final existing = _items.firstWhere(
      (i) => i.name == item.name && i.size == item.size,
      orElse: () => CartItem(name: '', category: '', price: 0, quantity: 0),
    );
    if (existing.quantity > 0) {
      existing.quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
