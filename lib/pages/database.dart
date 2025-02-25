import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/pages/profile.dart';
import 'package:flutter/material.dart';

class Database
  {
    var userId = FirebaseAuth.instance.currentUser!.uid.toString();
    var email = FirebaseAuth.instance.currentUser!.email.toString();

    Future<void> recordPost({ required String body,required String image, required BuildContext context})async 
    {
      String username="";
      try
      {
        await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
          (snapshot)
          {
            var info = snapshot.data();
            username = info?['username'];

          }
        );
        
        await FirebaseFirestore.instance.collection('posts').doc().set(
        {
          'author_id': userId,
          'email': email,
          'username': username,
          'body': body,
          'image': image,
          'likes': 0,
          'date_created':FieldValue.serverTimestamp()
        });


        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
      }
      catch(e)
      {
        String message = e.toString();
        print(message);
      }   
      
    }

    Future<Future<QuerySnapshot<Map<String, dynamic>>>> getPosts()async
    {
      return FirebaseFirestore.instance.collection('posts').get();
    

    }

    Future<void> recordComment({required String authorId, required String body, required String postId})async
    {
      await FirebaseFirestore.instance.collection('posts').doc('').collection('comments').doc().set(
        {
          'author_id':authorId,
          'post_id': postId,
          'email': email,
          'body': body,
          'likes': 0,
        }
      );
    }

    Future<void> getComment({required String postId})async{}

    Future<void> updateLikes({required String postId, required bool selected, required int likes})async
    {
        
      
      if(selected)
      {
        likes = likes+1;
      
          FirebaseFirestore.instance.collection('posts').doc(postId).update(
            {
              'likes': likes
            });
      }
      else
      {
        likes = likes-1;
        FirebaseFirestore.instance.collection('posts').doc(postId).update(
          {
            'likes': likes,
          });
      }

      
  print('HERE'+postId);

    }
Future<void> setLikedPosts({required String userId, required String postId, required bool selected})async
{
  if(selected)
  {
    FirebaseFirestore.instance.collection('users').doc(userId).collection('likedPosts').doc().set(
    {
      'postId':postId,  
    }
    );
  
  }
  
  else
  {
    String likedPost ="";
    FirebaseFirestore.instance.collection('users').doc(userId).collection('likedPosts').get().then(
      (snapshot)
      {
        int length = snapshot.docs.length;
        var data;
        for(int i =0; i<length;i++)
        {
          data = snapshot.docs[i].data();
          if(data['postId'] == postId)
          {
            likedPost = snapshot.docs[i].reference.id.toString();
            FirebaseFirestore.instance.collection('users').doc(userId).collection('likedPosts').doc(likedPost).delete();
            
            break;
          }
        }
       
      }
      );
      print('Database');
  print(likedPost);
      //FirebaseFirestore.instance.collection('users').doc(userId).collection('likedPosts').doc(likedPost).delete();
  }
}

Future<Future<QuerySnapshot<Map<String, dynamic>>>> getLikedPosts({required String userId, required String postId})async
{
  return FirebaseFirestore.instance.collection('users').doc(userId).collection('likedPosts').get();
}



    /*
    FutureBuilder(
    future: FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('addresses')
        .get(),
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }else{return Text(snapshot.data.docs[0].reference.id.toString());}
    */ 
  }