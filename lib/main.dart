import 'package:contra/model/category.dart';
import 'package:contra/providers/cart_provider.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/auth/login_screen.dart';
import 'package:contra/screens/auth/register.dart';
import 'package:contra/screens/auth/signup_screen.dart';
import 'package:contra/screens/cart/cart_screen.dart';
import 'package:contra/screens/home/bottom_nav_screen.dart';
import 'package:contra/screens/on_boarding/on_boarding_start.dart';
import 'package:contra/screens/payment/payment_confirm_screen.dart';
import 'package:contra/screens/payment/payment_screen.dart';
import 'package:contra/screens/products/product_screen.dart';
import 'package:contra/service/locator.dart';
import 'package:flutter/material.dart';
import 'package:contra/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contra/screens/categories/category_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  registerServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider())
        ],
        child: MaterialApp(
            title: 'NewRX',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //  TODO: Setup theme
              primaryColor: primaryColor,
              textTheme: GoogleFonts.poppinsTextTheme(),
              primaryTextTheme: GoogleFonts.poppinsTextTheme(),
              iconTheme:
                  IconTheme.of(context).copyWith(color: primaryDeepBlueText),
              colorScheme:
                  Theme.of(context).colorScheme.copyWith(primary: primaryColor),
            ),
            initialRoute: OnBoardingStart.routeName,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case OnBoardingStart.routeName:
                  return MaterialPageRoute(
                    builder: (context) {
                      return OnBoardingStart();
                    },
                  );

                case SignUpScreen.routeName:
                  return MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  );
                case Register.routeName:
                  return MaterialPageRoute(
                    builder: (context) => Register(),
                  );

                case BottomNavScreen.routeName:
                  return MaterialPageRoute(
                    builder: (context) => BottomNavScreen(),
                  );

                case CategoryScreen.routeName:
                  final args = settings.arguments as Map;

                  return MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      category: args["category"] as Category,
                    ),
                  );

                // case ProductScreen.routeName:
                //   return MaterialPageRoute(
                //     builder: (context) => ProductScreen(),
                //   );

                // case CartScreen.routeName:
                //   return MaterialPageRoute(
                //     builder: (context) => CartScreen(),
                //   );
                case PaymentScreen.routeName:
                  return MaterialPageRoute(
                    builder: (context) => PaymentScreen(),
                  );
                case PaymentConfirmScreen.routeName:
                  return MaterialPageRoute(
                    builder: (context) => PaymentConfirmScreen(),
                  );
                case LoginScreen.routeName:
                  return MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  );

                default:
                  return null;
              }
            }),
      ),
    );
  }
}
