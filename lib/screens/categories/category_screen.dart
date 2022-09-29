import 'package:contra/constants/colors.dart';
import 'package:contra/constants/sizing.dart';
import 'package:contra/data/temp_data.dart';
import 'package:contra/model/category.dart';
import 'package:contra/model/product.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/products/product_screen.dart';
import 'package:contra/service/api_service.dart';
import 'package:contra/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contra/widgets/products/product_card.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  static const String routeName = "/category";
  final Category category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = GetIt.instance<ApiService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconTheme.of(context).copyWith(color: primaryDeepBlueText),
        title: Text(widget.category.categoryName,
            style: GoogleFonts.poppins(
              color: primaryDeepBlueText,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: defaultHorizontalPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(18.h),
              // HighlightDealCard(),
              addVerticalSpace(18.h),
              Text("${widget.category.categoryName} Products",
                  style: GoogleFonts.poppins(
                    color: primaryDeepBlueText,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  )),
              addVerticalSpace(16.h),
              FutureBuilder(
                  future: _apiService.getProductsForACategory(
                      token:
                          Provider.of<UserProvider>(context).getUser?.token ??
                              '',
                      category: widget.category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error getting data'),
                      );
                    }
                    if (snapshot.hasData) {
                      return _buildCategorySubCategories(
                          context, snapshot.data as List<Product>);
                    }
                    return Container();
                  }),
              addVerticalSpace(16.h),
              Text(
                "All Products",
                style: GoogleFonts.poppins(
                  color: primaryDeepBlueText,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              addVerticalSpace(24.h),
              FutureBuilder(
                  future: _apiService.getProducts(
                    token:
                        Provider.of<UserProvider>(context).getUser?.token ?? '',
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error getting data'),
                      );
                    }
                    if (snapshot.hasData) {
                      return _buildAllProductsRow(
                          snapshot.data as List<Product>);
                    }
                    return Container();
                  }),
              addVerticalSpace(10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySubCategories(
      BuildContext context, List<Product> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            products.map((e) => _buildSubCategoryCard(context, e)).toList(),
      ),
    );
  }

  Widget _buildSubCategoryCard(BuildContext context, Product product) {
    return Container(
      margin: EdgeInsets.only(right: 17.w),
      width: 110.w,
      height: 162.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color(0xFFF5F7FA),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductScreen(product: product)));
        },
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 99.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                child: Image.asset(
                  product.image ?? "assets/images/drug_images/pills_bottle.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            addVerticalSpace(14.h),
            Text(product.name,
                style: GoogleFonts.poppins(
                  color: primaryDeepBlueText,
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildAllProductsRow(List<Product> products) {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 250.h,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 20.w,
          childAspectRatio: 2),
      children: products.map((e) => ProductCard(product: e)).toList(),
    );
  }
}
