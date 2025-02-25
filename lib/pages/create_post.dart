import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/database.dart';
import 'package:first_app/pages/profile.dart';
import 'package:flutter/material.dart';

var userId = FirebaseAuth.instance.currentUser!.uid.toString();

class CreatePost extends StatefulWidget
{
  const CreatePost({Key? key}) : super(key: key);

    @override
    State<CreatePost> createState() => CreatePostState();


}

class CreatePostState extends State<CreatePost>
{

  TextEditingController BodyController = TextEditingController();
  TextEditingController ImageController = TextEditingController();


  

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 137, 164, 255),
        leading:TextButton(onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
        }, 
          child: Text('Cancel',style: TextStyle(color:Colors.white, fontSize: 20),)),
        leadingWidth: 100,  
      actions:[
        ElevatedButton(onPressed: ()
        {
          Database().recordPost(body: BodyController.text, image: '', context: context);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), 
        child: Text('Post',
          style: TextStyle(color:Colors.white),)
          ),
         Padding(padding: const EdgeInsets.only(left:20)) 
      ]
      ),
      backgroundColor: Color.fromARGB(255, 137, 164, 255),
      body: SafeArea(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
                Padding(padding: EdgeInsets.only(left:20)),
                CircleAvatar(backgroundColor: Colors.grey, 
                  backgroundImage: ExactAssetImage('assets/default_image.jpg'),
                  radius: 28,
                  
                ),
                
              ]
            ),
            
            Row(children: [Padding(padding: const EdgeInsets.only(left:65)),
              
              SizedBox(
                height:600,
                width:333,
                child: TextField(
                controller:BodyController,  
                  //expands: true,
                maxLines: 30,
                maxLength: 100,
                cursorHeight: 30,
                style: TextStyle(color: Colors.white,fontSize: 16),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: 'Tell your story....',
                   contentPadding: EdgeInsets.symmetric(
                   vertical: 25.0,
                   horizontal: 10.0,
                  ),
                  counterText: '',
                  border: OutlineInputBorder()
                )
              )
              )
              
            ],
            ),
            
          ],
        )
        ),
    );
  }
}