//import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Services/auth.dart';
import 'package:first_app/pages/create_post.dart';
import 'package:first_app/pages/database.dart';
import 'package:first_app/pages/edit_profile.dart';
import 'package:first_app/pages/home.dart';
//import 'package:first_app/models/users.dart';
import 'package:first_app/pages/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


FirebaseDatabase database = FirebaseDatabase.instance;
FirebaseAuth auth = FirebaseAuth.instance;
var userId = FirebaseAuth.instance.currentUser!.uid.toString();

String body = "body";
Map<String,dynamic> postData = Map<String,dynamic>();
Map<String,dynamic> likesData = Map<String,dynamic>();
int postIndex =0;
int likesIndex = 0;
//bool likeSelected = false;


class MyProfile extends StatefulWidget
{
  const MyProfile({Key? key}) : super(key: key);

    @override
    State<MyProfile> createState() => MyProfileState();


}

class MyProfileState extends State<MyProfile>
{

  String username = "Username";
  String email = "@email";
  var followers = 0;
  var following = 0;
  String bio = "User bio";
  String profilePicture = "";
 // String body = "body";
 
   Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo()async
    {
      //final snapshot;
      
      //String userId = "9mr6aOIAKKXu5pLM60yb2MzeXoi1";//AuthService().getCurrentUID() as String;
      
      Map<String,dynamic> data = {};
      userId = FirebaseAuth.instance.currentUser!.uid.toString();
      var snapshot =await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
      
       /* (DocumentSnapshot snapshot)
        {
          if(snapshot.exists)
          {
            data  = snapshot.data()! as Map<String,dynamic>;
          }
        }*/
        (snapshot)
        {
          var data = snapshot.data();
          setState(() {
            username = data?['username'];
            email = data?['email'];
            followers = data?['followers'];
            following = data?['following'];
            profilePicture = data?['profile_picture'];

          });
        }
        
      );
        //print(userId+'HERE HERE');
        return snapshot;
      
    } 
 

  @override
   Widget build(BuildContext context) 
   { 
    //print(userId+'HERE');
    //getUserInfo();
    //print(userId+'HERE HERE');// Problem is here
      //Map<String, dynamic> data =  getUserInfo() as Map<String, dynamic>;
    //Try future builder but have initialize global variables like username
    const tabsCount = 4;
      return DefaultTabController(length: tabsCount, child: Scaffold(
        appBar: AppBar(
          
           toolbarHeight: 1,
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.blue,
        activeColor: Color.fromARGB(219, 255, 255, 255),
        inactiveColor: Color.fromARGB(255, 63, 63, 63),
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
        activeIcon:IconButton(onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
        },
        icon: Icon(Icons.home))),
        BottomNavigationBarItem(icon: Icon(Icons.search))
      ],) ,
        body: SafeArea(
          child:
          Stack(
            children: [
              //Future builder here
              FutureBuilder(future: FirebaseFirestore.instance.collection('posts').get()/*Database().getPosts()*/, 
              builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                if(snapshot.hasData == false)
                {
                  print('No Data');
                }
                else if(snapshot.hasData && snapshot.hasError)
                {
                  print("ERROR");
                }

                 
                else if(snapshot.connectionState == ConnectionState.done)
                {
                  int length = snapshot.data!.docs.length;
                  int index = 0;
                  for(int i = 0; i<length;i++)
                  {
                    var data = snapshot.data!.docs[i].data();
                    if(userId == data['author_id'])
                    {
                      //body = data['body'];
                      postData['body$index'] = data['body'];
                      postData['username$index'] = data['username'];
                      //postData['date$index'] = data['date_created'];
                      postData['likes$index'] = data['likes'];
                      postData['postId$index'] = snapshot.data!.docs[i].reference.id.toString();
                      index++;
                    }
                  }
                   postIndex = index;

                  /*snapshot.data?.then(
                    (snapshots)
                    {
                      
                      //print('HERE${snapshots.docs.length}');
                      userId = FirebaseAuth.instance.currentUser!.uid.toString();
                      int length = snapshots.docs.length;
                      int index = 0;
                      for(int i =0; i <length;i++)
                      {
                       
                        var data = snapshots.docs[i].data();
                        if(userId == data['author_id'])
                        {
                          body = data['body'];
                          postData['body$index'] = data['body'];
                          postData['username$index'] = data['username'];
                          postData['date$index'] = data['date_created'];
                          postData['likes$index'] = data['likes'];
                          postData['postId$index'] = snapshots.docs[i].reference.id.toString();
                          index++;
                        }
                        
                      }
                      postIndex = index;
                      
                    });*/

                  
                  //print(postData['body1']);
                  print('Success');
                 
                }

                return Text('Loading');
              }),
              FutureBuilder(future: getUserInfo(), 
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
              {
                  if(snapshot.hasError)
                  {
                    return Text("There is an error");
                  }

                  else if(snapshot.hasData && !snapshot.data!.exists)
                  {
                      return Text("Document doesn't exist");
                  }

                  else if(snapshot.connectionState == ConnectionState.done)
                  {
                      Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
                      username = data['username'] as String;
                      return Text("Hello");
                  }

                  return Text('Loading...');
              }),
              FutureBuilder(future: FirebaseFirestore.instance.collection('users').doc(userId).collection('likedPosts').get(),
              //Maybe do straight to post instead and then recieve the like post id in a gloal variable before
              builder: (BuildContext context, AsyncSnapshot snapshot)
              {
                 if(snapshot.hasData == false)
                {
                  print('No Data');
                }

                else if(snapshot.hasError && snapshot.hasData)
                {
                  print('ERROR for Likes');
                }

                else if(snapshot.connectionState == ConnectionState.done)
                {
                 
                 int length = snapshot.data!.docs.length;

                 if(length ==0)
                 {
                  likesIndex =0;
                 }
                 
                  int index = 0;
                  int infoIndex =0;
                  var postIdNum;
                  CollectionReference postRef = FirebaseFirestore.instance.collection('posts');
                  for(int i = 0; i<length;i++)
                  {
                    var data = snapshot.data!.docs[i].data();
                    likesData['postId$index'] = data['postId'];
                    postIdNum =data['postId'];
                    print( likesData['postId$index']);
                   
                   postRef.get().then((postshot)
                   {
                    setState(() {

                      int numPosts = postshot.docs.length;
                    //print(numPosts);

                    for(int j =0; j < numPosts; j++)
                    {
                     // print('Point');
                     // print(postshot.docs[j].reference.id.toString());
                      //print( likesData['postId$index']);
                     // print(postIdNum);
                      if(postshot.docs[j].reference.id.toString() == postIdNum)
                      {

                      //print('HELLO');
                      //var postsInfo = postshot.docs[j].data();
                      
                     // post?['username'];
                     
                      var post =postshot.docs[j];
                    
                      //likesData['body$infoIndex'] = postshot.docs[j].get('body');
                      likesData['body$infoIndex'] = post.get('body');
                      likesData['username$infoIndex'] = postshot.docs[j].get('username');
                      //postData['date$index'] = data['date_created'];
                      likesData['likes$infoIndex'] = postshot.docs[j].get('likes');
                      infoIndex++;
                     
                     
                      
                      
                    }
                    
                    }
                    likesIndex = infoIndex;
                      
                    });
                    
                   });
                  
                       index++;

                   /*
                      likesData['body$index'] = data['body'];
                      likesData['username$index'] = data['username'];
                      //postData['date$index'] = data['date_created'];
                      likesData['likes$index'] = data['likes'];
                      likesData['postId$index'] = snapshot.data!.docs[i].reference.id.toString();
                      index++;*/
                    
                  }
                  
                   //likesIndex = index;
                   print('HERE');
                   print(likesData['username0']);
                   print(likesData['body0']);
                   print(likesData['body1']);
                }

                return Text("loading...");

              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(image: ExactAssetImage('assets/background.jpg'),
                    width: double.infinity,height:150,fit: BoxFit.fill,),
                    
                   ]
                ),
                  Positioned(
                    child:Padding(padding:const EdgeInsets.all(8.0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.black38,
                              child: IconButton(
                                onPressed: ()async{
                                  await AuthService().signOut(context: context);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                                }, 
                                icon: Icon(Icons.more_horiz_rounded,color: Colors.white,size: 30,))
                              //Icon(Icons.more_horiz_rounded,color: Colors.white,size: 30,),//change to icon button
                            )
                       ]
                      )
                    )
                  ),
                  Padding(padding:const EdgeInsets.all(12.0)),
                  Positioned(
                    right:10,
                    top: 100,
                    child: 
                      Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border:Border.all(
                          color:Colors.blue,),
                          color: Colors.blue  ),
                          child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.add_a_photo,color: Colors.white,)
                          ),
                      )
                  ),
                  Positioned(
                    top:100,
                    left: 25,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.black12,
                        child: CircleAvatar(
                          radius: 37,
                          backgroundColor: Colors.white,
                          backgroundImage: ExactAssetImage('assets/default_image.jpg'),
                    ),
                  )
                ),
              ),
              Positioned(
                top:150,
                left: 310,
                child: Card(
                  color: Colors.blue[400],
                  
                  child: SizedBox(
                    height: 39,
                    //padding: const EdgeInsets.only(left:16,right:16,top:7,bottom:7),
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                      }, 
                      child: Text('Edit Profile',
                        style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)))
                    
                  )
                )
              ),
              Positioned(
                top:190,
                left:10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(username,//This doesnt work
                      style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25)),
                    ),
                    Container(
                      child:Text('@'+username,style: TextStyle(color:Colors.black54, fontSize: 15))
                    ),
                    Container(
                      margin:EdgeInsets.only(top: 10),
                      child:Text('User bio', style: TextStyle(color:Colors.black, fontSize: 16, fontWeight: FontWeight.normal))
                    ),
                   
                  ],
                )
              ),
              Positioned(
                top:270,
                left:0,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(onPressed: (){}, 
                        child: Text('0 Following', style: TextStyle(color:Colors.black))),
                      TextButton(onPressed: (){}, 
                        child: Text('0 Followers', style: TextStyle(color:Colors.black)))
                      ],
                    )
                )
            ),
           
           
           Container(
            margin: EdgeInsets.only(top:320),
            child: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text:'Posts'),
                Tab(text: 'Replies'),
                Tab(text: 'Media'),
                Tab(text:'Likes')
              ]
            ),
           ),
           Container(
             margin: EdgeInsets.only(top:400),
            child:
           
             TabBarView(
              children: [
                
                ListView.separated(
                restorationId: "post_feed",
                itemCount: postIndex,
                itemBuilder: (BuildContext context, int index)
                {
                  //return Divider();
                  const Divider(height:2);
                  //const Duration(seconds: 3);
                  return UserTweets(postData['username$index'],postData['body$index'],
                  /*postData['date$index'],*/postData['likes$index'], postData['postId$index']);
/*
                  return UserTweets(
                    body: postData['body$index'], username: postData['username$index'],
                     date: postData['date$index'],likes: postData['likes$index'], likeSelected: likeSelected,);*/
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),

            

              ListView.separated(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index)
                {
                  const Divider(height:6);
                  return Card();
                  //return UserTweets(body: postData['body0']);
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
              ListView.separated(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index)
                {
                  const Divider(height:6);
                  return Card();
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
              ListView.separated(
                itemCount: likesIndex,
                itemBuilder: (BuildContext context, int index)
                {
                  const Divider(height:2);
                   return UserTweets(likesData['username$index'],likesData['body$index'],
                  likesData['likes$index'], likesData['postId$index']);
                  //return Card();
                },
                separatorBuilder: (context, index) {
                  return Divider();
                }
              )
                
            ]
          )
          ),

          Positioned(
            bottom: 40,
            right:20,
            child:CircleAvatar(
              radius: 35,
              backgroundColor: Colors.blue,
  
              child: IconButton(
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePost()));
                  }, 
                icon: Icon(Icons.add),
                iconSize: 40,
                color:Colors.white,)
            )
            )     
            ]
                  
              
              ),
              
        
          )
          
      ));//Here
   }
   
}

