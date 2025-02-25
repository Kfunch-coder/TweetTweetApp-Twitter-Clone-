import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      
      appBar: AppBar(backgroundColor: const Color.fromARGB(106, 178, 99, 243), 
      title: const Text("App Name",
      style:TextStyle(fontWeight: FontWeight.w100, fontSize: 20, color: Colors.black)
      ),
      centerTitle: true,),
    );
  }*/
   
  const tabsCount = 2;
  //final Color oddItemColor = Color.fromARGB(156, 196, 47, 226);
  //final Color evenItemColor = Color.fromARGB(235, 187, 92, 213);

  return DefaultTabController(
    initialIndex: 1,
    length: tabsCount,
     
    child: Scaffold(
      appBar: AppBar(backgroundColor:const Color.fromARGB(255, 99, 145, 243),
      //bottomNavigationBarItem: CupertinoTabBar(items: const []),
      automaticallyImplyLeading: true,
      leading:const CircleAvatar(backgroundColor: Colors.lightBlueAccent, child: Text('U'), ),
      leadingWidth: 50.0,
      titleSpacing: 0,
      title: const Text('Tweet Tweet', 
      style: TextStyle(fontSize: 20, color: Colors.white)),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications),
          tooltip: 'notification',
          onPressed: (){},
          iconSize: 30,
          color: Colors.white,
        ),
        
      ],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
      notificationPredicate: (ScrollNotification notification){
        return notification.depth == 1;
      },
      scrolledUnderElevation: 4.0,
      bottom: const TabBar(
        labelColor: Colors.white,
        tabs:[
          Tab(text: 'For you'),
          Tab(text: 'Following')
        ]
      )),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Color.fromARGB(255, 99, 145, 243),
        activeColor: Color.fromARGB(219, 255, 255, 255),
        inactiveColor: Color.fromARGB(255, 63, 63, 63),
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.search))
      ],) ,
      body: TabBarView(
        children: [
          
          ListView.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index){
              const Divider(height:6);
              return const Card(
                child: _PostCard(),
                elevation: 50,color: 
                Colors.white, 
                shadowColor: Colors.black,
                ); // making post cards in the app
              /*return ListTile(
                
                tileColor: index.isOdd ? oddItemColor: evenItemColor,
                minTileHeight: 200,
                title: const Text('Slot1'),
                
              );*/
            },
          ),
           ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index){
              return const Card(
                child: _PostCard(),
                elevation: 50,color: 
                Colors.white, 
                shadowColor: Colors.black,
                ); // making post cards in the app
              /*
              return ListTile(
                tileColor: index.isOdd ? oddItemColor: evenItemColor,
                minTileHeight: 200,
                title: const Text('Slot2'),
                
              );*/
            },
          )
        ],
      )
    )
  
    );
  }

 
}

class _PostCard extends StatelessWidget
{
  const _PostCard ();
  @override
  Widget build(BuildContext context)
  {
    return SizedBox( 
      width: 300,
      height: 200,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: const Color.fromARGB(255, 160, 201, 113), radius: 30,
        child:const Text('A')),
        title:const Text('Username'),
        //subtitle: Text('User post text',maxLines: 6,),
        subtitle: Container(height:140, width: 300, /*color: Colors.yellow,*/
        child:Column( 
          children: [
            Container(
              //color:Colors.orange,
              height:110,
              width:330,
              child:Text('User post text', maxLines: 5,textAlign: TextAlign.left,),
              decoration: BoxDecoration(border: Border.all(color:Color.fromARGB(180, 91, 195, 255),width:4)),
            ),
            //Divider(height:65),
            Container(/*color: Colors.green[300],*/height: 20,width: 330,child: Align(alignment: Alignment.bottomLeft, child:Row(

              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.favorite),
                  tooltip: 'favorite',
                  onPressed: (){},
                  iconSize: 25,
                  color: Colors.grey
                ),
                const Divider(indent: 30,),
                IconButton(
                  icon: const Icon(Icons.share), 
                  tooltip: 'retweet',
                  onPressed: (){},
                  iconSize: 25,
                  color: Colors.grey),
                 const Divider(indent: 30,),
                 IconButton(
                  icon: const Icon(Icons.comment), 
                  tooltip: 'Comment',
                  onPressed: (){},
                  iconSize: 25,
                  color: Colors.grey),  
              ],
            )
            )
            )
          ],
        )
      ),
        //trailing: Icon(Icons.favorite),

        
        

      ),
      
    );
    
  }
  
}