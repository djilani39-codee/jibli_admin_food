import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({required this.tryAgain, super.key});
  final VoidCallback tryAgain;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset(
        //   Assets.assets_icons_network_error_svg,
        //   width: 150,
        // ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "لا يوجد اتصال بالإنترنت",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const Text(
          "اتصل بالإنترنت وحاول مرة أخرى",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.grey),
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
