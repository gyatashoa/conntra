import 'package:contra/constants/colors.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {Key? key, this.fn, required this.icon, required this.title})
      : super(key: key);
  final VoidCallback? fn;
  final Widget icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.only(left: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(
              right: 16.w,
            ),
            onTap: fn,
            leading: icon,
            title: Text(title,
                style: GoogleFonts.overpass(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: primaryDeepBlueText.withOpacity(0.75))),
            trailing: Icon(
              Icons.chevron_right,
              color: primaryDeepBlueText,
              size: 20.sp,
            ),
          ),
          addVerticalSpace(10.h),
          Divider(
            height: 2,
            color: primaryColor,
            indent: 55.w,
          )
        ],
      ),
    );
  }
}
