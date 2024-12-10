import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/main.dart';
import 'package:edushare/pages/Home_web.dart';
import 'package:edushare/pages/add.dart';
import 'package:edushare/pages/chat.dart';
import 'package:edushare/pages/firestore.dart';
import 'package:edushare/pages/profile.dart';
import 'package:edushare/pages/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> avatarMale = [
    'assets/avatar1.png',
    'assets/avatar2.png',
    'assets/avatar4.png'
  ];
  List<String> avatarFemale = [
    'assets/avatar3.png',
    'assets/avatar5.png',
    'assets/avatar6.png'
  ];
  int currentIndex = 0;
  final List pagesWeb = [Home_web(), searchWeb(), addProjectWeb()];
  final List pages = [HomeMobile(), searchPage(), addProject(), Chat()];

  ontapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0.0;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: (MediaQuery.sizeOf(context).width < 800)
              ? pages[currentIndex]
              : pagesWeb[currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        height: 85,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: GNav(
          padding: EdgeInsets.all(8.0),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          color: Colors.white,
          activeColor: Colors.black,
          tabBorderRadius: 25,
          tabBackgroundColor: Color(0xFFFFFFFF),
          iconSize: 27,
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          gap: 8,
          tabs: [
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: Icons.home_outlined,
              text: "Home",
              textSize: 20,
              iconActiveColor: Colors.black,
              //backgroundColor: Colors.blue[200],
            ),
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: Icons.search,
              text: "Search",
              textSize: 20,
            ),
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: Icons.add,
              text: "Post",
              textSize: 20,
            ),
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: CupertinoIcons.chat_bubble,
              text: "Chat",
            ),
          ],
          onTabChange: ((value) {
            ontapped(value);
          }),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Flexible DataFromFireStore() {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              return ListView.builder(
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String Name = data['Title of the Project'];
                  String Author = data['Name'];
                  String Status = data['Status'];
                  String Desc = data['Describe your project/problem statement'];
                  return Card(
                    Name: Name,
                    Author: Author,
                    Status: Status,
                    Desc: Desc,
                  );
                },
                itemCount: notesList.length,
              );
            } else {
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
    required this.Desc,
  });
  final String Desc;
  final String Name;
  final String Author;
  final String Status;
  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: InkWell(
        onTap: () {
          setState(() {});
        },
        child: Container(
          //: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.black,width: 1,strokeAlign: BorderSide.strokeAlignInside) ,
            //borderRadius: BorderRadius.circular(11),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.Author,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      widget.Name,
                                      style: TextStyle(
                                        color: Color(0xff757575),
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.clip,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: LikeButton())),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          border: Border.all(color: Colors.black, width: 2),
                          color: Color(0xfffaf2fb),
                        ),
                        child: Center(
                            child: Text(
                          "View ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  static bool liked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          liked = !liked;
        });
      },
      child: liked
          ? Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : Icon(
              Icons.favorite_border,
              color: Colors.black,
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
  int currentIndex = 0;
  ontapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List pagesWeb = [
    Home_web(),
    searchWeb(),
  ];
  final List pages = [
    HomeMobile(),
    searchPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 85,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(11))),
        child: GNav(
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
          color: Colors.white,
          activeColor: Colors.black,
          tabBorderRadius: 25,
          tabBackgroundColor: Color(0xFFFFFFFF),
          iconSize: 27,
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          gap: 8,
          tabs: [
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: Icons.home_outlined,
              text: "Home",
              textSize: 20,
              iconActiveColor: Colors.black,
              //backgroundColor: Colors.blue[200],
            ),
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: Icons.search,
              text: "Search",
              textSize: 20,
            ),
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: Icons.add,
              text: "Post",
              textSize: 20,
            ),
            GButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              icon: CupertinoIcons.chat_bubble,
              text: "Chat",
            ),
          ],
          onTabChange: ((value) {
            ontapped(value);
          }),
        ));
  }
}

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  User? _currentUser;
  late String _pfp;

  Future<void> _fetchUserData() async {
    _currentUser = FirebaseAuth.instance.currentUser;

    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: _currentUser!.email)
        .get();
    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      setState(() {
        _pfp = userDoc['pfp'];
        //  isMale = userDoc['isMale'];
      });
    }
  }

  late bool isMale;
  int currentIndex = 0;
  ontapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                          Align(
                            child: Image.asset(
                              'assets/logo.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            alignment: Alignment.topCenter,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                            child: Text(
                              "EDUshare",
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // var auth = FirebaseAuth.instance;
                          //auth.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>landing()));
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(_pfp),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 11, 11),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WHAT'S NEW TODAY",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DataFromFireStore(),
          ],
        ),
      ),
    );
  }

  Flexible DataFromFireStore() {
    return Flexible(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService().getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              return ListView.builder(
                itemBuilder: (context, index) {
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String Name = data['Title of the Project'];
                  String Author = data['Name'];
                  String Status = data['Status'];
                  String Desc = data['Describe your project/problem statement'];
                  return Card(
                    Name: Name,
                    Author: Author,
                    Status: Status,
                    Desc: Desc,
                  );
                },
                itemCount: notesList.length,
              );
            } else {
              return Text("no data...");
            }
          }),
    );
  }
}
