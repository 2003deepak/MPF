import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/side_nav_drawer.dart';
import 'profile_page.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _hscCollegeController = TextEditingController();
  final TextEditingController _hscYearController = TextEditingController();
  final TextEditingController _hscMarksController = TextEditingController();
  final TextEditingController _hscTotalMarksController = TextEditingController();
  final TextEditingController _sscCollegeController = TextEditingController();
  final TextEditingController _sscYearController = TextEditingController();
  final TextEditingController _sscMarksController = TextEditingController();
  final TextEditingController _sscTotalMarksController = TextEditingController();
  final List<TextEditingController> _cgpaControllers = List.generate(6, (_) => TextEditingController());

  File? _resume;

  double _calculatePercentage(String marks, String total) {
    if (marks.isNotEmpty && total.isNotEmpty) {
      double obtained = double.tryParse(marks) ?? 0;
      double maxMarks = double.tryParse(total) ?? 1;
      return (obtained / maxMarks) * 100;
    }
    return 0.0;
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _resume = File(result.files.single.path!);
      });
    }
  }

  void _submitForm() {
  if (_formKey.currentState!.validate()) {
    Map<String, dynamic> userData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'contact': _contactController.text,
      'rollNo': _rollNoController.text,
      'hscCollege': _hscCollegeController.text,
      'hscYear': _hscYearController.text,
      'hscPercentage': _calculatePercentage(_hscMarksController.text, _hscTotalMarksController.text).toStringAsFixed(2),
      'sscCollege': _sscCollegeController.text,
      'sscYear': _sscYearController.text,
      'sscPercentage': _calculatePercentage(_sscMarksController.text, _sscTotalMarksController.text).toStringAsFixed(2),
      'semesterCGPA': _cgpaControllers.map((controller) => controller.text).toList(),
      'resumePath': _resume?.path,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(userData: userData),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: const SideNavDrawer(),
      appBar: AppBar(
        title: const Text('Registration'),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle("Student Registration"),
                        _buildTextField(_nameController, 'Name'),
                        _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress),
                        _buildTextField(_contactController, 'Contact No', keyboardType: TextInputType.phone),
                        _buildTextField(_rollNoController, 'Roll No'),
                        
                        const Divider(),
                        _buildSectionTitle("HSC Details"),
                        _buildTextField(_hscCollegeController, 'College Name'),
                        _buildTextField(_hscYearController, 'Year of Passing', keyboardType: TextInputType.number),
                        _buildTextField(_hscMarksController, 'Marks Obtained', keyboardType: TextInputType.number, onChanged: () => setState(() {})),
                        _buildTextField(_hscTotalMarksController, 'Total Marks', keyboardType: TextInputType.number, onChanged: () => setState(() {})),
                        _buildPercentageText(_hscMarksController.text, _hscTotalMarksController.text),

                        const Divider(),
                        _buildSectionTitle("SSC Details"),
                        _buildTextField(_sscCollegeController, 'College Name'),
                        _buildTextField(_sscYearController, 'Year of Passing', keyboardType: TextInputType.number),
                        _buildTextField(_sscMarksController, 'Marks Obtained', keyboardType: TextInputType.number, onChanged: () => setState(() {})),
                        _buildTextField(_sscTotalMarksController, 'Total Marks', keyboardType: TextInputType.number, onChanged: () => setState(() {})),
                        _buildPercentageText(_sscMarksController.text, _sscTotalMarksController.text),

                        const Divider(),
                        _buildSectionTitle("Semester CGPA"),
                        ...List.generate(6, (index) => _buildTextField(_cgpaControllers[index], 'Sem ${index + 1} CGPA', keyboardType: TextInputType.number)),

                        const Divider(),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: _pickResume,
                            icon: const Icon(Icons.upload_file, color: Colors.white),
                            label: const Text('Upload Resume', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        if (_resume != null)
                          Center(child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text("File: ${_resume!.path.split('/').last}", style: const TextStyle(color: Colors.black54)),
                          )),

                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text, VoidCallback? onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? 'Enter $label' : null,
        onChanged: onChanged != null ? (_) => onChanged() : null,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
    );
  }

  Widget _buildPercentageText(String marks, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "Percentage: ${_calculatePercentage(marks, total).toStringAsFixed(2)}%",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }
}
