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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDk32FM9qh-PT-C7sj0_bWivhgGRQ61lxo',
    appId: '1:327538148956:web:41de69f1d76f6c31508899',
    messagingSenderId: '327538148956',
    projectId: 'truly-social-project',
    authDomain: 'truly-social-project.firebaseapp.com',
    storageBucket: 'truly-social-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeBIEoxzWgHf1SPYHQovAU-9rimdOatx4',
    appId: '1:327538148956:android:66417c799b219b96508899',
    messagingSenderId: '327538148956',
    projectId: 'truly-social-project',
    storageBucket: 'truly-social-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPdgmanQtllew4kov7R5DEz0MxqRZ4Z40',
    appId: '1:327538148956:ios:916455c394ac4615508899',
    messagingSenderId: '327538148956',
    projectId: 'truly-social-project',
    storageBucket: 'truly-social-project.appspot.com',
    iosClientId: '327538148956-n6khthujo56r87n69na8lkdiopsdcfko.apps.googleusercontent.com',
    iosBundleId: 'com.example.trulysocial',
  );
}