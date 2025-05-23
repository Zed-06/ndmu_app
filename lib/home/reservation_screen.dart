import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/cart.dart';

class ReservationScreen extends StatelessWidget {
  final List<CartItem> reserved;
  final double total;

  const ReservationScreen({Key? key, required this.reserved, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrData = reserved
        .map((i) => '${i.name}x${i.quantity}${i.size != null ? '(${i.size})' : ''}')
        .join(';');

    return Scaffold(
      appBar: AppBar(title: const Text('Your Reservation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Reserved Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reserved.length,
                itemBuilder: (context, index) {
                  final item = reserved[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      'Qty: ${item.quantity}'
                      '${item.size != null ? ', Size: ${item.size}' : ''}',
                    ),
                    trailing: Text('₱${(item.price * item.quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: QrImageView(
                data: 'RESERVE;$qrData;TOTAL:${total.toStringAsFixed(2)}',
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text('Total: ₱${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
