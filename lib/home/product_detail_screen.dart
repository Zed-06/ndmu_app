import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String category;
  final double price;
  final bool available;
  final bool isUniform;

  const ProductDetailScreen({
    Key? key,
    required this.name,
    required this.category,
    required this.price,
    required this.available,
    this.isUniform = false,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _gender;
  String? _size;

  Future<int?> _askQuantity(int initial) async {
    final controller = TextEditingController(text: initial.toString());
    return showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter Quantity'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantity'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final qty = int.tryParse(controller.text) ?? initial;
              Navigator.pop(context, qty);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text('Category: ${widget.category}'),
            Text('Price: ₱${widget.price.toStringAsFixed(2)}'),
            if (widget.isUniform) ...[
              const SizedBox(height: 16),
              const Text('Select Gender:'),
              Row(
                children: ['Male', 'Female']
                    .map((g) => Expanded(
                          child: RadioListTile<String>(
                            title: Text(g),
                            value: g,
                            groupValue: _gender,
                            onChanged: (value) => setState(() {
                              _gender = value;
                              _size = null;
                            }),
                          ),
                        ))
                    .toList(),
              ),
              if (_gender != null) ...[
                const SizedBox(height: 8),
                const Text('Select Size:'),
                DropdownButton<String>(
                  value: _size,
                  hint: const Text('Size'),
                  items: ['XS', 'S', 'M', 'L', 'XL', '2XL', '3XL', '4XL']
                      .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) => setState(() => _size = value),
                ),
              ],
            ],
            const SizedBox(height: 16),
            Text('Available: ${widget.available ? 'Yes' : 'No'}'),
            const SizedBox(height: 16),
            if (widget.available)
              ElevatedButton(
                onPressed: () async {
                  final qty = await _askQuantity(1) ?? 1;
                  final cart = context.read<CartModel>();
                  cart.add(CartItem(
                    name: widget.name,
                    category: widget.category,
                    price: widget.price,
                    quantity: qty,
                    size: _size,
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${widget.name} x$qty added to cart'))
                  );
                },
                child: const Text('Add to Cart'),
              ),
          ],
        ),
      ),
    );
  }
}