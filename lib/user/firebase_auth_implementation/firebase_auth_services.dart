import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print(e.toString());
      print("Some error occurred during sign up");
      return null;
    }
  }
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occurred during sign in");
      return null;
    }
  }


  Future<void> setUserRole(String uid, String role) async {
    try {
      await _firestore.collection('users').doc(uid).set({'role': role});
    } catch (e) {
      print("Error setting user role: $e");
    }
  }

  // Get user role
  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()?['role'];
    } catch (e) {
      print("Error getting user role: $e");
      return null;
    }
  }

  // Get current user
  User? getCurrentUser() {
  return _auth.currentUser;
}

// Sign out
Future<void> signOut() async {
  await _auth.signOut();
}
}
// import 'package:firebase_auth/firebase_auth.dart';
//
// class FirebaseAuthService{
//  FirebaseAuth _auth =FirebaseAuth.instance;
//  Future<User?> signUpWithEmailAndPassword(String email, String password)async
//  {
//    try{
//      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//      return credential.user;
//    }
//    catch (e){
//      print(e.toString());
//      print("Some error occured");
//    }
// return null;
//  }
//  Future<User?> signInWithEmailAndPassword(String email, String password)async
//  {
//    try{
//      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//      return credential.user;
//    }
//    catch (e){
//      print("Some error occured");
//    }
//    return null;
//  }
// }