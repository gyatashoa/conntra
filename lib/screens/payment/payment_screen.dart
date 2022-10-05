import 'package:contra/constants/colors.dart';
import 'package:contra/constants/sizing.dart';
import 'package:contra/constants/stripe_api_key.dart';
import 'package:contra/model/cart.dart';
import 'package:contra/model/order.dart';
import 'package:contra/providers/cart_provider.dart';
import 'package:contra/providers/user_provider.dart';
import 'package:contra/screens/payment/payment_confirm_screen.dart';
import 'package:contra/service/cloud_firestore_service.dart';
import 'package:contra/utils/ui.dart';
import 'package:contra/widgets/gloabal/cc_elevated_button.dart';
import 'package:contra/widgets/payment/address_tile.dart';
import 'package:contra/widgets/payment/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  static const routeName = '/paymentSelect';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = "cc";

  Map<String, dynamic>? paymentIntent;
  bool isLoading = false;

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment(String amount, Order order) async {
    try {
      setState(() {
        isLoading = true;
      });
      paymentIntent = await createPaymentIntent(amount, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(order);
    } catch (e, s) {
      print('exception:$e$s');
      setState(() {
        false;
      });
    }
  }

  displayPaymentSheet(Order order) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await GetIt.instance<CloudFirestoreService>().placeOrder(order);
        setState(() {
          false;
        });
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                )).then((value) {
          delAddress = null;
          Provider.of<CartProvider>(context, listen: false).clear();
          Navigator.pushNamed(context, PaymentConfirmScreen.routeName);
        });
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
        setState(() {
          false;
        });
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
      setState(() {
        false;
      });
    } catch (e) {
      print('$e');
      setState(() {
        false;
      });
    }
  }

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
                      title: "Credit card",
                      imgPath: "cc",
                      groupValue: selectedPaymentMethod,
                      value: "cc",
                      onChange: (value) {},
                    ),
                    PaymentTile(
                      title: "VODAFONE CASH",
                      imgPath: "vodafone_cash",
                      groupValue: selectedPaymentMethod,
                      value: "vodafone",
                      onChange: (value) {},
                    ),
                    PaymentTile(
                      title: "AIRTEL TIGO MONEY",
                      imgPath: "airtel",
                      groupValue: selectedPaymentMethod,
                      value: "airtel",
                      onChange: (value) {},
                    ),
                    PaymentTile(
                      title: "MTN MOBILE MONEY",
                      imgPath: "mtn",
                      groupValue: selectedPaymentMethod,
                      value: "mtn",
                      onChange: (value) {},
                    ),
                    PaymentTile(
                      title: "Cash",
                      imgPath: "ghpay",
                      groupValue: selectedPaymentMethod,
                      value: "cash",
                      onChange: (value) {},
                    ),
                  ],
                ),
              ),
              addVerticalSpace(70.h),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CCElevatedButton(
                      text: "Place Order",
                      onPress: () async {
                        if (delAddress == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content:
                                      Text('Please selection a destination')));
                          return;
                        }
                        await makePayment(
                            Provider.of<CartProvider>(context, listen: false)
                                .computePrice
                                .toInt()
                                .toString(),
                            Order(
                                id: '',
                                createdAt: DateTime.now(),
                                cart: Provider.of<CartProvider>(context,
                                        listen: false)
                                    .products,
                                price: Provider.of<CartProvider>(context,
                                        listen: false)
                                    .computePrice,
                                email: Provider.of<UserProvider>(context,
                                            listen: false)
                                        .getUser
                                        ?.email ??
                                    '',
                                location: delAddress ?? ''));
                      }),
              addVerticalSpace(30.h),
            ],
          ),
        );
      }),
    );
  }
}

String? delAddress;
