// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'home.dart';
// import 'login.dart';
//
// class MainPage extends StatelessWidget{
//   const MainPage ({Key? key}) : super (key: key);
//
//   Widget build (BuildContext context)
//   {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context,snapshot)
//         {
//           if (snapshot.hasData)
//           {
//             return HomeActivity();
//           }
//           else
//           {
//             return AuthPage();
//           }
//         },
//       ),
//     )
//   }
// }