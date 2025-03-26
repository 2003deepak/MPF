import 'package:flutter/material.dart';
import '../widgets/side_nav_drawer.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> companies = [
      {
        'name': 'Google',
        'date': '10 March 2025',
        'startDate': '1 March 2025',
        'endDate': '7 March 2025',
        'description': 'Google is hiring software engineers for its Cloud division.',
        'logo': 'https://media.wired.com/photos/5926ffe47034dc5f91bed4e8/master/pass/google-logo.jpg'
      },
      {
        'name': 'Microsoft',
        'date': '15 March 2025',
        'startDate': '5 March 2025',
        'endDate': '10 March 2025',
        'description': 'Microsoft is looking for AI and ML specialists for their R&D team.',
        'logo': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Microsoft_logo.svg/2048px-Microsoft_logo.svg.png'
      },
      {
        'name': 'Amazon',
        'date': '20 March 2025',
        'startDate': '10 March 2025',
        'endDate': '17 March 2025',
        'description': 'Amazon is recruiting software developers for its AWS platform.',
        'logo': 'https://assets.upstox.com/content/assets/images/cms/202451/Amazon%20logo.png'
      },
    ];

    return Scaffold(
      drawer: const SideNavDrawer(),
      appBar: AppBar(
        title: const Text('Upcoming Companies', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Logo
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(companies[index]['logo']!),
                    ),
                    const SizedBox(width: 16),
                    
                    // Company Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            companies[index]['name']!,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Drive Date: ${companies[index]['date']}',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Application Start: ${companies[index]['startDate']}',
                            style: const TextStyle(fontSize: 14, color: Colors.green),
                          ),
                          Text(
                            'Application Close: ${companies[index]['endDate']}',
                            style: const TextStyle(fontSize: 14, color: Colors.red),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            companies[index]['description']!,
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
