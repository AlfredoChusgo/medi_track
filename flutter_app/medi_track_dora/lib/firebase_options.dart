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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB2IXUj2EXriqc18Sx-5dkFHeepHOXln1o',
    appId: '1:669323524427:web:52dad6918bc84c599210ce',
    messagingSenderId: '669323524427',
    projectId: 'medi-track-dora',
    authDomain: 'medi-track-dora.firebaseapp.com',
    databaseURL: 'https://medi-track-dora-default-rtdb.firebaseio.com',
    storageBucket: 'medi-track-dora.appspot.com',
    measurementId: 'G-JZGWESCKLP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz9TIdWDB9pZWbgefaoFjpQXNcF-rPvmo',
    appId: '1:669323524427:android:cd3e1130ae2e419d9210ce',
    messagingSenderId: '669323524427',
    projectId: 'medi-track-dora',
    databaseURL: 'https://medi-track-dora-default-rtdb.firebaseio.com',
    storageBucket: 'medi-track-dora.appspot.com',
  );
}
