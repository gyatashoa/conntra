import 'package:contra/constants/colors.dart';
import 'package:contra/data/temp_data.dart';
import 'package:contra/model/category.dart';
import 'package:contra/model/product.dart';
import 'package:contra/model/user.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/cart/cart_screen.dart';
import 'package:contra/service/api_service.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:contra/widgets/products/top_category_chip.dart';
import 'package:contra/widgets/products/deals_product_card.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/products/highlight_deal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiService _apiService;
  @override
  void initState() {
    super.initState();
    _apiService = GetIt.instance<ApiService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FBFF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _buildTopBar(),
            Padding(
              padding: EdgeInsets.only(left: 24.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(189.h),
                  //  Search text field
                  _buildSearchField(),
                  addVerticalSpace(24.h),
                  Text(
                    "Top Categories",
                    style: GoogleFonts.overpass(
                      color: Color(0xFF1A2D5D),
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addVerticalSpace(8.h),
                  FutureBuilder(
                      future: _apiService.getCategories(
                          token: Provider.of<UserProvider>(context)
                                  .getUser
                                  ?.token ??
                              ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error while getting data'));
                        }
                        if (snapshot.hasData) {
                          return _buildCategoriesList(
                              snapshot.data as List<Category>);
                        }
                        return Container();
                      }),
                  addVerticalSpace(23.h),
                  HighlightDealCard(),
                  addVerticalSpace(24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deals of the Day",
                        style: GoogleFonts.overpass(
                          color: primaryDeepBlueText,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "More",
                          style: GoogleFonts.overpass(
                              color: Color(0xFF1A2D5D),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: _apiService.getProducts(
                          token: Provider.of<UserProvider>(context)
                                  .getUser
                                  ?.token ??
                              ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error getting data'),
                          );
                        }
                        if (snapshot.hasData) {
                          return _buildDealsList(
                              (snapshot.data as List<Product>).sublist(0, 4));
                        }
                        return Container();
                      }),
                  addVerticalSpace(24.h),
                  Text(
                    "Featured Brands",
                    style: GoogleFonts.overpass(
                      color: Color(0xFF1A2D5D),
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  addVerticalSpace(16.h),
                  _buildBrandsList(),
                  addVerticalSpace(24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
          gradient:
              linearGradient(179.71, ["#FF8B7B 0.25%", "#6C7BEB 115.87%"])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(52.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Container(
                  width: 42.h,
                  height: 42.h,
                  color: Colors.white,
                  child: Icon(Icons.person),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined,
                              color: primaryDeepBlueText),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CartScreen())),
                        ),
                        Positioned(
                          right: 10,
                          top: 5,
                          child: ClipOval(
                              child: Container(
                            color: Colors.red,
                            width: 15.sp,
                            height: 15.sp,
                            child: Consumer<CartProvider>(
                                builder: (context, value, child) {
                              return Center(
                                child: Text(
                                  value.products.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            }),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          addVerticalSpace(18.h),
          Consumer<UserProvider>(
            builder: (_, value, child) => Text(
              "Hi ${value.getUser?.name}",
              style: GoogleFonts.overpass(
                color: Color(0xFF1A2D5D),
                fontSize: 24.0.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          addVerticalSpace(3.h),
          Text(
            "Welcome to NewRx",
            style: GoogleFonts.overpass(
              color: Color(0xFF1A2D5D),
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          addVerticalSpace(45.h),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 60.h,
      padding: EdgeInsets.only(right: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(56.r),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF000000).withOpacity(0.07),
            offset: Offset(0.0, 6.0),
            blurRadius: 14.0,
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Search Medicine & Healthcare products",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(56.r),
              borderSide: BorderSide.none),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }

  List<Color> colors = [Colors.red, Colors.yellowAccent, Colors.blue];

  Widget _buildCategoriesList(List<Category> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: categories
              .asMap()
              .map((i, value) => MapEntry(
                  i,
                  TopCategoryChip(
                      color: colors[i],
                      category: categories[i],
                      imgUrl: 'img_1',
                      title: value.categoryName,
                      bg: linearGradient(180, ["#FF9598 0%", "#FF70A7 100%"]))))
              .values
              .toList()
          // [
          //   TopCategoryChip(
          //       imgUrl: "img",
          //       title: "Dental",
          //       bg: linearGradient(180, ["#FF9598 0%", "#FF70A7 100%"])),
          // TopCategoryChip(
          //     imgUrl: "img_1",
          //     title: "Wellness",
          //     bg: linearGradient(180, ["#19E5A5 0%", "#15BD92 100%"])),
          // TopCategoryChip(
          //     imgUrl: "img_2",
          //     title: "Homeo",
          //     bg: linearGradient(180, ["#FFC06F 0%", "#FF793A 100%"])),
          // TopCategoryChip(
          //     imgUrl: "img_3",
          //     title: "Eye\ncare",
          //     bg: linearGradient(180, ["#4DB7FF 0%", "#3E7DFF 100%"])),
          // TopCategoryChip(
          //     imgUrl: "img_5",
          //     title: "Skin & Hair",
          //     bg: linearGradient(180, ["#828282 0%", "#090F47 100%"])),
          // ],
          ),
    );
  }

  Widget _buildDealsList(List<Product> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((e) => DealsProductCard(product: e)).toList(),
      ),
    );
  }

  Widget _buildBrandsList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 80.sp,
                    height: 80.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.05),
                          offset: Offset(0.0, 7.0),
                          blurRadius: 13.0,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/brand_logos/brand3.png",
                        height: 15.h, fit: BoxFit.contain),
                  ),
                ),
                addVerticalSpace(8.h),
                Text(
                  "Accu-Check",
                  style: GoogleFonts.overpass(
                      color: primaryDeepBlueText,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 80.sp,
                    height: 80.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.05),
                          offset: Offset(0.0, 7.0),
                          blurRadius: 13.0,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/brand_logos/brand3.png",
                        height: 15.h, fit: BoxFit.contain),
                  ),
                ),
                addVerticalSpace(8.h),
                Text(
                  "Roche",
                  style: GoogleFonts.overpass(
                      color: primaryDeepBlueText,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 80.sp,
                    height: 80.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.05),
                          offset: Offset(0.0, 7.0),
                          blurRadius: 13.0,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/brand_logos/brand3.png",
                        height: 15.h, fit: BoxFit.contain),
                  ),
                ),
                addVerticalSpace(8.h),
                Text(
                  "Ferring",
                  style: GoogleFonts.overpass(
                      color: primaryDeepBlueText,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 80.sp,
                    height: 80.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.05),
                          offset: Offset(0.0, 7.0),
                          blurRadius: 13.0,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/brand_logos/brand3.png",
                        height: 15.h, fit: BoxFit.contain),
                  ),
                ),
                addVerticalSpace(8.h),
                Text(
                  "Novartis",
                  style: GoogleFonts.overpass(
                      color: primaryDeepBlueText,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                ClipOval(
                  child: Container(
                    width: 80.sp,
                    height: 80.sp,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0xFF000000).withOpacity(0.05),
                          offset: Offset(0.0, 7.0),
                          blurRadius: 13.0,
                        ),
                      ],
                    ),
                    child: Image.asset("assets/images/brand_logos/brand3.png",
                        height: 15.h, fit: BoxFit.contain),
                  ),
                ),
                addVerticalSpace(8.h),
                Text(
                  "Accu-Check",
                  style: GoogleFonts.overpass(
                      color: primaryDeepBlueText,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
