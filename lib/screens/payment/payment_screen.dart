import 'package:contra/constants/colors.dart';
import 'package:contra/constants/sizing.dart';
import 'package:contra/providers/cart_provider.dart';
import 'package:contra/screens/payment/payment_confirm_screen.dart';
import 'package:contra/utils/ui.dart';
import 'package:contra/widgets/gloabal/cc_elevated_button.dart';
import 'package:contra/widgets/payment/address_tile.dart';
import 'package:contra/widgets/payment/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/paymentSelect';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = "vodafone";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: primaryDeepBlueText),
        title: Text("Cart",
            style: GoogleFonts.poppins(
              color: primaryDeepBlueText,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            )),
      ),
      body: Consumer<CartProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultHorizontalPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${value.products.length} Items in Your Cart",
                    style: GoogleFonts.overpass(
                      color: primaryGreyText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "TOTAL",
                        style: GoogleFonts.overpass(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            color: primaryGreyText),
                      ),
                      Text(
                        "GHC ${value.computePrice}",
                        style: GoogleFonts.overpass(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: primaryDeepBlueText),
                      ),
                    ],
                  )
                ],
              ),
              addVerticalSpace(16.h),
              Text(
                "Delivery Address",
                style: GoogleFonts.overpass(
                  color: primaryDeepBlueText,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              addVerticalSpace(16.h),
              // AddressTile(),
              AddressTile(),
              addVerticalSpace(10.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //         onPressed: () {},
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Icon(
              //               Icons.add,
              //               color: primaryDeepBlueText,
              //             ),
              //             Text("Add Address",
              //                 style: GoogleFonts.poppins(
              //                   color: primaryDeepBlueText,
              //                   fontSize: 14.0,
              //                   fontWeight: FontWeight.w400,
              //                 )),
              //           ],
              //         )),
              //   ],
              // ),
              addVerticalSpace(10.h),
              Text("Payment Method",
                  style: GoogleFonts.poppins(
                    color: primaryDeepBlueText,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  )),
              addVerticalSpace(12.h),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(24.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: primaryDeepBlueText.withOpacity(0.1), width: 1)),
                child: Column(
                  children: [
                    PaymentTile(
                      title: "VODAFONE CASH",
                      imgPath: "vodafone_cash",
                      groupValue: selectedPaymentMethod,
                      value: "vodafone",
                      onChange: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    PaymentTile(
                      title: "AIRTEL TIGO MONEY",
                      imgPath: "airtel",
                      groupValue: selectedPaymentMethod,
                      value: "airtel",
                      onChange: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    PaymentTile(
                      title: "MTN MOBILE MONEY",
                      imgPath: "mtn",
                      groupValue: selectedPaymentMethod,
                      value: "mtn",
                      onChange: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    PaymentTile(
                      title: "Cash",
                      imgPath: "ghpay",
                      groupValue: selectedPaymentMethod,
                      value: "cash",
                      onChange: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              addVerticalSpace(70.h),
              CCElevatedButton(
                  text: "Place Order",
                  onPress: () {
                    Provider.of<CartProvider>(context, listen: false).clear();
                    Navigator.pushNamed(
                        context, PaymentConfirmScreen.routeName);
                  }),
              addVerticalSpace(30.h),
            ],
          ),
        );
      }),
    );
  }
}
