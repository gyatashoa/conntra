import 'package:contra/constants/colors.dart';
import 'package:contra/screens/home/home_screen.dart';
import 'package:contra/screens/home/news_screen.dart';
import 'package:contra/screens/home/orders_screen.dart';
import 'package:contra/screens/home/profile_screen.dart';
import 'package:contra/screens/home/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';

class BottomNavScreen extends StatefulWidget {
  static const String routeName = "/bottomNavScreen";
  BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentBottomNavIndex = 0;

  final _screens = [
    HomeScreen(),
    // ScheduleScreen(),
    NewsScreen(),
    OrdersScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70.h,
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          onTap: (index) {
            print(index);
            setState(() {
              _currentBottomNavIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Iconify(
                Uil.home_alt,
                color: _currentBottomNavIndex == 0
                    ? primaryColor
                    : primaryGreyText,
              ),
              label: "Home",
            ),
            // BottomNavigationBarItem(
            //     icon: Iconify(
            //       Uil.clock,
            //       color: _currentBottomNavIndex == 1
            //           ? primaryColor
            //           : primaryGreyText,
            //     ),
            //     label: "Schedule"),
            BottomNavigationBarItem(
                icon: Iconify(
                  Uil.newspaper,
                  color: _currentBottomNavIndex == 1
                      ? primaryColor
                      : primaryGreyText,
                ),
                label: "News"),
            BottomNavigationBarItem(
                icon: Iconify(
                  Uil.shopping_bag,
                  color: _currentBottomNavIndex == 2
                      ? primaryColor
                      : primaryGreyText,
                ),
                label: "History"),
            BottomNavigationBarItem(
                icon: Iconify(
                  Uil.user,
                  color: _currentBottomNavIndex == 3
                      ? primaryColor
                      : primaryGreyText,
                ),
                label: "Profile"),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentBottomNavIndex,
        children: _screens,
      ),
    );
  }
}
