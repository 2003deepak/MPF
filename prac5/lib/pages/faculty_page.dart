import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/side_nav_drawer.dart';

class FacultyPage extends StatelessWidget {
  const FacultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for a professional look
      appBar: AppBar(
        title: const Text('Faculty Information'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      drawer: const SideNavDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          FacultyCard(
            name: 'Prof. Dr. Dhananjay Kalbande',
            position: 'Head Of Department',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2023/04/dr-dhananjay-kalbande.jpg',
            linkedInUrl: 'https://www.linkedin.com/in/dhananjay-kalbande-77349923/',
            description:
                'Dr. Kalbande is a renowned expert in Artificial Intelligence and Machine Learning, with over 20 years of experience in the industry and academia.',
          ),
          FacultyCard(
            name: 'Prof. Dr. Pooja Raundale',
            position: 'Professor',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2022/12/PR-e1670491866552.jpg',
            linkedInUrl: 'https://www.linkedin.com/in/pooja-raundale-9a7349153/',
            description:
                'Dr. Raundale specializes in Natural Language Processing and has published numerous research papers in top journals.',
          ),
          FacultyCard(
            name: 'Prof. Dr. Aarti Karande',
            position: 'Assistant Professor',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2022/12/aarti.png',
            linkedInUrl: 'https://www.linkedin.com/in/aartimkarande/',
            description:
                'Dr. Karande focuses on Data Science and Cybersecurity, mentoring students in advanced machine learning techniques.',
          ),
          FacultyCard(
            name: 'Prof. Harshil Kanakia',
            position: 'Assistant Professor',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2022/12/HK.png',
            linkedInUrl: 'https://www.linkedin.com/in/harshil-kanakia-b477246a/',
            description:
                'Prof. Kanakia has expertise in Cloud Computing and distributed systems, guiding students on large-scale infrastructure projects.',
          ),
          FacultyCard(
            name: 'Prof. Nikhita Mangaonkar',
            position: 'Assistant Professor',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2022/12/NM.png',
            linkedInUrl: 'https://www.linkedin.com/in/nikhita-mangaonkar-5268b4191/',
            description:
                'Prof. Mangaonkar is passionate about Software Engineering and Agile Development, helping students build real-world applications.',
          ),
          FacultyCard(
            name: 'Prof. Sakina Shaikh',
            position: 'Assistant Professor',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2022/12/SK.png',
            linkedInUrl: 'https://www.linkedin.com/in/sakina-salmani-1283a1a2/',
            description:
                'Prof. Shaikh specializes in Mobile Application Development and has guided several student projects in Flutter and React Native.',
          ),
          FacultyCard(
            name: 'Prof. Pallavi Thakur',
            position: 'Assistant Professor',
            imageUrl:
                'https://mca.spit.ac.in/wp-content/uploads/2022/12/PT.png',
            linkedInUrl: 'https://www.linkedin.com/in/pallavi-thakur-8a7a271ba/',
            description:
                'Prof. Thakur focuses on Data Structures and Algorithms, helping students prepare for coding competitions and placements.',
          ),
        ],
      ),
    );
  }
}

class FacultyCard extends StatefulWidget {
  final String name;
  final String position;
  final String imageUrl;
  final String linkedInUrl;
  final String description;

  const FacultyCard({
    super.key,
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.linkedInUrl,
    required this.description,
  });

  @override
  State<FacultyCard> createState() => _FacultyCardState();
}

class _FacultyCardState extends State<FacultyCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.grey[850], // Dark card background
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          iconColor: Colors.orangeAccent,
          collapsedIconColor: Colors.orangeAccent,
          title: Text(
            widget.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            widget.position,
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 60, color: Colors.red),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.description,
                    style: TextStyle(color: Colors.grey[300], fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton.icon(
                      onPressed: () => _launchUrl(widget.linkedInUrl),
                      icon: const Icon(Icons.open_in_new, color: Colors.orangeAccent),
                      label: const Text(
                        'LinkedIn',
                        style: TextStyle(color: Colors.orangeAccent),
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

  void _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open $url: $e')),
    );
  }
}
}
