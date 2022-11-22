import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;
  final double birdHeight; // normal double value for width
  final double birdWidth; // out of 2, 2 being the entire height of the screen

  MyBird({this.birdY, required this.birdHeight, required this.birdWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, (2 * birdY + birdHeight) / (2 - birdHeight)),
        child: Image.asset(
          'assets/images/bluebird.png',
          width: MediaQuery.of(context).size.height * birdWidth / 2,
          height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
          fit: BoxFit.fill,
        ));
  }
}
