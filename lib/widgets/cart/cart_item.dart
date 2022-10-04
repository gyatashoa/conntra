import 'package:contra/constants/api.dart';
import 'package:contra/constants/colors.dart';
import 'package:contra/model/cart.dart';
import 'package:contra/providers/cart_provider.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.cart}) : super(key: key);
  final Cart cart;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: Image.network(
                widget.cart.product.image ?? defaultImg,
                // height: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.cart.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: primaryDeepBlueText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  // Text("bottle of 500 pellets",
                  //     style: GoogleFonts.poppins(
                  //       color: primaryGreyText,
                  //       fontSize: 13.sp,
                  //       fontWeight: FontWeight.w400,
                  //     )),
                  addVerticalSpace(20.h),
                  Text("GHC ${widget.cart.product.price}",
                      style: GoogleFonts.poppins(
                        color: primaryDeepBlueText,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
            ),
            addHorizontalSpace(16.w),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .removeCart(widget.cart);
                      },
                      child: Iconify(
                        Uil.times_circle,
                        size: 25.sp,
                        color: Colors.black.withOpacity(0.25),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 95.sp,
                    height: 32.sp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.r),
                        color: Color(0xFFFFE8E5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .reduceProductCount(widget.cart);
                          },
                          child: ClipOval(
                            child: Container(
                              width: 32.sp,
                              height: 32.sp,
                              color: Color(0xFFFFC7BF),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${widget.cart.count}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        InkWell(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .increaseProductCount(widget.cart);
                          },
                          child: ClipOval(
                            child: Container(
                              width: 32.sp,
                              height: 32.sp,
                              color: Color(0xFFFF8B7B),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        addVerticalSpace(16.h),
        Divider(
          height: 1,
        ),
        addVerticalSpace(16.h),
      ],
    );
  }
}
