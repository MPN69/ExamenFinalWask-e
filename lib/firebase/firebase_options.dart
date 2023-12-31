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
    apiKey: 'AIzaSyBQNTWVl5fL9OYdjHQ9wJqQMJzGp65_31o',
    appId: '1:160018509544:web:4b50f94696e09ae277235d',
    messagingSenderId: '160018509544',
    projectId: 'game-store-9a13f',
    authDomain: 'game-store-9a13f.firebaseapp.com',
    storageBucket: 'game-store-9a13f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7E71jOtJ4kVsMGZYjlbbe8kEBlIDh1_o',
    appId: '1:160018509544:android:78f0510abbd68e6677235d',
    messagingSenderId: '160018509544',
    projectId: 'game-store-9a13f',
    storageBucket: 'game-store-9a13f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDciV8ZnXpsv6FYJyYWE0ZYnSppWOTv6To',
    appId: '1:160018509544:ios:91fa5363e3fea24a77235d',
    messagingSenderId: '160018509544',
    projectId: 'game-store-9a13f',
    storageBucket: 'game-store-9a13f.appspot.com',
    iosClientId: '160018509544-rlrbeh0m592uh2gcqgmkfs8pc1l5hj9q.apps.googleusercontent.com',
    iosBundleId: 'com.example.waskeFinalExam',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDciV8ZnXpsv6FYJyYWE0ZYnSppWOTv6To',
    appId: '1:160018509544:ios:53a882008dcb3e9c77235d',
    messagingSenderId: '160018509544',
    projectId: 'game-store-9a13f',
    storageBucket: 'game-store-9a13f.appspot.com',
    iosClientId: '160018509544-n0sbv8f2tbid7p1au5bfujphu6pjdp5f.apps.googleusercontent.com',
    iosBundleId: 'com.example.waskeFinalExam.RunnerTests',
  );
}
