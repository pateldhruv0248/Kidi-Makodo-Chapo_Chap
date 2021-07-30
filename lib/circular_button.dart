import 'package:flutter/material.dart';
import 'constants.dart';

class CircularButton extends StatelessWidget {
  final Color colour;
  final String title;
  final Color borderColour;

  CircularButton({
    required this.colour,
    required this.title,
    this.borderColour = kBorderColour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.center,
      padding: EdgeInsets.all(100.0),
      child: FittedBox(
        child: Text(
          title,
          style: TextStyle(fontSize: 35, color: kSecondaryColour),
          softWrap: true,
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colour,
        border: Border.all(
          width: 10,
          color: borderColour,
        ),
      ),
    );
  }
}
