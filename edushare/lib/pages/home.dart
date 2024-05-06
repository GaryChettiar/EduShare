import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/pages/firestore.dart';
import 'package:edushare/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
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
        ),
      ),
    
    bottomNavigationBar: navbar(),);
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
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(11))
      ),
      child: GNav(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        color: Colors.white,
        activeColor: Colors.black,
        tabBorderRadius: 25,
        tabBackgroundColor:  Color(0xFFFFFFFF),
        iconSize: 27,
       
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
       gap: 8,
        tabs: [
        
        GButton(padding : EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        icon: Icons.home_outlined,
        text: "Home",
        textSize: 20,
        iconActiveColor: Colors.black,
        //backgroundColor: Colors.blue[200],
        ),
        GButton(
          padding : EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          icon: Icons.search,
          text: "Search",
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>searchPage()));
          },
          textSize: 20,),
        GButton(padding : EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          icon: Icons.add,
          text: "Post",
          textSize: 20,
          ),
        GButton(padding : EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          icon: CupertinoIcons.chat_bubble,
          text: "Chat",
          ),
        
      ],),
    );
  }
}