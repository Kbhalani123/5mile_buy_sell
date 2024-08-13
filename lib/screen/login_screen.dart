import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mile_locally/constant/app_constant.dart';
import 'package:mile_locally/google/google_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GoogleService service = GoogleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/localStuff.png',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[10],
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius:5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.grey.shade100), // Set your desired color
                    ),
                    onPressed: () {
                      _loginWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          child: Image.asset('assets/images/google.png'),
                        ),
                        Text(
                          'Login With Google',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ),
                /*
                FilledButton(
                  onPressed: () {
                    _loginWithFacebook(context);
                  },
                  child: Text('Facebook'),
                ),
        */
              ],
            ),
          ),
        ));
  }

  Future<void> _loginWithGoogle() async {
    GoogleSignInAccount? account = await service.signInWithGoogle();

    if (account == null) return;
    print('id : ${account.id}');
    print('email : ${account.email}');
    print('display name : ${account.displayName}');
    print('photo url : ${account.photoUrl}');

    GoogleSignInAuthentication auth = await account.authentication;
    print('access token : ${auth.accessToken}');
    print('id token : ${auth.idToken}');

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppConstant.homeView,
          (route) => false,
    );
  }

}