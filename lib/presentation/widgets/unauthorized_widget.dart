import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class UnauthorizedWidget extends StatelessWidget {
  const UnauthorizedWidget({required this.tryAgain, super.key});
  final VoidCallback tryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset(
        //   Assets.assets_icons_login_2_svg,
        //   width: 150,
        // ),
        SizedBox(
          height: 2.h,
        ),
        const Text(
          "Please_log_in_first",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 2.h,
        ),
        OutlinedButton(
            onPressed: tryAgain,
            child: const Text(
              "LOGIN",
            ))
      ],
    );
  }
}
