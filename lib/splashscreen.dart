import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:test_run/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() =>_SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mylogin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(253, 227, 227,1.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 20),
              Text(
                "Crochet O' clock",
                style: GoogleFonts.dancingScript(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(96, 81, 81, 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:test_run/login.dart';
//
// class SplashScreen extends StatefulWidget{
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
//
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 5),() {
//       Navigator.pushReplacement(context, MaterialPageRoute(
//         builder: (context) =>Mylogin(),
//       ));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Color.fromRGBO(253, 227, 227, 1.0),
//         child: Center(child: Text('Crochet o Clock', style: TextStyle(
//             fontSize: 34,
//             fontWeight: FontWeight.w700,
//             color: Color.fromRGBO(96,81,81, 1.0),
//         ),),),
//       ),
//     );
//     throw UnimplementedError();
//   }
// }