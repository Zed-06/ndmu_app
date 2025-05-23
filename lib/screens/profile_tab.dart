import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _basic = false, _contact = false, _education = false, _family = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        Row(
          children: const [
            Icon(Icons.person, size: 28, color: Colors.black87),
            SizedBox(width: 8),
            Text('Personal Data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Disclaimer: If there are information here that need to be updated, please inform the MIS',
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 16),
        // Accordions
        _buildAccordion('Basic Information', _basic, () => setState(() => _basic = !_basic),
            _buildTable(
              ['Name', 'Gender', 'DOB', 'Status', 'Birthplace', 'Nationality', 'Religion'],
              ['Juan B. Dela Cruz', 'Male', '05/05/1999', 'Single', 'Koronadal City', 'Filipino', 'Roman Catholic'],
            )),
        _buildAccordion('Contact Information', _contact, () => setState(() => _contact = !_contact),
            _buildTable(
              ['Number', 'Email', 'Address'],
              ['09123456789', 'juan@example.com', 'Koronadal City, South Cotabato'],
            )),
        _buildAccordion('Education', _education, () => setState(() => _education = !_education),
            _buildTable(
              ['Course', 'Year', 'Dept', 'College'],
              ['BS Computer Engineering', '2', 'EECE', 'College of Engineering Architecture and Computing'],
            )),
        _buildAccordion('Family Background', _family, () => setState(() => _family = !_family),
            _buildTable(
              ['Father Name', 'Father Job', 'Father Contact', 'Mother Name', 'Mother Job', 'Mother Contact'],
              ['John D. Cruz', 'Engineer', '09129876543', 'Juanita B. Cruz', 'Teacher', '09127654321'],
            )),
      ],
    );
  }

  Widget _buildAccordion(String title, bool isOpen, VoidCallback onTap, Widget child) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.black87),
              ],
            ),
          ),
        ),
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: child,
          ),
      ],
    );
  }

  Widget _buildTable(List<String> labels, List<String> values) {
    return Column(
      children: List.generate(labels.length, (i) {
        return Container(
          color: i.isEven ? const Color(0xFF7ED957).withOpacity(0.3) : Colors.grey[200],
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text(labels[i], style: const TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 5, child: Text(values[i])),
            ],
          ),
        );
      }),
    );
  }
}