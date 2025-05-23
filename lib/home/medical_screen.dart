import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({Key? key}) : super(key: key);

  @override
  _MedicalScreenState createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = [
    'Stethoscope',
    'Thermometer',
    'BP Monitor',
    'Microscope',
    'Lab Kit',
    'Safety Goggles',
  ];
  List<String> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_allItems);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filtered = _allItems.where((i) => i.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search equipment...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
            children: _filtered.map((name) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      name: name,
                      category: 'Medical',
                      price: 0.0,
                      available: true,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(name, textAlign: TextAlign.center),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}