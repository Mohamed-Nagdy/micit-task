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
    apiKey: 'AIzaSyCJ1BSEYiLtH7Xo2dQmKCQ4gsU7tnuNUV0',
    appId: '1:57277552174:web:7e67aeffe2f00555dbb1bf',
    messagingSenderId: '57277552174',
    projectId: 'licit-task',
    authDomain: 'licit-task.firebaseapp.com',
    storageBucket: 'licit-task.appspot.com',
    measurementId: 'G-TDL2K1NFCC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFA6Y5UGbtEl9FroCgAZUIQdlhFqnnDJQ',
    appId: '1:57277552174:android:654491f8085e5c71dbb1bf',
    messagingSenderId: '57277552174',
    projectId: 'licit-task',
    storageBucket: 'licit-task.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcL4x74lgrwTcQxze9Muye7mul3VOVm-M',
    appId: '1:57277552174:ios:15ceff0436020e3cdbb1bf',
    messagingSenderId: '57277552174',
    projectId: 'licit-task',
    storageBucket: 'licit-task.appspot.com',
    iosClientId: '57277552174-25qc2f76aoc499m7du24ib5sprt1gv6l.apps.googleusercontent.com',
    iosBundleId: 'com.micit.task',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcL4x74lgrwTcQxze9Muye7mul3VOVm-M',
    appId: '1:57277552174:ios:15ceff0436020e3cdbb1bf',
    messagingSenderId: '57277552174',
    projectId: 'licit-task',
    storageBucket: 'licit-task.appspot.com',
    iosClientId: '57277552174-25qc2f76aoc499m7du24ib5sprt1gv6l.apps.googleusercontent.com',
    iosBundleId: 'com.micit.task',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJ1BSEYiLtH7Xo2dQmKCQ4gsU7tnuNUV0',
    appId: '1:57277552174:web:f34dacd024709487dbb1bf',
    messagingSenderId: '57277552174',
    projectId: 'licit-task',
    authDomain: 'licit-task.firebaseapp.com',
    storageBucket: 'licit-task.appspot.com',
    measurementId: 'G-WQTPMWQPLB',
  );

}