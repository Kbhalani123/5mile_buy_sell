// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAq5FJQypsL1BgrE0XjeRT3aL14ZFXqhN4',
    appId: '1:592408313041:web:fa296ba7e039fc17ebd9f0',
    messagingSenderId: '592408313041',
    projectId: 'mile-locally',
    authDomain: 'mile-locally.firebaseapp.com',
    storageBucket: 'mile-locally.appspot.com',
    measurementId: 'G-88Y3WRD7QN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvr05AbYhwMG1tijiiYMzZ-Q3Zm0mvjNY',
    appId: '1:592408313041:android:68ba9a585931638cebd9f0',
    messagingSenderId: '592408313041',
    projectId: 'mile-locally',
    storageBucket: 'mile-locally.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKX4hZh68uBC8EluoJOAb4xctXnD99sLQ',
    appId: '1:592408313041:ios:c20c4f7757963f53ebd9f0',
    messagingSenderId: '592408313041',
    projectId: 'mile-locally',
    storageBucket: 'mile-locally.appspot.com',
    iosBundleId: 'com.example.mileLocally',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKX4hZh68uBC8EluoJOAb4xctXnD99sLQ',
    appId: '1:592408313041:ios:c20c4f7757963f53ebd9f0',
    messagingSenderId: '592408313041',
    projectId: 'mile-locally',
    storageBucket: 'mile-locally.appspot.com',
    iosBundleId: 'com.example.mileLocally',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAq5FJQypsL1BgrE0XjeRT3aL14ZFXqhN4',
    appId: '1:592408313041:web:008c6cdef01ad9b9ebd9f0',
    messagingSenderId: '592408313041',
    projectId: 'mile-locally',
    authDomain: 'mile-locally.firebaseapp.com',
    storageBucket: 'mile-locally.appspot.com',
    measurementId: 'G-GE3NLWHX4X',
  );
}
