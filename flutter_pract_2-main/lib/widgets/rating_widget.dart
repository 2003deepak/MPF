import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final Function(int) onRatingSelected;

  RatingWidget({required this.onRatingSelected});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () {
            setState(() {
              _selectedRating = index + 1;
            });
            widget.onRatingSelected(_selectedRating);
          },
        );
      }),
    );
  }
}
