import 'package:contra/constants/colors.dart';
import 'package:contra/screens/auth/login_screen.dart';
import 'package:contra/screens/auth/register.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "/signup";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 70.h, left: 32.w, right: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/images/on_boarding/welcome.png",
              height: 258.sp,
              width: 258.sp,
              fit: BoxFit.fill,
            )),
            addVerticalSpace(34.h),
            Text(
              "Welcome to NewRx",
              style: TextStyle(
                color: primaryDeepBlueText,
                fontSize: 24.0.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            addVerticalSpace(16.h),
            Text(
              "Do you want some help with your\nhealth to get better life?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryGreyText,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            addVerticalSpace(34.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Register.routeName);
              },
              child: Text(
                "SIGN UP EMAIL",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(56.0),
                  )),
            ),
            addVerticalSpace(10.h),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Image.asset("assets/images/social_icons/facebook(3)1.png"),
            //       addHorizontalSpace(21.w),
            //       Text(
            //         "CONTINUE WITH FACEBOOK",
            //         style: TextStyle(
            //             fontSize: 13.0.sp,
            //             fontWeight: FontWeight.w700,
            //             color: primaryDeepBlueText.withOpacity(0.75)),
            //       ),
            //     ],
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       elevation: 0,
            //       minimumSize: const Size.fromHeight(50),
            //       primary: Colors.white,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(56.0),
            //           side: BorderSide(color: primaryGreyText, width: 1))),
            // ),
            // addVerticalSpace(10.h),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Image.asset(
            //           "assets/images/social_icons/google-hangouts(1)1.png"),
            //       addHorizontalSpace(21.w),
            //       Text(
            //         "CONTINUE WITH GMAIL",
            //         style: TextStyle(
            //             fontSize: 13.0.sp,
            //             fontWeight: FontWeight.w700,
            //             color: primaryDeepBlueText.withOpacity(0.75)),
            //       ),
            //     ],
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       elevation: 0,
            //       minimumSize: const Size.fromHeight(50),
            //       primary: Colors.white,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(56.0),
            //           side: BorderSide(color: primaryGreyText, width: 1))),
            // ),
            Center(
              child: TextButton(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: primaryDeepBlueText.withOpacity(0.45)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
