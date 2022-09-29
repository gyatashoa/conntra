import 'package:contra/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CCUnderlinedInput extends StatelessWidget {
  const CCUnderlinedInput(
      {Key? key,
      required this.hintText,
      this.icon,
      this.enabled = true,
      required this.textEditingController,
      this.trailing})
      : super(key: key);
  final String hintText;
  final bool enabled;
  final IconData? icon;
  final Widget? trailing;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.overpass(
              fontWeight: FontWeight.w400,
              height: 1.33,
              fontSize: 15.0.sp,
              color: primaryGreyText),
          suffixIcon: trailing,
          prefixIcon: icon != null
              ? IconTheme(
                  data: IconTheme.of(context)
                      .copyWith(color: primaryDeepBlueText),
                  child: IconButton(icon: Icon(icon), onPressed: () {}))
              : null,
          prefixIconColor: primaryDeepBlueText,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryDeepBlueText.withOpacity(0.1)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryDeepBlueText),
          ),
        ));
  }
}
