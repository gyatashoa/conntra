import 'package:contra/constants/colors.dart';
import 'package:contra/model/prediction.dart';
import 'package:contra/screens/places/places_screen.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressTile extends StatefulWidget {
  const AddressTile({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  Prediction? prediction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: RadioListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16..w, vertical: 16.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.h),
            side: BorderSide(
                color: primaryDeepBlueText.withOpacity(0.1), width: 1)),
        title: Text(
          prediction != null ? prediction!.mainText! : "No location selected",
          style: GoogleFonts.overpass(
            color: primaryDeepBlueText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            addVerticalSpace(4.h),
            Text(
              prediction != null ? prediction!.secondaryText! : "",
              style: GoogleFonts.overpass(
                color: primaryGreyText,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        secondary: IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () async {
            var res = await Navigator.push(context,
                MaterialPageRoute(builder: (_) => const PlacesScreen()));
            if (res != null) {
              setState(() {
                prediction = res;
              });
            }
          },
        ),
        value: "2",
        groupValue: [],
        onChanged: (value) {},
      ),
    );
  }
}
