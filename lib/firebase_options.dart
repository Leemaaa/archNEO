// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDIiis17IdsVUyIf7HP0v11LlO5VI1Xb7E',
    appId: '1:79287456473:web:1145ae3751e21f993c64c8',
    messagingSenderId: '79287456473',
    projectId: 'freelance-app-f192c',
    authDomain: 'freelance-app-f192c.firebaseapp.com',
    storageBucket: 'freelance-app-f192c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcT-aXVJ41Nbgg0x78wphWkJ2GXDvUHuA',
    databaseURL: 'https://getjob-ef46d.farebaseio.com/',
    appId: '1:182814081093:android:cf2a9b7687f47311f4e32c',
    messagingSenderId: '182814081093',
    projectId: 'getjob-ef46d',
    storageBucket: 'getjob-ef46d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC69N8cOW-ljoBIauYACAUxHYxDCisJ2pg',
    appId: '1:79287456473:ios:6c06e418cbe8c8f53c64c8',
    messagingSenderId: '79287456473',
    projectId: 'freelance-app-f192c',
    storageBucket: 'freelance-app-f192c.appspot.com',
    iosClientId: '79287456473-taun6ns6oktgrinh00ot065gs50lvval.apps.googleusercontent.com',
    iosBundleId: 'com.example.freelanceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC69N8cOW-ljoBIauYACAUxHYxDCisJ2pg',
    appId: '1:79287456473:ios:6c06e418cbe8c8f53c64c8',
    messagingSenderId: '79287456473',
    projectId: 'freelance-app-f192c',
    storageBucket: 'freelance-app-f192c.appspot.com',
    iosClientId: '79287456473-taun6ns6oktgrinh00ot065gs50lvval.apps.googleusercontent.com',
    iosBundleId: 'com.example.freelanceApp',
  );
}
