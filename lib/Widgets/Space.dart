import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({super.key, required this.number});

  final double number;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: number);
  }
}
