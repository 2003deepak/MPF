import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS: // Adding support for iOS
        return ios;
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

  // Web Firebase Configuration
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBMr1z44kf0gD8BMB-QkTFyxinNJ9vhgU8',
    authDomain: 'flutter-prac8.firebaseapp.com',
    projectId: 'flutter-prac8',
    storageBucket: 'flutter-prac8.firebasestorage.app',
    messagingSenderId: '65562615851',
    appId: '1:65562615851:web:659790c3780f774328ca6e',
  );

  // Android Firebase Configuration
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdFwxMY97loV-ysvtqJe2zCuDpR7edWYc',
    appId: '1:65562615851:android:3bbd82f2bb427ad228ca6e',
    messagingSenderId: '65562615851',
    projectId: 'flutter-prac8',
    storageBucket: 'flutter-prac8.firebasestorage.app',
  );

  // iOS Firebase Configuration (Add this if you need iOS support)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2JTk3czLKx69BY9LTv5hH84J9AlnxJCo',
    appId: '1:65562615851:ios:9abacbc0b505d13fe4a3ed',
    messagingSenderId: '65562615851',
    projectId: 'flutter-prac8',
    storageBucket: 'flutter-prac8.firebasestorage.app',
  );
}
