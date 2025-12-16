import 'package:flutter/material.dart';

class CostumeButton extends StatelessWidget {
  const CostumeButton({required this.onPressed, required this.child, Key? key})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            //fixedSize: const Size(0, 50),
            ),
        child: child);
  }
}

class customButton extends StatelessWidget {
  const customButton({
    super.key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.border,
    required this.child,
    required this.colorText,
    required this.colorButton,
  });
  final Function()? onTap;
  final double height, width, border;
  final Widget child;
  final Color colorText, colorButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: colorButton,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border)),
        ),
        child: child,
      ),
    );
  }
}
