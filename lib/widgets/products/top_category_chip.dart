import 'package:contra/constants/colors.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:contra/screens/categories/category_screen.dart';

class TopCategoryChip extends StatelessWidget {
  const TopCategoryChip(
      {required this.imgUrl, required this.title, Key? key, required this.bg})
      : super(key: key);
  final String imgUrl;
  final String title;
  final LinearGradient bg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CategoryScreen.routeName,
            arguments: {"category": title});
      },
      child: Ink(
        child: Container(
          width: 64.w,
          height: 98.h,
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(70.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.02),
                offset: Offset(0.0, 6.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            children: [
              addVerticalSpace(7.h),
              ClipOval(
                child: Container(
                  height: 48.sp,
                  width: 48.sp,
                  decoration: BoxDecoration(gradient: bg),
                  child: Center(
                    child: Image.asset(
                        "assets/images/category_icons/$imgUrl.png",
                        width: 29.sp,
                        height: 29.sp,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              addVerticalSpace(5.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(
                  color: primaryDeepBlueText.withOpacity(0.95),
                  fontSize: 11.0.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
