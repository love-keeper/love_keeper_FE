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
    apiKey: 'AIzaSyAQaF9aLPRfbVYqV8Gqd6cVfror2UxME_I',
    appId: '1:774761664851:web:22266e5f42d9176da691a6',
    messagingSenderId: '774761664851',
    projectId: 'lovekeeper-bebc0',
    authDomain: 'lovekeeper-bebc0.firebaseapp.com',
    storageBucket: 'lovekeeper-bebc0.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC7ZA2YJMoAoiXlgrLGX2ZrkYTXKZsp9c',
    appId: '1:774761664851:android:d3b898d09574f666a691a6',
    messagingSenderId: '774761664851',
    projectId: 'lovekeeper-bebc0',
    storageBucket: 'lovekeeper-bebc0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7XztSWDu4UlGaEq_QmbmxU0r3XMEMHlY',
    appId: '1:774761664851:ios:9d4567f8d6122160a691a6',
    messagingSenderId: '774761664851',
    projectId: 'lovekeeper-bebc0',
    storageBucket: 'lovekeeper-bebc0.firebasestorage.app',
    iosBundleId: 'com.example.loveKeeper',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7XztSWDu4UlGaEq_QmbmxU0r3XMEMHlY',
    appId: '1:774761664851:ios:9d4567f8d6122160a691a6',
    messagingSenderId: '774761664851',
    projectId: 'lovekeeper-bebc0',
    storageBucket: 'lovekeeper-bebc0.firebasestorage.app',
    iosBundleId: 'com.example.loveKeeper',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAQaF9aLPRfbVYqV8Gqd6cVfror2UxME_I',
    appId: '1:774761664851:web:5a511693d2ff7188a691a6',
    messagingSenderId: '774761664851',
    projectId: 'lovekeeper-bebc0',
    authDomain: 'lovekeeper-bebc0.firebaseapp.com',
    storageBucket: 'lovekeeper-bebc0.firebasestorage.app',
  );
}
