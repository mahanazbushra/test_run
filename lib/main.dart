// import 'package:firebase_core/firebase_core.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:project/signup.dart';
//
//
// import 'login.dart';
//
//
//   void main()  {
//
//
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     initialRoute: 'login',
//     routes: {
//       'login':(context)=>Mylogin(),
//       'signup': (context) => SignUp(),
//     },
//   ));
//
//
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_run/home.dart';
import 'package:test_run/signup.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB_Vj1Rn6sRf8PqlCJ8nKfOyaEgQ7o01Bw",
        authDomain: "setup-firebase-5048a.firebaseapp.com",
          projectId: "setup-firebase-5048a",
        storageBucket: "setup-firebase-5048a.firebasestorage.app",
          messagingSenderId: "963927760561",
          appId: "1:963927760561:android:2b724c78ee50bbb5f4cc90",
          measurementId: "G-W7G7NGWT8G",
      ),);
  }else{
    Firebase.initializeApp();
  }

  runApp(const MyApp());//application create
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',

      routes: {
        'login': (context) => Mylogin(),
        'signUp': (context) => SignUp(),
        'home': (context) => HomeActivity(),
      },
    );
  }
}