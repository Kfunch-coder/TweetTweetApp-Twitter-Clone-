import 'package:first_app/Services/auth.dart';
import 'package:first_app/pages/profile.dart';
import 'package:first_app/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:form_validator/form_validator.dart';
//import 'package:url_launcher/url_launcher.dart';

List usernames = ['Ifan', 'A', 'a','Loshe', 'Fane', 'The Red Prince', 'Marcus','Sebille'];



class CreateAccount extends StatefulWidget
{
  const CreateAccount({Key? key}) : super(key: key);

  @override
    State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>
{
    String username = '';
    String password = '';
    String email = '';
    TextEditingController emailController =TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    Map userData = {}; 
    final _formkey = GlobalKey<FormState>(); 
    //final AuthService _auth = AuthService();
    
    @override
    Widget build(BuildContext context)
    {
      return Scaffold(
        appBar: AppBar(
           title: const Text('Tweet Tweet',style:TextStyle(color:Colors.white)),
           centerTitle: true,
           backgroundColor: Colors.blue,
        ),
         backgroundColor: const Color.fromARGB(255, 137, 164, 255),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: SizedBox(
                          width: 300,
                          height: 80,
                          child: Text('Create An Account',
                                textAlign: TextAlign.center,
                                style:TextStyle(color: Colors.white,fontSize: 25,))
                        ) ) 
                      ),
                      Padding(
                        padding:  const EdgeInsets.only(top:0.0, left: 12.0,right: 12.0,bottom: 0.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: <Widget>[
                              Padding(
                               // padding: const EdgeInsets.all(12.0),
                               padding: const EdgeInsets.only(top: 0.0, bottom:12.0),
                                child: TextFormField(
                                  controller: emailController,
                                  onChanged: (val){setState(()=>email=val);},
                                  validator: MultiValidator([
                                    RequiredValidator(
                                      errorText: 'Please enter an email address'
                                      ),
                                      EmailValidator(
                                        errorText: 'Enter a valid email adsress')
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
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const Padding(padding: EdgeInsets.all(6.0),),
                                    
                                  TextFormField(
                                    controller: usernameController,
                                    onChanged: (val){setState(()=>username=val);},
                                    autovalidateMode: AutovalidateMode.always,
                                    validator:(val) {
                                      if(usernames.contains(val))
                                      {
                                        return 'Username is taken';
                                      }

                                      else if(val!.isEmpty)
                                      {
                                        return 'Please enter a username';
                                      }
                                      return null;
                                      
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        hintText: 'Username',
                                        labelText: 'Username',
                                        fillColor: Colors.white,
                                        labelStyle: TextStyle(color: Colors.black),
                                        prefixIcon: Icon(Icons.people),
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
                                    ) 
                                  ),
                                  Padding(padding: const EdgeInsets.all(12.0),),
                                    TextFormField(
                                      controller: passwordController,
                                       onChanged: (val){setState(()=>password=val);},
                                      obscureText: true,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                          errorText:'Please enter your password'),
                                        MinLengthValidator(6, 
                                          errorText: 'There must be at least 6 digits'),
                                        PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                          errorText: 'At least 1 special character'), 
                                      // MatchValidator(errorText: 'f')      
                                      ]).call,
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
                                  ),
                                  Padding(padding: const EdgeInsets.all(12.0),),
                                  TextFormField(
                                    obscureText: true,
                                    validator: (value) => MatchValidator(
                                      errorText: 'passwords do not match').validateMatch(value!, password),
                                    decoration: InputDecoration(
                                        filled: true,
                                        
                                        hintText: 'Re-enter Password',
                                        labelText: 'Re-enter Password',
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
                                    ) 
                                  )
                                  ],
                                )
                                
                              )
                            ],
                          ),
                          )
                        ),
                         SizedBox(
                                height:40,
                                width:400,
                                child: InkWell(
                                    onTap: () {
                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const SignIn()),
                                       ); 
                                    },
                                    //=> launchUrl(Uri.file('pages/sign_in.dart')),//add () and link later
                                    child: const Text('Have an Account?. Sign in here', 
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
                                        width: 280,
                                        child:ElevatedButton(
                                            onPressed: () async{
                                              if(_formkey.currentState!.validate())
                                              {
                                                 await AuthService().signUp(email: emailController.text,
                                                 password: passwordController.text,username: usernameController.text);
                                                 await AuthService().signIn(password: password, email: email, context: context);
                                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                                                 
                                              }
                                               
                                            }, 
                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                            //onHover: ,
                                            child: const Text('Create Account', style:TextStyle(color:Colors.white,fontSize: 20))
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