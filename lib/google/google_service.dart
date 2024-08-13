import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email'],
      serverClientId:
      '1042723318047-vns0c1pg43g1ms588969lr8dbatq7edn.apps.googleusercontent.com',
      clientId: Platform.isAndroid
          ? '1042723318047-sgujipdgeenufakpc05j8c4pd1gda8ef.apps.googleusercontent.com'
          : '1042723318047-nu5n6afhn51s2er46uq42fm937erjdu5.apps.googleusercontent.com');

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {
      print("Error occurred during Google Sign-In: $e");
      return null;
    }
  }

  Future<GoogleSignInAccount?> getUserInfo() async {
    try {
      return await _googleSignIn.signInSilently();
    } catch (e) {
      return null;
    }
  }

  Future<bool> logout() async {
    var account = await _googleSignIn.signOut();
    if (account != null) {
      print('account-0 : $account');
      return false;
    }
    print('account-1 : $account');
    return true;
  }

  Future<bool> checkSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}