class UserTweets extends StatefulWidget 
{
  final String username;
  //final Timestamp date;
  final int likes;
  final String body;
  final String postId;
 
  const UserTweets(this.username, this.body,/*this.date,*/ this.likes, this.postId, {super.key});

  @override
  _UserTweets createState() => _UserTweets();

  
}

class _UserTweets extends State<UserTweets> with AutomaticKeepAliveClientMixin
{
  bool likeSelected =false;

  @override
  bool get wantKeepAlive => true; // This ensures the state is preserved
  @override
  Widget build(BuildContext context)
  {super.build(context);
   
    return SizedBox(
      height: 200,
      width: 300,
      
      child:
        Padding(padding: const EdgeInsets.only(left:8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [CircleAvatar(
                  radius:25,
                  backgroundColor: Colors.grey,
                  // child: Image()
                  ),
                  Padding(padding: EdgeInsets.only(left:10,top:0)),
                  Text(widget.username, style: TextStyle(fontSize: 16),), 
                  Padding(padding: EdgeInsets.only(left:2)),
                  Text('@${widget.username}',style:TextStyle(color:Colors.grey[600],fontSize: 16)),
                  Padding(padding: EdgeInsets.only(left:19)),
                  Text('11/4/2024',style:TextStyle(color:Colors.grey[600], fontSize: 16)),
                  Padding(padding: EdgeInsets.only(left:96)),
                  PopupMenuButton(itemBuilder: (context) =>[
                    PopupMenuItem(value:1,
                     child: Text('Delete Post'))
                  ],
                  color:const Color.fromARGB(143, 117, 117, 117),
                  child: Icon(Icons.more_horiz_rounded),
                  
                  ),
                  ],
                  ),
             
           Expanded(
            child:
            Container(
            margin: const EdgeInsets.only(left:60,top:0, right:30),
             child: Text(widget.body,maxLines: 10, softWrap: true,)
           )
          ),
   
          Container(
            margin: const EdgeInsets.only(left:60, right:60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Icon(Icons.chat_bubble_outline),
              Icon(Icons.repeat),
              Row(children: [
                 //Icon(Icons.favorite_border_outlined),
                 IconButton(
                  isSelected: likeSelected,
                  selectedIcon: Icon(Icons.favorite_outlined, color: Colors.redAccent[400]),
                  onPressed: ()
                  { likeSelected = !likeSelected;
                    Database().updateLikes(postId: widget.postId, selected: likeSelected, likes: widget.likes);
                    Database().setLikedPosts(userId: userId, postId: widget.postId, selected: likeSelected);
                    
                  }, icon: Icon(Icons.favorite_border_outlined)),
                 Text('${widget.likes}')
              ],),
             
            ],)
          )
           
           
          
        ])
      
            
          )
          
         

      );
    
  }
  
}