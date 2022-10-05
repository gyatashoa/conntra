import 'package:contra/constants/colors.dart';
import 'package:contra/constants/sizing.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/on_boarding/on_boarding_screen.dart';
import 'package:contra/screens/on_boarding/on_boarding_start.dart';
import 'package:contra/service/api_service.dart';
import 'package:contra/service/storage_service.dart';
import 'package:contra/utils/math_util.dart';
import 'package:contra/utils/ui.dart';
import 'package:contra/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("My Profile",
            style: GoogleFonts.overpass(
              color: primaryDeepBlueText,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            )),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: defaultHorizontalPadding.w),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 62.sp,
                      height: 62.sp,
                      padding: EdgeInsets.all(5),
                      decoration: ShapeDecoration(
                        // image: DecorationImage(
                        //     image: NetworkImage(
                        //   "https://randomuser.me/api/portraits/thumb/men/${getRandomNumber()}.jpg",
                        // )),
                        shape: CircleBorder(
                            side: BorderSide(width: 3, color: primaryColor)),
                      ),
                      child: ClipOval(
                        child: Image.network(
                            "https://randomuser.me/api/portraits/thumb/men/${MathUtil.getRandomNumber()}.jpg",
                            width: 50.sp,
                            height: 50.sp,
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  addHorizontalSpace(10.w),
                  Column(
                    children: [
                      Consumer<UserProvider>(builder: (context, value, child) {
                        return Text(
                          "Hi ${value.getUser?.name}",
                          style: GoogleFonts.overpass(
                              color: primaryDeepBlueText,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                        );
                      }),
                      Text(
                        "Welcome to  NewRx",
                        style: GoogleFonts.overpass(
                            color: primaryGreyText,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp),
                      ),
                    ],
                  )
                ],
              ),
            ),
            addVerticalSpace(40.h),
            // SettingsTile(
            //     icon: Icon(Icons.sticky_note_2_outlined,
            //         color: primaryDeepBlueText),
            //     title: "My Profile"),
            // SettingsTile(
            //     icon: Icon(Icons.shopping_bag_outlined,
            //         color: primaryDeepBlueText),
            //     title: "My Purchases"),
            // SettingsTile(
            //     icon: Icon(Icons.person_add_alt, color: primaryDeepBlueText),
            //     title: "Invite Friends"),
            // SettingsTile(
            //     icon: Icon(Icons.card_giftcard_outlined,
            //         color: primaryDeepBlueText),
            //     title: "Promotions"),
            // SettingsTile(
            //     icon: Icon(Icons.settings_outlined, color: primaryDeepBlueText),
            //     title: "Settings"),
            SettingsTile(
              icon: Icon(Icons.logout),
              title: 'Logout',
              fn: () async {
                await GetIt.instance<ApiService>().logout();
                // ignore: use_build_context_synchronously
                Navigator.pushNamedAndRemoveUntil(
                    context, OnBoardingStart.routeName, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
