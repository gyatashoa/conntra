import 'dart:developer';

import 'package:contra/constants/colors.dart';
import 'package:contra/model/gender.dart';
import 'package:contra/model/user.dart';
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
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routeName = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController dateController;
  late bool isLoading;
  late ApiService _apiService;
  late Gender _gender;
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: '');
    nameController = TextEditingController(text: '');
    usernameController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    confirmPasswordController = TextEditingController(text: '');
    dateController = TextEditingController(text: '');
    isLoading = false;
    _apiService = GetIt.instance<ApiService>();
    _gender = Gender.MALE;
  }

  void showSnack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(msg),
            ],
          )));

  void onSignup() async {
    if (nameController.text.trim().isEmpty ||
        dateController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        _dob == null ||
        passwordController.text.trim().isEmpty) {
      showSnack('Please complete the form');
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showSnack('Passwords should match');
      return;
    }
    setState(() {
      isLoading = true;
    });
    var res = await _apiService.signUp(
        User(
            id: '',
            dob: _dob!,
            gender: _gender,
            username: usernameController.text,
            schoolId: 1,
            hostelId: 1,
            password: passwordController.text,
            name: nameController.text,
            email: emailController.text),
        confirmPasswordController.text);
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

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, BottomNavScreen.routeName, (route) => false);
    //TODO login successfull
  }

  void onGenderChanged(Gender? value) => setState(() {
        _gender = value ?? _gender;
      });

  void _showDatePicker() async {
    _dob = (await showDatePicker(
            context: context,
            initialDate: DateTime(1999),
            firstDate: DateTime(1900),
            lastDate: DateTime(2005))) ??
        _dob;
    if (_dob != null) {
      dateController.text = '${_dob!.day}/${_dob!.month}/${_dob!.year}';
    }
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(10.h),
                  Text(
                    "Welcome!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.overpass(
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                        fontSize: 24.0.sp,
                        color: primaryDeepBlueText),
                  ),
                  addVerticalSpace(24.h),
                  CCUnderlinedInput(
                    textEditingController: nameController,
                    hintText: "Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('GENDER'),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<Gender>(
                            title: Text(Gender.MALE.name),
                            value: Gender.MALE,
                            groupValue: _gender,
                            onChanged: onGenderChanged),
                      ),
                      Expanded(
                        child: RadioListTile<Gender>(
                            title: Text(Gender.FEMALE.name),
                            value: Gender.FEMALE,
                            groupValue: _gender,
                            onChanged: onGenderChanged),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CCUnderlinedInput(
                          enabled: false,
                          textEditingController: dateController,
                          hintText: "Date",
                          icon: Icons.date_range_sharp,
                        ),
                      ),
                      IconButton(
                          onPressed: _showDatePicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                  addVerticalSpace(16.h),
                  CCUnderlinedInput(
                    textEditingController: emailController,
                    hintText: "Email",
                    icon: Icons.mail_outline,
                  ),
                  CCUnderlinedInput(
                    textEditingController: usernameController,
                    hintText: "Username",
                    icon: Icons.person,
                  ),
                  addVerticalSpace(16.h),
                  CCUnderlinedInput(
                    textEditingController: passwordController,
                    hintText: "Password",
                    icon: Icons.lock_outline,
                  ),
                  CCUnderlinedInput(
                    textEditingController: confirmPasswordController,
                    hintText: "Confirm Password",
                    icon: Icons.lock_outline,
                  ),
                  addVerticalSpace(24.h),
                  CCElevatedButton(
                    isLoading: isLoading,
                    text: "REGISTER",
                    onPress: onSignup,
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
      ),
    );
  }
}
