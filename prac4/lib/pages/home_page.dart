import 'package:flutter/material.dart';
import '../widgets/side_nav_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideNavDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // College Logo
                Image.network(
                  'https://www.spit.ac.in/wp-content/uploads/2021/01/LogoSPIT.png',
                  height: 150,
                ),
                const SizedBox(height: 30),

                // Welcome Text
                const Text(
                  'Welcome to TPO SPIT',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Tagline
                const Text(
                  'Empowering Students for a Brighter Future!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),

                // Mission Statement
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Our mission is to connect students with top recruiters, '
                    'provide career guidance, and equip them with the skills '
                    'needed to excel in their careers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),

               
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
