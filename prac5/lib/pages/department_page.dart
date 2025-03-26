import 'package:flutter/material.dart';
import '../widgets/side_nav_drawer.dart';

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        title: const Text('Department Vision and Mission'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      drawer: const SideNavDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLogoHeader(),
          const SizedBox(height: 16),
          const DepartmentCard(
            title: 'DEPARTMENT VISION (Effective from 2024-25)',
            content:
                'To develop globally competent and ethical professionals in Computer Science and Engineering and enable them to contribute to society.',
          ),
          const DepartmentCard(
            title: 'DEPARTMENT VISION',
            content:
                'To create a center of excellence which will produce cutting edge technologies to cater to the needs of Business and Society.',
          ),
          const DepartmentCard(
            title: 'DEPARTMENT MISSION (Effective from 2024-25)',
            content: '''
M1: To provide rigorous, high-standard, multidisciplinary curriculum and innovative T-L-E-A processes and ensure a stimulating academic environment.

M2: To promote research and innovations through collaborations.

M3: To develop requisite attitudes and skills, besides providing a strong knowledge foundation.

M4: To foster ethics and social responsibility among stakeholders and imbibe a sense of contribution.
            ''',
          ),
          const DepartmentCard(
            title: 'DEPARTMENT MISSION',
            content: '''
- To provide high-quality education.
- To train the students to excel in cutting-edge technologies that makes them industry-ready.
- To inculcate ethical and professional values in students for the betterment of society.
- To inculcate an entrepreneurial mindset in students to make them job creators.
            ''',
          ),
        ],
      ),
    );
  }

  // Logo Header
  Widget _buildLogoHeader() {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://mca.spit.ac.in/wp-content/uploads/2022/12/cropped-logo-removebg-preview-1.png', // College logo URL
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 80, color: Colors.red),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Department of Computer Science and Engineering',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 2,
            color: Colors.orangeAccent,
          )
        ],
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final String title;
  final String content;

  const DepartmentCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.grey[850], // Dark card background
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent, // Accent color for titles
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
