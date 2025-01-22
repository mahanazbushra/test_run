import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController =TextEditingController();
@override
  void dispose() {
  _emailController.dispose();

    super.dispose();
  }
  
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());
      showDialog(context: context,
          builder: (context)
          {
            return AlertDialog(
              content: Text("Password reset link sent! Check your email."),
            );
          });
    } on FirebaseAuthException catch(e)
    {
      print (e);
      showDialog(context: context,
          builder: (context)
      {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Enter your Email and we will send you a verification code"
          ,textAlign: TextAlign.center,),
        SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.25,
    right: 35,
    left: 35),

    child: Column(
    children: [
    TextField(
    controller: _emailController,

    decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,
    labelText: 'Email',
    hintText: 'Enter Phone Number or Email',
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10)
    ),

    ) ,
    keyboardType: TextInputType.emailAddress,


    ),
        ],
      ),

    ),
        ),
      SizedBox(
        height: 50,
        width: 400,),
          MaterialButton(
            onPressed:
              passwordReset,
            child:  Text("Reset your password",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),
            color: Color.fromRGBO(96,81,81, 1.0),

          )

    ],
      ),
    );
  }
}
