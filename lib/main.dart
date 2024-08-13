import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/firebase_options.dart';
import 'package:mile_locally/route/app_route.dart';
import 'package:mile_locally/sharedpreferenece/pref_management.dart';
import 'package:mile_locally/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppConstant.splashView,
      theme: AppTheme(context),
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}