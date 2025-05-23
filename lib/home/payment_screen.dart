import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0097B2), Color(0xFF7ED957),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Balance', style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Php 4,600.12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('ID Number: 2023123', style: TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),

            // Account Details Section
            SizedBox(height: 10),
            Text('Account Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey, thickness: 1),
            Card(
              elevation: 2,
              child: Column(
                children: const [
                  ListTile(
                    title: Text('Account Name'),
                    trailing: Text('Juan B. Dela Cruz', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Credit Units'),
                    trailing: Text('28', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Total Paid Hours'),
                    trailing: Text('29.00', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Transactions Section
            SizedBox(height: 10),
            Text('Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey, thickness: 1),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Tuition Fee Payment'),
                    subtitle: Text('01/05/2023'),
                    trailing: Text('-₱25,000.00', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                  const ListTile(
                    title: Text('Library Fee'),
                    subtitle: Text('01/07/2023'),
                    trailing: Text('-₱500.00', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                  const ListTile(
                    title: Text('Laboratory Fee'),
                    subtitle: Text('01/10/2023'),
                    trailing: Text('-₱1,200.00', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                  const ListTile(
                    title: Text('Scholarship Grant'),
                    subtitle: Text('01/15/2023'),
                    trailing: Text('+₱10,000.00', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {}, // No-op handler
                      child: const Text(
                        'View More',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
