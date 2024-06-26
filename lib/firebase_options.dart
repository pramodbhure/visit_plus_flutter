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
    apiKey: 'AIzaSyCZlXu1BOHy6z1RNa-sSeSJa5VKA1qHy-g',
    appId: '1:963373003153:android:37b54a70f0a370e1fbea30',
    messagingSenderId: '349815328227',
    projectId: 'visit-plus-app',
    authDomain: 'visit-plus-app.firebaseapp.com',
    storageBucket: 'visit-plus-app.appspot.com',
    measurementId: 'G-751FFKWB0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZlXu1BOHy6z1RNa-sSeSJa5VKA1qHy-g',
    appId: '1:963373003153:android:37b54a70f0a370e1fbea30',
    messagingSenderId: '349815328227',
    projectId: 'visit-plus-app',
    storageBucket: 'visit-plus-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBr934slZ7p9PRhGmj15xByV8NkBAKvLKY',
    appId: '1:349815328227:ios:1bd0a913a75d2a8138a4d6',
    messagingSenderId: '349815328227',
    projectId: 'visit-plus-app',
    storageBucket: 'visit-plus-app.appspot.com',
    iosBundleId: 'com.example.visitplusapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBr934slZ7p9PRhGmj15xByV8NkBAKvLKY',
    appId: '1:349815328227:ios:1bd0a913a75d2a8138a4d6',
    messagingSenderId: '349815328227',
    projectId: 'visit-plus-app',
    storageBucket: 'visit-plus-app.appspot.com',
    iosBundleId: 'com.example.visitplusapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZlXu1BOHy6z1RNa-sSeSJa5VKA1qHy-g',
    appId: '1:349815328227:web:667456c04810326838a4d6',
    messagingSenderId: '349815328227',
    projectId: 'visit-plus-app',
    authDomain: 'visit-plus-app.firebaseapp.com',
    storageBucket: 'visit-plus-app.appspot.com',
    measurementId: 'G-8XBYC94CF2',
  );
}
