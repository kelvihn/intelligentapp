import 'package:flutter/material.dart';

class LeadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final double iconSize;
  const LeadingWidget(
      {Key? key,
      required this.height,
      required this.width,
      this.iconSize = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
      ),
      child: Center(
        child: Icon(Icons.person, size: iconSize),
      ),
    );
  }
}
