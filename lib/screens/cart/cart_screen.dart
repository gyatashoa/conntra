import 'package:contra/constants/colors.dart';
import 'package:contra/constants/sizing.dart';
import 'package:contra/model/product.dart';
import 'package:contra/providers/cart_provider.dart';
import 'package:contra/utils/ui.dart';
import 'package:contra/widgets/cart/cart_item.dart';
import 'package:contra/widgets/gloabal/cc_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:provider/provider.dart';

import '../payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                children: [
                  Text(
                    "${value.products.length} Items in Your Cart",
                    style: GoogleFonts.overpass(
                      color: primaryGreyText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: primaryGreyText,
                          ),
                          addHorizontalSpace(5.w),
                          Text(
                            "Add More",
                            style: GoogleFonts.overpass(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: primaryDeepBlueText),
                          )
                        ],
                      ))
                ],
              ),
              addVerticalSpace(24.h),
              ...value.products.map((e) => CartItem(
                    cart: e,
                  )),
              addVerticalSpace(24.h),
              Text("Payment Summary",
                  style: GoogleFonts.poppins(
                    color: primaryDeepBlueText,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  )),
              addVerticalSpace(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Total",
                      style: GoogleFonts.poppins(
                        color: primaryGreyText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("GHC ${value.computePrice}",
                      style: GoogleFonts.poppins(
                        color: primaryDeepBlueText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              addVerticalSpace(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Items Discount",
                      style: GoogleFonts.poppins(
                        color: primaryGreyText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("GHC 0",
                      style: GoogleFonts.poppins(
                        color: primaryDeepBlueText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              addVerticalSpace(15.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("Coupon Discount",
              //         style: GoogleFonts.poppins(
              //           color: primaryGreyText,
              //           fontSize: 14.0,
              //           fontWeight: FontWeight.w400,
              //         )),
              //     Text("-GHC 15",
              //         style: GoogleFonts.poppins(
              //           color: primaryDeepBlueText,
              //           fontSize: 14.0,
              //           fontWeight: FontWeight.w400,
              //         )),
              //   ],
              // ),
              addVerticalSpace(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Shipping",
                      style: GoogleFonts.poppins(
                        color: primaryGreyText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("Free",
                      style: GoogleFonts.poppins(
                        color: primaryDeepBlueText,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              addVerticalSpace(15.h),
              Divider(
                height: 1,
              ),
              addVerticalSpace(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style: GoogleFonts.poppins(
                        color: primaryGreyText,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("GHC ${value.computePrice}",
                      style: GoogleFonts.poppins(
                        color: primaryDeepBlueText,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
              addVerticalSpace(30.h),
              CCElevatedButton(
                  text: "Place Order @ GHC${value.computePrice}",
                  onPress: () {
                    if (value.computePrice == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Row(
                            children: const [
                              Icon(Icons.shopping_basket),
                              Text('Cart is empty')
                            ],
                          )));
                      return;
                    }
                    Navigator.pushNamed(context, PaymentScreen.routeName);
                  }),
              addVerticalSpace(30.h),
            ],
          ),
        );
      }),
    );
  }
}
