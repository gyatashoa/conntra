import 'dart:developer';

import 'package:contra/constants/colors.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/home/bottom_nav_screen.dart';
import 'package:contra/service/api_service.dart';
import 'package:contra/utils/ui.dart';
import 'package:contra/widgets/gloabal/cc_elevated_button.dart';
import 'package:contra/widgets/gloabal/cc_underlined_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool isLoading;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    isLoading = false;
    _apiService = GetIt.instance<ApiService>();
  }

  void onLogin() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Row(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text('Please complete the form'),
            ],
          )));
      return;
    }
    setState(() {
      isLoading = true;
    });
    var res = await _apiService.login(
        email: emailController.text, password: passwordController.text);
    setState(() {
      isLoading = false;
    });
    if (res is String) {
      log(res);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Text(res),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ));
      return;
    }
    if (res is List) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: res.map((e) => Text(e)).toList()),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'))
                ],
              ));
      return;
    }
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false).setUser = res;
    Navigator.pushNamedAndRemoveUntil(
        context, BottomNavScreen.routeName, (route) => false);
    //TODO login successfull
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: primaryDeepBlueText),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(10.h),
                Text(
                  "Welcome Back!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.overpass(
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                      fontSize: 24.0.sp,
                      color: primaryDeepBlueText),
                ),
                addVerticalSpace(24.h),
                CCUnderlinedInput(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.mail_outline,
                ),
                addVerticalSpace(16.h),
                CCUnderlinedInput(
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: Icons.lock_outline,
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.overpass(
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                          fontSize: 10.0.sp,
                          color: primaryGreyText),
                    ),
                  ),
                ),
                addVerticalSpace(24.h),
                CCElevatedButton(
                  isLoading: isLoading,
                  text: "LOGIN",
                  onPress: onLogin,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: GoogleFonts.overpass(
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                        fontSize: 14.0.sp,
                        color: primaryGreyText),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
