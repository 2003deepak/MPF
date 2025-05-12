import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
        elevation: 10, // Adding shadow to the AppBar
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = 600.0;
          double padding = constraints.maxWidth * 0.05;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: constraints.maxWidth > maxWidth
                    ? maxWidth
                    : constraints.maxWidth,
                padding:
                    EdgeInsets.symmetric(horizontal: padding, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ProfileHeader(constraints: constraints),
                    SizedBox(height: 20),
                    ProfileDescription(constraints: constraints),
                    SizedBox(height: 30),
                    _buildContactInfo(
                      icon: Icons.email,
                      label: 'Email',
                      value: 'deepak.yadav24@spit.ac.in',
                      constraints: constraints,
                    ),
                    _buildContactInfo(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: '9967900689',
                      constraints: constraints,
                    ),
                    _buildContactInfo(
                      icon: Icons.location_on,
                      label: 'Location',
                      value: 'Mumbai, India',
                      constraints: constraints,
                    ),
                    SizedBox(height: 40),
                    AboutMeSection(constraints: constraints),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String label,
    required String value,
    required BoxConstraints constraints,
  }) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.teal[700],
              size: constraints.maxWidth * 0.06 < 30
                  ? constraints.maxWidth * 0.06
                  : 30,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.04 < 18
                        ? constraints.maxWidth * 0.04
                        : 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: constraints.maxWidth * 0.045 < 20
                        ? constraints.maxWidth * 0.045
                        : 20,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ScaleTransition(
          scale: _scaleAnimation,
          child: CircleAvatar(
            radius: widget.constraints.maxWidth * 0.15,
            backgroundImage: AssetImage("assets/profilePicture.jpeg"),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Deepak Kumar Yadav',
          style: TextStyle(
            fontSize: widget.constraints.maxWidth * 0.07 < 36
                ? widget.constraints.maxWidth * 0.07
                : 36,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Senior Software Engineer',
          style: TextStyle(
            fontSize: widget.constraints.maxWidth * 0.05 < 24
                ? widget.constraints.maxWidth * 0.05
                : 24,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.teal, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            '2+ Years of Experience in Full-Stack Development',
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.045 < 20
                  ? constraints.maxWidth * 0.045
                  : 20,
              color: Colors.white, // Make text gradient colored
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'About Me',
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.06 < 28
                ? constraints.maxWidth * 0.06
                : 28,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[100]!, Colors.teal[300]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            'I am a passionate software engineer with expertise in building robust web and mobile applications. I specialize in Flutter for mobile development and React for front-end web development. I love solving complex problems and learning new technologies.',
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.04 < 18
                  ? constraints.maxWidth * 0.04
                  : 18,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
