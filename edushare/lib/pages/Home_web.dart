import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/pages/firestore.dart';
import 'package:edushare/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home_web extends StatefulWidget {
  const Home_web({super.key});

  @override
  State<Home_web> createState() => _Home_webState();
}

class _Home_webState extends State<Home_web> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(0),
        child: Row(
          children: [
            Align(
              
              alignment: Alignment.centerLeft,
              child: navbar()),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(child: Image.asset('assets/logo.png' ,height: 30,width: 30,fit: BoxFit.fill,),alignment: Alignment.topCenter,),
                          SizedBox(width: 10,),
                          Align(
                            child: Text("EDUshare",style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              
                            ),
                            textAlign:TextAlign.center,
                              
                            ),
                            alignment: Alignment.bottomCenter,
                    
                          ),
                          ],
                        ),
                        
                  
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/profile.png'),
                          )
                      ],
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 11, 11),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("WHAT'S NEW TODAY",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                    
                      ],
                    ),
                  ),
                  DataFromFireStore()
                  
                ],
              ),
            ),
          ],
        ),
      ),
    
   );
  }

  Flexible DataFromFireStore() {
    return Flexible(
      
        child: StreamBuilder<QuerySnapshot>(stream: FirestoreService().getNotesStream(), 
             builder: (context,snapshot){
                if(snapshot.hasData){
                  List notesList = snapshot.data!.docs;
                    return ListView.builder(itemBuilder: (context,index){                 
                          DocumentSnapshot document = notesList[index];
                          String docID=document.id;
                          Map<String, dynamic> data= document.data() as Map<String,dynamic>;
                          String Name = data['Title of the Project'];
                          String Author = data['Name'];
                          String Status = data['Status'];
                          return Card(Name: Name, Author: Author,Status: Status);
                        },
                        itemCount: notesList.length,);
                      }
                      else{
                        return Text("no data...");
                      }
                }),
              );
  }
}

class Card extends StatefulWidget {
  const Card({
    super.key,
    required this.Name,
    required this.Author, 
    required this.Status,
  });

  final String Name;
  final String Author;
  final String Status;
  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
   bool isFocus =false;
   
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
      child:
       InkWell(
        onTap: () {
          setState(() {
           isFocus=!isFocus;
            
          });
        },
         child: Container(
          height: isFocus?200:90,
          width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 33, 37, 41),
              borderRadius: BorderRadius.circular(11),
       
              ),
                  
            child: Padding(
                     padding: const EdgeInsets.all(8.0),
                        child: !isFocus?Column(
                          
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
       
                              child: Text(widget.Name,style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold,color: Colors.white),)),
       
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(widget.Author,style: TextStyle(color: Colors.white),),
                              ))
                          ],
                        ):Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
       
                              child: Text(widget.Name,style: TextStyle(fontSize: 24,
                              fontWeight: FontWeight.bold,color: Colors.white),)),
       
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(widget.Author,style: TextStyle(color: Colors.white),),
                              )),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(widget.Status,style: TextStyle(color: Colors.white,),),
                              ))
                          ],
                        ),
                      ),
             ),
       ),
    );
  }
}

class navbar extends StatefulWidget {
  const navbar({
    super.key,
  });

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
   bool isOpen =false;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.sizeOf(context).height,
      width: isOpen? MediaQuery.sizeOf(context).width*0.1: MediaQuery.sizeOf(context).width*0.05,
        color: Color.fromARGB(255, 33, 37, 41),
      child: InkWell(
        
        child: Column(
          
          children: [
            Align(
              alignment: isOpen?Alignment.centerLeft:Alignment.center,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined,color: Colors.white,)),
                     isOpen?Text('Home',style: TextStyle(color: Colors.white),):SizedBox(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,)),
                    isOpen? Text('Search',style: TextStyle(color: Colors.white),):SizedBox(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.white,)),
                    isOpen? Text('Create',style: TextStyle(color: Colors.white),):SizedBox(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  
                },
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.chat,color: Colors.white,)),
                   isOpen? Text('Chats',style: TextStyle(color: Colors.white),):SizedBox(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Row(
                      children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.settings,color: Colors.white,)),
                        isOpen? Text('Settings',style: TextStyle(color: Colors.white),):SizedBox(),
                      ],
                    ),
                  ),
                )),
            )
      
          ],
        ),
      )

    );
  }
}

//Widget SideBar( ){}