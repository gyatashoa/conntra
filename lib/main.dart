import 'package:contra/model/category.dart';
import 'package:contra/model/gender.dart';
import 'package:contra/model/user.dart';
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
import 'package:contra/service/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contra/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:contra/screens/categories/category_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/stripe_api_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  Stripe.publishableKey = stripePublishableKey;
  await Hive.initFlutter();
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(UserAdapter());
  registerServices();
  await getIt.allReady();
  final res = GetIt.instance<StorageService>().getUser;
  bool isLoggedIn = false;
  if (res != null) {
    isLoggedIn = true;
  }
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    user: res,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final User? user;
  const MyApp({Key? key, required this.isLoggedIn, required this.user})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
          isLoggedIn
              ? ChangeNotifierProvider<UserProvider>(
                  create: (_) => UserProvider(user: user))
              : ChangeNotifierProvider<UserProvider>(
                  create: (_) => UserProvider())
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
            initialRoute: isLoggedIn
                ? BottomNavScreen.routeName
                : OnBoardingStart.routeName,
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
