import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_run/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_run/user/firebase_auth_implementation/firebase_auth_services.dart';


class Mylogin extends StatefulWidget {
  const Mylogin({super.key});

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {


bool _isSigning = false;
final FirebaseAuthService _auth = FirebaseAuthService();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  void dispose()
  {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
        body: Stack(
          children: [
            // ... your existing container ...
            Container(
              padding: EdgeInsets.only(left: 40, top: 90), // Adjust padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!",style:GoogleFonts.playfairDisplay(

                    color: Color.fromRGBO(96, 81, 81, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 30, // Adjust font size as needed
                  ),
                  ),
                  SizedBox(height: 8), // Add spacing between heading and text
                  Text(
                    "Login to your account.", // Your additional text
                    style: GoogleFonts.sourceSerif4(
                      color: Color.fromRGBO(96, 81, 81, 1.0),
                      fontSize: 16, // Adjust font size as needed
                    ),
                  ),
                ],
              ),
            ),

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
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,

                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off: Icons.visibility,
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
                      keyboardType: TextInputType.visiblePassword,
                    ),
                SizedBox(
                    height: 20,
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                    GestureDetector(
                    onTap: () {
                      // Navigate to sign-in screen
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mylogin()),
                    );
                    },
                    child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                    color: Colors.blue,

                    ),
                    ),
                    ),
                  ],
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      width: 400,
    ),
                      GestureDetector(
                        onTap: () {
                          _signIn();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(96,81,81, 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: _isSigning ? CircularProgressIndicator(
                              color: Colors.white,) : Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        _signInWithGoogle();

                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              SizedBox(width: 5,),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('New User?'),
                        SizedBox(width: 8), // Add some spacing
                        GestureDetector(
                          onTap: () {
                            // Navigate to sign-in screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),

                            );
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

        ],
      ),
    );
  }
  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    User? user = await _auth.signInWithEmailAndPassword(
        email,
        password // First positional argument (email)_passwordController.text, // Second positional argument (password)
    );
    setState(() {
      _isSigning = false;
    });
    if (user != null) {
      showToast("Logged in successfully");
      Navigator.pushNamed(context, "home");
    }
    else {
      showToast("Some error occured");
    }
  }

  void showToast(String message) => Fluttertoast.showToast(msg: message);
_signInWithGoogle()async{

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  try {

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if(googleSignInAccount != null ){
      final GoogleSignInAuthentication googleSignInAuthentication = await
      googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      Navigator.pushNamed(context, "/home");
    }

  }catch(e) {
    showToast("some error occured $e");
  }


}
}
