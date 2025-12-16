import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({required this.tryAgain, super.key});
  final VoidCallback tryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset(
        //   "Assets.assets_icons_error_svg",
        //   width: 150,
        // ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "حدث خطـأ ما",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        OutlinedButton(
            onPressed: tryAgain,
            child: const Text(
              "أعد المحاولة",
            ))
      ],
    );
  }
}
