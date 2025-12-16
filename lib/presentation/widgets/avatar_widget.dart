import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {required this.width,
      required this.height,
      required this.style,
      required this.firstName,
      required this.lastName,
      this.raduis,
      this.color,
      super.key});
  final String firstName;
  final String lastName;
  final TextStyle style;
  final Color? color;
  final double width;
  final double height;
  final bool? raduis;
  @override
  Widget build(BuildContext context) {
    final first = firstName[0].toUpperCase();
    final last = lastName[0].toUpperCase();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis == null ? 8 : 100),
        color: Color(0xFFE1E1E1),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "$first$last",
          style: style,
        ),
      ),
    );
  }
}
