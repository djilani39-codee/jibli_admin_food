import 'package:flutter/material.dart';

class ShimmerContainerWidget extends StatelessWidget {
  const ShimmerContainerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.raduis,
  });
  final double height, width, raduis;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(raduis),
      ),
    );
  }
}
