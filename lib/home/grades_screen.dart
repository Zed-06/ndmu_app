import 'package:flutter/material.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data structure with placeholders for all terms
    final academicHistory = {
      'SY 2022-2023': {
        'First Semester': [
          {'id': 'ENGMATH 113', 'title': 'Differential Equation', 'grade': 2.75, 'units': 3},
          {'id': 'ENGMATH 114', 'title': 'Data Analysis', 'grade': 2.50, 'units': 3},
          {'id': 'CPEPC 114', 'title': 'Discrete Mathematics', 'grade': 3.00, 'units': 3},
          {'id': 'CPEPC 116', 'title': 'JavaScript', 'grade': 1.75, 'units': 3},
        ],
        'Second Semester': [
          {'id': 'SSP 115', 'title': 'Ethics II', 'grade': 2.00, 'units': 2},
          {'id': 'EEPC 112', 'title': 'Circuits Analysis', 'grade': 1.75, 'units': 3},
        ],
        'Summer 2023': [
          {'id': 'PE 4', 'title': 'Physical Education IV', 'grade': 1.50, 'units': 2},
          {'id': 'MATH 201', 'title': 'Advanced Calculus', 'grade': 2.25, 'units': 3},
        ],
      }
    };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Academic History', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Student Header (solid background)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF00B374),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 36, backgroundImage: AssetImage('assets/smurf.jpg')),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'JUAN B. DELA CRUZ',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Bachelor of Science in Computer Engineering',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: Text('SUBJECT ID', textAlign: TextAlign.center)),
                  Expanded(flex: 4, child: Text('DESCRIPTIVE TITLE', textAlign: TextAlign.center)),
                  Expanded(child: Text('GRADES', textAlign: TextAlign.center)),
                  Expanded(child: Text('UNITS', textAlign: TextAlign.center)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Academic History Sections
            ...academicHistory['SY 2022-2023']!.entries.map((term) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    term.key,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  ...term.value.map<Widget>((course) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF0097B2), Color(0xFF7ED957)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              course['id'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              course['title'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              course['grade'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              course['units'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
