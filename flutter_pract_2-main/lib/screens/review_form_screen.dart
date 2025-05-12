import 'package:flutter/material.dart';
import '../widgets/rating_widget.dart';
import 'review_details_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // For animation effects

class ReviewFormScreen extends StatefulWidget {
  @override
  _ReviewFormScreenState createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name, _surname, _email, _address, _review;
  String? _phone;
  DateTime? _dob;
  String _gender = 'Male'; // Default gender selection
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submit a Review',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.cyanAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: Form(
            key: _formKey,
            child: ListView(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  _buildTextField('Name', (value) => _name = value),
                  _buildTextField('Surname', (value) => _surname = value),
                  _buildTextField(
                    'Email',
                    (value) => _email = value,
                    inputType: TextInputType.emailAddress,
                  ),
                  _buildTextField(
                    'Phone',
                    (value) => _phone = value,
                    inputType: TextInputType.phone,
                  ),
                  _buildTextField('Address', (value) => _address = value),
                  _buildGenderSelector(), // Gender radio buttons
                  _buildTextField('Review', (value) => _review = value,
                      maxLines: 3),
                  RatingWidget(
                    onRatingSelected: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved,
      {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: inputType,
        maxLines: maxLines,
        validator: (value) => value!.isEmpty ? 'Enter $label' : null,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGenderRadioButton('Male', Icons.male),
              _buildGenderRadioButton('Female', Icons.female),
              _buildGenderRadioButton('Other', Icons.transgender),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderRadioButton(String gender, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _gender = gender;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: _gender == gender ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gender,
                style: TextStyle(
                  color: _gender == gender ? Colors.white : Colors.black54,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      onPressed: _submitForm,
      child: Text(
        'Submit Review',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review Submitted Successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewDetailsScreen(
            name: _name!,
            surname: _surname!,
            email: _email!,
            phone: _phone!,
            address: _address!,
            gender: _gender,
            review: _review!,
            rating: _rating,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Submission Failed'),
            content: Text('Please fill out all fields correctly.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
