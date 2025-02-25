//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Services/auth.dart';
import 'package:first_app/pages/create_account.dart';
//import 'package:first_app/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:url_launcher/url_launcher.dart';

class SignIn extends StatefulWidget
{
    //const SignIn({super.key});
    const SignIn({Key? key}) : super(key: key);

    @override
    State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn>
{
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
   // String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    Map userData = {}; 
    final _formkey = GlobalKey<FormState>(); 
    



    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Tweet Tweet',style:TextStyle(color:Colors.white)),
                centerTitle: true,
                backgroundColor: Colors.blue,
            ),
            backgroundColor: Color.fromARGB(255, 137, 164, 255),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(top: 60),
                                child: Center(
                                    child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(60),
                                            border: Border.all(color: Colors.white, width: 6)
                                        ),
                                        child: Image.asset('assets/blue_bird.png'),
                                    )
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                    child: Container(
                                        width:200,
                                        height: 80,
                                        child:  const Text('Sign In', 
                                            textAlign:TextAlign.center,
                                            style:TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            )),
                                        ),
                                    )
                                ),
                           Padding(
                            padding: const EdgeInsets.all(12.0),
                             child:Form(
                               key: _formkey, 
                                child:Column( 
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        children:<Widget>[Padding(padding:const EdgeInsets.all(12.0), 
                        //)])//padding//wid/column
                            child: TextFormField(
                                 controller: emailController,
                                validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:'Please enter an email address' ),
                                    EmailValidator(
                                        errorText:'Enter a valid email address' )
                                ]).call,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Email',
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color:Colors.black),
                                    prefixIcon: Icon(Icons.email_rounded),
                                    prefixIconColor: Colors.blue[900],
                                    errorStyle: TextStyle(fontSize: 18.0),
                                    fillColor: Colors.white,
                                     
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    errorBorder:const OutlineInputBorder(
                                        borderSide: 
                                            BorderSide(color: Colors.red, width: 2.0,),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))

                                    ) ,
                                     disabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: 
                                            BorderSide(color: Colors.red, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                ),
                            )),//M)//
                           //),
                           Padding(
                            padding:const EdgeInsets.all(12.0),
                            
                            child:TextFormField(
                               obscureText: true,
                               controller: passwordController,
                                validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please enter your password'),
                                    MinLengthValidator(6, 
                                        errorText: 'There must be at least 6 digits'),
                                    PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                        errorText: 'At least 1 special character')        
                                ]
                                ).call,
                                decoration: InputDecoration(
                                    filled: true,
                                    hintText: 'Password',
                                    labelText: 'Password',
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.key),
                                    prefixIconColor: Colors.blue[900],
                                    errorStyle: TextStyle(fontSize: 18.0),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    errorBorder:const OutlineInputBorder(
                                        borderSide: 
                                            BorderSide(color: Colors.red, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: 
                                            BorderSide(color: Colors.red, width: 2.0),
                                        borderRadius: 
                                            BorderRadius.all(Radius.circular(22.0))
                                    ),
                                    
                                ),   
                            )//
                            ),])),//M
                           ),
                            SizedBox(
                                height:40,
                                width:400,
                                child: InkWell(
                                    onTap: () {
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CreateAccount()),
                                       ); 
                                    },//add () and link later
                                    child: const Text('Create an account here', 
                                        style: TextStyle(
                                            color:Colors.white,
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.white,
                                            decorationThickness: 3.0,
                                            fontSize: 18),)
                                )
                            ), 
                            Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Container(
                                    child: SizedBox(
                                        height: 50,
                                        width: 250,
                                        child:ElevatedButton(
                                            onPressed: ()async{
                                                if(_formkey.currentState!.validate())
                                                {
                                                   await AuthService().signIn(
                                                    password: passwordController.text,email: emailController.text, context: context);
                                                   /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const MyProfile()),
                                       ); */
                                                    //debugPrint('submitted');
                                                }
                                            }, 
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                            //onHover: ,
                                            child: const Text('Login', style:TextStyle(color:Colors.white,fontSize: 20))
                                        ),
                                    )
                                )
                                )    
                    ],
                    )
                )
            )
        );
    }
}