import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser()
  {
      return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async
  {
    try
    {
      //sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password
      );

      // save user info if it doesn't already exits
      _firestore.collection("User").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          }
      );
      return userCredential;
    } on FirebaseAuthException catch (e)
    {
      throw Exception(e.code);
    }
  }

  // signup
  Future<UserCredential> signUpWithEmailPassword(String email,password) async
  {
    try
    {
        //create user
       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

       // save user info in a separate doc
       _firestore.collection("User").doc(userCredential.user!.uid).set(
         {
           'uid': userCredential.user!.uid,
           'email': email,
         }
       );

       return userCredential;
    } on FirebaseAuthException catch (e)
    {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async{
    return await _auth.signOut();
  }
}


