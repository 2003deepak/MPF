import 'package:flutter/material.dart';
import 'review_form_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Review Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReviewFormScreen()),
            );
          },
          child: Text('Submit a Review'),
        ),
      ),
    );
  }
}
