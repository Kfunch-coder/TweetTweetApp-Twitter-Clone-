//import 'package:first_app/pages/create_account.dart';
//import 'package:first_app/pages/create_post.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:first_app/pages/create_account.dart';
//import 'package:first_app/pages/edit_profile.dart';
//import 'package:first_app/pages/profile.dart';
import 'package:first_app/pages/sign_in.dart';
//import 'package:first_app/pages/profile.dart';
//import 'package:first_app/pages/edit_profile.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
/*
import 'pages/home.dart';
import 'pages/sign_in.dart';
import 'pages/create_account.dart';
*/
void main ()async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins',scaffoldBackgroundColor:  const Color.fromARGB(255, 137, 164, 255)),
      //darkTheme: ThemeData(),
      home: const SignIn()
    );
  }
}
