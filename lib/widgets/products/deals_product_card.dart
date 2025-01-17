import 'package:contra/constants/api.dart';
import 'package:contra/model/product.dart';
import 'package:contra/screens/products/product_screen.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DealsProductCard extends StatelessWidget {
  final Product product;
  const DealsProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProductScreen(
                    product: product,
                  ))),
      child: Container(
        width: 180.w,
        height: 250.h,
        margin: EdgeInsets.only(right: 17.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0.r),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.03),
              offset: Offset(0.0, 3.0),
              blurRadius: 13.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 154.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0.r),
                color: Color(0xFFEEEEF0),
              ),
              child: Image.network(
                product.image ?? defaultImg,
                width: 20.w,
                height: 130.h,
                fit: BoxFit.contain,
              ),
            ),
            addVerticalSpace(14.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 13.0.sp, height: 1.46),
                  ),
                  addVerticalSpace(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      // Text(
                      //   "GHC ${product.price}",
                      //   style: const TextStyle(
                      //     fontSize: 16.0,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                      Container(
                        width: 48.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(20.r)),
                          color: Color(0xFFFFC000),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 16.sp),
                            addHorizontalSpace(3.0.w),
                            Text(
                              "4.2",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
