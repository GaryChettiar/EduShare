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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDC6hKfmVMBnfcySsoY-9ny3GkoLZf94pw',
    appId: '1:687297746176:android:da53536678d6a6d6d04fe5',
    messagingSenderId: '687297746176',
    projectId: 'edushare-59de0',
    storageBucket: 'edushare-59de0.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDtxXyLOrKbVgSdcrdwoVA9b3VEmREdatI',
    appId: '1:687297746176:web:89d096a6c0318fe3d04fe5',
    messagingSenderId: '687297746176',
    projectId: 'edushare-59de0',
    authDomain: 'edushare-59de0.firebaseapp.com',
    storageBucket: 'edushare-59de0.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0Qqd0QGEx1Ab3G7IrCzzNacxDBX-AhEk',
    appId: '1:687297746176:ios:4a618b3effe2fc53d04fe5',
    messagingSenderId: '687297746176',
    projectId: 'edushare-59de0',
    storageBucket: 'edushare-59de0.appspot.com',
    iosBundleId: 'com.example.edushare',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0Qqd0QGEx1Ab3G7IrCzzNacxDBX-AhEk',
    appId: '1:687297746176:ios:4a618b3effe2fc53d04fe5',
    messagingSenderId: '687297746176',
    projectId: 'edushare-59de0',
    storageBucket: 'edushare-59de0.appspot.com',
    iosBundleId: 'com.example.edushare',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDtxXyLOrKbVgSdcrdwoVA9b3VEmREdatI',
    appId: '1:687297746176:web:d427668edd02f869d04fe5',
    messagingSenderId: '687297746176',
    projectId: 'edushare-59de0',
    authDomain: 'edushare-59de0.firebaseapp.com',
    storageBucket: 'edushare-59de0.appspot.com',
  );

}