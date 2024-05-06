import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edushare/pages/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
List allResults=[];
  getClientStream()async{
    var data =await FirebaseFirestore.instance.collection('Project Information (Responses)').orderBy('Name',descending: false).get();
    setState(() {
      allResults=data.docs;
    }
    );
    searchResults();
  }

  final TextEditingController searchcontroller = new TextEditingController();
  List searchresults=[];
  searchResults(){
    var showResults=[];
    if(searchcontroller.text!=""){
      for (var clientsnapshots in allResults){
        var name = clientsnapshots['Title of the Project'].toString().toLowerCase();
        if(name.contains(searchcontroller.text.toLowerCase())){
          showResults.add(clientsnapshots);
        }
      }
    }
    else{
      showResults =List.from(allResults);
    }
    setState(() {
      searchresults=showResults;
    });
  }
  @override
  void initState() {
    getClientStream();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                
                  SizedBox(height: 50,)
                    ],
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black,width: 2,strokeAlign: BorderSide.strokeAlignInside),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    controller: searchcontroller,
                    backgroundColor: Colors.white,
                    onSubmitted: (value) {
                      searchResults();
                    },
                  )
                      
                      
                  ),
                ),
              ),
            Flexible(
              child: ListView.builder(itemCount: searchresults.length,
                itemBuilder: (context,index){                 
                            
                            String Name = searchresults[index]['Title of the Project'];
                            String Author = searchresults[index]['Name'];
                            String Status = searchresults[index]['Status'];
                            return Card(Name: Name, Author: Author,Status: Status);
                          },
              ),
            )
            
          ],
        ),
      ),
      bottomNavigationBar: navbar(),
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