import 'package:flutter/material.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/model/current_user.dart';
import 'package:mile_locally/model/gridData.dart';
import 'package:mile_locally/model/product.dart';
import 'package:mile_locally/screen/add_address/add_address.dart';
import 'package:mile_locally/screen/add_address/view_address.dart';
import 'package:mile_locally/screen/buy_screen.dart';
import 'package:mile_locally/screen/category_product/category_productList.dart';
import 'package:mile_locally/screen/home_screen.dart';
import 'package:mile_locally/screen/login_screen.dart';
import 'package:mile_locally/screen/payment.dart';
import 'package:mile_locally/screen/productList/productList_screen.dart';
import 'package:mile_locally/screen/productList/products/product_screen.dart';
import 'package:mile_locally/screen/soldProduct.dart';
import 'package:mile_locally/screen/splash_screen.dart';

import '../screen/introScreen/intro_screen.dart';
class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstant.splashView:
        return MaterialPageRoute(
          builder: (context) => SplashView(),
        );

      case AppConstant.introView:
        return MaterialPageRoute(
          builder: (context) => IntroView(),
        );

      case AppConstant.loginView:
        return MaterialPageRoute(
          builder: (context) => LoginView(),
        );

      case AppConstant.homeView:
        return MaterialPageRoute(
          builder: (context) => HomeView(),
        );

      case AppConstant.buyView:
        Product? product =
        settings.arguments != null ? settings.arguments as Product : null;
        return MaterialPageRoute(
          builder: (context) => BuyView(product),
        );

      case AppConstant.catagoryViseProduct:
        HomeGridData? homeGridData = settings.arguments != null
            ? settings.arguments as HomeGridData
            : null;
        return MaterialPageRoute(
          builder: (context) => CategoryViseProductView(homeGridData!),
        );

      case AppConstant.paymentView:
        Product? product =
        settings.arguments != null ? settings.arguments as Product : null;
        return MaterialPageRoute(
          builder: (context) =>
              PaymentView(product: product),
        );

      case AppConstant.addressView:
        return MaterialPageRoute(
          builder: (context) => AddressView(),
        );

      case AppConstant.addAddress:
        CurrentUserData? currentUserData = settings.arguments != null
            ? settings.arguments as CurrentUserData
            : null;
        return MaterialPageRoute(
          builder: (context) => AddAddress(currentUserData),
        );

      case AppConstant.productListView:
        return MaterialPageRoute(
          builder: (context) => ProductListView(),
        );

      case AppConstant.soldProductListView:
        return MaterialPageRoute(
          builder: (context) => SoldProductListView(),
        );

      case AppConstant.productView:
        Product? product =
        settings.arguments != null ? settings.arguments as Product : null;
        return MaterialPageRoute(
          builder: (context) => ProductView(product),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashView(),
        );
    }
  }
}