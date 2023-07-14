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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBniC6MzG-IeO0OpMrfQtmc4VsqQzRcxKM',
    appId: '1:440274112073:web:2b9a9f1c00337938c1b998',
    messagingSenderId: '440274112073',
    projectId: 'messengerapp-d2d51',
    authDomain: 'messengerapp-d2d51.firebaseapp.com',
    storageBucket: 'messengerapp-d2d51.appspot.com',
    measurementId: 'G-ZV4L019BY6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUyd5JFATTNB8Hfpk8MXdD4RAeva_04nw',
    appId: '1:440274112073:android:ecb7959f5aa128ddc1b998',
    messagingSenderId: '440274112073',
    projectId: 'messengerapp-d2d51',
    storageBucket: 'messengerapp-d2d51.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5sQXTenamBuDhTV3Un8GhLxerC-yWATo',
    appId: '1:440274112073:ios:3d5f620bdb3d97aec1b998',
    messagingSenderId: '440274112073',
    projectId: 'messengerapp-d2d51',
    storageBucket: 'messengerapp-d2d51.appspot.com',
    iosClientId:
        '440274112073-8hd9blokmnrsbuvlfpdf4db2rva9k08e.apps.googleusercontent.com',
    iosBundleId: 'com.example.messengerapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5sQXTenamBuDhTV3Un8GhLxerC-yWATo',
    appId: '1:440274112073:ios:2fb42cb40029a8c6c1b998',
    messagingSenderId: '440274112073',
    projectId: 'messengerapp-d2d51',
    storageBucket: 'messengerapp-d2d51.appspot.com',
    iosClientId:
        '440274112073-tic6e7v1f2ud9fl3247oind4bu4lihm3.apps.googleusercontent.com',
    iosBundleId: 'com.example.messengerapp.RunnerTests',
  );
}
