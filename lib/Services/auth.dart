import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:first_app/models/users.dart';
import 'package:first_app/pages/profile.dart';
import 'package:first_app/pages/sign_in.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:first_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseApp mainApp = Firebase.app('firstApp');
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AuthService
{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
   late Map<String,dynamic> data;
  
  Future<void> signUp({required String username, required String password, required String email}) async
  {
    
    try
    {
      UserCredential userCredential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      

      User? user = userCredential.user;
      
      if(user != null)
      {
        if(userCredential.additionalUserInfo!.isNewUser)
        {
          await firestore.collection('users').doc(user.uid).set(
            {
              'username' : username,
              'uid' : user.uid,
              'email' : email,
              'password': password,
              'following': 0,
              'followers': 0,
              'profile_picture': "",
              'date_created': user.metadata.creationTime,
            }
          );
       
        }
      }

      //FirebaseAuth.instanceFor(app: app)
    }
    on FirebaseAuthException catch(e)
    {
      String message ='';
      if(e.code == 'email-already-in-use')
      {
        message = 'An account already exists with that email';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black54,
        textColor: Colors.red,
        fontSize: 14.0
        );
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  

  }

   Future<void> signIn({required String password, required String email, required BuildContext context}) async
  {
    try
    {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      //UserCredential userCredential =await _auth.getRedirectResult();
      await Future.delayed(const Duration(seconds: 1));
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyProfile()));
      
    }
    on FirebaseAuthException catch(e)
    {
      String message =e.code;
      if(e.code == 'user-not-found')
      {
        message = 'No user found with that email';
      }

      else if(e.code == 'wrong-password')
      {
        message = 'Wrong password for this user';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black54,
        textColor: Colors.red,
        fontSize: 14.0
        );
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }

   

  }

   Future<void> signOut({required BuildContext context}) async
  {
    await _auth.signOut();
    //await Future.delayed(const Duration(seconds: 3));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));

  }

  
}