import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:edushare/pages/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class searchPage extends StatefulWidget {
   searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {

  late String _pfp;

  Future<void> _fetchUserData() async {
     User? _currentUser = FirebaseAuth.instance.currentUser;
   
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: _currentUser!.email).get();
    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      setState(() {
       
        _pfp = userDoc['pfp'];
      //  isMale = userDoc['isMale'];
      });
    }
  }
List allResults=[];

  _searchPageState();
  getClientStream()async{
    QuerySnapshot data =await FirebaseFirestore.instance.collection('Project Information (Responses)').get();
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
    _fetchUserData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
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
                      
                 InkWell(
                            onTap: () {
                              var auth = FirebaseAuth.instance;
                //auth.signOut();
               
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>landing()));
                            },
                            child: CircleAvatar(
                              
                              radius: 25,
                              backgroundImage: AssetImage(_pfp),
                            ),
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
              child: ListView.builder(itemCount:searchcontroller.text==''?allResults.length: searchresults.length,
                itemBuilder: (context,index){                 
                            
                            String Name = searchresults[index]['Title of the Project'];
                            String Author = searchresults[index]['Name'];
                            // String Status = searchresults[index]['Status']; 
                            return Card(Name: Name, Author: Author);
                          },
              ),
            )
            
          ],
        ),
      ),
      
    );
  }
}



  
class Card extends StatefulWidget {
  const Card({
    super.key,
    required this.Name,
    required this.Author, 
     this.Status = null
  });

  final String Name;
  final String Author;
  final String? Status;
  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
   bool isFocus =false;
   
  @override
  Widget build(BuildContext context) {
   
    bool status = (widget.Status == null)? false: true;
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
          height: isFocus?200:120,
          width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
             // borderRadius: BorderRadius.circular(11),
       
              ),
                  
            child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal:16),
                        child: !isFocus?Column(
                          
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
       
                              child: Text(widget.Name,style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold,color: Colors.black),)),
       
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(widget.Author,style: TextStyle(color: Colors.black),),
                              ))
                          ],
                        ):Column(
                          
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
       
                              child: Text(widget.Name,style: TextStyle(fontSize: 24,
                              fontWeight: FontWeight.bold,color: Colors.black),)),
       
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(widget.Author,style: TextStyle(color: Colors.black),),
                              )),
                           Spacer(),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                         borderRadius: BorderRadius.all(Radius.circular(11)),
                                              border: Border.all(color: Colors.black,width: 2),
                                             color: Color(0xfffaf2fb),
                                      ),
                                      child: Center(child: Text("View ",style: TextStyle(
                                               fontWeight: FontWeight.bold
                                            ),)),
                                    ),
                                  ),
                                ),

                                 Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      left: 10
                                      
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      decoration: BoxDecoration(
                                         borderRadius: BorderRadius.all(Radius.circular(11)),
                                              border: Border.all(color: Colors.black,width: 2),
                                             color: Color(0xfffaf2fb),
                                      ),
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Add ",style: TextStyle(
                                                   fontWeight: FontWeight.bold
                                                ),),
                                                Icon(Icons.add,color: Colors.black,size: 20,)
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
             ),
       ),
    );
  }
}

class searchWeb extends StatefulWidget {
  const searchWeb({super.key});

  @override
  State<searchWeb> createState() => _searchWebState();
}

class _searchWebState extends State<searchWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}