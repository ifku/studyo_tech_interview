
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
    apiKey: 'AIzaSyDdIFdgfu57XQzBn0uHBL6OJZmMrICVbIs',
    appId: '1:60116051217:web:419fac2e40b9b9ff3758b0',
    messagingSenderId: '60116051217',
    projectId: 'studyo-tech-interview',
    authDomain: 'studyo-tech-interview.firebaseapp.com',
    storageBucket: 'studyo-tech-interview.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqg_xIVioi3TG1iE0q2VrUhrXjQ41mpp0',
    appId: '1:60116051217:android:3d0b286c534f95923758b0',
    messagingSenderId: '60116051217',
    projectId: 'studyo-tech-interview',
    storageBucket: 'studyo-tech-interview.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKx6XBKOBv99Pu-adsI46V9V8PZEizje0',
    appId: '1:60116051217:ios:0f396a2d5030cfe63758b0',
    messagingSenderId: '60116051217',
    projectId: 'studyo-tech-interview',
    storageBucket: 'studyo-tech-interview.appspot.com',
    iosBundleId: 'com.ifkusyoba.studyoTechInterview',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKx6XBKOBv99Pu-adsI46V9V8PZEizje0',
    appId: '1:60116051217:ios:0f396a2d5030cfe63758b0',
    messagingSenderId: '60116051217',
    projectId: 'studyo-tech-interview',
    storageBucket: 'studyo-tech-interview.appspot.com',
    iosBundleId: 'com.ifkusyoba.studyoTechInterview',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDdIFdgfu57XQzBn0uHBL6OJZmMrICVbIs',
    appId: '1:60116051217:web:1a7751e4c9487a203758b0',
    messagingSenderId: '60116051217',
    projectId: 'studyo-tech-interview',
    authDomain: 'studyo-tech-interview.firebaseapp.com',
    storageBucket: 'studyo-tech-interview.appspot.com',
  );
}
