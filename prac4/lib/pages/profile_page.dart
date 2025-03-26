import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../widgets/side_nav_drawer.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({Key? key, this.userData = const {}}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? resumePath;

  @override
  void initState() {
    super.initState();
    resumePath = widget.userData['resumePath'];
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        resumePath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideNavDrawer(),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle("Student Profile"),
                      _buildProfileItem("Name", widget.userData['name']),
                      _buildProfileItem("Email", widget.userData['email']),
                      _buildProfileItem("Contact No", widget.userData['contact']),
                      _buildProfileItem("Roll No", widget.userData['rollNo']),
                      const Divider(),
                      _buildSectionTitle("HSC Details"),
                      _buildProfileItem("College Name", widget.userData['hscCollege']),
                      _buildProfileItem("Year of Passing", widget.userData['hscYear']),
                      _buildProfileItem("HSC Percentage", "${widget.userData['hscPercentage']}%"),
                      const Divider(),
                      _buildSectionTitle("SSC Details"),
                      _buildProfileItem("College Name", widget.userData['sscCollege']),
                      _buildProfileItem("Year of Passing", widget.userData['sscYear']),
                      _buildProfileItem("SSC Percentage", "${widget.userData['sscPercentage']}%"),
                      const Divider(),
                      _buildSectionTitle("Semester CGPA"),
                      ...List.generate(
                        widget.userData['semesterCGPA'] != null ? widget.userData['semesterCGPA'].length : 0,
                        (index) => _buildProfileItem("Sem ${index + 1} CGPA", widget.userData['semesterCGPA'][index]),
                      ),
                      const Divider(),
                      _buildResumeSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
    );
  }

  Widget _buildProfileItem(String label, dynamic value) {
    String displayValue = (value != null && value.toString().isNotEmpty) ? value.toString() : "Not Provided";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        "$label: $displayValue",
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _buildResumeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const Text(
          "Resume",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        const SizedBox(height: 8),
        resumePath != null && resumePath!.isNotEmpty
            ? ElevatedButton.icon(
                onPressed: () async {
                  if (resumePath!.startsWith("http")) {
                    // Open URL (Web-Based Resume)
                    Uri url = Uri.parse(resumePath!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      debugPrint("Could not open resume URL");
                    }
                  } else {
                    // Open Local File
                    final result = await OpenFile.open(resumePath);
                    if (result.type == ResultType.error) {
                      debugPrint("Error opening file: ${result.message}");
                    }
                  }
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("View Resume"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              )
            : const Text(
                "No file uploaded",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
        const SizedBox(height: 10),
        
      ],
    );
  }
}
