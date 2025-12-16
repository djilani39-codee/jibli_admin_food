import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.readOnly = false,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.inputType,
    this.maxLines,
    this.onFieldSubmitted,
    this.maxlenght,
    this.obscureText = false,
    this.textAlign = TextAlign.start,
    this.textInputAction,
  }) : super(key: key);
  final String label;
  final String hint;
  final int? maxLines, maxlenght;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextAlign textAlign;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.h,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16.dp),
        ),
        SizedBox(
          height: .5.h,
        ),
        TextFormField(
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          textInputAction: textInputAction,
          onTapOutside: (PointerDownEvent event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLines,
          maxLength: maxlenght,
          textAlign: textAlign,
          style: const TextStyle(height: 1.5),
          keyboardType: inputType,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          decoration: InputDecoration(
              hintText: hint, suffixIcon: suffixIcon, prefixIcon: prefixIcon),
          controller: controller,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
