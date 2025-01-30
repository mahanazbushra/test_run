

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_run/admin/admin.dart';
import 'package:test_run/Customer/home.dart';
import 'package:test_run/signup.dart';
import 'package:test_run/splashscreen.dart';
import 'package:test_run/verify_email_page.dart';

import 'Customer/controller_customer/product_cus_controller.dart';
import 'admin/contoller/product_controller.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCAI78Q59ZQCSyoCthgDIE1wvkS-n5Q3NQ",
            authDomain: "ecommerce-efdf9.firebaseapp.com",
            projectId: "ecommerce-efdf9",
            storageBucket: "ecommerce-efdf9.firebasestorage.app",
            messagingSenderId: "557469507425",
            appId: "1:557469507425:web:f1d28a7d5d90ad95cf6f20",
            measurementId: "G-KFJ5GBMTET"
          // apiKey: "AIzaSyCAI78Q59ZQCSyoCthgDIE1wvkS-n5Q3NQ",
          // authDomain: "ecommerce-efdf9.firebaseapp.com",
          // projectId: "ecommerce-efdf9",
          // storageBucket: "ecommerce-efdf9.firebasestorage.app",
          // messagingSenderId: "557469507425",
          // appId: "1:557469507425:web:fe31954f24f4717fcf6f20",
          // measurementId: "G-FME5V4DJ3F",
        ),
      );
    } else {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCG8BryJhYBnB8LFRUtoXJcKrHEXVKlLJY",
          authDomain: "ecommerce-efdf9.firebaseapp.com",
          projectId: "ecommerce-efdf9",
          storageBucket: "ecommerce-efdf9.firebasestorage.app",
          messagingSenderId: "557469507425",
          appId: "1:557469507425:android:540aba67b7807614cf6f20",
        ),
      );
    }

      await Supabase.initialize(
        url:'https://qfgzrzyqipfymbnatstk.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFmZ3pyenlxaXBmeW1ibmF0c3RrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyMzQwNTUsImV4cCI6MjA1MzgxMDA1NX0.Y3GnS2PbbMuhYTZPePuQu4I3AJcJwiUdz-ZE1cSjlq4',

      );

    Get.put(ProductController());
    Get.put(ProductCustomerController());

    runApp(const MyApp()); // Launch the application
  } catch (e) {
    print("Firebase initialization error: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: 'splash screen',

      routes: {
        'splash screen': (context) => SplashScreen(),
        'login': (context) => Mylogin(),
        'signUp': (context) => SignUp(),
        'home': (context) => HomeActivity(),
        'Verify Email' :(context) => VerifyEmailPage(),
       'Admin Dashboard' : (context) => Admin(),

        //'add-new-product':(context) => const AddNewProductScreen(),
        //'update-product':(context) => const UpdateProductScreen()

      },
    );
  }
}

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