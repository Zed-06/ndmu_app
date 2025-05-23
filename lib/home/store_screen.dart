// lib/screens/store_screen.dart
import 'package:flutter/material.dart';
import 'books_screen.dart';
import 'uniform_screen.dart';
import 'medical_screen.dart';
import 'merchandise_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Store',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF0097B2), Color(0xFF7ED957)],
              ),
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Books'),
              Tab(text: 'Uniforms'),
              Tab(text: 'Medical'),
              Tab(text: 'Merch'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BooksScreen(),
            UniformScreen(),
            MedicalScreen(),
            MerchandiseScreen(),
          ],
        ),
      ),
    );
  }
}
