
import 'dart:async'; // Import for Timer

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_run/Customer/home.dart';



//Define Utils class (or import it if it exists elsewhere)
class Utils {
  static void showSnackBar(String message) {
    // Implement your snackbar logic here
  }
}

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState(); // Corrected class name
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
 bool  canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );


    }
  }
  @override
  void dispose()
  {
    timer?.cancel();
    super.dispose();

  }
  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
}

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      // Call setState to rebuild the widget
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 30));
      setState(() => canResendEmail = true);

      // setState(() {
      //   isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      // });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) { // Build method inside the class
    return isEmailVerified
        ? HomeActivity()
        : Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A verification email has been sent to your email',

                style: TextStyle(fontSize: 20),

            textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(

              style:ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(96,81,81, 1.0),
                foregroundColor: Color.fromRGBO(253, 227, 227, 1.0),
                minimumSize: Size.fromHeight(50),
              ),
              icon:Icon(Icons.email,size:32),
              label: Text(
                'Resend Email',
                style:TextStyle(fontSize:24),
              ),
              onPressed: canResendEmail? sendVerificationEmail:null,
              ),


            SizedBox(height: 24),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(96,81,81, 1.0),
                foregroundColor: Color.fromRGBO(253, 227, 227, 1.0),
                minimumSize: Size.fromHeight(50),
              ),

              child: Text(
                'Cancel',

                style:TextStyle(fontSize:24),

              ),
              onPressed: ()=> FirebaseAuth.instance.signOut(),
            ),
          ],
        )
      )
    );
  }
}