import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:first_app/pages/home.dart';
//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseApp mainApp = Firebase.app('firstApp');
FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
//String userId = FirebaseAuth.instance.currentUser!.uid.toString();

//This doesnt work
class Users
{
  String userId = " ";
  String profilePicture = "";
  String username = "";
  String bio = "";
  var followers = 0;
  var following = 0;

  //Users(this.userId, this.username ,this.profilePicture, this.bio, this.followers, this.following);

  Users()
  {
    setUsername();
  }

  Future<void> setUsername ()
async {

  await firestore.collection('users').doc(userId).get();

  //username = snapshot['username'];
  username='his';
           
  
  //return this.username;
}

String getProfilePic()
{
  String profilePic = "";

  return profilePic;
}

String getUserId()
{
  String userId = "";
  return userId;
}

String get getUsername
{
  return username;
}
}