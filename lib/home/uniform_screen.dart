import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class UniformScreen extends StatefulWidget {
  const UniformScreen({Key? key}) : super(key: key);

  @override
  _UniformScreenState createState() => _UniformScreenState();
}

class _UniformScreenState extends State<UniformScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allItems = [
    'School Uniform',
    'PE Uniform',
    'Nursing Uniform',
    'MedTech Uniform',
    'Lab Gown',
    'Practice Teacher Outfit',
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
              hintText: 'Search uniforms...',
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
                      category: 'Uniforms',
                      price: 0.0,
                      available: true,
                      isUniform: true,
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
                          Icons.checkroom,
                          size: 48,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                    ),
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
