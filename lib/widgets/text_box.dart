
import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

Widget textbox(
    {required String hinttext,
      required IconData icon,
      bool? readonly = false,
      Color? color = AppColors.searchcolor,
      void Function()? ontap}) {
  return TextFormField(
    readOnly: readonly!,
    onTap: () {},
    decoration: InputDecoration(
      filled: true,
      fillColor: color,
      suffixIcon: Icon(
        icon,
        color: AppColors.lightGrey,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      hintText: hinttext,
    ),
  );
}
