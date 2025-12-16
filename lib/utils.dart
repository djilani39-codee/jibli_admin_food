import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jibli_admin_food/presentation/main/blocs/main_navigation_cubi.dart';

import 'app/locator.dart';

final ImagePicker picker = ImagePicker();

String? patterRegexAlgerie(String? value) {
  const pattern = r'^(?:\+?213|00213|0)(5|6|7)([0-9]{8})$';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "please_enter_phone_number";
  } else if (regex.hasMatch("+213$value")) {
    return null;
  } else {
    return 'is_not_a_valid_Algerian_phone_number.';
  }
}

String? patterRegexTunis(String? value) {
  const pattern = r'^(?:\+?216|00216|0)([2379]\d{7})$';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "please_enter_phone_number";
  } else if (regex.hasMatch("+216$value")) {
    return null;
  } else {
    return 'is not a valid Algerian phone number.';
  }
}

bool isMP4(String videoUrl) {
  RegExp mp4Pattern = RegExp(r'\.mp4$', caseSensitive: false);
  if (mp4Pattern.hasMatch(videoUrl)) {
    return true;
  }
  return false;
}

bool isPhoto(String videoUrl) {
  RegExp PhotoPattern = RegExp(r'\.(jpg|jpeg|png)$', caseSensitive: false);
  if (PhotoPattern.hasMatch(videoUrl)) {
    return true;
  }
  return false;
}

String? patterRegexMaroc(String? value) {
  const pattern = r'^(?:\+?212|00212|0)([567]\d{8})$';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "please_enter_phone_number";
  } else if (regex.hasMatch("+212$value")) {
    return null;
  } else {
    return 'is not a valid Algerian phone number.';
  }
}

Future<XFile?> pickImage(ImageSource source) async {
  XFile? adImage = await picker.pickImage(source: source);
  return adImage;
}

Future<XFile?> pickVideo(ImageSource source) async {
  XFile? adImage = await picker.pickVideo(
    source: source,
    maxDuration: const Duration(
      minutes: 1,
    ),
  );
  return adImage;
}

Future<List<XFile>> pickImageMulti() async {
  List<XFile> adImage =
      await picker.pickMultiImage(maxHeight: 200, maxWidth: 200);
  print(adImage);
  return adImage;
}

String? firstNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "please_enter_first_name";
  } else if (value.length < 3) {
    return "the_first_name_must_be_at_least_3_characters";
  } else {
    return null;
  }
}

String? lastNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "please_enter_last_name";
  } else if (value.length < 3) {
    return "the_last_name_must_be_at_least_3_characters";
  } else {
    return null;
  }
}

String? fieldValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "هذا الحقل إجباري".tr();
  }
  return null;
}

String? fullNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "please_enter_full_name";
  } else if (value.length < 3) {
    return "the_last_name_must_be_at_least_3_characters";
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "please_enter_password";
  } else if (!RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-])[A-Za-z\d@$!%*?&-]{8,}$')
      .hasMatch(value)) {
    if (value.length < 8) {
      return "Password_must_be_at_least_8_characters_long.";
    }
    return "password_invalid";
  } else {
    return null;
  }
}

Future<void> smartToast({required String msg}) {
  return SmartDialog.showToast(
    msg,
    alignment: Alignment.topCenter,
    animationType: SmartAnimationType.scale,
    // animationTime: Duration(seconds: ),
    //displayTime: const Duration(seconds: 3
  );
}

Future<dynamic> showSmartNotification({
  String? title,
  String? body,
  required int length,
}) {
  return SmartDialog.show(
      backDismiss: false,
      clickMaskDismiss: false,
      builder: (_) => Container(
            height: 20.h,
            width: 80.w,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Text(length == 1 ? title ?? "طلب جديد" : "طلبات جديدة",
                    style: TextStyle(
                        fontSize: 20.dp, fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                        length == 1
                            ? body ?? ""
                            : "طلبات جديدة من جيبلي المطعم",
                        style: TextStyle(
                            fontSize: 15.dp, fontWeight: FontWeight.w500)),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 5.5.h,
                  width: 60.h,
                  child: TextButton(
                    child: Text("اخذ بعين الإعتبار"),
                    onPressed: () async {
                      FlutterLocalNotificationsPlugin().cancelAll();
                      if (sl<BottomNavigationCubit>().state != 0) {
                        sl<BottomNavigationCubit>().controller.jumpToPage(0);
                        sl<BottomNavigationCubit>().changeTap(0);
                      }
                      SmartDialog.dismiss();
                    },
                  ),
                ),
              ],
            ),
          ),
      alignment: Alignment.center);
}
