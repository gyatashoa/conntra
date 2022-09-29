import 'package:flutter/material.dart';

class CCElevatedButton extends StatelessWidget {
  const CCElevatedButton(
      {Key? key,
      this.isDisabled = false,
      required this.text,
      required this.onPress,
      this.isLoading = false})
      : super(key: key);
  final String text;
  final VoidCallback? onPress;
  final bool isDisabled;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPress,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56.0),
          )),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
    );
  }
}
