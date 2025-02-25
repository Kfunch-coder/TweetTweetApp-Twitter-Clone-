import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:first_app/pages/profile.dart';
import 'package:flutter/material.dart';

var userId = FirebaseAuth.instance.currentUser!.uid.toString();

class EditProfile extends StatefulWidget
{
  const EditProfile({Key? key}) : super(key: key);

    @override
    State<EditProfile> createState() => CreateEditProfileState();

}
class CreateEditProfileState extends State<EditProfile>
{

  Future<void> editInfo ()async
  {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(userId).update({'username':usernameController,/*'Bio':bioController*/});
  }

  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 164, 255),
        leadingWidth: 100,
        leading:TextButton(onPressed: ()
        {
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
        }, 
          child: Text('Cancel',style: TextStyle(color:Colors.white, fontSize: 20),)),
        centerTitle: true,
        title: Text('Edit Profile',style: TextStyle(color:Colors.white),),
        actions: [
          ElevatedButton(onPressed: ()
          {
            //editInfo();
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
          },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), 
            child: Text('Save',
            style: TextStyle(color:Colors.white),)
          ),
          Padding(padding: const EdgeInsets.only(left:20)) 
        ],
      ),
      backgroundColor: Color.fromARGB(255, 137, 164, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           Container(
            margin: const EdgeInsets.only(left:10),
            child: CircleAvatar(
              radius: 37,
              backgroundImage:  ExactAssetImage('assets/default_image.jpg'),
              child: Container(
                margin: const EdgeInsets.only(left: 30,top:30),
                child:IconButton(onPressed: (){}, icon: Icon(Icons.photo_camera,color:Colors.grey)))
            ),
          ),
           
            SizedBox(height:10),
            SizedBox(
              height:65,
              width:430,
              child:TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Text('   Username:   ',style: TextStyle(color:Colors.white, fontSize: 18),),
                  prefixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white, width: 3)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white, width: 3)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white, width: 3)),
                ),
              )
            ),
             SizedBox(height: 0),
            SizedBox(
              height:90,
              width:430,
              child:TextFormField(
                controller: bioController,
                decoration: InputDecoration(
                  prefixIcon: Text('  Bio:   ',style: TextStyle(color:Colors.white, fontSize: 18),),
                  prefixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white, width: 3)),
                  disabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white, width: 3)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.white, width: 3)),
                ),
              )
            )
          ],
        ) 
      )
    );
  }
}