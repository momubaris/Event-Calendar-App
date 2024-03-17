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
    apiKey: 'AIzaSyBzWRcd7ugpCNa-GCv_D-e0G7tn9MzhTLo',
    appId: '1:232069170974:web:f225bc40ac73f1a2602b0f',
    messagingSenderId: '232069170974',
    projectId: 'event-management-91ad1',
    authDomain: 'event-management-91ad1.firebaseapp.com',
    storageBucket: 'event-management-91ad1.appspot.com',
    measurementId: 'G-95MQQR15JT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvHpnOT_UhyDzkyonxd-ylO0NYB7QvNvg',
    appId: '1:232069170974:android:d7691969ba078c5c602b0f',
    messagingSenderId: '232069170974',
    projectId: 'event-management-91ad1',
    storageBucket: 'event-management-91ad1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBtNT3YJGqkt77X3dJ5HBUm48fvAwQD7Y',
    appId: '1:232069170974:ios:273ba5e44fcace09602b0f',
    messagingSenderId: '232069170974',
    projectId: 'event-management-91ad1',
    storageBucket: 'event-management-91ad1.appspot.com',
    iosBundleId: 'com.example.eventManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBtNT3YJGqkt77X3dJ5HBUm48fvAwQD7Y',
    appId: '1:232069170974:ios:45ffe740eb72f056602b0f',
    messagingSenderId: '232069170974',
    projectId: 'event-management-91ad1',
    storageBucket: 'event-management-91ad1.appspot.com',
    iosBundleId: 'com.example.eventManagement.RunnerTests',
  );
}
