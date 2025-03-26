import 'package:flutter/material.dart';

class SideNavDrawer extends StatelessWidget {
  const SideNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://www.spit.ac.in/wp-content/uploads/2021/01/LogoSPIT.png',
                  height: 80, // Adjusted size for better UI
                ),
                const SizedBox(height: 10),
                const Text(
                  'TPO Navigation',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildListTile(context, Icons.home, 'Home', '/home'),
          _buildListTile(context, Icons.app_registration, 'Register', '/register'),
          _buildListTile(context, Icons.person, 'Profile', '/profile'),
          _buildListTile(context, Icons.business, 'Companies', '/company'),
          const Divider(), // Adds a separator for better UI
        ],
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
