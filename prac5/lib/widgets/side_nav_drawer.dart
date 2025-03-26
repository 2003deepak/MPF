import 'package:flutter/material.dart';

class SideNavDrawer extends StatelessWidget {
  const SideNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black, // Dark background
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(context, Icons.school, 'Faculty', '/'),
                _drawerItem(context, Icons.business, 'Department', '/department'),
                _drawerItem(context, Icons.notifications, 'Notifications', '/notifications'),
                _drawerItem(context, Icons.web, 'WebView', '/webview'),
                _drawerItem(context, Icons.feedback, 'Feedback', '/feedback'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://mca.spit.ac.in/wp-content/uploads/2022/12/cropped-logo-removebg-preview-1.png', // College logo URL
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, size: 50, color: Colors.red),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'MCA App',
            style: TextStyle(
              color: Colors.orangeAccent, // Accent color
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.orangeAccent, // Orange accent for icons
        size: 28,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white, // White text for contrast
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      hoverColor: Colors.grey[800], // Hover effect for better UX
    );
  }
}
