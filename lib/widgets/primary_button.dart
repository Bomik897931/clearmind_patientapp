
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/widgets/textWidget.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/constant.dart';

Widget primaryButton(
    {required String buttontext,
      Color? buttoncolor = AppColors.primary,
      required void Function()? ontap,
      Color? textcolor = AppColors.white}) {
  return IconButton(
    onPressed: ontap,
    icon: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: buttoncolor),
      width: Get.width,
      height: 50,
      child: Center(
        child: semiboldtext(text: buttontext, fontsize: 16, color: textcolor),
      ),
    ),
  );
}

Widget smallButton(
    {required String buttontext,
      required Color textcolor,
      required void Function()? ontap,
      required Color buttoncolor}) {
  return IconButton(
    onPressed: ontap,
    icon: Container(
      height: 50,
      width: Get.width * .40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: buttoncolor,
      ),
      child: Center(
        child: semiboldtext(text: buttontext, fontsize: 14, color: textcolor),
      ),
    ),
  );
}

Widget appointmentButton({
  required String buttontext1,
  required String buttontext2,
  required void Function()? ontap1,
  required void Function()? ontap2,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        onPressed: ontap1,
        icon: Container(
          height: 35,
          width:width < 380 ? width*.38: Get.width * .40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(30),
            color: AppColors.white,
          ),
          child: Center(
            child: semiboldtext(
                text: buttontext1, fontsize: 12, color: AppColors.primary),
          ),
        ),
      ),
      IconButton(
        onPressed: ontap2,
        icon: Container(
          height: 35,
          width:width < 380 ? width*.38: Get.width * .40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.primary,
          ),
          child: Center(
            child: semiboldtext(text: buttontext2, fontsize: 12, color: AppColors.white),
          ),
        ),
      )
    ],
  );
}
