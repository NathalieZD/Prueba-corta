
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

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
    apiKey: 'AIzaSyD-zkd1S9YlIa_bOJy4oGnMtT2fodSTeaE',
    appId: '1:796478446037:web:aa599977289e3ecf09855c',
    messagingSenderId: '796478446037',
    projectId: 'citasmedicas-fefa5',
    authDomain: 'citasmedicas-fefa5.firebaseapp.com',
    storageBucket: 'citasmedicas-fefa5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACjOztQlxBdVqRUysdSRu8o7bkiEgALco',
    appId: '1:796478446037:android:80768c30f68693e109855c',
    messagingSenderId: '796478446037',
    projectId: 'citasmedicas-fefa5',
    storageBucket: 'citasmedicas-fefa5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_9iEI543CG6y7nZohvfqUKqQRbhpKtXg',
    appId: '1:796478446037:ios:cedd1787fdb470d609855c',
    messagingSenderId: '796478446037',
    projectId: 'citasmedicas-fefa5',
    storageBucket: 'citasmedicas-fefa5.appspot.com',
    iosBundleId: 'com.example.prueba2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_9iEI543CG6y7nZohvfqUKqQRbhpKtXg',
    appId: '1:796478446037:ios:cedd1787fdb470d609855c',
    messagingSenderId: '796478446037',
    projectId: 'citasmedicas-fefa5',
    storageBucket: 'citasmedicas-fefa5.appspot.com',
    iosBundleId: 'com.example.prueba2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-zkd1S9YlIa_bOJy4oGnMtT2fodSTeaE',
    appId: '1:796478446037:web:ece3444ced15a7c209855c',
    messagingSenderId: '796478446037',
    projectId: 'citasmedicas-fefa5',
    authDomain: 'citasmedicas-fefa5.firebaseapp.com',
    storageBucket: 'citasmedicas-fefa5.appspot.com',
  );
}
