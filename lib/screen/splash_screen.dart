import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/google/google_service.dart';
import 'package:mile_locally/sharedpreferenece/pref_management.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      // var user = FirebaseAuth.instance.currentUser;
      if (!PrefUtils.getOnBoardingStatus()) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppConstant.introView, (route) => false);
      } else if (await GoogleService().checkSignedIn()) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppConstant.homeView, (route) => false);
            //context, AppConstant.splashView, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, AppConstant.loginView, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: 0.4,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Container(
                     height: 250,
                     width: 300,
                     child: Image(
                         image: AssetImage('assets/images/localStuff.png'),
                         ),
                   ),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                    strutStyle: StrutStyle(
                      fontSize: 50
                    ),
                   text: TextSpan(children:[
                     TextSpan(
                   text: '5',
                    style: TextStyle(color: Colors.pinkAccent.shade200,fontSize: 50,fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: 'Miles',style: TextStyle(color: Colors.black,fontSize: 50,letterSpacing: 2,fontWeight: FontWeight.bold)),


                   ])
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}