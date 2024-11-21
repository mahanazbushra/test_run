import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_run/login.dart';

import 'package:test_run/user/firebase_auth_implementation/firebase_auth_services.dart';

import 'home.dart';




final _formKey = GlobalKey<FormState>();

class SignUp extends StatefulWidget{
  const SignUp ({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp>
{
  bool isSigningUp = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
@override
 void dispose()
 {
   _usernameController.dispose();
   _emailController.dispose();
   _mobileNumberController.dispose();
   _passwordController.dispose();
   _confirmPasswordController.dispose();

    super.dispose();


 }

  String? validateEmail(String? email)
  {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid){
      return 'Please enter a valid email';
    }
    return null ;
  }
  String? validateBangladeshMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    }
    // Regular expression for Bangladeshi mobile numbers
    // Allows optional +88 prefix and requires 11 digits starting with 01
    if (!RegExp(r'^(?:\+?88)?01[13-9]\d{8}$').hasMatch(value)) {
      return 'Please enter a valid Bangladeshi mobile number';
    }
    return null; // Return null if the numberis valid
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$').hasMatch(value)) {
      return 'Password must be 6-12 characters and \ncontain at least one letter and one digit';
    }
    else if(value != _passwordController.text){
      return'Password does not match';
    }

    return null;
  }
  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null; // Return null if passwords match
  }


  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,






  ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left:75,top:10),
            child:

            Text("Register Now! ", textAlign: TextAlign.center, style: TextStyle(
              color: Color.fromRGBO(96,81,81, 1.0),fontWeight : FontWeight.bold,fontSize: 33
            ),),


            ),

    SingleChildScrollView(
    child: Container(
    padding: EdgeInsets.only(top:MediaQuery. of(context).size.height*0.1,right: 35,left:35),
      child:Form(
        child: Column(
          key: _formKey,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                  labelText: ' Name',
                hintText: ' Enter your Name',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ) ,
              validator: (name) => name!.length<3?'Name should be at least 3 characters':null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: ' Email',
                  hintText: 'Enter your Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ) ,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,

              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _mobileNumberController,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Mobile Number',
                  hintText: 'Enter a valid number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ) ,
              keyboardType: TextInputType.phone,

                  // ... other properties ...
                  validator: validateBangladeshMobile,
              autovalidateMode: AutovalidateMode.onUserInteraction,

            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(

              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,

                labelText: ' New Password',
                hintText: 'Create new password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),

              validator: validatePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,

            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,

                labelText: ' Confirm Password',
                hintText: 'Confirm your password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),

              ),
              validator: validateConfirmPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
    ),
            SizedBox(
            height: 40,),

    GestureDetector(
    onTap:  (){
    _signUp();
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mylogin()),
    );


    },
    child: Container(
    width: double.infinity,
    height: 45,
    decoration: BoxDecoration(
      color: Color.fromRGBO(96,81,81, 1.0),
    borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
    child: isSigningUp ? CircularProgressIndicator(color: Colors.white,):Text(
    "Sign Up",
    style: TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold),
    )),
    ),



            //   child: ElevatedButton(
            //     onPressed: _signUp,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color.fromRGBO(96,81,81, 1.0),
            //       foregroundColor: Colors.white,
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //       textStyle: TextStyle(fontSize: 18),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //
            //
            //         Text('Sign Up'),
            //
            //       ],
            //     ),
            //  ),
            // ),
    ),

            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                SizedBox(width: 8), // Add some spacing
                GestureDetector(
                  onTap: () {// Navigate to sign-in screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mylogin()),
                    );
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.blue,

                    ),
                  ),
                ),
              ],
            )
          ],

        ),
      )
    ),
    ),
  ]
      ),
    );



  }
  Future register() async {
    //inProgress = true;
    setState(() {

    });
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text)
        .then((value) {
      setState(() {
        print('registerd');
        // inProgress = false;
        // Get.to(CustomerInformationScreen(email: emailController.text.toString(),));
      });
    }).onError((error, stackTrace) {

      setState(() {
        print(error.toString());
        print('failed to register');
       // inProgress = false;
      });
    });
  }
  void _signUp() async{
    String username= _usernameController.text;
    String email= _emailController.text;
    String mobile_number = _mobileNumberController.text;
    String password = _passwordController.text;
    String confirm_password = _confirmPasswordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,// First positional argument (email)_passwordController.text, // Second positional argument (password)
    );
    if (user != null)
      {
        showToast("User is successfully created");
        Navigator.pushNamed(context, "home");
      }
    else{
      showToast("Some error occured");
    }

  }

  void showToast(String message) => Fluttertoast.showToast(msg: message);
}